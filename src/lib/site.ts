/* Identity, contact details and social links. Edit here and the whole site updates. */

export const SITE = {
  name: "Diwe Innocent",
  fullName: "Diwe Innocent Esomchi",
  role: "Software Engineer & Mobile Architect",
  tagline: "Flutter, Next.js and the systems behind them",
  description:
    "Diwe Innocent is a software engineer and mobile architect in Port Harcourt, Nigeria. He builds production Flutter apps, Next.js websites and the platforms behind them, across fintech, social commerce, healthcare, edtech and AI.",
  url: process.env.NEXT_PUBLIC_SITE_URL || "https://diweinnocent.vercel.app",
  location: "Port Harcourt, NG",
  timezone: "Africa/Lagos",
  email: "diweesomchi@gmail.com",
  phone: "+234 706 888 4102",
  whatsapp: "https://wa.me/2347068884102",
  cv: "/Diwe-Innocent-Esomchi-CV.pdf",
  availability: "Open to remote roles and selected freelance projects",
};

export type Social = { label: string; handle: string; href: string };

export const SOCIALS: Social[] = [
  { label: "GitHub", handle: "@mhista", href: "https://github.com/mhista" },
  { label: "LinkedIn", handle: "in/diwe-innocent", href: "https://www.linkedin.com/in/diwe-innocent" },
  { label: "X", handle: "@somtechh", href: "https://x.com/somtechh" },
  { label: "pub.dev", handle: "innocentdiwe.qzz.io", href: "https://pub.dev/publishers/innocentdiwe.qzz.io/packages" },
  { label: "WhatsApp", handle: "+234 706 888 4102", href: "https://wa.me/2347068884102" },
  { label: "Kymaa", handle: "kymaa.tech", href: "https://kymaa.tech" },
];

export const NAV = [
  { href: "/", label: "Work" },
  { href: "/archive", label: "Archive" },
  { href: "/info", label: "Info" },
  { href: "/contact", label: "Contact" },
];
