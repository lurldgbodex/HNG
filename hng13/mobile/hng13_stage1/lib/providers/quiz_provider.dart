import 'dart:async';

import 'package:flutter/material.dart';

import '../data/quiz_data.dart';

class QuizProvider extends ChangeNotifier {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;
  List<int?> userAnswers = List.filled(questions.length, null);
  Timer? timer;
  int timeLeft = 15;
  VoidCallback? onQuizComplete;

  QuizProvider({this.onQuizComplete}) {
    startTimer();
  }

  void startTimer() {
    stopTimer();
    timeLeft = 15;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (timeLeft > 0) {
        timeLeft--;
        notifyListeners();
      } else {
        _handleTimeUp();
      }
    });
  }

  void _handleTimeUp() {
    if (userAnswers[currentQuestionIndex] == null) {
      userAnswers[currentQuestionIndex] = -1;
    }

    if (isLastQuestion) {
      finishQuiz();
    } else {
      nextQuestion(autoFromTimer: true);
    }
  }

  void finishQuiz() {
    stopTimer();

    final callback = onQuizComplete;
    if (callback != null) {
      Future.delayed(Duration.zero, callback);
    }
  }

  void stopTimer() => timer?.cancel();

  void nextQuestion({bool autoFromTimer = false}) {
    if (!isLastQuestion) {
      currentQuestionIndex++;
      selectedAnswerIndex = userAnswers[currentQuestionIndex];
      startTimer();
      notifyListeners();
    } else {
      finishQuiz();
    }
  }

  void prevQuestion() {
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      selectedAnswerIndex = userAnswers[currentQuestionIndex];
      startTimer();
      notifyListeners();
    }
  }

  void restartQuiz() {
    stopTimer();
    currentQuestionIndex = 0;
    score = 0;
    selectedAnswerIndex = null;
    userAnswers = List.filled(questions.length, null);
    timeLeft = 15;
    onQuizComplete = null;
    startTimer();
    notifyListeners();
  }

  void selectAnswer(int index) {
    selectedAnswerIndex = index;
    userAnswers[currentQuestionIndex] = index;

    if (index == questions[currentQuestionIndex].correctAnswerIndex) {
      score++;
    }
    notifyListeners();
  }

  bool get isLastQuestion => currentQuestionIndex == questions.length - 1;
  bool get isFirstQuestion => currentQuestionIndex == 0;
}
