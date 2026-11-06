import Link from "next/link";

export default function NotFound() {
  return (
    <section className="flex min-h-[100svh] flex-col items-start justify-center px-5 sm:px-8 lg:px-12">
      <p className="text-[12px] text-ash">404</p>
      <h1 className="display mt-4 text-[clamp(3rem,12vw,10rem)]">Not here</h1>
      <p className="mt-6 max-w-md text-[13px] text-ash">That page doesn't exist, or it moved when the site was rebuilt.</p>
      <div className="mt-8 flex gap-6 text-[13px]">
        <Link href="/" className="link-u text-signal">Go to the work</Link>
        <Link href="/archive" className="link-u">Browse the archive</Link>
      </div>
    </section>
  );
}
