// ============================================
// FILE: lib/components/custom_cursor.dart
// ============================================
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client
class CustomCursor extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return div(
       [
        div(classes: 'cursor', []),
        div(classes: 'cursor-follower', []),
      ],
    );
  }
}