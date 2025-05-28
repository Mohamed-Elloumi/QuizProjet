import 'package:flutter/material.dart';
import 'package:my_library/models/question.dart';

class QuizController with ChangeNotifier {
  List<Question> questions = [];
  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  bool isAnswered = false;


  void loadQuestions(List<Question> loadedQuestions) {
    questions = loadedQuestions;
    notifyListeners();
  }


  void checkAnswer(String answer) {
    if (isAnswered) return;

    selectedAnswer = answer;
    isAnswered = true;

    if (answer == questions[currentIndex].correctAnswer) {
      score++;
    }

    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        selectedAnswer = null;
        isAnswered = false;
        notifyListeners();
      } else {

      }
    });
  }


  void resetQuiz() {
    currentIndex = 0;
    score = 0;
    selectedAnswer = null;
    isAnswered = false;
    notifyListeners();
  }
}
