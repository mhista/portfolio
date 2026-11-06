/* Bio, experience, skills and open-source work for the Info page. */

export const BIO = [
  "I'm a software engineer and mobile architect in Port Harcourt, Nigeria. I build production Flutter apps, Next.js websites and the platforms behind them, and I care about the whole journey of a feature: the plan, the build, the launch and what the numbers say afterwards.",
  "Most recently I led Flutter development at Grascope Technology, where I architected Merkado OS and wrote the shared Flutter SDK behind five consumer products. Through my studio, Kymaa, I design and ship websites and apps for clients in legal, education, healthcare, e-commerce, fintech and the nonprofit sector.",
  "I write the PRD or the architecture doc before the code, and I publish what I can as open source.",
];

export type Role = { period: string; title: string; org: string; place: string; points: string[] };

export const EXPERIENCE: Role[] = [
  {
    period: "2023 — Now",
    title: "Founder · Independent Flutter & Web Engineer",
    org: "Kymaa",
    place: "Remote",
    points: [
      "Design and deliver Flutter and web projects for clients across legal, education, healthcare, e-commerce, fintech and nonprofits",
      "Shipped aaci.ngo, Turuchi Law Firm, Acegraphiix, PSKY Business School and Kolaa",
    ],
  },
  {
    period: "2024 — 2026",
    title: "Flutter Technical Lead & Mobile Architect",
    org: "Grascope Technology",
    place: "Port Harcourt",
    points: [
      "Led Flutter development across the consumer product suite: MyCut, Driply, ItsYourDay",
      "Sole author of the Merkado Flutter SDK: wallet, SSO, trust system, design system and KYC",
      "Wrote the PRDs, SRS documents and architecture proposals",
    ],
  },
  {
    period: "2024 — 2025",
    title: "Tech Lead, Port Harcourt Chapter",
    org: "Superteam Nigeria (Solana)",
    place: "Port Harcourt",
    points: ["Ran workshops, meetups and hackathon participation, and mentored developers entering Web3"],
  },
  {
    period: "2023",
    title: "ICT Trainer",
    org: "Excelsior Royal Schools",
    place: "Imo State",
    points: ["Taught programming logic, problem-solving and beginner-friendly AI tools"],
  },
  {
    period: "2021",
    title: "Software Developer Intern",
    org: "Aptech Computer Institute",
    place: "Nigeria",
    points: ["Built and maintained web and mobile apps with senior developers"],
  },
];

export const SKILLS: { group: string; items: string[] }[] = [
  { group: "Mobile", items: ["Flutter 3.x (iOS, Android, Web)", "Dart", "Bloc / Cubit", "Riverpod", "Hive", "Drift", "Firebase", "HLS video", "Agora"] },
  { group: "Web", items: ["Next.js 15", "React 19", "TypeScript", "Tailwind CSS", "Framer Motion", "Astro", "Jaspr (Dart SSR)", "SEO & JSON-LD"] },
  { group: "Backend & data", items: ["Node.js", "Serverpod", "Supabase", "PostgreSQL", "Redis", "REST", "WebSockets / SSE", "Resend"] },
  { group: "Cloud & tooling", items: ["Vercel", "Cloudflare Workers", "AWS (EC2, S3, Lambda)", "Docker", "GitHub Actions", "ImageKit"] },
  { group: "AI", items: ["Anthropic", "OpenAI", "Gemini", "Groq", "WhatsApp & Telegram bots", "AI pipelines"] },
  { group: "Payments & security", items: ["Paystack", "Fincra", "Metamap KYC", "Ed25519 / AES-GCM", "NFC / Android HCE", "Solana / Web3"] },
  { group: "Architecture & product", items: ["SDK design", "Multi-tenant platforms", "Design systems", "PRDs & SRS", "Offline-first apps"] },
];

export const PACKAGES = [
  {
    name: "common_utils2",
    version: "v3.0.1",
    href: "https://pub.dev/packages/common_utils2",
    description: "24+ Flutter utilities: video preloading, notification centre, concurrent downloads, multi-engine storage, Dio token management, connectivity and geofencing, Nigerian bank and BVN/NIN validation.",
  },
  {
    name: "common_designs",
    version: "v1.1.6",
    href: "https://pub.dev/packages/common_designs",
    description: "A Flutter design system with 60+ animated components: transitions, list animations, skeleton loaders, pull-to-refresh, swipe-to-delete, onboarding carousels and light/dark schemes.",
  },
];
