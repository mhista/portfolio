import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
// import '../services/email_service.dart';
import '../components/footer.dart';
import '../services/email_service.dart';

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
  Component build(BuildContext context) {
    return section(classes: 'contact-page max-w-7xl px-[2rem] pt-[8rem] md:px-[4rem] md:pt-[12rem]', [
      div(classes: 'contact-container', [
        div(classes: 'contact-info slide-in-left', [
          h1(
            classes: 'contact-title scramble-text gradient-text',
            attributes: {'data-text': 'GET IN TOUCH'},
            [Component.text('GET IN TOUCH')],
          ),
          p(classes: 'contact-subtitle fade-in', [
            Component.text(
              'Have a project in mind? Let\'s talk about it. '
              'I\'m always open to discussing new projects, creative ideas, '
              'or opportunities to be part of your visions.',
            ),
          ]),

          div(classes: 'contact-details fade-in', [
            div(classes: 'contact-detail-item hover-lift', [
              span(classes: 'contact-icon', [Component.text('📧')]),
              div([
                span(classes: 'contact-label', [Component.text('EMAIL')]),
                a(
                  href: 'mailto:diweesomchi@gmail.com',
                  classes: 'contact-value scramble-text',
                  attributes: {'data-text': 'diweesomchi@gmail.com'},
                  [Component.text('diweesomchi@gmail.com')],
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
                  a(
                    href: 'https://x.com/somtechh',
                    target: Target.blank,
                    classes: 'social-link magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('TWITTER / X')],
                  ),
                  a(
                    href: 'https://www.linkedin.com/in/diwe-innocent',
                    target: Target.blank,
                    classes: 'social-link magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('LINKEDIN')],
                  ),
                  a(
                    href: 'https://github.com/mhista',
                    target: Target.blank,
                    classes: 'social-link magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('GITHUB')],
                  ),
                ]),
              ]),
            ]),
          ]),
        ]),

        div(classes: 'contact-form-container slide-in-right', [
          if (sent)
            div(classes: 'contact-success fade-in pulse', [
              span(classes: 'success-icon', [Component.text('✓')]),
              h3(
                classes: 'scramble-text',
                attributes: {'data-text': 'MESSAGE SENT!'},
                [Component.text('MESSAGE SENT!')],
              ),
              p([Component.text('Thank you for reaching out. I\'ll get back to you soon!')]),
            ])
          else
            form(classes: 'contact-form', [
              if (error != null) div(classes: 'form-error fade-in', [Component.text(error!)]),

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
                // events: {'click': (event) => _handleSubmit()},
                // onClick: () => _handleSubmit(),
                disabled: sending,
                [Component.text(sending ? 'SENDING...' : 'SEND MESSAGE →')],
              ),
            ]),
        ]),
      ]),
      Footer(),
         RawText('''
        <script>
          document.addEventListener('DOMContentLoaded', function() {
            // Wait for button to exist
            const checkButton = setInterval(() => {
              const submitBtn = document.querySelector('.contact-submit');
              if (submitBtn) {
                clearInterval(checkButton);
                console.log('✅ Contact button found');

                submitBtn.addEventListener('click', async function(e) {
                  e.preventDefault();
                  console.log('📧 Button clicked!');

                  // Get form values
                  const name = document.querySelector('input[type="text"]').value;
                  const email = document.querySelector('input[type="email"]').value;
                  const subject = document.querySelectorAll('input[type="text"]')[1]?.value || '';
                  const message = document.querySelector('textarea').value;

                  if (!name || !email || !message) {
                    alert('Please fill in all required fields');
                    return;
                  }

                  // Show loading state
                  submitBtn.disabled = true;
                  submitBtn.textContent = 'SENDING...';

                  try {
                    const response = await fetch('http://localhost:8080/contact/send', {
                      method: 'POST',
                      headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                      },
                      body: JSON.stringify({ name, email, subject, message })
                    });

                    const result = await response.json();

                    if (result.success) {
                      alert('Message sent successfully!');
                      // Clear form
                      document.querySelector('input[type="text"]').value = '';
                      document.querySelector('input[type="email"]').value = '';
                      document.querySelectorAll('input[type="text"]')[1].value = '';
                      document.querySelector('textarea').value = '';
                    } else {
                      alert('Failed to send message. Please try again.');
                    }
                  } catch (error) {
                    console.error('Error:', error);
                    alert('Error sending message. Please try again.');
                  } finally {
                    submitBtn.disabled = false;
                    submitBtn.textContent = 'SEND MESSAGE →';
                  }
                });
              }
            }, 100);
          });
        </script>
      '''),
    ]);
  }
}
