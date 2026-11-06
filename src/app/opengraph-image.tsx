import { ImageResponse } from "next/og";
import { SITE } from "@/lib/site";

export const alt = `${SITE.name}, ${SITE.role}`;
export const size = { width: 1200, height: 630 };
export const contentType = "image/png";

export default function OG() {
  return new ImageResponse(
    (
      <div style={{ width: "100%", height: "100%", display: "flex", flexDirection: "column", justifyContent: "space-between", background: "#0a0a0a", color: "#f2f2ee", padding: 72 }}>
        <div style={{ display: "flex", justifyContent: "space-between", fontSize: 26, color: "#8c8c86" }}>
          <span>{SITE.role}</span>
          <span>{SITE.location}</span>
        </div>
        <div style={{ display: "flex", flexDirection: "column" }}>
          <div style={{ fontSize: 150, fontWeight: 800, letterSpacing: -7, lineHeight: 0.9, textTransform: "uppercase" }}>Diwe</div>
          <div style={{ fontSize: 150, fontWeight: 800, letterSpacing: -7, lineHeight: 0.9, textTransform: "uppercase", color: "#00ff41" }}>Innocent</div>
        </div>
        <div style={{ fontSize: 28, color: "#8c8c86" }}>{SITE.tagline}</div>
      </div>
    ),
    size,
  );
}
