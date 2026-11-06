import type { Metadata, Viewport } from "next";
import { GeistSans } from "geist/font/sans";
import { GeistMono } from "geist/font/mono";
import "./globals.css";
import { SITE, SOCIALS } from "@/lib/site";
import { Header } from "@/components/Header";
import { Cursor } from "@/components/Cursor";
import { SmoothScroll } from "@/components/SmoothScroll";

export const metadata: Metadata = {
  metadataBase: new URL(SITE.url),
  title: { default: `${SITE.name}, ${SITE.role}`, template: `%s, ${SITE.name}` },
  description: SITE.description,
  keywords: ["Diwe Innocent", "Flutter developer", "Next.js developer", "mobile architect", "Port Harcourt", "Nigeria", "software engineer"],
  authors: [{ name: SITE.fullName, url: SITE.url }],
  openGraph: { title: SITE.name, description: SITE.description, type: "website", siteName: SITE.name, url: SITE.url },
  twitter: { card: "summary_large_image", title: SITE.name, description: SITE.description, creator: "@somtechh" },
  alternates: { canonical: "/" },
};

export const viewport: Viewport = { themeColor: "#0a0a0a", width: "device-width", initialScale: 1 };

const personLd = {
  "@context": "https://schema.org",
  "@type": "Person",
  name: SITE.fullName,
  alternateName: SITE.name,
  jobTitle: SITE.role,
  email: `mailto:${SITE.email}`,
  url: SITE.url,
  image: `${SITE.url}/images/diwe.jpg`,
  address: { "@type": "PostalAddress", addressLocality: "Port Harcourt", addressCountry: "NG" },
  sameAs: SOCIALS.filter((s) => s.label !== "WhatsApp").map((s) => s.href),
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="en" className={`${GeistSans.variable} ${GeistMono.variable}`}>
      <body>
        <a href="#main" className="sr-only focus:not-sr-only focus:fixed focus:left-4 focus:top-4 focus:z-[100] focus:rounded focus:bg-signal focus:px-4 focus:py-2 focus:text-void">
          Skip to content
        </a>
        <Header />
        <main id="main">{children}</main>
        <Cursor />
        <SmoothScroll />
        <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(personLd) }} />
      </body>
    </html>
  );
}
