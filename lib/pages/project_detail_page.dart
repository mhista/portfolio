import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:port/components/shimmer_image.dart';
import '../models/project.dart';
import '../services/project_service.dart';
import '../components/footer.dart';

@client
class ProjectDetailPage extends StatefulComponent {
  final String projectId;

  const ProjectDetailPage({required this.projectId, super.key});

  @override
  State createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  Project? project;
  bool loading = false;
  int currentImageIndex = 0;
  bool isMobile = false;

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  void _loadProject() {
    final projects = ProjectService.getMockProjects();
    project = projects.firstWhere((pp) => pp.id == component.projectId);
  }

  void _nextImage() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % (project?.images?.length ?? 1);
    });
  }

  void _prevImage() {
    setState(() {
      final imagesLength = project?.images?.length ?? 1;
      currentImageIndex = (currentImageIndex - 1 + imagesLength) % imagesLength;
    });
  }

  @override
  Component build(BuildContext context) {
    if (loading) {
      return div(classes: 'min-h-screen bg-black text-white flex items-center justify-center', [
        Component.text('LOADING PROJECT...'),
      ]);
    }

    if (project == null) {
      return div(classes: 'min-h-screen bg-black text-white flex items-center justify-center', [
        h1(classes: 'text-4xl', [Component.text('PROJECT NOT FOUND')]),
      ]);
    }

    return div(classes: 'min-h-screen bg-black text-white', [
      // Hero section with split layout
      div(classes: 'container mx-auto px-6 md:px-12 py-20', [
        div(classes: 'grid md:grid-cols-2 gap-16 items-start', [
          // Left side - Project info
          div(classes: 'space-y-12', [
            // Title
            h1(classes: 'text-[clamp(2.5rem,8vw,6rem)] font-bold leading-none tracking-tight mb2', [
              Component.text(project!.title),
            ]),

            // Metadata grid
            div(classes: 'grid grid-cols-2 gap-8 text-sm', [
              div([
                div(classes: 'text-gray-500 mb-2 tracking-wider', [Component.text('YEAR')]),
                div(classes: 'text-white font-mono', [Component.text(project!.year)]),
              ]),
              div([
                div(classes: 'text-gray-500 mb-2 tracking-wider', [Component.text('SERVICES')]),
                div(classes: 'text-white', [
                  Component.text('BRANDING'),
                  br(),
                  Component.text('DESIGN'),
                  br(),
                  Component.text('DEVELOPMENT'),
                ]),
              ]),
              div([
                div(classes: 'text-gray-500 mb-2 tracking-wider', [Component.text('LIVE SITE')]),
                if (project!.projectUrl != null)
                  a(
                    href: project!.projectUrl!,
                    classes: 'text-white hover:text-gray-400 transition-colors inline-flex items-center gap-2',
                    [
                      Component.text(project!.title.toUpperCase()),
                      span([Component.text('↗')]),
                    ],
                  )
                else
                  div(classes: 'text-white', [Component.text('—')]),
              ]),
              div([
                div(classes: 'text-gray-500 mb-2 tracking-wider', [Component.text('CARBON FOOTPRINT')]),
                div(classes: 'text-white font-mono', [
                  Component.text('0.32 G/CO2 '),
                  span(classes: 'text-green-500', [Component.text('[B]')]),
                ]),
                div(classes: 'text-xs text-gray-600 mt-1', [
                  Component.text('CLEANER THAN 65% OF WEB PAGES.'),
                ]),
                div(classes: 'text-xs text-gray-600', [
                  Component.text('SOURCE: WEBSITECARBON.COM'),
                ]),
              ]),
            ]),

            // Technologies section
            div(classes: 'container mx-auto', [
              div(classes: 'grid md:grid-cols-2 gap-16', [
                div([
                  h3(classes: 'text-sm text-gray-500 mb-4 tracking-wider', [Component.text('TECHNOLOGIES')]),
                  div(classes: 'flex flex-wrap gap-3', [
                    for (var tech in project!.technologies)
                      span(
                        classes: 'px-4 py-2 bg-gray-900 hover:bg-gray-800 rounded-full text-xs transition-colors',
                        [Component.text(tech)],
                      ),
                  ]),
                ]),
                div([
                  h3(classes: 'text-sm text-gray-500 mb-4 tracking-wider', [Component.text('RESULTS')]),
                  div(classes: 'space-y-3 text-xs', [
                    for (var result in project!.results!) p([Component.text(result)]),
                  ]),
                ]),
              ]),
            ]),
          ]),

          // Right side - Hero image
          div(classes: 'relative', [
            div(classes: 'aspect-[4/3] bg-gradient-to-br from-gray-900 to-black rounded-lg overflow-hidden', [
              img(
                src: project!.imageUrl,
                alt: project!.title,
                classes: 'w-full h-full object-fit',
              ),
            ]),
          ]),
        ]),
      ]),

      // Description section
      div(classes: 'container mx-auto px-6 md:px-12 py-16 border-t border-gray-900', [
        div(classes: 'max-w-4xl', [
          p(classes: 'text-xl md:text-2xl leading-relaxed', [
            Component.text(
              project!.description,
            ),
          ]),
        ]),
      ]),

      // Image gallery section with carousel
      div(classes: 'py-20 bg-gradient-to-b from-black to-gray-950', [
        div(classes: 'container mx-auto px-6 md:px-12', [
          // Gallery carousel
          div(classes: 'relative aspect-[16/9] bg-gray-900 rounded-lg overflow-hidden', [
            ShimmerImage(
              src: project!.images![currentImageIndex],
              alt: 'Project image ${currentImageIndex + 1}',
              classes: 'w-full h-full object-fit transition-opacity duration-500',
            ),

            // Navigation buttons
            button(
              onClick: () => _prevImage(),
              classes:
                  'absolute left-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black bg-opacity-50 hover:bg-opacity-80 rounded-full flex items-center justify-center text-white transition-all',
              [Component.text('←')],
            ),
            button(
              onClick: () => _nextImage(),
              classes:
                  'absolute right-4 top-1/2 -translate-y-1/2 w-12 h-12 bg-black bg-opacity-50 hover:bg-opacity-80 rounded-full flex items-center justify-center text-white transition-all',
              [Component.text('→')],
            ),

            // Image counter
            div(
              classes:
                  'absolute bottom-4 left-1/2 -translate-x-1/2 text-sm font-mono bg-black bg-opacity-50 px-4 py-2 rounded-full',
              [
                Component.text('${currentImageIndex + 1} / ${project!.images!.length}'),
              ],
            ),
          ]),

          // Thumbnails
          div(classes: 'grid grid-cols-3 gap-4 mt-6', [
            for (var i = 0; i < project!.images!.length; i++)
              button(
                onClick: () => setState(() => currentImageIndex = i),
                classes:
                    'aspect-video rounded overflow-hidden ${i == currentImageIndex ? 'ring-2 ring-white' : 'opacity-50 hover:opacity-100'} transition-all',
                [
                  ShimmerImage(
                    src: project!.images![i],
                    alt: 'Thumbnail ${i + 1}',
                    classes: 'w-full h-full object-fit',
                  ),
                ],
              ),
          ]),
        ]),
      ]),

      // Footer
      Footer(),
    ]);
  }
}
