import type { Metadata } from "next";
import { SITE } from "@/lib/site";
import { Scramble } from "@/components/Scramble";
import { ContactForm } from "@/components/ContactForm";
import { Socials } from "@/components/Socials";
import { Clock } from "@/components/Clock";
import { CvButton } from "@/components/CvButton";

export const metadata: Metadata = {
  title: "Contact",
  description: "Get in touch with Diwe Innocent about a role, a project or a question.",
  alternates: { canonical: "/contact" },
};

export default function ContactPage() {
  return (
    <>
      <section className="px-5 pb-32 pt-32 sm:px-8 sm:pt-40 lg:px-12">
        <Scramble as="h1" text="Get in touch" onMount className="display block text-[clamp(3.2rem,12vw,11rem)]" />
        <div className="mt-14 grid gap-16 lg:grid-cols-12">
          <div className="lg:col-span-7">
            <p className="mb-10 max-w-[55ch] font-sans text-[18px] leading-relaxed text-bone/85">
              Hiring for a role, planning an app or a website, or want a second opinion on an architecture? Tell me a little about it and I'll get back to you.
            </p>
            <ContactForm />
          </div>
          <aside className="space-y-10 text-[13px] lg:col-span-4 lg:col-start-9">
            <div>
              <p className="mb-2 text-[12px] text-ash">Email</p>
              <a href={`mailto:${SITE.email}`} className="link-u text-signal">{SITE.email}</a>
            </div>
            <div>
              <p className="mb-2 text-[12px] text-ash">Phone and WhatsApp</p>
              <a href={`tel:${SITE.phone.replace(/\s/g, "")}`} className="link-u">{SITE.phone}</a>
            </div>
            <div>
              <p className="mb-2 text-[12px] text-ash">Local time</p>
              <Clock />
            </div>
            <div>
              <p className="mb-3 text-[12px] text-ash">Elsewhere</p>
              <Socials className="flex-col" withHandles />
            </div>
            <CvButton />
          </aside>
        </div>
      </section>
    </>
  );
}
