"use client";

import Image from "next/image";
import { useState } from "react";

/* next/image with the original site's shimmer placeholder while it loads. */
export function ProjectImage({
  src, alt, sizes, priority, className = "", fit = "cover",
}: { src: string; alt: string; sizes: string; priority?: boolean; className?: string; fit?: "cover" | "contain" }) {
  const [loaded, setLoaded] = useState(false);
  return (
    <div className={`relative h-full w-full overflow-hidden bg-coal ${className}`}>
      {!loaded && <div className="absolute inset-0 animate-shimmer bg-[linear-gradient(90deg,#141414_0%,#222_25%,#141414_50%)] bg-[length:200%_100%]" />}
      <Image
        src={src}
        alt={alt}
        fill
        sizes={sizes}
        priority={priority}
        onLoad={() => setLoaded(true)}
        className={`transition-opacity duration-500 ${loaded ? "opacity-100" : "opacity-0"} ${fit === "cover" ? "object-cover object-top" : "object-contain"}`}
      />
    </div>
  );
}
