import 'package:flutter/material.dart';
import 'quizz.dart';

void main() => runApp(const QuizzlerApp());

class QuizzlerApp extends StatelessWidget {
  const QuizzlerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizzler',
      debugShowCheckedModeBanner: false,
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentIndex = 0;
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userAnswer) {
    final correctAnswer = questionBank[currentIndex].answer;

    setState(() {
      if (userAnswer == correctAnswer) {
        scoreKeeper.add(
          const Icon(Icons.check, color: Color.fromARGB(255, 172, 248, 174)),
        );
      } else {
        scoreKeeper.add(
          const Icon(Icons.close, color: Color.fromARGB(255, 245, 184, 180)),
        );
      }

      if (currentIndex < questionBank.length - 1) {
        currentIndex++;
      } else {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Hoàn thành'),
                content: const Text('Bạn đã hoàn thành tất cả câu hỏi.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      setState(() {
                        currentIndex = 0;
                        scoreKeeper.clear();
                      });
                    },
                    child: const Text('Chơi lại'),
                  ),
                ],
              ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionText = questionBank[currentIndex].text;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    questionText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => checkAnswer(true),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Đúng', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => checkAnswer(false),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Sai', style: TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: scoreKeeper),
            ],
          ),
        ),
      ),
    );
  }
}
