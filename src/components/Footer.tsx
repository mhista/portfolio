import Link from "next/link";
import { SITE } from "@/lib/site";
import { Socials } from "./Socials";
import { CvButton } from "./CvButton";

export function Footer() {
  return (
    <footer className="mt-32 border-t border-line px-5 pb-10 pt-16 sm:px-8 lg:px-12">
      <div className="grid gap-12 lg:grid-cols-12">
        <div className="lg:col-span-7">
          <p className="text-[12px] text-ash">Have something in mind?</p>
          <a href={`mailto:${SITE.email}`} className="display mt-4 block text-[clamp(1.6rem,5.2vw,4.75rem)] normal-case leading-[0.95] tracking-[-0.04em] transition-colors hover:text-signal">
            {SITE.email.split("@")[0]}<wbr />@{SITE.email.split("@")[1]}
          </a>
          <div className="mt-8 flex flex-wrap items-center gap-4">
            <CvButton />
            <Link href="/contact" className="link-u text-[12px] text-ash hover:text-bone">Or send a message</Link>
          </div>
        </div>
        <div className="space-y-8 text-[13px] lg:col-span-5 lg:pt-8">
          <div>
            <p className="mb-3 text-[12px] text-ash">Elsewhere</p>
            <Socials withHandles className="flex-col" />
          </div>
          <div>
            <p className="mb-3 text-[12px] text-ash">Phone</p>
            <a href={`tel:${SITE.phone.replace(/\s/g, "")}`} className="link-u">{SITE.phone}</a>
          </div>
        </div>
      </div>
      <div className="mt-16 flex flex-col justify-between gap-3 text-[11px] text-ash sm:flex-row">
        <p>© {new Date().getFullYear()} {SITE.fullName}</p>
        <p>
          Designed and built by me at <a href="https://kymaa.tech" target="_blank" rel="noreferrer" className="link-u hover:text-bone">Kymaa</a>
        </p>
      </div>
    </footer>
  );
}
