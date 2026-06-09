import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';
import 'package:port/components/shimmer_image.dart';
import '../services/project_service.dart';
import '../models/project.dart';

// @client
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

  void _loadProjects() {
    projects = ProjectService.getMockProjects();
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
          classes: 'flex-1 flex flex-col justify-between px-4 sm:px-8 pb-6 min-h-0 mt-20 sm:mt-24',
          [
            // Top: Project title and meta
            div(
              classes: 'max-w-[1600px] mx-auto w-full flex flex-col md:flex-row justify-between items-start md:items-end gap-4 sm:gap-6 md:gap-0 flex-shrink-0 md:pr-24',
              [
                // Large project title
                h2(
                  classes: 'scramble-text hero-title text-4xl sm:text-5xl md:text-6xl lg:text-7xl xl:text-8xl font-bold leading-none',
                  attributes: {'data-text': currentProject.title},
                  [Component.text(currentProject.title)],
                ),

                // Project meta info
                div(
                  classes: 'grid grid-cols-[1fr_auto] gap-4 sm:gap-6 md:gap-8 mb-0 md:mb-6 w-full md:w-auto',
                  [
                    div(classes: 'space-y-1', [
                      p(classes: 'text-[10px] sm:text-xs tracking-widest uppercase', [
                        Component.text('BRANDING')
                      ]),
                      p(classes: 'text-[10px] sm:text-xs tracking-widest uppercase', [
                        Component.text('DESIGN')
                      ]),
                      p(classes: 'text-[10px] sm:text-xs tracking-widest uppercase', [
                        Component.text('DEVELOPMENT')
                      ]),
                    ]),
                    div(classes: 'text-right', [
                      p(classes: 'text-[10px] sm:text-xs tracking-widest uppercase', [
                        Component.text(currentProject.year)
                      ]),
                    ]),
                  ],
                ),
              ],
            ),

            // Top section with name and role
            div(
              classes: 'px-0 sm:px-8 pb-4 sm:pb-6 flex-shrink-0 mt-4 sm:mt-8',
              [
                div(classes: 'max-w-[1600px] mx-auto flex flex-col sm:flex-row justify-between items-start gap-2 sm:gap-0', [
                  div([
                    p(
                      classes: 'scramble-text text-[9px] sm:text-xs tracking-widest uppercase text-gray-500 transition-colors duration-300 hover:text-green-neon',
                      attributes: {'data-text': 'SOFTWARE ARCHITECT, DESIGNER & DEVELOPER'},
                      [Component.text('SOFTWARE ARCHITECT, DESIGNER & DEVELOPER')],
                    ),
                  ]),
                  // Timer on the right
                  div(classes: 'text-left sm:text-right', [
                    p(
                      classes: 'text-[9px] sm:text-xs tracking-widest uppercase text-gray-500',
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
            div(classes: 'flex-shrink-0 mt-auto', [
              // Swipe counter
              div(classes: 'flex justify-center mb-3 sm:mb-4', [
                p(
                  classes: 'text-[10px] sm:text-xs tracking-widest uppercase text-gray-500',
                  [Component.text('${currentIndex + 1} / ${projects.length}')],
                ),
                span(classes: 'mx-4 sm:mx-8 text-gray-700', [Component.text('•')]),
                p(
                  classes: 'text-[10px] sm:text-xs tracking-widest uppercase text-gray-500',
                  [Component.text('FEATURED WORK (SWIPE)')],
                ),
              ]),

              // Bottom horizontal scrolling images - MOBILE OPTIMIZED
              div(
                classes: 'w-full overflow-hidden -mx-4 sm:mx-0',
                [
                  div(
                    classes: 'blur-siblings-container flex gap-3 sm:gap-4 overflow-x-auto snap-x snap-mandatory scrollbar-hide pb-2 px-4 sm:px-0',
                    id: 'projects-carousel',
                    [
                      for (var i = 0; i < projects.length; i++)
                        div(
                          classes: 'blur-siblings flex-shrink-0 snap-center first:ml-0 sm:first:ml-8 last:mr-0 sm:last:mr-8',
                          [
                            Link(
                              to: '/projects/${projects[i].id}',
                              classes: 'cursor-pointer relative group',
                              child: MyComponent(i: i, projects: projects,),
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

// @client
class MyComponent extends StatefulComponent {
  final int i;
  final List<Project> projects;
  // final int currentIndex;
  const MyComponent(
    {
      required this.i,
      required this.projects,
      // required this.currentIndex,
    }
  );

  @override
  State createState() => MyComponentState();
}

class MyComponentState extends State<MyComponent> {
  int currentIndex = 0;
  @override
  Component build(BuildContext context) {
    return div(
      classes: 'relative group cursor-pointer project-card ${component.i == currentIndex ? 'active' : ''}',
      attributes: {
        'data-index': component.i.toString(),
      },
      events: {
        'click': (event) => setState(() => currentIndex = component.i),
        'mouseenter': (event) => setState(() {
          currentIndex = component.i;
        }),
      },
      [
        ShimmerImage(
          src: component.projects[component.i].imageUrl,
          alt: component.projects[component.i].title,
          classes: 'project-image rounded-lg',
        ),
        div(
          classes: 'absolute bottom-3 left-3 text-xs tracking-widest',
          [Component.text('[${(component.i + 1).toString().padLeft(2, '0')}]')],
        ),
      ],
    );
  }
}
