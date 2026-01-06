import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

@client
class Navigation extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return nav(
      classes: 'fixed top-0 left-2 right-20 z-[1000] px-20 py-4 flex justify-between items-center bg-gradient-to-b from-primary-bg to-transparent',
      [
        div(
          classes: 'scramble-text text-xs tracking-widest uppercase font-medium',
          attributes: {'data-text': 'DIWE INNOCENT'},
          [Component.text('DIWE INNOCENT')],
        ),
        ul(classes: 'flex gap-12 list-none mr-32', [
          _buildNavLink('/', '[ WORK ]'),
          _buildNavLink('/info', 'INFO'),
          _buildNavLink('/contact', 'CONTACT'),
        ]),
      ],
    );
  }

  Component _buildNavLink(String path, String label) {
    // Remove Router.of(context) - it doesn't work on server
    // The active state will be handled by client-side JS
    
    return li([
      Link(
        to: path,
        child: span(
          classes: 'scramble-text text-xs uppercase tracking-widest transition-colors duration-300 text-primary-text hover:text-green-neon nav-link',
          attributes: {
            'data-text': label,
            'data-path': path, // Add this for client-side JS
          },
          [Component.text(label)],
        ),
      ),
    ]);
  }
}