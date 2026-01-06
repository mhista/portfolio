import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../../models/project.dart';
import '../../services/project_service.dart';
import 'admin_layout.dart';

@client
class ProjectsAdmin extends StatefulComponent {
  @override
  State createState() => _ProjectsAdminState();
}

class _ProjectsAdminState extends State<ProjectsAdmin> {
  List<Project> projects = [];
  bool loading = true;
  bool showForm = false;
  Project? editingProject;

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

  void _showCreateForm() {
    setState(() {
      showForm = true;
      editingProject = null;
    });
  }

  void _hideForm() {
    setState(() {
      showForm = false;
      editingProject = null;
    });
  }

  @override
  Component build(BuildContext context) {
    return AdminLayout(
      child: div(classes: 'admin-page fade-in', [
        div(classes: 'admin-header', [
          h1(classes: 'admin-title scramble-text gradient-text', 
             attributes: {'data-text': 'PROJECTS'}, 
             [Component.text('PROJECTS')]),
          button(
            classes: 'admin-btn admin-btn-primary magnetic pulse',
            attributes: {'data-strength': '15'},
            onClick: () => _showCreateForm(),
            [Component.text('+ NEW PROJECT')],
          ),
        ]),

        if (showForm)
          div(classes: 'admin-form-overlay', [
            div(classes: 'admin-form slide-in-right', [
              h2(classes: 'scramble-text', [Component.text('NEW PROJECT')]),
              Component.text('Form content here...'),
              button(
                classes: 'admin-btn admin-btn-secondary',
                onClick: () => _hideForm(),
                [Component.text('CANCEL')],
              ),
            ]),
          ])
        else if (loading)
          div(classes: 'admin-loading', [
            span(classes: 'scramble-text', [Component.text('LOADING...')]),
          ])
        else
          div(classes: 'admin-grid blur-siblings-container', [
            for (var project in projects)
              div(classes: 'admin-card blur-siblings hover-lift', [
                if (project.imageUrl.isNotEmpty)
                  img(classes: 'admin-card-image', src: project.imageUrl, alt: project.title),
                div(classes: 'admin-card-content', [
                  h3(classes: 'scramble-text', 
                     attributes: {'data-text': project.title}, 
                     [Component.text(project.title)]),
                  p(classes: 'admin-card-meta', [Component.text(project.category)]),
                  p(classes: 'admin-card-desc', [Component.text(project.description)]),
                  div(classes: 'admin-card-actions', [
                    button(
                      classes: 'admin-btn admin-btn-secondary magnetic',
                      attributes: {'data-strength': '15'},
                      [Component.text('EDIT')],
                    ),
                    button(
                      classes: 'admin-btn admin-btn-danger magnetic',
                      attributes: {'data-strength': '15'},
                      [Component.text('DELETE')],
                    ),
                  ]),
                ]),
              ]),
          ]),
      ]),
    );
  }
}
