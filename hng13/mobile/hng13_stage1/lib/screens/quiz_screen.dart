import 'package:flutter/material.dart';
import 'package:hng13_stage1/widgets/button_widget.dart';
import 'package:provider/provider.dart';

import '../data/quiz_data.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();

    quiz.onQuizComplete = () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/result');
      }
    };

    return Consumer<QuizProvider>(
      builder: (context, quiz, _) {
        final question = questions[quiz.currentQuestionIndex];

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Tech Trivia Quiz',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              const Icon(Icons.timer, color: Colors.red),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text('${quiz.timeLeft}s'),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${quiz.currentQuestionIndex + 1}/${questions.length}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                LinearProgressIndicator(
                  value: quiz.currentQuestionIndex / questions.length,
                ),
                Text(
                  question.question,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 16),
                ...List.generate(question.options.length, (index) {
                  return RadioGroup(
                    groupValue: quiz.selectedAnswerIndex,
                    onChanged: (value) {},
                    child: RadioListTile(
                      value: index,
                      title: Text(question.options[index]),
                    ),
                  );
                }),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      onPressed: quiz.prevQuestion,
                      text: "Previous",
                      isDisabled: quiz.isFirstQuestion,
                    ),
                    ButtonWidget(
                      onPressed: () {
                        if (quiz.isLastQuestion) {
                          quiz.finishQuiz();
                        } else {
                          quiz.nextQuestion();
                        }
                      },
                      text: quiz.isLastQuestion ? 'Finish' : 'Next',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
