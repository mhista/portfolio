"use client";

import Link from "next/link";
import { useCallback, useEffect, useRef, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import type { Project } from "@/lib/projects";
import { SITE } from "@/lib/site";
import { Scramble } from "./Scramble";
import { Clock } from "./Clock";
import { Cover } from "./Cover";
import { ProjectImage } from "./ProjectImage";
import { CvButton } from "./CvButton";
import { Socials } from "./Socials";

const pad = (n: number) => String(n).padStart(2, "0");

export function HomeShowcase({ projects, total }: { projects: Project[]; total: number }) {
  const [active, setActive] = useState(0);
  const strip = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();
  const p = projects[active];

  /* Vertical wheel scrolls the strip sideways on desktop */
  useEffect(() => {
    const el = strip.current;
    if (!el) return;
    const onWheel = (e: WheelEvent) => {
      if (Math.abs(e.deltaY) <= Math.abs(e.deltaX)) return;
      e.preventDefault();
      el.scrollBy({ left: e.deltaY, behavior: "auto" });
    };
    el.addEventListener("wheel", onWheel, { passive: false });
    return () => el.removeEventListener("wheel", onWheel);
  }, []);

  /* On touch screens the card nearest the centre is the active one */
  const onScroll = useCallback(() => {
    const el = strip.current;
    if (!el || window.matchMedia("(hover: hover)").matches) return;
    const mid = el.scrollLeft + el.clientWidth / 2;
    let best = 0, dist = Infinity;
    Array.from(el.children).forEach((c, i) => {
      const card = c as HTMLElement;
      const d = Math.abs(card.offsetLeft + card.offsetWidth / 2 - mid);
      if (d < dist) { dist = d; best = i; }
    });
    setActive(best);
  }, []);

  /* Arrow keys move through projects, Enter opens one */
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.target as HTMLElement)?.closest("input, textarea")) return;
      if (e.key === "ArrowRight" || e.key === "ArrowLeft") {
        const next = (active + (e.key === "ArrowRight" ? 1 : -1) + projects.length) % projects.length;
        setActive(next);
        const card = strip.current?.children[next] as HTMLElement | undefined;
        card?.scrollIntoView({ behavior: reduce ? "auto" : "smooth", inline: "center", block: "nearest" });
      }
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [active, projects.length, reduce]);

  return (
    <section className="relative flex h-[100svh] min-h-[620px] flex-col overflow-hidden pt-16 sm:pt-20">
      {/* Backdrop: the active project, very faint */}
      <AnimatePresence>
        {p.cover && (
          <motion.div
            key={p.slug}
            className="pointer-events-none absolute inset-0 -z-10"
            initial={{ opacity: 0 }}
            animate={{ opacity: 0.16 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.8 }}
          >
            <div className="h-full w-full scale-110 blur-2xl">
              <ProjectImage src={p.cover} alt="" sizes="60vw" className="!bg-transparent" />
            </div>
          </motion.div>
        )}
      </AnimatePresence>

      <div className="flex flex-1 flex-col justify-between gap-6 px-5 sm:px-8 lg:px-12">
        <div className="flex flex-col justify-between gap-2 pt-4 text-[12px] text-ash sm:flex-row">
          <Scramble as="p" text={SITE.role} onMount delay={150} />
          <Clock />
        </div>

        <div className="min-w-0">
          <h1 className="sr-only">{SITE.fullName}, {SITE.role}</h1>
          <p className="mb-3 text-[12px] text-ash" aria-live="polite">
            <span className="text-signal">{pad(active + 1)}</span> / {pad(projects.length)}
            <span className="ml-4 text-bone/70">{p.group}</span>
          </p>
          <Link href={`/work/${p.slug}`} className="group block min-w-0" data-cursor="View">
            <Scramble
              as="h2"
              text={p.title}
              onMount
              className="display block truncate text-[clamp(3.2rem,12.5vw,12.5rem)] transition-colors duration-300 group-hover:text-signal"
            />
          </Link>
          <div className="mt-5 grid max-w-4xl grid-cols-2 gap-x-8 gap-y-3 text-[12px] sm:grid-cols-[1.3fr_1fr_auto]">
            <p className="col-span-2 text-bone sm:col-span-1">{p.summary}</p>
            <p className="text-ash">{p.role}</p>
            <p className="text-right text-ash sm:text-left">{p.year}</p>
          </div>
        </div>

        <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div className="flex flex-wrap items-center gap-x-6 gap-y-4">
            <CvButton />
            <Socials className="text-[12px]" />
          </div>
          <Link href="/archive" className="link-u hidden text-[12px] text-ash hover:text-bone sm:inline">
            See all {total} projects
          </Link>
        </div>
      </div>

      <div className="relative mt-6 pb-5 sm:pb-8">
        <div
          ref={strip}
          onScroll={onScroll}
          data-lenis-prevent
          className="no-scrollbar flex snap-x snap-mandatory gap-3 overflow-x-auto scroll-smooth px-5 sm:gap-4 sm:px-8 lg:px-12"
          role="list"
          aria-label="Featured projects"
        >
          {projects.map((proj, i) => (
            <motion.div
              key={proj.slug}
              role="listitem"
              className="shrink-0 snap-center"
              initial={reduce ? false : { opacity: 0, y: 40 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.35 + i * 0.06, duration: 0.7, ease: [0.65, 0, 0.35, 1] }}
            >
              <Link
                href={`/work/${proj.slug}`}
                onMouseEnter={() => setActive(i)}
                onFocus={() => setActive(i)}
                onClick={(e) => {
                  /* first tap on touch selects, second tap opens */
                  if (!window.matchMedia("(hover: hover)").matches && i !== active) {
                    e.preventDefault();
                    setActive(i);
                    (e.currentTarget.parentElement as HTMLElement).scrollIntoView({ behavior: "smooth", inline: "center", block: "nearest" });
                  }
                }}
                data-cursor="Open"
                aria-label={`${proj.title}, ${proj.year}`}
                className={`group relative block aspect-[4/3] w-[68vw] overflow-hidden rounded-md transition-[filter,opacity,transform] duration-500 ease-cut sm:w-[17rem] lg:w-[19rem] ${
                  i === active ? "opacity-100 [filter:none]" : "opacity-50 [filter:grayscale(.6)_blur(1.5px)] hover:opacity-80"
                }`}
              >
                {proj.cover ? (
                  <ProjectImage src={proj.cover} alt={proj.title} sizes="(min-width: 1024px) 19rem, (min-width: 640px) 17rem, 68vw" priority={i < 3} />
                ) : (
                  <Cover project={proj} size="sm" />
                )}
                <span className="absolute bottom-2.5 left-3 rounded bg-void/70 px-1.5 py-0.5 text-[11px] backdrop-blur-sm">
                  [{pad(i + 1)}]
                </span>
                <span
                  className={`absolute inset-x-0 bottom-0 h-0.5 origin-left bg-signal transition-transform duration-500 ease-cut ${i === active ? "scale-x-100" : "scale-x-0"}`}
                />
              </Link>
            </motion.div>
          ))}
        </div>
        <p className="mt-3 px-5 text-[11px] text-ash sm:px-8 lg:px-12">
          <span className="hidden sm:inline">Hover to preview, click to open. Scroll or use ← → to browse.</span>
          <span className="sm:hidden">Swipe to browse, tap a project twice to open it.</span>
        </p>
      </div>
    </section>
  );
}
