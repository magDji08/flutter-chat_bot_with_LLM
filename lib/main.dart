import 'package:flutter/material.dart';
import 'package:magdji_bot/pages/chatbot_page.dart';
import 'package:magdji_bot/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // definir les routes de l'application
      routes: {
        '/': (context) => LoginPage(),
        '/chatbot': (context) => ChatbotPage(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      primaryColor: Colors.teal
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // home: LoginPage(),
    );
  }
}