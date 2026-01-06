// ============================================
// FILE: lib/pages/admin/messages_admin.dart
// ============================================
import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';
import 'admin_layout.dart';

class ContactMessage {
  final String id;
  final String name;
  final String email;
  final String subject;
  final String message;
  final DateTime receivedAt;
  final bool read;

  ContactMessage({
    required this.id,
    required this.name,
    required this.email,
    required this.subject,
    required this.message,
    required this.receivedAt,
    required this.read,
  });
}

@client
class MessagesAdmin extends StatefulComponent {
  @override
  State createState() => _MessagesAdminState();
}

class _MessagesAdminState extends State<MessagesAdmin> {
  List<ContactMessage> messages = [];
  bool loading = true;
  ContactMessage? selectedMessage;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    // Mock data - replace with actual API call
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      messages = [
        ContactMessage(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          subject: 'Project Inquiry',
          message: 'Hi, I would like to discuss a potential project...',
          receivedAt: DateTime.now().subtract(Duration(hours: 2)),
          read: false,
        ),
        ContactMessage(
          id: '2',
          name: 'Jane Smith',
          email: 'jane@example.com',
          subject: 'Collaboration Opportunity',
          message: 'I came across your portfolio and I\'m impressed...',
          receivedAt: DateTime.now().subtract(Duration(days: 1)),
          read: true,
        ),
      ];
      loading = false;
    });
  }

  void _selectMessage(ContactMessage message) {
    setState(() => selectedMessage = message);
  }

  void _closeMessage() {
    setState(() => selectedMessage = null);
  }

  @override
  Component build(BuildContext context) {
    return AdminLayout(
      child: div(classes: 'admin-page fade-in', [
        h1(
          classes: 'admin-title scramble-text gradient-text',
          attributes: {'data-text': 'MESSAGES'},
          [Component.text('MESSAGES')],
        ),

        if (loading)
          div(classes: 'admin-loading', [
            span(classes: 'scramble-text', [Component.text('LOADING...')]),
          ])
        else
          div(classes: 'messages-container', [
            div(classes: 'messages-list', [
              for (var message in messages)
                div(
                  classes: 'message-item hover-lift ${!message.read ? 'unread' : ''}',
                  events: {
                    'click': (e) => _selectMessage(message),
                  },
                  [
                    div(classes: 'message-header', [
                      h3(
                        classes: 'scramble-text',
                        attributes: {'data-text': message.name},
                        [Component.text(message.name)],
                      ),
                      span(classes: 'message-time', [
                        Component.text(message.receivedAt.toString().substring(0, 16)),
                      ]),
                    ]),
                    p(classes: 'message-subject', [Component.text(message.subject)]),
                    p(classes: 'message-preview', [
                      Component.text(message.message.substring(0, 60) + '...'),
                    ]),
                  ],
                ),
            ]),

            if (selectedMessage != null)
              div(classes: 'message-detail slide-in-right', [
                div(classes: 'message-detail-header', [
                  h2(
                    classes: 'scramble-text',
                    attributes: {'data-text': selectedMessage!.name},
                    [Component.text(selectedMessage!.name)],
                  ),
                  button(
                    classes: 'close-btn magnetic',
                    attributes: {'data-strength': '15'},
                    onClick: () => _closeMessage(),
                    [Component.text('✕')],
                  ),
                ]),
                div(classes: 'message-detail-meta', [
                  p([Component.text('From: ${selectedMessage!.email}')]),
                  p([Component.text('Subject: ${selectedMessage!.subject}')]),
                  p([Component.text('Received: ${selectedMessage!.receivedAt}')]),
                ]),
                div(classes: 'message-detail-body', [
                  p([Component.text(selectedMessage!.message)]),
                ]),
                div(classes: 'message-actions', [
                  button(
                    classes: 'admin-btn admin-btn-primary magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('REPLY')],
                  ),
                  button(
                    classes: 'admin-btn admin-btn-danger magnetic',
                    attributes: {'data-strength': '15'},
                    [Component.text('DELETE')],
                  ),
                ]),
              ]),
          ]),
      ]),
    );
  }
}
