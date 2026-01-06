import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:port/components/shimmer_image.dart';
import '../services/project_service.dart';
import '../models/project.dart';
@client
class HomePage extends StatefulComponent {
  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Project> projects = [];
  bool loading = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects()  {
    projects =  ProjectService.getMockProjects();
  }

  @override
  Component build(BuildContext context) {
    if (loading) {
      return div(
        classes: 'h-screen flex items-center justify-center',
        [Component.text('Loading...')],
      );
    }

    final currentProject = projects[currentIndex];

    return section(
      classes: 'h-screen overflow-hidden flex flex-col',
      [
        // Main content area
        div(
          classes: 'flex-1 flex flex-col justify-between px-8 pb-6 min-h-0 mt-24',
          [
            // Top: Project title and meta
            div(
              classes:
                  'max-w-[1600px] mx-auto w-full flex flex-col md:flex-row justify-between items-end content-end flex-shrink-0 pr-24',
              [
                // Large project title - FIXED: Only one scramble-text class
                h2(
                  classes: 'scramble-text hero-title',
                  attributes: {'data-text': currentProject.title},
                  [Component.text(currentProject.title)],
                ),

                // Project meta info
                div(
                  classes: 'grid grid-cols-[1fr_auto] gap-8 mb-6',
                  [
                    div(classes: 'space-y-1', [
                      p(classes: 'text-xs tracking-widest uppercase', [Component.text('BRANDING')]),
                      p(classes: 'text-xs tracking-widest uppercase', [Component.text('DESIGN')]),
                      p(classes: 'text-xs tracking-widest uppercase', [Component.text('DEVELOPMENT')]),
                    ]),
                    div(classes: 'text-right', [
                      p(classes: 'text-xs tracking-widest uppercase', [Component.text(currentProject.year)]),
                    ]),
                  ],
                ),
              ],
            ),

            // Top section with name and role
            div(
              classes: 'px-8 pb-6 flex-shrink-0 mt-8',
              [
                div(classes: 'max-w-[1600px] mx-auto flex justify-between items-start', [
                  div([
                    p(
                      classes:
                          'scramble-text text-xs tracking-widest uppercase text-gray-500 transition-colors duration-300 hover:text-green-neon',
                      attributes: {'data-text': 'SOFTWARE ARCHITECT, DESIGNER & DEVELOPER'},
                      [Component.text('SOFTWARE ARCHITECT, DESIGNER & DEVELOPER')],
                    ),
                  ]),
                  // Timer on the right
                  div(classes: 'text-right', [
                    p(
                      classes: 'text-xs tracking-widest uppercase text-gray-500',
                      [
                        Component.text('PORT HARCOURT, NG — '),
                        span(id: 'time', [Component.text('00:00:00')]),
                      ],
                    ),
                  ]),
                ]),
              ],
            ),

            // Bottom: Counter and carousel
            div(classes: 'flex-shrink-0', [
              // Swipe counter
              div(classes: 'flex justify-center mb-4', [
                p(
                  classes: 'text-xs tracking-widest uppercase text-gray-500',
                  [Component.text('${currentIndex + 1} / ${projects.length}')],
                ),
                span(classes: 'mx-8 text-gray-700', [Component.text('•')]),
                p(
                  classes: 'text-xs tracking-widest uppercase text-gray-500',
                  [Component.text('FEATURED WORK (SWIPE)')],
                ),
              ]),

              // Bottom horizontal scrolling images - FIXED: Using blur-siblings
              div(
                classes: 'w-full overflow-hidden',
                [
                  div(
                    classes:
                        'blur-siblings-container flex gap-4 overflow-x-auto snap-x snap-mandatory scrollbar-hide pb-2',
                    id: 'projects-carousel',
                    [
                      for (var i = 0; i < projects.length; i++)
                        div(
                          classes: 'blur-siblings flex-shrink-0 snap-start first:ml-8 last:mr-8',
                          [
                            Link(
                              to: '/projects/${projects[i].id}',
                              classes: 'cursor-pointer relative group',
                              child: div(
                                classes:
                                    'relative group cursor-pointer project-card ${i == currentIndex ? 'active' : 'blur'}',
                                attributes: {
                                  'data-index': i.toString(),
                                },
                                events: {
                                  'click': (event) => setState(() => currentIndex = i),
                                  'mouseover': (event) => setState(() => currentIndex = i),
                                },
                                [
                                  ShimmerImage(
                                    src: projects[i].imageUrl,
                                    alt: projects[i].title,
                                    classes: 'w-[232px] h-[146.267px] object-cover rounded-lg',
                                  ),
                                  div(
                                    classes: 'absolute bottom-3 left-3 text-xs tracking-widest',
                                    [Component.text('[${(i + 1).toString().padLeft(2, '0')}]')],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ],
    );
  }
}
