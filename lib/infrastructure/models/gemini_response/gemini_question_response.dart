// To parse this JSON data, do
//
//     final geminiQuizResponse = geminiQuizResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';

GeminiQuestionResponse? geminiQuestionResponseFromJson(String str) {
  try {
    return GeminiQuestionResponse.fromJson(json.decode(str));
  } catch (e) {
    return null;
  }
}

String geminiQuestionResponseToJson(GeminiQuestionResponse data) =>
    json.encode(data.toJson());

class GeminiQuestionResponse {
  final String quiz;
  final List<String> alternatives;
  final int answer;
  final QuizType type;

  GeminiQuestionResponse({
    required this.quiz,
    required this.alternatives,
    required this.answer,
    required this.type,
  });

  factory GeminiQuestionResponse.fromJson(Map<String, dynamic> json) {
    final alternativesJson =
        List<String>.from(json["alternatives"].map((x) => x));
    return GeminiQuestionResponse(
      quiz: json["question"],
      alternatives: alternativesJson,
      answer: json["answer"],
      type: QuizType.fromString(json["type"], alternativesJson.length),
    );
  }
  Map<String, dynamic> toJson() => {
        "question": quiz,
        "alternatives": List<dynamic>.from(alternatives.map((x) => x)),
        "answer": answer,
        "type": type
      };
}
