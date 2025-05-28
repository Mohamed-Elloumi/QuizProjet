import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_library/models/question.dart';
import 'package:my_library/services/api_Quiz.dart';
import 'package:my_library/services/audio_service.dart';
import 'package:my_library/screens/question_card.dart';
import 'package:my_library/screens/answer_button.dart';
import 'package:my_library/screens/result_screen.dart';

class QuizConf extends StatefulWidget {
  final String difficulty;
  final bool backgroundMusic;
  final bool soundEffects;
  final bool hasTimer;

  const QuizConf({
    Key? key,
    required this.difficulty,
    required this.backgroundMusic,
    required this.soundEffects,
    required this.hasTimer,
  }) : super(key: key);

  @override
  State<QuizConf> createState() => _QuizConfState();
}

class _QuizConfState extends State<QuizConf> {
  late Future<List<Question>> futureQuestions;
  late AudioService _audioService;

  int currentIndex = 0;
  int score = 0;
  String? selectedAnswer;
  Timer? _timer;
  int _remainingTime = 15;

  @override
  void initState() {
    super.initState();
    futureQuestions = ApiQuiz.fetchQuestions(widget.difficulty);
    _audioService = AudioService();
    if (widget.backgroundMusic) {
      _audioService.playBackgroundMusic();
    }
  }

  void startTimer() {
    if (!widget.hasTimer) return; // On ne fait rien si le timer est désactivé
    stopTimer();
    _remainingTime = 15;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });
      if (_remainingTime == 0) {
        timer.cancel();
        goToNextQuestion(isTimeOut: true);
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void goToNextQuestion({bool isTimeOut = false}) {
    if (widget.hasTimer && !isTimeOut) stopTimer();

    if (currentIndex < _questionList.length - 1) {
      setState(() {
        currentIndex++;
        selectedAnswer = null;
        _remainingTime = 15;
      });
      if (widget.hasTimer) startTimer(); // Démarre le timer uniquement si activé
    } else {
      stopTimer();
      _audioService.stopBackgroundMusic();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(score: score, total: _questionList.length),
        ),
      );
    }
  }

  void checkAnswer(String selected, List<Question> questions) {
    stopTimer();
    final correctAnswer = questions[currentIndex].correctAnswer;

    if (selected == correctAnswer) {
      score++;
      if (widget.soundEffects) _audioService.playEffect('correct');
    } else {
      if (widget.soundEffects) _audioService.playEffectWrong('wrong');
    }

    setState(() {
      selectedAnswer = selected;
    });

    Future.delayed(const Duration(seconds: 1), () {
      goToNextQuestion();
    });
  }

  late List<Question> _questionList;

  @override
  void dispose() {
    stopTimer();
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Quiz",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Question>>(
        future: futureQuestions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Aucune question trouvée."));
          }

          _questionList = snapshot.data!;
          final question = _questionList[currentIndex];

          if (_timer == null && selectedAnswer == null) {
            startTimer();
          }

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2193b0), Color(0xFF6dd5ed)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: kToolbarHeight + 40),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                          QuestionCard(
                            questionText: question.question,
                            remainingTime: _remainingTime,
                          ),

                          // Nouveau minuteur stylisé avec un cercle





                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Container(

                    decoration: const BoxDecoration(

                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      itemCount: question.answers.length,
                      itemBuilder: (context, index) {
                        final answer = question.answers[index];
                        final isSelected = selectedAnswer == answer;
                        final isCorrect = answer == question.correctAnswer;

                        return AnswerButton(
                          answer: answer,
                          isSelected: isSelected,
                          isCorrect: isCorrect,
                          isAnswered: selectedAnswer != null,
                          onTap: () => checkAnswer(answer, _questionList),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
