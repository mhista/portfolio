import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import '../services/email_service.dart';
import '../components/footer.dart';

@client
class ContactPage extends StatefulComponent {
  @override
  State createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String name = '';
  String email = '';
  String subject = '';
  String message = '';
  bool sending = false;
  bool sent = false;
  String? error;

  Future<void> _handleSubmit() async {
    if (name.isEmpty || email.isEmpty || message.isEmpty) {
      setState(() => error = 'Please fill in all required fields');
      return;
    }

    setState(() {
      sending = true;
      error = null;
    });

    final success = await EmailService.sendContactEmail(
      name: name,
      email: email,
      subject: subject,
      message: message,
    );

    setState(() {
      sending = false;
      if (success) {
        sent = true;
        name = '';
        email = '';
        subject = '';
        message = '';
      } else {
        error = 'Failed to send message. Please try again.';
      }
    });

    if (sent) {
      // Reset after 3 seconds
      Future.delayed(Duration(seconds: 3), () {
        setState(() => sent = false);
      });
    }
  }

  @override
  Component build(BuildContext context)  {
    return section(classes: 'contact-page', [
      div(classes: 'contact-container', [
        div(classes: 'contact-info slide-in-left', [
          h1(
            classes: 'contact-title scramble-text gradient-text',
            attributes: {'data-text': 'GET IN TOUCH'},
            [Component.text('GET IN TOUCH')],
          ),
          p(classes: 'contact-subtitle fade-in', [
            Component.text('Have a project in mind? Let\'s talk about it. '
                 'I\'m always open to discussing new projects, creative ideas, '
                 'or opportunities to be part of your visions.'),
          ]),
          
          div(classes: 'contact-details fade-in', [
            div(classes: 'contact-detail-item hover-lift', [
              span(classes: 'contact-icon', [Component.text('📧')]),
              div([
                span(classes: 'contact-label', [Component.text('EMAIL')]),
                a(
                  href: 'mailto:hello@example.com',
                  classes: 'contact-value scramble-text',
                  attributes: {'data-text': 'hello@example.com'},
                  [Component.text('hello@example.com')],
                ),
              ]),
            ]),
            div(classes: 'contact-detail-item hover-lift', [
              span(classes: 'contact-icon', [Component.text('📍')]),
              div([
                span(classes: 'contact-label', [Component.text('LOCATION')]),
                span(
                  classes: 'contact-value scramble-text',
                  attributes: {'data-text': 'PORT HARCOURT, NG'},
                  [Component.text('PORT HARCOURT, NG')],
                ),
              ]),
            ]),
            div(classes: 'contact-detail-item hover-lift', [
              span(classes: 'contact-icon', [Component.text('🌐')]),
              div([
                span(classes: 'contact-label', [Component.text('SOCIAL')]),
                div(classes: 'social-links', [
                  a(href: '#', classes: 'social-link magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('TWITTER')]),
                  a(href: '#', classes: 'social-link magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('LINKEDIN')]),
                  a(href: '#', classes: 'social-link magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('GITHUB')]),
                ]),
              ]),
            ]),
          ]),
        ]),

        div(classes: 'contact-form-container slide-in-right', [
          if (sent)
            div(classes: 'contact-success fade-in pulse', [
              span(classes: 'success-icon', [Component.text('✓')]),
              h3(classes: 'scramble-text',
                 attributes: {'data-text': 'MESSAGE SENT!'},
                 [Component.text('MESSAGE SENT!')]),
              p([Component.text('Thank you for reaching out. I\'ll get back to you soon!')]),
            ])
          else
            form(classes: 'contact-form', [
              if (error != null)
                div(classes: 'form-error fade-in', [Component.text(error!)]),

              div(classes: 'form-group', [
                label([Component.text('NAME *')]),
                input(
                  type: InputType.text,
                  classes: 'form-input',
                  value: name,
                  onInput: (value) => setState(() => name = value.toString()),
                  attributes: {'placeholder': 'John Doe'},
                ),
              ]),

              div(classes: 'form-group', [
                label([Component.text('EMAIL *')]),
                input(
                  type: InputType.email,
                  classes: 'form-input',
                  value: email,
                  onInput: (value) => setState(() => email = value.toString()),
                  attributes: {'placeholder': 'john@example.com'},
                ),
              ]),

              div(classes: 'form-group', [
                label([Component.text('SUBJECT')]),
                input(
                  type: InputType.text,
                  classes: 'form-input',
                  value: subject,
                  onInput: (value) => setState(() => subject = value as String),
                  attributes: {'placeholder': 'Project Inquiry'},
                ),
              ]),

              div(classes: 'form-group', [
                label([Component.text('MESSAGE *')]),
                textarea(
                  classes: 'form-textarea',
                  rows: 6,
                  placeholder: 'Tell me about your project...',
                  onInput: (value) => setState(() => message = value),
                  // attributes: {'placeholder': 'Tell me about your project...', 'rows': '6'},
                  [],
                ),
              ]),

              button(
                type: ButtonType.button,
                classes: 'contact-submit magnetic ${sending ? 'pulse' : ''}',
                attributes: {'data-strength': '20'},
                events: {'click': (event) => _handleSubmit()},
                // onClick: () => _handleSubmit(),
                disabled: sending,
                [Component.text(sending ? 'SENDING...' : 'SEND MESSAGE →')],
              ),
            ]),
        ]),
      ]),
      Footer()
    ]);

    
  }
}