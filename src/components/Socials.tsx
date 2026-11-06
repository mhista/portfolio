import { SOCIALS } from "@/lib/site";

export function Socials({ className = "", withHandles = false }: { className?: string; withHandles?: boolean }) {
  return (
    <ul className={`flex flex-wrap gap-x-5 gap-y-2 ${className}`}>
      {SOCIALS.map((s) => (
        <li key={s.label}>
          <a href={s.href} target="_blank" rel="noreferrer" className="link-u text-bone hover:text-signal">
            {s.label}
            {withHandles && <span className="ml-2 text-ash">{s.handle}</span>}
          </a>
        </li>
      ))}
    </ul>
  );
}
