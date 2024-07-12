import 'package:flutter/material.dart';

class ResultQuizScreen extends StatelessWidget {
  const ResultQuizScreen({super.key});

  static const name = 'resume-quiz';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Quiz'),
      ),
      body: const Center(child: Text('Result Quiz')),
    );
  }
}
