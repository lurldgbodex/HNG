import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.read<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Score: ${quiz.score}/${questions.length}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final q = questions[index];
                  final userAns = quiz.userAnswers[index];
                  final bool answered = userAns != null && userAns != -1;
                  final bool correct =
                      answered && q.correctAnswerIndex == userAns;

                  return Card(
                    color: correct
                        ? Colors.green[100]
                        : answered
                        ? Colors.red[100]
                        : Colors.grey[200],
                    child: ListTile(
                      title: Text(
                        q.question,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your answer: ${answered ? q.options[userAns!] : "Unanswered"}',
                          ),
                          Text(
                            'Correct answer: ${q.options[q.correctAnswerIndex]}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                quiz.restartQuiz();
                Navigator.pushReplacementNamed(context, '/');
              },
              child: const Text(
                'Restart Quiz',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
