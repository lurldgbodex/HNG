import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/quiz_provider.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: MaterialApp(
        title: 'Tech Trivia Quiz',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const QuizScreen(),
          '/result': (_) => const ResultScreen(),
        },
      ),
    );
  }
}
