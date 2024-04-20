import 'package:dsa_algorithm/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSA Algorithm',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
              displaySmall:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
              displayMedium:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              displayLarge:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      home: const HomePage(),
    );
  }
}
