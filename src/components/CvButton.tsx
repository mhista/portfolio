import { SITE } from "@/lib/site";
import { Magnetic } from "./Magnetic";

export function CvButton({ className = "" }: { className?: string }) {
  return (
    <Magnetic>
      <a
        href={SITE.cv}
        download="Diwe-Innocent-Esomchi-CV.pdf"
        className={`group relative inline-flex items-center gap-3 overflow-hidden rounded-full border border-bone/30 px-5 py-3 text-[12px] text-bone transition-colors duration-300 hover:border-signal hover:text-void ${className}`}
      >
        <span className="absolute inset-0 -z-0 translate-y-full bg-signal transition-transform duration-300 ease-cut group-hover:translate-y-0" />
        <svg aria-hidden viewBox="0 0 16 16" className="relative h-3.5 w-3.5" fill="none" stroke="currentColor" strokeWidth="1.5">
          <path d="M8 2v9m0 0L4.5 7.5M8 11l3.5-3.5M2.5 14h11" />
        </svg>
        <span className="relative">Download CV</span>
        <span className="relative text-ash group-hover:text-void/70">PDF</span>
      </a>
    </Magnetic>
  );
}
