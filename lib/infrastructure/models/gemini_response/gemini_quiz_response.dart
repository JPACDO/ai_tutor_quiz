// To parse this JSON data, do
//
//     final geminiQuizResponse = geminiQuizResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';

List<GeminiQuestionResponse> geminiQuizResponseFromJson(
        String str, QuizType type) =>
    List<GeminiQuestionResponse>.from(
        json.decode(str).map((x) => GeminiQuestionResponse.fromJson(x)));

String geminiQuizResponseToJson(List<GeminiQuestionResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    final alternativesJson = List<String>.from(json["opciones"].map((x) => x));
    return GeminiQuestionResponse(
      quiz: json["pregunta"],
      alternatives: alternativesJson,
      answer: json["respuesta"],
      type: QuizType.fromString(json["type"], alternativesJson.length),
    );
  }
  Map<String, dynamic> toJson() => {
        "pregunta": quiz,
        "opciones": List<dynamic>.from(alternatives.map((x) => x)),
        "respuesta": answer,
        "type": type
      };
}
