//PRACTICAL 4 : mobile application where users
// navigate through multiple screens like login,
// dashboard, and profile.
//Design a Form-based Registration App with validation
//using TextFormField.

import 'package:flutter/material.dart';
import 'login.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'todolist.dart';
import 'feedback.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/registration',
      routes: {
        '/registration': (context) => const RegistrationScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/todolist': (context) => const TodoListScreen(),
        '/feedback': (context) => const FeedbackScreen(),
      },
    );
  }
}
