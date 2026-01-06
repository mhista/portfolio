import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return footer(
      classes: 'p-16 grid grid-cols-3 gap-8 border-t border-[#222]',
      [
        div(classes: 'footer-col', [
          h4(classes: 'text-xs text-accent uppercase tracking-[0.1em] mb-4', [Component.text('CONTACT')]),
          a(
            href: 'mailto:hello@example.com',
            classes: 'text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('diweesomchi@gmail.com')],
          ),
          a(
            href: 'tel:+234',
            classes: 'text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('+234 706 888 4102')],
          ),
        ]),
        div(classes: 'footer-col', [
          h4(classes: 'text-xs text-accent uppercase tracking-[0.1em] mb-4', [Component.text('SOCIAL')]),
          a(
            href: 'https://x.com/somtechh',
            classes: 'text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('Twitter / X')],
          ),
          a(
            href: 'https://www.linkedin.com/in/diwe-innocent',
            classes: 'text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('LinkedIn')],
          ),
          a(
            href: 'https://github.com/mhista',
            classes: 'text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('GitHub')],
          ),
        ]),
        div(classes: 'footer-col', [
          h4(classes: 'text-xs text-accent uppercase tracking-[0.1em] mb-4', [Component.text('LEGAL')]),
          p(classes: 'text-sm text-primary-text mb-2', [Component.text('© 2025')]),
          // a(
          //   href: '#',
          //   classes: 'text-sm text-primary-text block hover:text-green-neon transition-colors',
          //   [Component.text('IMPRINT & DATA PRIVACY')],
          // ),
        ]),
      ],
    );
  }
}