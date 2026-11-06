import type { MetadataRoute } from "next";
import { SITE } from "@/lib/site";
import { PROJECTS } from "@/lib/projects";

export default function sitemap(): MetadataRoute.Sitemap {
  const pages = ["", "/archive", "/info", "/contact"].map((p) => ({ url: `${SITE.url}${p}`, changeFrequency: "monthly" as const, priority: p ? 0.8 : 1 }));
  const work = PROJECTS.map((p) => ({ url: `${SITE.url}/work/${p.slug}`, changeFrequency: "yearly" as const, priority: 0.6 }));
  return [...pages, ...work];
}
