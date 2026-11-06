"use client";

import { useCallback, useEffect, useRef, type ElementType } from "react";

/* The original site's text-scramble effect: letters resolve through random glyphs.
   Replays when `text` changes, on mount (`onMount`) and on hover (`onHover`). */

const GLYPHS = "!<>-_\\/[]{}=+*^?#%&$";
const esc = (s: string) => s.replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" })[c]!);

export function useScramble<T extends HTMLElement>(text: string) {
  const ref = useRef<T>(null);
  const frame = useRef(0);
  const current = useRef(text);

  const play = useCallback(
    (to: string = text) => {
      const el = ref.current;
      if (!el) return;
      if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
        el.textContent = to;
        current.current = to;
        return;
      }
      const from = current.current;
      const len = Math.max(from.length, to.length);
      const queue = Array.from({ length: len }, (_, i) => {
        const start = Math.floor(Math.random() * 18);
        return { from: from[i] ?? "", to: to[i] ?? "", start, end: start + 8 + Math.floor(Math.random() * 18), ch: "" };
      });
      let f = 0;
      cancelAnimationFrame(frame.current);
      const tick = () => {
        let out = "";
        let done = 0;
        for (const q of queue) {
          if (f >= q.end) {
            done++;
            out += esc(q.to);
          } else if (f >= q.start) {
            if (!q.ch || Math.random() < 0.3) q.ch = GLYPHS[Math.floor(Math.random() * GLYPHS.length)];
            out += q.to === " " ? " " : `<span style="color:var(--signal)">${esc(q.ch)}</span>`;
          } else out += esc(q.from);
        }
        el.innerHTML = out;
        if (done < queue.length) {
          f++;
          frame.current = requestAnimationFrame(tick);
        } else {
          el.textContent = to;
          current.current = to;
        }
      };
      tick();
    },
    [text],
  );

  useEffect(() => () => cancelAnimationFrame(frame.current), []);
  return { ref, play, current };
}

type Props = {
  text: string;
  as?: ElementType;
  className?: string;
  onMount?: boolean;
  onHover?: boolean;
  delay?: number;
};

export function Scramble({ text, as: Tag = "span", className, onMount = false, onHover = false, delay = 0 }: Props) {
  const { ref, play, current } = useScramble<HTMLElement>(text);
  const first = useRef(true);

  useEffect(() => {
    if (first.current) {
      first.current = false;
      if (onMount) {
        current.current = text.replace(/\S/g, " ");
        const t = setTimeout(() => play(text), delay);
        return () => clearTimeout(t);
      }
      return;
    }
    play(text);
  }, [text, onMount, delay, play, current]);

  return (
    <Tag ref={ref} className={className} aria-label={text} onMouseEnter={onHover ? () => play(text) : undefined}>
      {text}
    </Tag>
  );
}
