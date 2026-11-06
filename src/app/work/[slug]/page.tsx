import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { PROJECTS, getProject } from "@/lib/projects";
import { SITE } from "@/lib/site";
import { Scramble } from "@/components/Scramble";
import { Cover } from "@/components/Cover";
import { ProjectImage } from "@/components/ProjectImage";
import { Gallery } from "@/components/Gallery";
import { Footer } from "@/components/Footer";

type Params = { params: Promise<{ slug: string }> };

export function generateStaticParams() {
  return PROJECTS.map((p) => ({ slug: p.slug }));
}

export async function generateMetadata({ params }: Params): Promise<Metadata> {
  const p = getProject((await params).slug);
  if (!p) return {};
  const image = p.cover?.startsWith("http") ? `${p.cover}?tr=w-1200,q-80` : p.cover;
  return {
    title: p.title,
    description: p.summary,
    alternates: { canonical: `/work/${p.slug}` },
    openGraph: { title: `${p.title}, ${SITE.name}`, description: p.summary, ...(image ? { images: [image] } : {}) },
  };
}

export default async function ProjectPage({ params }: Params) {
  const { slug } = await params;
  const p = getProject(slug);
  if (!p) notFound();
  const i = PROJECTS.indexOf(p);
  const next = PROJECTS[(i + 1) % PROJECTS.length];
  const gallery = p.mobile ? p.images : p.images.slice(1);

  return (
    <>
      <article className="px-5 pt-32 sm:px-8 sm:pt-40 lg:px-12">
        <Link href="/archive" className="link-u text-[12px] text-ash hover:text-bone">Back to the archive</Link>

        <header className="mt-8">
          <Scramble as="h1" text={p.title} onMount className="display block break-words text-[clamp(3rem,11vw,10rem)]" />
          <p className="mt-6 max-w-2xl font-sans text-[clamp(1.15rem,2vw,1.5rem)] leading-snug text-bone/90">{p.summary}</p>

          <dl className="mt-12 grid grid-cols-2 gap-x-8 gap-y-6 border-t border-line pt-6 text-[12px] md:grid-cols-4">
            <div><dt className="text-ash">Year</dt><dd className="mt-1.5">{p.year}</dd></div>
            <div><dt className="text-ash">Role</dt><dd className="mt-1.5">{p.role}</dd></div>
            <div><dt className="text-ash">Status</dt><dd className="mt-1.5">{p.status}</dd></div>
            <div>
              <dt className="text-ash">Links</dt>
              <dd className="mt-1.5 flex flex-col gap-1.5">
                {p.links.length ? (
                  p.links.map((l) => (
                    <a key={l.href} href={l.href} target="_blank" rel="noreferrer" className="link-u w-fit text-signal">
                      {l.label} <span aria-hidden>↗</span>
                    </a>
                  ))
                ) : (
                  <span className="text-ash">Private</span>
                )}
              </dd>
            </div>
          </dl>
        </header>

        {!p.mobile && (
          <div className="mt-12 aspect-[16/9] overflow-hidden rounded-md ring-1 ring-line">
            {p.cover ? <ProjectImage src={p.cover} alt={`${p.title}`} sizes="100vw" priority /> : <Cover project={p} size="lg" />}
          </div>
        )}

        <div className="mt-16 grid gap-14 lg:grid-cols-12">
          <div className="space-y-6 font-sans text-[17px] leading-[1.7] text-bone/85 lg:col-span-7">
            {p.description.map((d) => <p key={d.slice(0, 24)} className="max-w-[65ch]">{d}</p>)}
          </div>
          <aside className="space-y-10 text-[13px] lg:col-span-5">
            <div>
              <h2 className="mb-4 text-[12px] text-ash">What stands out</h2>
              <ul className="space-y-3">
                {p.highlights.map((h) => (
                  <li key={h} className="flex gap-3"><span aria-hidden className="mt-[0.45em] h-1.5 w-1.5 shrink-0 rounded-full bg-signal" />{h}</li>
                ))}
              </ul>
            </div>
            <div>
              <h2 className="mb-4 text-[12px] text-ash">Built with</h2>
              <ul className="flex flex-wrap gap-2">
                {p.stack.map((s) => <li key={s} className="rounded-full border border-line px-3 py-1.5 text-[12px] text-bone/85">{s}</li>)}
              </ul>
            </div>
          </aside>
        </div>

        {gallery.length > 0 && (
          <section className="mt-20" aria-label="Screenshots">
            <h2 className="mb-6 text-[12px] text-ash">Screens</h2>
            <Gallery images={gallery} title={p.title} mobile={p.mobile} />
          </section>
        )}
        {p.mobile && !gallery.length && (
          <div className="mt-16 aspect-[16/9] overflow-hidden rounded-md ring-1 ring-line"><Cover project={p} size="lg" /></div>
        )}

        <Link href={`/work/${next.slug}`} className="group mt-28 block border-t border-line pt-8" data-cursor="Next">
          <span className="text-[12px] text-ash">Next project</span>
          <span className="display mt-3 block text-[clamp(2.5rem,9vw,8rem)] transition-colors duration-300 group-hover:text-signal">{next.title}</span>
        </Link>
      </article>
      <Footer />
    </>
  );
}
