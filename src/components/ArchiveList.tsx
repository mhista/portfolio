"use client";

import Link from "next/link";
import { useMemo, useRef, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import { GROUPS, type Group, type Project } from "@/lib/projects";
import { Cover } from "./Cover";
import { ProjectImage } from "./ProjectImage";

/* Index of every project. On desktop a preview follows the pointer over each row. */
export function ArchiveList({ projects }: { projects: Project[] }) {
  const [filter, setFilter] = useState<Group | "All">("All");
  const [hover, setHover] = useState<Project | null>(null);
  const preview = useRef<HTMLDivElement>(null);

  const sections = useMemo(
    () => GROUPS.filter((g) => filter === "All" || g === filter).map((g) => ({ group: g, items: projects.filter((p) => p.group === g) })),
    [filter, projects],
  );
  const counts = useMemo(
    () => Object.fromEntries([["All", projects.length], ...GROUPS.map((g) => [g, projects.filter((p) => p.group === g).length])]),
    [projects],
  );

  const onMove = (e: React.PointerEvent) => {
    if (preview.current) preview.current.style.transform = `translate3d(${e.clientX + 24}px, ${e.clientY - 110}px, 0)`;
  };

  return (
    <div onPointerMove={onMove}>
      <div role="group" aria-label="Filter projects" className="flex flex-wrap gap-2">
        {(["All", ...GROUPS] as const).map((k) => (
          <button
            key={k}
            onClick={() => setFilter(k)}
            aria-pressed={filter === k}
            className={`rounded-full border px-3.5 py-1.5 text-[12px] transition-colors duration-200 ${
              filter === k ? "border-signal bg-signal text-void" : "border-line text-ash hover:border-bone/40 hover:text-bone"
            }`}
          >
            {k} <span className={filter === k ? "text-void/60" : "text-ash/60"}>{counts[k]}</span>
          </button>
        ))}
      </div>

      <div onPointerLeave={() => setHover(null)}>
      {sections.map(({ group, items }) => (
      <section key={group} className="mt-14 first:mt-10" aria-labelledby={`g-${group}`}>
        <div className="mb-4 flex items-baseline justify-between gap-4">
          <h2 id={`g-${group}`} className="font-sans text-[20px] font-semibold sm:text-[24px]">{group}</h2>
          <span className="text-[12px] text-ash">{items.length} {items.length === 1 ? "project" : "projects"}</span>
        </div>
      <ul className="border-b border-line">
        <AnimatePresence initial={false}>
          {items.map((p) => (
            <motion.li key={p.slug} layout initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }} transition={{ duration: 0.25 }} className="border-t border-line">
              <Link
                href={`/work/${p.slug}`}
                onPointerEnter={(e) => e.pointerType === "mouse" && setHover(p)}
                onFocus={() => setHover(null)}
                className="group grid grid-cols-[auto_1fr_auto] items-center gap-x-4 gap-y-1 py-5 sm:grid-cols-[3.5rem_1fr_14rem_6.5rem] sm:gap-x-6 sm:py-6"
              >
                <span className="h-12 w-16 overflow-hidden rounded sm:hidden">
                  {p.cover ? <ProjectImage src={p.cover} alt="" sizes="64px" /> : <Cover project={p} size="xs" />}
                </span>
                <span className="hidden text-[12px] text-ash sm:block">{p.year}</span>
                <span className="display min-w-0 text-[clamp(1.6rem,4.2vw,3.6rem)] transition-[color,transform] duration-300 ease-cut group-hover:translate-x-2 group-hover:text-signal">
                  {p.title}
                </span>
                <span className="col-span-2 col-start-2 text-[12px] text-ash sm:col-span-1 sm:col-start-auto">{p.category}</span>
                <span className="col-start-3 row-start-1 text-right text-[11px] text-ash sm:col-start-auto sm:row-start-auto">
                  <span className="sm:hidden">{p.year}</span>
                  <span className="hidden sm:inline">{p.status}</span>
                </span>
              </Link>
            </motion.li>
          ))}
        </AnimatePresence>
      </ul>
      </section>
      ))}
      </div>

      <div ref={preview} aria-hidden className="pointer-events-none fixed left-0 top-0 z-40 hidden [@media(hover:hover)_and_(pointer:fine)]:block">
        <AnimatePresence>
          {hover && (
            <motion.div
              key={hover.slug}
              initial={{ opacity: 0, scale: 0.9, rotate: -2 }}
              animate={{ opacity: 1, scale: 1, rotate: 0 }}
              exit={{ opacity: 0, scale: 0.95 }}
              transition={{ duration: 0.3, ease: [0.65, 0, 0.35, 1] }}
              className="h-[220px] w-[300px] overflow-hidden rounded-md shadow-2xl shadow-black/60"
            >
              {hover.cover ? <ProjectImage src={hover.cover} alt="" sizes="300px" /> : <Cover project={hover} size="sm" />}
            </motion.div>
          )}
        </AnimatePresence>
      </div>
    </div>
  );
}
