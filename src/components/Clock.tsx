"use client";

import { useEffect, useState } from "react";
import { SITE } from "@/lib/site";

/* Live local time in Port Harcourt. Renders a placeholder on the server to avoid a hydration mismatch. */
export function Clock({ className }: { className?: string }) {
  const [now, setNow] = useState<string | null>(null);
  useEffect(() => {
    const fmt = new Intl.DateTimeFormat("en-GB", { timeZone: SITE.timezone, hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: false });
    const tick = () => setNow(fmt.format(new Date()));
    tick();
    const id = setInterval(tick, 1000);
    return () => clearInterval(id);
  }, []);
  return (
    <span className={className}>
      {SITE.location} <span className="tabular-nums text-bone">{now ?? "--:--:--"}</span>
    </span>
  );
}
