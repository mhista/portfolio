import type { Metadata } from "next";
import Image from "next/image";
import { SITE } from "@/lib/site";
import { BIO, EXPERIENCE, PACKAGES, SKILLS } from "@/lib/profile";
import { Scramble } from "@/components/Scramble";
import { CvButton } from "@/components/CvButton";
import { Socials } from "@/components/Socials";
import { Footer } from "@/components/Footer";

export const metadata: Metadata = {
  title: "Info",
  description: "About Diwe Innocent: experience, skills, open-source packages and how to get in touch.",
  alternates: { canonical: "/info" },
};

export default function InfoPage() {
  return (
    <>
      <section className="px-5 pt-32 sm:px-8 sm:pt-40 lg:px-12">
        <div className="grid gap-12 lg:grid-cols-12 lg:gap-16">
          <div className="lg:col-span-7">
            <Scramble as="h1" text="Info" onMount className="display block text-[clamp(4rem,17vw,14rem)]" />
            <div className="mt-10 space-y-6 font-sans text-[clamp(1.1rem,1.6vw,1.35rem)] leading-[1.6] text-bone/90">
              {BIO.map((b) => <p key={b.slice(0, 20)} className="max-w-[60ch]">{b}</p>)}
            </div>
            <div className="mt-10 flex flex-wrap items-center gap-x-6 gap-y-4">
              <CvButton />
              <a href={`mailto:${SITE.email}`} className="link-u text-[13px] text-signal">{SITE.email}</a>
            </div>
            <p className="mt-6 text-[12px] text-ash">{SITE.availability}.</p>
          </div>
          <div className="lg:col-span-5 lg:pt-6">
            <figure className="group relative aspect-[4/5] overflow-hidden rounded-md ring-1 ring-line">
              <Image
                src="/images/diwe.jpg"
                alt="Diwe Innocent smiling, in a patterned shirt"
                fill
                priority
                sizes="(min-width: 1024px) 40vw, 100vw"
                className="object-cover grayscale transition-[filter,transform] duration-700 ease-cut group-hover:scale-[1.02] group-hover:grayscale-0"
              />
              <figcaption className="absolute bottom-3 left-3 rounded bg-void/70 px-2 py-1 text-[11px] backdrop-blur-sm">{SITE.location}</figcaption>
            </figure>
            <div className="mt-8 text-[13px]">
              <p className="mb-3 text-[12px] text-ash">Find me on</p>
              <Socials withHandles className="flex-col" />
            </div>
          </div>
        </div>
      </section>

      <section className="mt-32 px-5 sm:px-8 lg:px-12" aria-labelledby="exp">
        <h2 id="exp" className="display text-[clamp(2.4rem,7vw,6rem)]">Experience</h2>
        <ol className="mt-10 border-b border-line">
          {EXPERIENCE.map((r) => (
            <li key={r.org + r.period} className="grid gap-3 border-t border-line py-7 md:grid-cols-12 md:gap-6">
              <p className="text-[12px] tabular-nums text-ash md:col-span-2">{r.period}</p>
              <div className="md:col-span-4">
                <p className="font-sans text-[18px] font-semibold leading-snug">{r.title}</p>
                <p className="mt-1 text-[12px] text-ash">{r.org}, {r.place}</p>
              </div>
              <ul className="space-y-2 font-sans text-[15px] leading-relaxed text-bone/80 md:col-span-6">
                {r.points.map((pt) => <li key={pt}>{pt}</li>)}
              </ul>
            </li>
          ))}
        </ol>
      </section>

      <section className="mt-32 px-5 sm:px-8 lg:px-12" aria-labelledby="skills">
        <h2 id="skills" className="display text-[clamp(2.4rem,7vw,6rem)]">Skills</h2>
        <div className="mt-10 grid gap-x-10 gap-y-10 sm:grid-cols-2 lg:grid-cols-3">
          {SKILLS.map((s) => (
            <div key={s.group}>
              <h3 className="border-b border-line pb-3 text-[12px] text-signal">{s.group}</h3>
              <ul className="mt-4 space-y-2 text-[14px] text-bone/85">
                {s.items.map((it) => <li key={it}>{it}</li>)}
              </ul>
            </div>
          ))}
        </div>
      </section>

      <section className="mt-32 px-5 sm:px-8 lg:px-12" aria-labelledby="oss">
        <h2 id="oss" className="display text-[clamp(2.4rem,7vw,6rem)]">Open source</h2>
        <div className="mt-10 grid gap-4 md:grid-cols-2">
          {PACKAGES.map((pkg) => (
            <a key={pkg.name} href={pkg.href} target="_blank" rel="noreferrer" className="group block rounded-md border border-line p-6 transition-colors duration-300 hover:border-signal">
              <div className="flex items-baseline justify-between gap-4">
                <p className="font-sans text-[22px] font-semibold transition-colors group-hover:text-signal">{pkg.name}</p>
                <p className="text-[12px] text-ash">{pkg.version} on pub.dev</p>
              </div>
              <p className="mt-4 max-w-[60ch] font-sans text-[15px] leading-relaxed text-bone/75">{pkg.description}</p>
            </a>
          ))}
        </div>
      </section>
      <Footer />
    </>
  );
}
