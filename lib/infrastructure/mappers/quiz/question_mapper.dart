import 'package:ai_tutor_quiz/domain/entities/entities.dart';

import '../../models/gemini_response/gemini_question_response.dart';

const empty = "";
const zero = 0;

extension QuestionResponseMapper on GeminiQuestionResponse? {
  Question toDomain() {
    return Question(
        question: this?.quiz ?? empty,
        alternatives: this?.alternatives ?? [],
        correctAnswerIndex: this?.answer ?? zero,
        type: this?.type ?? QuizType.multipleChoice);
  }
}
