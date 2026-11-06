import type { Metadata } from "next";
import { PROJECTS } from "@/lib/projects";
import { ArchiveList } from "@/components/ArchiveList";
import { Footer } from "@/components/Footer";

export const metadata: Metadata = {
  title: "Archive",
  description: "Every project by Diwe Innocent: Flutter apps, Next.js websites, platforms, AI tools and open source.",
  alternates: { canonical: "/archive" },
};

const years = PROJECTS.map((p) => Number(p.year));

export default function ArchivePage() {
  return (
    <>
      <section className="px-5 pt-32 sm:px-8 sm:pt-40 lg:px-12">
        <div className="flex flex-wrap items-end justify-between gap-6">
          <h1 className="display text-[clamp(4rem,17vw,15rem)]">Archive</h1>
          <p className="max-w-xs pb-3 text-[12px] text-ash">
            {PROJECTS.length} projects from {Math.min(...years)} to {Math.max(...years)}, grouped into mobile apps, platforms, websites and tools.
          </p>
        </div>
        <div className="mt-12">
          <ArchiveList projects={PROJECTS} />
        </div>
      </section>
      <Footer />
    </>
  );
}
