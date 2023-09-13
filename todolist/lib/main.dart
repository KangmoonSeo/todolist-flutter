import 'package:flutter/material.dart';
import 'package:todolist/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFFFCFCFC),
        scaffoldBackgroundColor: const Color.fromRGBO(28, 28, 39, 1),
        highlightColor: const Color(0xFFFFB43A),
        cardColor: const Color.fromRGBO(39, 40, 51, 1),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(24, 24, 33, 1), // o:1
          foregroundColor: Color(0xFFFCFCFC),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFFFCFCFC),
          ),
          labelLarge: TextStyle(
            backgroundColor: Color(0xFFE94141),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
