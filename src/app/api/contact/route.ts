import { NextResponse } from "next/server";
import nodemailer from "nodemailer";
import { SITE } from "@/lib/site";

/* POST /api/contact
   Sends the message with Resend (RESEND_API_KEY) or, failing that, SMTP (SMTP_HOST + SMTP_USER + SMTP_PASSWORD).
   With neither configured it answers { fallback: true } and the form opens the visitor's email app instead. */

export const runtime = "nodejs";

const hits = new Map<string, number[]>();
function limited(ip: string) {
  const now = Date.now();
  const recent = (hits.get(ip) ?? []).filter((t) => now - t < 10 * 60_000);
  recent.push(now);
  hits.set(ip, recent);
  return recent.length > 5;
}

const esc = (s: string) => s.replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]!);
const EMAIL = /^[^\s@]+@[^\s@]+\.[^\s@]{2,}$/;

export async function POST(req: Request) {
  const ip = req.headers.get("x-forwarded-for")?.split(",")[0]?.trim() || "local";
  if (limited(ip)) return NextResponse.json({ error: "Too many messages from this connection. Try again in a few minutes, or email me directly." }, { status: 429 });

  let raw: Record<string, unknown>;
  try {
    raw = await req.json();
  } catch {
    return NextResponse.json({ error: "The form couldn't be read. Refresh the page and try again." }, { status: 400 });
  }
  if (raw.website) return NextResponse.json({ ok: true }); // honeypot

  const str = (k: string, max: number) => String(raw[k] ?? "").trim().slice(0, max);
  const m = { name: str("name", 120), email: str("email", 160).toLowerCase(), subject: str("subject", 160), message: str("message", 5000) };

  const fields: Record<string, string> = {};
  if (!m.name) fields.name = "Add your name.";
  if (!EMAIL.test(m.email)) fields.email = "Enter an email address I can reply to.";
  if (m.message.length < 10) fields.message = "Write at least a sentence about what you need.";
  if (Object.keys(fields).length) return NextResponse.json({ error: "Some fields need attention.", fields }, { status: 422 });

  const to = process.env.CONTACT_TO || SITE.email;
  const subject = `Portfolio: ${m.subject || "New message"} (from ${m.name})`;
  const text = `${m.message}\n\n${m.name} <${m.email}>`;
  const html = `<p style="white-space:pre-wrap;font-family:system-ui">${esc(m.message)}</p><hr/><p style="font-family:system-ui">${esc(m.name)} &lt;${esc(m.email)}&gt;</p>`;

  try {
    if (process.env.RESEND_API_KEY) {
      const res = await fetch("https://api.resend.com/emails", {
        method: "POST",
        headers: { Authorization: `Bearer ${process.env.RESEND_API_KEY}`, "Content-Type": "application/json" },
        body: JSON.stringify({ from: process.env.CONTACT_FROM || "Portfolio <onboarding@resend.dev>", to: [to], reply_to: m.email, subject, text, html }),
      });
      if (!res.ok) throw new Error(`Resend ${res.status}: ${await res.text()}`);
      return NextResponse.json({ ok: true });
    }
    if (process.env.SMTP_HOST && process.env.SMTP_USER && process.env.SMTP_PASSWORD) {
      const port = Number(process.env.SMTP_PORT || 465);
      const transport = nodemailer.createTransport({
        host: process.env.SMTP_HOST,
        port,
        secure: port === 465,
        auth: { user: process.env.SMTP_USER, pass: process.env.SMTP_PASSWORD },
      });
      await transport.sendMail({ from: `"Portfolio" <${process.env.SMTP_USER}>`, to, replyTo: m.email, subject, text, html });
      return NextResponse.json({ ok: true });
    }
    return NextResponse.json({ fallback: true }, { status: 503 });
  } catch (err) {
    console.error("contact: send failed", err);
    return NextResponse.json({ error: "The message didn't send. Email me directly at " + SITE.email + "." }, { status: 502 });
  }
}
