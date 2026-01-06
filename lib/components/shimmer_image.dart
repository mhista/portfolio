import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client
class ShimmerImage extends StatefulComponent {
  final String src;
  final String alt;
  final String classes;

  const ShimmerImage({
    required this.src,
    required this.alt,
    this.classes = '',
  });

  @override
  State createState() => _ShimmerImageState();
}

class _ShimmerImageState extends State<ShimmerImage> {
  bool loaded = true;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'shimmer-image-container ${component.classes}',
      [
        if (!loaded)
          div(classes: 'shimmer-placeholder', []),
        img(
          src: component.src,
          alt: component.alt,
          classes: 'shimmer-image ${loaded ? 'loaded' : 'loading'}',
          events: {
            'load': (event) => setState(() => loaded = true),
            'error': (event) => setState(() => loaded = true), // Show broken image
          },
        ),
      ],
    );
  }
}