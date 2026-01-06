import 'package:jaspr/dom.dart';
import 'package:jaspr/server.dart';
import '../components/navigation.dart';
import '../components/custom_cursor.dart';
import '../components/page_transition.dart';

class MainLayout extends StatelessComponent {
  final Component child;

  const MainLayout({required this.child});

  @override
  Component build(BuildContext context) {
    return Document(
      title: 'Portfolio - [Diwe Innocent]',
      head: [
        meta(charset: 'utf-8'),
        meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
        link(rel: 'stylesheet', href: '/main.css'),

        // link(rel: 'stylesheet', href: '/styles.css'),
        script(
          src: 'https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4',
        ),
        script(
          src: '/interaction.js',
        ),
        script(
          src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js',
        ),
        script(
          src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js',
        ),
      ],
      body: div([
        CustomCursor(),
        PageTransition(),
        Navigation(),
        child,
        // script(src: '/main.dart.js', ),
      ]),
    );
  }
}
