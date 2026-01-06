import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../models/project.dart';
import '../services/project_service.dart';
import '../components/footer.dart';

@client
class ArchivePage extends StatefulComponent {
  const ArchivePage({super.key});

  @override
  State createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  List<Project> projects = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  Future<void> _loadProjects() async {
    final data = await ProjectService.getAllProjects();
    setState(() {
      projects = data;
      loading = false;
    });
  }

  @override
  Component build(BuildContext context)  {
    return div(classes: 'min-h-screen bg-black text-white', [
      // Hero section - sticky
      div(
        classes: 'h-screen flex flex-col items-center justify-center sticky top-0 z-10',
        [
          // Small thumbnail at top
          div(classes: 'absolute top-8 right-8 w-64 h-40 overflow-hidden rounded', [
            img(
              src: 'https://images.unsplash.com/photo-1460925895917-afdab827c52f?w=600',
              alt: 'Featured project',
              classes: 'w-full h-full object-cover',
            ),
            div(classes: 'absolute bottom-2 left-2 text-xs font-mono', [
              Component.text('[01] DATASPOT – BRANDING CONCEPT (2024)'),
            ]),
          ]),
          
          // Large title
          h1(
            classes: 'text-[clamp(5rem,20vw,15rem)] font-bold leading-none tracking-tighter',
            [Component.text('ARCHIVE')],
          ),
          
          p(classes: 'text-sm tracking-widest text-gray-500 mt-6', [
            Component.text('SCROLL TO DISCOVER'),
          ]),
        ],
      ),
      
      // Project grid - scrolls over hero
      div(classes: 'relative z-20 bg-black pt-24', [
        div(classes: 'container mx-auto px-6 md:px-12', [
          if (loading)
            div(classes: 'text-center py-20 text-gray-500', [
              Component.text('LOADING PROJECTS...'),
            ])
          else
            div(classes: 'space-y-px', [
              for (var i = 0; i < projects.length; i++)
                a(
                  href: '/projects/${projects[i].id}',
                  classes: 'block group',
                  [
                    div(
                      classes: 'bg-black hover:bg-gray-950 border-t border-gray-900 py-8 px-6 transition-all duration-300',
                      [
                        div(classes: 'flex items-center justify-between gap-8', [
                          // Index
                          span(classes: 'text-gray-600 font-mono text-sm shrink-0', [
                            Component.text('[${(i + 1).toString().padLeft(2, '0')}]'),
                          ]),
                          
                          // Title
                          h2(
                            classes: 'text-2xl md:text-4xl font-bold uppercase tracking-tight flex-1 group-hover:text-gray-400 transition-colors',
                            [Component.text(projects[i].title)],
                          ),
                          
                          // Year
                          span(classes: 'text-gray-600 font-mono text-sm shrink-0', [
                            Component.text('(${projects[i].year})'),
                          ]),
                        ]),
                        
                        // Expandable image on hover
                        div(
                          classes: 'mt-6 max-h-0 opacity-0 overflow-hidden transition-all duration-500 group-hover:max-h-96 group-hover:opacity-100',
                          [
                            img(
                              src: projects[i].imageUrl,
                              alt: projects[i].title,
                              classes: 'w-full h-80 object-cover rounded',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
            ]),
        ]),
        
        // Bottom spacing
        div(classes: 'h-32', []),
      ]),
      
       Footer(),
    ]);
  }
}