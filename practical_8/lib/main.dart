import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login.dart';
import 'dashboard.dart';
import 'profile.dart';
import 'news.dart';

Future<void> main() async {
  try {
    await dotenv.load();
  } catch (e) {
    // Handle .env loading error gracefully
    debugPrint('Warning: Could not load .env file: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Practical 8',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/news': (context) => const NewsScreen(),
      },
    );
  }
}
