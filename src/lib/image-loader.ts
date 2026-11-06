/* ImageKit resizes its own images (?tr=w-800,q-75); local files in /public are already sized. */
export default function imageLoader({ src, width, quality }: { src: string; width: number; quality?: number }) {
  if (src.startsWith("https://ik.imagekit.io/")) {
    const sep = src.includes("?") ? "&" : "?";
    return `${src}${sep}tr=w-${width},q-${quality ?? 75}`;
  }
  return src;
}
