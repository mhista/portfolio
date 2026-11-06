"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { NAV, SITE } from "@/lib/site";
import { Scramble } from "./Scramble";

export function Header() {
  const pathname = usePathname();
  const isActive = (href: string) => (href === "/" ? pathname === "/" || pathname.startsWith("/work") : pathname.startsWith(href));

  return (
    <header className="fixed inset-x-0 top-0 z-50 bg-gradient-to-b from-void via-void/80 to-transparent">
      <div className="flex items-center justify-between gap-6 px-5 py-5 text-[12px] sm:px-8 lg:px-12">
        <Link href="/" className="shrink-0 uppercase tracking-[0.08em]" aria-label={`${SITE.name}, home`}>
          <Scramble text={SITE.name} onHover />
        </Link>
        <nav aria-label="Main">
          <ul className="flex items-center gap-3 sm:gap-8">
            {NAV.map((item) => {
              const active = isActive(item.href);
              return (
                <li key={item.href} className={item.href === "/" ? "hidden sm:block" : undefined}>
                  <Link
                    href={item.href}
                    aria-current={active ? "page" : undefined}
                    className={`whitespace-nowrap transition-colors duration-200 hover:text-signal ${active ? "text-bone" : "text-ash"}`}
                  >
                    <span aria-hidden className={`text-signal transition-opacity ${active ? "opacity-100" : "opacity-0"}`}>[ </span>
                    <Scramble text={item.label} onHover />
                    <span aria-hidden className={`text-signal transition-opacity ${active ? "opacity-100" : "opacity-0"}`}> ]</span>
                  </Link>
                </li>
              );
            })}
          </ul>
        </nav>
      </div>
    </header>
  );
}
