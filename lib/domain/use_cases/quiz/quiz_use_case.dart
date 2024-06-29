import 'package:ai_tutor_quiz/domain/entities/entities.dart';

class QuizUseCase {
  final QuizGateway quizGateway;

  QuizUseCase({required this.quizGateway});

  Future<Quiz> getQuiz() async {
    return await quizGateway.getQuiz();
  }
}
