"use client";

import { useState } from "react";
import { SITE } from "@/lib/site";

type State = { kind: "idle" } | { kind: "sending" } | { kind: "sent" } | { kind: "error"; message: string; fields?: Record<string, string> };

const field =
  "w-full rounded-md border border-line bg-coal/60 px-4 py-3 font-sans text-[16px] text-bone placeholder:text-ash/60 transition-colors focus:border-signal focus:outline-none";

export function ContactForm() {
  const [state, setState] = useState<State>({ kind: "idle" });

  async function onSubmit(e: React.FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const form = e.currentTarget;
    const data = Object.fromEntries(new FormData(form));
    setState({ kind: "sending" });
    try {
      const res = await fetch("/api/contact", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(data) });
      const json = await res.json().catch(() => ({}));
      if (res.ok && json.ok) {
        setState({ kind: "sent" });
        form.reset();
        return;
      }
      if (json.fallback) {
        /* Email isn't configured on the server: open the visitor's email app with the message filled in */
        const subject = encodeURIComponent(String(data.subject || "Project enquiry"));
        const body = encodeURIComponent(`${data.message}\n\n${data.name} (${data.email})`);
        window.location.href = `mailto:${SITE.email}?subject=${subject}&body=${body}`;
        setState({ kind: "idle" });
        return;
      }
      setState({ kind: "error", message: json.error ?? "The message didn't send. Try again, or email me directly.", fields: json.fields });
    } catch {
      setState({ kind: "error", message: "Couldn't reach the server. Check your connection and try again, or email me directly." });
    }
  }

  if (state.kind === "sent") {
    return (
      <div role="status" className="rounded-md border border-signal/50 bg-signal/5 p-8">
        <p className="display text-[clamp(2rem,5vw,3.5rem)] text-signal">Message sent</p>
        <p className="mt-4 font-sans text-[16px] text-bone/85">Thanks for writing. I'll reply to your email within two working days.</p>
        <button onClick={() => setState({ kind: "idle" })} className="link-u mt-6 text-[12px] text-ash hover:text-bone">Send another message</button>
      </div>
    );
  }

  const err = state.kind === "error" ? state.fields ?? {} : {};
  return (
    <form onSubmit={onSubmit} noValidate className="space-y-5">
      <div className="grid gap-5 sm:grid-cols-2">
        <label className="block">
          <span className="mb-2 block text-[12px] text-ash">Name</span>
          <input name="name" required maxLength={120} autoComplete="name" className={field} placeholder="Your name" aria-invalid={!!err.name} />
          {err.name && <span className="mt-1.5 block text-[12px] text-red-400">{err.name}</span>}
        </label>
        <label className="block">
          <span className="mb-2 block text-[12px] text-ash">Email</span>
          <input name="email" type="email" required maxLength={160} autoComplete="email" className={field} placeholder="you@company.com" aria-invalid={!!err.email} />
          {err.email && <span className="mt-1.5 block text-[12px] text-red-400">{err.email}</span>}
        </label>
      </div>
      <label className="block">
        <span className="mb-2 block text-[12px] text-ash">Subject <span className="text-ash/60">(optional)</span></span>
        <input name="subject" maxLength={160} className={field} placeholder="A role, a project, a question" />
      </label>
      <label className="block">
        <span className="mb-2 block text-[12px] text-ash">Message</span>
        <textarea name="message" required rows={6} maxLength={5000} className={`${field} resize-y`} placeholder="What are you building, and how can I help?" aria-invalid={!!err.message} />
        {err.message && <span className="mt-1.5 block text-[12px] text-red-400">{err.message}</span>}
      </label>
      {/* Honeypot: hidden from people, filled in by bots */}
      <input type="text" name="website" tabIndex={-1} autoComplete="off" className="hidden" aria-hidden />

      {state.kind === "error" && <p role="alert" className="text-[13px] text-red-400">{state.message}</p>}

      <button
        type="submit"
        disabled={state.kind === "sending"}
        className="group relative inline-flex items-center gap-3 overflow-hidden rounded-full bg-bone px-7 py-4 text-[13px] text-void transition-colors disabled:opacity-60"
      >
        <span className="absolute inset-0 translate-y-full bg-signal transition-transform duration-300 ease-cut group-hover:translate-y-0" />
        <span className="relative">{state.kind === "sending" ? "Sending…" : "Send message"}</span>
      </button>
    </form>
  );
}
