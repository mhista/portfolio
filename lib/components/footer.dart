import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

class Footer extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return footer(
      classes: 'p-6 sm:p-8 md:p-12 lg:p-16 grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6 sm:gap-8 border-t border-[#222]',
      [
        div(classes: 'footer-col', [
          h4(classes: 'text-xs text-accent uppercase tracking-[0.1em] mb-3 sm:mb-4', [
            Component.text('CONTACT')
          ]),
          a(
            href: 'mailto:diweesomchi@gmail.com',
            classes: 'text-xs sm:text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors break-all',
            [Component.text('diweesomchi@gmail.com')],
          ),
          a(
            href: 'tel:+2347068884102',
            classes: 'text-xs sm:text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('+234 706 888 4102')],
          ),
        ]),
        
        div(classes: 'footer-col', [
          h4(classes: 'text-xs text-accent uppercase tracking-[0.1em] mb-3 sm:mb-4', [
            Component.text('SOCIAL')
          ]),
          a(
            href: 'https://x.com/somtechh',
            target: Target.blank,
            classes: 'text-xs sm:text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('Twitter / X')],
          ),
          a(
            href: 'https://www.linkedin.com/in/diwe-innocent',
            target: Target.blank,
            classes: 'text-xs sm:text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('LinkedIn')],
          ),
          a(
            href: 'https://github.com/mhista',
            target: Target.blank,
            classes: 'text-xs sm:text-sm text-primary-text block mb-2 hover:text-green-neon transition-colors',
            [Component.text('GitHub')],
          ),
        ]),
        
        div(classes: 'footer-col sm:col-span-2 lg:col-span-1', [
          h4(classes: 'text-xs text-accent uppercase tracking-[0.1em] mb-3 sm:mb-4', [
            Component.text('LEGAL')
          ]),
          p(classes: 'text-xs sm:text-sm text-primary-text mb-2', [
            Component.text('© ${DateTime.now().year} Diwe Innocent')
          ]),
          p(classes: 'text-xs text-primary-text/60', [
            Component.text('All rights reserved')
          ]),
        ]),
      ],
    );
  }
}