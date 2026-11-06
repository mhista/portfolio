import { FEATURED, PROJECTS } from "@/lib/projects";
import { HomeShowcase } from "@/components/HomeShowcase";

export default function Home() {
  return <HomeShowcase projects={FEATURED} total={PROJECTS.length} />;
}
