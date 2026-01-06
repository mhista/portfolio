// FILE: lib/components/page_transition.dart
// ============================================
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client
class PageTransition extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return div(classes: 'page-transition', []);
  }
}
