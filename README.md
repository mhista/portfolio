# Diwe Innocent — portfolio (v2)

The portfolio rebuilt in Next.js (replacing the Jaspr version), ready for Vercel.

Next.js 15 (App Router) · React 19 · TypeScript · Tailwind CSS 3 · Framer Motion · Lenis · Geist

## What's in it

| Page | What it does |
| --- | --- |
| `/` | Full-screen showcase of featured work. Hover (or swipe on a phone) a project and its title scrambles in; wheel or ← → to browse. Download CV and social links. |
| `/archive` | Every project, filterable by type. On desktop a preview follows the pointer over each row. |
| `/work/[slug]` | Case study: summary, role, status, links, what stands out, stack, screenshots (phone frames for apps) with a full-screen viewer. |
| `/info` | Bio, portrait, experience, skills, open-source packages, socials. |
| `/contact` | Contact form that emails you (Resend or SMTP), with validation, a honeypot and rate limiting. |

Old links still work: `/projects/8` redirects to `/work/driply`, and so on.

Kept from the original design: the dark background with the spira line art, the green accent, the text scramble,
the custom cursor, magnetic buttons and the bracketed active nav link.

## Edit the content

Everything lives in three files:

- `src/lib/site.ts` — name, role, email, phone, CV path, social links.
- `src/lib/projects.ts` — every project. `featured: true` puts it on the home page. Projects without screenshots get a
  generated cover in their `accent` colour; add images to `public/projects/<slug>/` or use ImageKit URLs.
- `src/lib/profile.ts` — bio, experience, skills, packages.

The CV is `public/Diwe-Innocent-Esomchi-CV.pdf`. Replace the file to update it (keep the name).

## Run it

```bash
npm install
cp .env.example .env.local
npm run dev        # http://localhost:3000
npm run build      # production build (also type-checks)
```

## Deploy on Vercel

1. Push this folder to `github.com/mhista/portfolio`.
2. On vercel.com: **Add New → Project → Import** the repo. Vercel detects Next.js; keep the defaults.
3. **Settings → Environment Variables**, then redeploy:
   - `NEXT_PUBLIC_SITE_URL` — your final URL, e.g. `https://diweinnocent.vercel.app` or your own domain.
   - `CONTACT_TO` — where messages go (defaults to diweesomchi@gmail.com).
   - Email, pick one:
     - **Resend:** `RESEND_API_KEY` and `CONTACT_FROM` (a sender on a domain you verified in Resend, e.g. kymaa.tech).
     - **SMTP (Gmail):** `SMTP_HOST=smtp.gmail.com`, `SMTP_PORT=465`, `SMTP_USER`, `SMTP_PASSWORD` (a Gmail *app password*).
   - With neither set, the form still works: it opens the visitor's email app with the message filled in.
4. Optional: **Settings → Domains** to add a custom domain.

Nothing needs a server process or Docker, which is what made the Render deploy fragile: every page is pre-rendered
static HTML, and only `/api/contact` runs as a serverless function.
