import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

@client
class HeroSection extends StatefulComponent {
  @override
  State createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  String currentTime = '00:00:00';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    // Handled by JavaScript
  }

  @override
  Component build(BuildContext context) {
    return section(
      classes: 'flex flex-col justify-center px-16 relative overflow-hidden',
      [
        h1(
          classes: 'text-[clamp(3.5rem,10vw,9rem)] font-bold leading-[0.95] tracking-tight uppercase mb-8',
          [
            span(classes: 'block overflow-hidden', [
              span(
                classes: 'scramble-text inline-block opacity-0 translate-y-full animate-slide-up',
                attributes: {'data-text': 'CREATIVE'},
                [Component.text('CREATIVE')],
              ),
            ]),
            span(classes: 'block overflow-hidden', [
              span(
                classes: 'scramble-text inline-block opacity-0 translate-y-full animate-slide-up [animation-delay:0.3s]',
                attributes: {'data-text': 'DEVELOPER'},
                [Component.text('DEVELOPER')],
              ),
            ]),
          ],
        ),
        p(
          classes: 'scramble-text text-xl text-accent uppercase tracking-[0.1em] mb-4 opacity-0 animate-fade-in [animation-delay:0.6s]',
          [Component.text('DESIGNER & DEVELOPER')],
        ),
        p(
          classes: 'text-base text-accent font-mono opacity-0 animate-fade-in [animation-delay:0.8s]',
          [
            Component.text('PORT HARCOURT, NG — '),
            span(id: 'time', [Component.text(currentTime)]),
          ],
        ),
        div(
          classes: 'absolute bottom-16 left-16 flex items-center gap-4 text-xs text-accent uppercase tracking-[0.1em] opacity-0 animate-fade-in [animation-delay:1s]',
          [
            span([Component.text('SCROLL TO DISCOVER')]),
            div(classes: 'w-px h-[60px] bg-accent animate-scroll-line', []),
          ],
        ),
        div(
          classes: 'absolute bottom-16 right-16 opacity-0 animate-fade-in [animation-delay:1.2s]',
          [
            button(
              classes: 'magnetic px-12 py-6 text-sm font-semibold uppercase tracking-[0.1em] bg-transparent text-primary-text border border-accent rounded hover:border-green-neon hover:bg-green-neon hover:text-primary-bg transition-all duration-400 relative overflow-hidden group',
              attributes: {'data-strength': '20'},
              [
                span(classes: 'relative z-10', [Component.text('GET IN TOUCH')]),
                div(
                  classes: 'absolute inset-0 bg-green-neon -translate-y-full group-hover:translate-y-0 transition-transform duration-400 -z-10',
                  [],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
