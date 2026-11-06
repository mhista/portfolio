"use client";

import Link from "next/link";
import { useCallback, useEffect, useRef, useState } from "react";
import { AnimatePresence, motion, useReducedMotion } from "framer-motion";
import type { Project } from "@/lib/projects";
import { SITE, SOCIALS } from "@/lib/site";
import { Scramble } from "./Scramble";
import { Clock } from "./Clock";
import { Cover } from "./Cover";
import { ProjectImage } from "./ProjectImage";
import { CvButton } from "./CvButton";
import { Socials } from "./Socials";

const pad = (n: number) => String(n).padStart(2, "0");
const EASE = [0.65, 0, 0.35, 1] as const;

/* Title size that always fits: on phones the longest word must fit the width (words may wrap);
   on larger screens the whole title fits on one line. 0.7em is roughly one uppercase letter. */
function titleSize(title: string) {
  const longestWord = Math.max(...title.split(" ").map((w) => w.length));
  return {
    "--fs-m": `min(16vw, ${(88 / (longestWord * 0.7)).toFixed(2)}vw)`,
    "--fs-d": `min(12.5vw, 12.5rem, ${(92 / (title.length * 0.7)).toFixed(2)}vw)`,
  } as React.CSSProperties;
}

export function HomeShowcase({ projects, total }: { projects: Project[]; total: number }) {
  const [active, setActive] = useState(0);
  const strip = useRef<HTMLDivElement>(null);
  const reduce = useReducedMotion();
  const p = projects[active];

  /* While we scroll the strip ourselves, ignore scroll events so they don't change the selection mid-animation */
  const programmatic = useRef<ReturnType<typeof setTimeout> | null>(null);
  const scrollToCard = useCallback(
    (i: number) => {
      const el = strip.current;
      const card = el?.children[i] as HTMLElement | undefined;
      if (!el || !card) return;
      if (programmatic.current) clearTimeout(programmatic.current);
      programmatic.current = setTimeout(() => (programmatic.current = null), 700);
      el.scrollTo({ left: card.offsetLeft - (el.clientWidth - card.offsetWidth) / 2, behavior: reduce ? "auto" : "smooth" });
    },
    [reduce],
  );

  /* Vertical mouse wheel scrolls the strip sideways (mouse only; trackpads already scroll sideways) */
  useEffect(() => {
    const el = strip.current;
    if (!el) return;
    const onWheel = (e: WheelEvent) => {
      if (Math.abs(e.deltaY) <= Math.abs(e.deltaX)) return;
      const atStart = el.scrollLeft <= 0 && e.deltaY < 0;
      const atEnd = el.scrollLeft + el.clientWidth >= el.scrollWidth - 1 && e.deltaY > 0;
      if (atStart || atEnd) return; // let the page scroll when the strip can't
      e.preventDefault();
      el.scrollBy({ left: e.deltaY });
    };
    el.addEventListener("wheel", onWheel, { passive: false });
    return () => el.removeEventListener("wheel", onWheel);
  }, []);

  /* On touch screens the card nearest the centre becomes active as you swipe */
  const raf = useRef(0);
  const onScroll = useCallback(() => {
    if (programmatic.current) return;
    cancelAnimationFrame(raf.current);
    raf.current = requestAnimationFrame(() => {
      const el = strip.current;
      if (!el || window.matchMedia("(hover: hover) and (pointer: fine)").matches) return;
      const mid = el.scrollLeft + el.clientWidth / 2;
      let best = 0;
      let dist = Infinity;
      Array.from(el.children).forEach((c, i) => {
        const card = c as HTMLElement;
        const d = Math.abs(card.offsetLeft + card.offsetWidth / 2 - mid);
        if (d < dist) {
          dist = d;
          best = i;
        }
      });
      setActive(best);
    });
  }, []);

  /* Arrow keys move through projects */
  useEffect(() => {
    const onKey = (e: KeyboardEvent) => {
      if ((e.target as HTMLElement)?.closest("input, textarea")) return;
      if (e.key !== "ArrowRight" && e.key !== "ArrowLeft") return;
      const next = (active + (e.key === "ArrowRight" ? 1 : -1) + projects.length) % projects.length;
      setActive(next);
      scrollToCard(next);
    };
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [active, projects.length, scrollToCard]);

  const go = (dir: 1 | -1) => {
    const next = (active + dir + projects.length) % projects.length;
    setActive(next);
    scrollToCard(next);
  };

  return (
    <section className="relative flex min-h-[100svh] flex-col overflow-x-clip pb-8 pt-[4.25rem] sm:pt-20 tall:h-[100svh] tall:overflow-hidden tall:pb-0">
      {/* Backdrop: the active project, very faint (desktop only, it's heavy on phone GPUs) */}
      <AnimatePresence>
        {p.cover && (
          <motion.div
            key={p.slug}
            className="pointer-events-none absolute inset-0 -z-10 hidden md:block"
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

      <h1 className="sr-only">
        {SITE.fullName}, {SITE.role}
      </h1>

      {/* Intro line */}
      <div className="flex flex-wrap items-baseline justify-between gap-x-6 gap-y-1 px-5 pt-3 text-[11px] text-ash sm:px-8 sm:text-[12px] lg:px-12">
        <Scramble as="p" text={SITE.role} onMount delay={150} />
        <Clock />
      </div>

      {/* Active project */}
      <div className="flex flex-col px-5 pt-8 sm:px-8 sm:pt-10 lg:px-12 tall:flex-1 tall:justify-center tall:pt-0">
        <div className="mb-3 flex items-center justify-between gap-4 text-[11px] text-ash sm:justify-start sm:text-[12px]" aria-live="polite">
          <p>
            <span className="text-signal">{pad(active + 1)}</span> / {pad(projects.length)}
            <span className="ml-3 text-bone/70">{p.group}</span>
          </p>
          {/* Phone: previous / next buttons */}
          <div className="flex gap-1 sm:hidden">
            <button onClick={() => go(-1)} aria-label="Previous project" className="grid h-9 w-9 place-items-center rounded-full border border-line text-bone active:bg-coal">
              <svg viewBox="0 0 16 16" className="h-3.5 w-3.5" fill="none" stroke="currentColor" strokeWidth="1.5" aria-hidden><path d="M10 3 5 8l5 5" /></svg>
            </button>
            <button onClick={() => go(1)} aria-label="Next project" className="grid h-9 w-9 place-items-center rounded-full border border-line text-bone active:bg-coal">
              <svg viewBox="0 0 16 16" className="h-3.5 w-3.5" fill="none" stroke="currentColor" strokeWidth="1.5" aria-hidden><path d="m6 3 5 5-5 5" /></svg>
            </button>
          </div>
        </div>

        <Link href={`/work/${p.slug}`} className="group block min-w-0" data-cursor="View">
          <span
            style={titleSize(p.title)}
            className="display block min-h-[0.86em] text-[length:var(--fs-m)] text-balance leading-[0.88] transition-colors duration-300 group-hover:text-signal sm:text-[length:var(--fs-d)] sm:leading-[0.86]"
          >
            <Scramble as="span" text={p.title} onMount />
          </span>
        </Link>

        <div className="mt-4 grid max-w-4xl gap-x-8 gap-y-2 text-[12px] sm:mt-5 sm:grid-cols-[1.4fr_1fr_auto]">
          <p className="min-h-[3em] text-[13px] leading-relaxed text-bone sm:min-h-0 sm:text-[12px]">{p.summary}</p>
          <p className="flex justify-between gap-4 text-ash sm:block">
            <span>{p.role}</span>
            <span className="shrink-0 sm:hidden">{p.year}</span>
          </p>
          <p className="hidden text-ash sm:block">{p.year}</p>
        </div>
      </div>

      {/* Desktop: CV + socials sit above the strip */}
      <div className="mt-8 hidden items-center justify-between gap-4 px-8 sm:flex lg:px-12">
        <div className="flex flex-wrap items-center gap-x-6 gap-y-3">
          <CvButton />
          <Socials className="text-[12px]" />
        </div>
        <Link href="/archive" className="link-u shrink-0 text-[12px] text-ash hover:text-bone">
          See all {total} projects
        </Link>
      </div>

      {/* Project strip */}
      <div className="mt-6 sm:mt-6 tall:pb-8">
        <div
          ref={strip}
          onScroll={onScroll}
          data-lenis-prevent
          className="no-scrollbar flex snap-x snap-mandatory gap-3 overflow-x-auto scroll-px-5 px-5 sm:gap-4 sm:scroll-px-8 sm:px-8 lg:px-12"
          role="list"
          aria-label="Featured projects"
        >
          {projects.map((proj, i) => (
            <motion.div
              key={proj.slug}
              role="listitem"
              className="shrink-0 snap-center sm:snap-start"
              initial={reduce ? false : { opacity: 0, y: 40 }}
              animate={{ opacity: 1, y: 0 }}
              transition={{ delay: 0.35 + Math.min(i, 6) * 0.06, duration: 0.7, ease: EASE }}
            >
              <Link
                href={`/work/${proj.slug}`}
                onMouseEnter={() => setActive(i)}
                onFocus={() => setActive(i)}
                onClick={(e) => {
                  /* On touch, tapping a card that isn't selected selects it first */
                  if (!window.matchMedia("(hover: hover) and (pointer: fine)").matches && i !== active) {
                    e.preventDefault();
                    setActive(i);
                    scrollToCard(i);
                  }
                }}
                data-cursor="Open"
                aria-label={`${proj.title}, ${proj.year}`}
                aria-current={i === active ? "true" : undefined}
                className={`group relative block aspect-[4/3] w-[78vw] max-w-[22rem] overflow-hidden rounded-lg transition-[filter,opacity,transform] duration-500 ease-cut sm:w-[17rem] lg:w-[19rem] ${
                  i === active ? "opacity-100 [filter:none]" : "scale-[0.97] opacity-45 [filter:grayscale(.6)] sm:scale-100 sm:[filter:grayscale(.6)_blur(1.5px)] sm:hover:opacity-80"
                }`}
              >
                {proj.cover ? (
                  <ProjectImage src={proj.cover} alt={proj.title} sizes="(min-width: 1024px) 19rem, (min-width: 640px) 17rem, 78vw" priority={i < 2} />
                ) : (
                  <Cover project={proj} size="sm" />
                )}
                <span className="absolute bottom-2.5 left-3 rounded bg-void/70 px-1.5 py-0.5 text-[11px] backdrop-blur-sm">[{pad(i + 1)}]</span>
                <span className={`absolute inset-x-0 bottom-0 h-0.5 origin-left bg-signal transition-transform duration-500 ease-cut ${i === active ? "scale-x-100" : "scale-x-0"}`} />
              </Link>
            </motion.div>
          ))}
        </div>

        {/* Position indicator */}
        <div className="mt-4 flex items-center gap-3 px-5 sm:px-8 lg:px-12">
          <div className="flex flex-1 gap-1 sm:max-w-xs" aria-hidden>
            {projects.map((proj, i) => (
              <span key={proj.slug} className={`h-0.5 flex-1 rounded-full transition-colors duration-300 ${i === active ? "bg-signal" : "bg-line"}`} />
            ))}
          </div>
          <p className="shrink-0 text-[11px] text-ash">
            <span className="hidden sm:inline">Hover to preview, click to open, ← → to browse</span>
            <span className="sm:hidden">Swipe to browse</span>
          </p>
        </div>
      </div>

      {/* Phone: open the selected project, then CV + socials */}
      <div className="mt-6 space-y-6 px-5 sm:hidden">
        <div className="grid grid-cols-2 gap-3">
          <Link href={`/work/${p.slug}`} className="flex h-12 items-center justify-center rounded-full bg-bone text-[13px] text-void active:bg-signal">
            View {p.title.length > 12 ? "project" : p.title}
          </Link>
          <Link href="/archive" className="flex h-12 items-center justify-center rounded-full border border-line text-[13px] text-bone active:bg-coal">
            All {total} projects
          </Link>
        </div>
        <div className="border-t border-line pt-6">
          <CvButton className="w-full justify-center" block />
          <ul className="mt-4 grid grid-cols-3 gap-2 text-[12px]">
            {SOCIALS.map((s) => (
              <li key={s.label}>
                <a href={s.href} target="_blank" rel="noreferrer" className="flex h-11 items-center justify-center rounded-md border border-line text-bone active:border-signal active:text-signal">
                  {s.label}
                </a>
              </li>
            ))}
          </ul>
        </div>
      </div>
    </section>
  );
}
