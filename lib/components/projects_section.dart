import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../services/project_service.dart';
import '../models/project.dart';

@client
class ProjectsSection extends StatefulComponent {
  @override
  State createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  List<Project> projects = [];
  bool loading = true;
  int activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final data = await ProjectService.getFeaturedProjects();
    setState(() {
      projects = data;
      loading = false;
    });
  }

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'min-h-screen py-40 px-16 relative',
      id: 'work',
      [
        h2(
          classes: 'scramble-text text-5xl mb-16 uppercase tracking-tight',
          [Component.text('FEATURED WORK')],
        ),
        
        if (loading)
          div(
            classes: 'flex items-center justify-center min-h-[400px] text-2xl text-accent',
            [
              span(classes: 'scramble-text', [Component.text('LOADING...')]),
            ],
          )
        else
          div(
           [
              // Project Info - Fixed on left
              div(
                classes: 'fixed top-1/2 left-16 -translate-y-1/2 z-10 max-w-[300px]',
                [
                  div(
                    classes: 'project-number text-base text-accent mb-4 transition-all duration-300',
                    id: 'projectNumber',
                    [Component.text('[${(activeIndex + 1).toString().padLeft(2, '0')}]')],
                  ),
                  h3(
                    classes: 'scramble-text project-name text-5xl font-bold mb-4 uppercase leading-none transition-all duration-300',
                    id: 'projectName',
                    attributes: {'data-text': projects[activeIndex].title},
                    [Component.text(projects[activeIndex].title)],
                  ),
                  p(
                    classes: 'project-meta text-sm text-accent uppercase tracking-wider transition-all duration-300',
                    id: 'projectMeta',
                    [Component.text('${projects[activeIndex].category} / ${projects[activeIndex].year}')],
                  ),
                ],
              ),
              
              // Projects Carousel
              div(
                classes: 'ml-auto max-w-[800px] flex gap-8 overflow-x-hidden scroll-smooth py-8',
                [
                  for (var i = 0; i < projects.length; i++)
                    div(
                      classes: 'project-card min-w-[600px] aspect-[4/3] bg-[#111] rounded-lg overflow-hidden relative flex-shrink-0 transition-all duration-600 ease-[cubic-bezier(0.65,0,0.35,1)] ${i == 0 ? 'blur-0 brightness-100 scale-100 opacity-100' : 'blur-[8px] brightness-50 scale-95 opacity-60'}',
                      attributes: {
                        'data-name': projects[i].title,
                        'data-meta': '${projects[i].category} / ${projects[i].year}',
                        'data-number': (i + 1).toString().padLeft(2, '0'),
                      },
                      [
                        img(
                          src: projects[i].imageUrl,
                          classes: 'w-full h-full object-cover transition-transform duration-800 ease-[cubic-bezier(0.65,0,0.35,1)] hover:scale-105',
                          alt: projects[i].title,
                        ),
                        div(
                          classes: 'absolute inset-0 bg-gradient-to-t from-black/90 to-transparent flex flex-col justify-end p-12 opacity-0 hover:opacity-100 transition-opacity duration-400',
                          [
                            h3(classes: 'text-3xl font-semibold mb-2', [Component.text(projects[i].title)]),
                            p(classes: 'text-accent text-base', [Component.text(projects[i].description)]),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}