import type { Project } from "@/lib/projects";

/* For projects without screenshots: a typographic cover in the project's accent colour. */
export function Cover({ project, size = "md" }: { project: Project; size?: "xs" | "sm" | "md" | "lg" }) {
  const accent = project.accent ?? "#00ff41";
  /* Tiny thumbnails: just the initial on the accent pattern */
  if (size === "xs") {
    return (
      <div className="relative grid h-full w-full place-items-center overflow-hidden bg-coal" aria-hidden
        style={{ background: `radial-gradient(120% 100% at 100% 0%, ${accent}40 0%, transparent 60%), #141414` }}>
        <span className="display text-[22px]" style={{ color: accent }}>{project.title[0]}</span>
      </div>
    );
  }
  const title = size === "lg" ? "text-[clamp(3rem,9vw,8rem)]" : size === "sm" ? "text-2xl" : "text-[clamp(2rem,4vw,3.5rem)]";
  return (
    <div className="relative h-full w-full overflow-hidden bg-coal" aria-hidden>
      <div
        className="absolute inset-0 opacity-70"
        style={{
          background: `radial-gradient(120% 80% at 100% 0%, ${accent}33 0%, transparent 55%),
            repeating-linear-gradient(115deg, transparent 0 22px, ${accent}14 22px 23px)`,
        }}
      />
      <div className="absolute inset-0 flex flex-col justify-between p-5 sm:p-6">
        <div className="flex justify-between text-[11px] text-ash">
          <span>{project.category}</span>
          <span>{project.year}</span>
        </div>
        <p className={`display break-words ${title}`} style={{ color: accent }}>
          {project.title}
        </p>
      </div>
    </div>
  );
}
