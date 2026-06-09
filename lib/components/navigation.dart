import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr_router/jaspr_router.dart';

@client
class Navigation extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return nav(
      classes: 'fixed top-0 left-0 right-0 z-[1000] px-4 sm:px-8 md:px-12 lg:px-20 py-4 flex justify-between items-center bg-gradient-to-b from-primary-bg to-transparent',
      [
        // Logo/Name
        div(
          classes: 'scramble-text text-[10px] sm:text-xs tracking-widest uppercase font-medium flex-shrink-0',
          attributes: {'data-text': 'DIWE INNOCENT'},
          [Link(
            to: '/',
            child: Component.text('DIWE INNOCENT'),
          )],
        ),
        
        // Navigation Links
        ul(
          classes: 'flex gap-4 sm:gap-6 md:gap-8 lg:gap-12 list-none',
          [
            _buildNavLink('/', '[ WORK ]'),
            _buildNavLink('/info', 'INFO'),
            _buildNavLink('/contact', 'CONTACT'),
          ],
        ),
      ],
    );
  }

  Component _buildNavLink(String path, String label) {
    return li([
      Link(
        to: path,
        child: span(
          classes: 'scramble-text text-[10px] sm:text-xs uppercase tracking-widest transition-colors duration-300 text-primary-text hover:text-green-neon nav-link whitespace-nowrap',
          attributes: {
            'data-text': label,
            'data-path': path,
          },
          [Component.text(label)],
        ),
      ),
    ]);
  }
}