/// The entrypoint for the **server** environment.
///
/// The [main] method will only be executed on the server during pre-rendering.
/// To run code on the client, check the `main.client.dart` file.
library;

import 'package:jaspr/dom.dart';
// Server-specific Jaspr import.
import 'package:jaspr/server.dart';
import 'package:port/server/email_server.dart';

// Imports the [App] component.
import 'app.dart';

// This file is generated automatically by Jaspr, do not remove or edit.
import 'main.server.options.dart';

void main() async{
  // Initializes the server environment with the generated default options.
  Jaspr.initializeApp(
    options: defaultServerOptions,
  );

  final server = EmailServer();
  await server.start();

  // Starts the app.
  //
  // [Document] renders the root document structure (<html>, <head> and <body>)
  // with the provided parameters and components.
  // runApp(Document(
  //   title: 'port',
  //   base: '/',
  //   head: [
  //       meta(charset: 'utf-8'),
  //       meta(name: 'viewport', content: 'width=device-width, initial-scale=1.0'),
  //       link(rel: 'stylesheet', href: '/main.css'),

  //       // link(rel: 'stylesheet', href: '/styles.tw.css'),

       
  //       script(
  //         src: 'https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4',
  //       ),
  //       script(
  //         src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js',
  //       ),
  //       script(
  //         src: 'https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js',
  //       ),
  //        script(
  //         src: '/interaction.js',
  //       ),
  //   ],
   
  //   body: App(),
  // ));
}
