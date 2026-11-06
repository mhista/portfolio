"use client";

import { motion, useReducedMotion } from "framer-motion";

/* Runs on every navigation: the new page rises in while a signal-green line sweeps across. */
export default function Template({ children }: { children: React.ReactNode }) {
  const reduce = useReducedMotion();
  if (reduce) return <>{children}</>;
  return (
    <>
      <motion.div
        aria-hidden
        className="pointer-events-none fixed inset-x-0 top-0 z-[60] h-px origin-left bg-signal"
        initial={{ scaleX: 0, opacity: 1 }}
        animate={{ scaleX: 1, opacity: 0 }}
        transition={{ scaleX: { duration: 0.6, ease: [0.65, 0, 0.35, 1] }, opacity: { delay: 0.5, duration: 0.3 } }}
      />
      <motion.div initial={{ opacity: 0, y: 14 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.5, ease: [0.65, 0, 0.35, 1] }}>
        {children}
      </motion.div>
    </>
  );
}
