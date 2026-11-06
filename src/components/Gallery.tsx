"use client";

import { useEffect, useState } from "react";
import { AnimatePresence, motion } from "framer-motion";
import Image from "next/image";
import { ProjectImage } from "./ProjectImage";

/* Screenshots: phone frames in a row for mobile apps, large frames for the web.
   Clicking one opens it full screen; Esc, arrows or a click close/move. */
export function Gallery({ images, title, mobile }: { images: string[]; title: string; mobile?: boolean }) {
  const [open, setOpen] = useState<number | null>(null);

  useEffect(() => {
    if (open === null) return;
    const onKey = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(null);
      if (e.key === "ArrowRight") setOpen((i) => (i === null ? i : (i + 1) % images.length));
      if (e.key === "ArrowLeft") setOpen((i) => (i === null ? i : (i - 1 + images.length) % images.length));
    };
    window.addEventListener("keydown", onKey);
    document.body.style.overflow = "hidden";
    return () => {
      window.removeEventListener("keydown", onKey);
      document.body.style.overflow = "";
    };
  }, [open, images.length]);

  if (!images.length) return null;

  return (
    <>
      {mobile ? (
        <div data-lenis-prevent className="no-scrollbar -mx-5 flex snap-x gap-4 overflow-x-auto px-5 pb-4 sm:-mx-8 sm:px-8 lg:-mx-12 lg:px-12">
          {images.map((src, i) => (
            <button
              key={src + i}
              onClick={() => setOpen(i)}
              data-cursor="Zoom"
              aria-label={`Open screenshot ${i + 1} of ${images.length}`}
              className="relative aspect-[9/19.5] w-[58vw] shrink-0 snap-start overflow-hidden rounded-[2rem] border-[6px] border-coal bg-coal ring-1 ring-line transition-transform duration-500 ease-cut hover:-translate-y-2 sm:w-[15rem]"
            >
              <ProjectImage src={src} alt={`${title} screenshot ${i + 1}`} sizes="(min-width: 640px) 15rem, 58vw" />
            </button>
          ))}
        </div>
      ) : (
        <div className="grid gap-4 sm:grid-cols-2">
          {images.map((src, i) => (
            <button
              key={src + i}
              onClick={() => setOpen(i)}
              data-cursor="Zoom"
              aria-label={`Open screenshot ${i + 1} of ${images.length}`}
              className={`relative overflow-hidden rounded-md ring-1 ring-line ${i === 0 ? "aspect-[16/9] sm:col-span-2" : "aspect-[4/3]"}`}
            >
              <ProjectImage src={src} alt={`${title} screenshot ${i + 1}`} sizes={i === 0 ? "100vw" : "(min-width: 640px) 50vw, 100vw"} className="transition-transform duration-700 ease-cut hover:scale-[1.03]" />
            </button>
          ))}
        </div>
      )}

      <AnimatePresence>
        {open !== null && (
          <motion.div
            role="dialog"
            aria-modal="true"
            aria-label={`${title} screenshot ${open + 1} of ${images.length}`}
            className="fixed inset-0 z-[150] flex items-center justify-center bg-void/95 p-4 backdrop-blur"
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            onClick={() => setOpen(null)}
          >
            <motion.div key={open} initial={{ opacity: 0, scale: 0.96 }} animate={{ opacity: 1, scale: 1 }} className="relative h-[86vh] w-full max-w-6xl">
              <Image src={images[open]} alt={`${title} screenshot ${open + 1}`} fill sizes="100vw" className="object-contain" />
            </motion.div>
            <div className="absolute inset-x-0 bottom-5 flex items-center justify-center gap-6 text-[12px] text-ash">
              <button onClick={(e) => { e.stopPropagation(); setOpen((open - 1 + images.length) % images.length); }} className="hover:text-signal">Previous</button>
              <span className="tabular-nums text-bone">{open + 1} / {images.length}</span>
              <button onClick={(e) => { e.stopPropagation(); setOpen((open + 1) % images.length); }} className="hover:text-signal">Next</button>
            </div>
            <button onClick={() => setOpen(null)} className="absolute right-5 top-5 text-[12px] text-ash hover:text-signal">Close</button>
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
}
