import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../components/footer.dart';

@client
class InfoPage extends StatelessComponent {
  const InfoPage({super.key});

  @override
  Component  build(BuildContext context)  {
    return div(classes: 'min-h-screen bg-black text-white', [
      // Main content
      div(classes: 'container mx-auto px-6 md:px-12 py-20', [
        div(classes: 'grid md:grid-cols-2 gap-16 md:gap-24 items-start', [
          // Left side - Info text
          div(classes: 'space-y-12', [
            // Title
            h1(
              classes: 'text-[clamp(3rem,12vw,12rem)] font-bold leading-none tracking-tight',
              [Component.text('INFO')],
            ),
            
            // Bio paragraphs
            div(classes: 'space-y-8 text-sm md:text-2xl leading-relaxed', [
              p(classes: 'fade-in', [
                Component.text('I\'m Rylan Phillips, an independent designer & developer shaping brands that stand out and drive meaningful growth.'),
              ]),
              p(classes: 'fade-in', [
                Component.text('Originally from Los Angeles and now based in Vienna, I\'m passionate about bringing ambitious visions to life and partnering with founders and brands who refuse to settle for average.'),
              ]),
            ]),
            
            // Contact info
            div(classes: 'space-y-6 pt-8', [
              div(classes: 'space-y-2', [
                h3(classes: 'text-sm text-gray-500 tracking-wider', [Component.text('Email')]),
                a(
                  href: 'mailto:diweesomchi@gmail.com',
                  classes: 'text-white hover:text-gray-300 transition-colors flex items-center gap-2',
                  [
                    Component.text('DIWEESOMCHI@GMAIL.COM'),
                    span(classes: 'text-xs', [Component.text('📋')]),
                  ],
                ),
                p(classes: 'text-sm text-gray-500', [
                  Component.text('DESIGN & DEVELOPMENT BY DIWE INNOCENT'),
                ]),
              ]),
              
              div(classes: 'space-y-2', [
                h3(classes: 'text-sm text-gray-500 tracking-wider', [Component.text('Behance')]),
                a(
                  href: 'https://behance.net/rylanphillips',
                  classes: 'text-white hover:text-gray-300 transition-colors flex items-center gap-2',
                  [
                    Component.text('/DIWEINNOCENT'),
                    span(classes: 'text-xs', [Component.text('↗')]),
                  ],
                ),
              ]),
            ]),
          ]),
          
          // Right side - Portrait image
          div(classes: 'relative', [
            div(classes: 'aspect-[3/4] bg-gradient-to-br from-gray-800 to-gray-900 rounded-lg overflow-hidden ', [
              img(
                src: 'images/diwe.jpg',
                alt: 'Diwe Innocent',
                classes: 'w-full h-full object-cover grayscale hover:grayscale-0 transition-all duration-500',
              ),
            ]),
          ]),
        ]),
        
        // Specializing section
        div(classes: 'mt-24 pt-12 border-t border-gray-800', [
          h2(classes: 'text-4xl md:text-5xl font-bold mb-8', [
            Component.text('Specializing in Software architect, user-centered design, and innovative web and mobile development.'),
          ]),
        ]),
      ]),
      
      // Footer
       Footer(),
    ]);
  }
}