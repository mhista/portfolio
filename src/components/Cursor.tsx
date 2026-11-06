"use client";

import { useEffect, useRef } from "react";

/* A dot that follows the mouse exactly and a ring that trails it. The ring grows over
   anything clickable. Only on devices with a real mouse; off for reduced motion. */
export function Cursor() {
  const dot = useRef<HTMLDivElement>(null);
  const ring = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const fine = window.matchMedia("(hover: hover) and (pointer: fine)").matches;
    const reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    if (!fine || reduced) return;
    document.documentElement.classList.add("has-cursor");

    let x = -100, y = -100, rx = -100, ry = -100, raf = 0;
    const move = (e: PointerEvent) => {
      x = e.clientX;
      y = e.clientY;
      if (dot.current) dot.current.style.transform = `translate3d(${x}px, ${y}px, 0)`;
      const target = e.target as HTMLElement | null;
      const hot = !!target?.closest("a, button, [data-cursor]");
      ring.current?.classList.toggle("is-hot", hot);
      const label = target?.closest<HTMLElement>("[data-cursor]")?.dataset.cursor ?? "";
      if (ring.current) ring.current.dataset.label = label;
    };
    const loop = () => {
      rx += (x - rx) * 0.18;
      ry += (y - ry) * 0.18;
      if (ring.current) ring.current.style.transform = `translate3d(${rx}px, ${ry}px, 0)`;
      raf = requestAnimationFrame(loop);
    };
    const down = () => ring.current?.classList.add("is-down");
    const up = () => ring.current?.classList.remove("is-down");
    const leave = () => { x = y = -100; };

    window.addEventListener("pointermove", move);
    window.addEventListener("pointerdown", down);
    window.addEventListener("pointerup", up);
    document.addEventListener("pointerleave", leave);
    raf = requestAnimationFrame(loop);
    return () => {
      cancelAnimationFrame(raf);
      window.removeEventListener("pointermove", move);
      window.removeEventListener("pointerdown", down);
      window.removeEventListener("pointerup", up);
      document.removeEventListener("pointerleave", leave);
      document.documentElement.classList.remove("has-cursor");
    };
  }, []);

  return (
    <div aria-hidden className="pointer-events-none fixed inset-0 z-[200] hidden [@media(hover:hover)_and_(pointer:fine)]:block">
      <div ref={dot} className="absolute left-0 top-0 -ml-[3px] -mt-[3px] h-[6px] w-[6px] rounded-full bg-signal" />
      <div ref={ring} className="cursor-ring absolute left-0 top-0" />
      <style>{`
        .cursor-ring { width: 36px; height: 36px; margin: -18px 0 0 -18px; border: 1px solid rgba(242,242,238,.45); border-radius: 999px;
          transition: width .3s var(--cut), height .3s var(--cut), margin .3s var(--cut), border-color .3s, background-color .3s; }
        .cursor-ring.is-hot { width: 64px; height: 64px; margin: -32px 0 0 -32px; border-color: var(--signal); background: rgba(0,255,65,.06); }
        .cursor-ring.is-down { width: 26px; height: 26px; margin: -13px 0 0 -13px; }
        .cursor-ring[data-label]:not([data-label=""])::after { content: attr(data-label); position: absolute; inset: 0; display: grid; place-items: center;
          font: 500 10px/1 var(--font-geist-mono); letter-spacing: .04em; color: var(--signal); }
      `}</style>
    </div>
  );
}
