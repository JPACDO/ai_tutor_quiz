import 'package:ai_tutor_quiz/config/constants/enviroment.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('${Env.geminiKey}'),
    );
  }
}
