import { readFileSync } from "node:fs";

/* Old Jaspr URLs (/projects/8) -> new ones (/work/driply), read from src/lib/projects.ts */
const src = readFileSync(new URL("./src/lib/projects.ts", import.meta.url), "utf8");
const legacy = [...src.matchAll(/slug: "([^"]+)",\s*legacyId: "(\d+)"/g)].map(([, slug, id]) => ({
  source: `/projects/${id}`,
  destination: `/work/${slug}`,
  permanent: true,
}));

/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  poweredByHeader: false,
  images: {
    loader: "custom",
    loaderFile: "./src/lib/image-loader.ts",
  },
  async redirects() {
    return [...legacy, { source: "/projects", destination: "/archive", permanent: true }];
  },
  async headers() {
    return [
      {
        source: "/:path*",
        headers: [
          { key: "X-Frame-Options", value: "DENY" },
          { key: "X-Content-Type-Options", value: "nosniff" },
          { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
          { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=()" },
        ],
      },
      { source: "/projects/:path*", headers: [{ key: "Cache-Control", value: "public, max-age=31536000, immutable" }] },
    ];
  },
};
export default nextConfig;
