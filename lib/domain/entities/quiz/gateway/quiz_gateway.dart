import 'package:ai_tutor_quiz/domain/entities/quiz/quiz.dart';

abstract class QuizGateway {
  Future<Quiz> getQuiz();
}
