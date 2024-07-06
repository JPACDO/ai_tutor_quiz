// To parse this JSON data, do
//
//     final geminiQuizResponse = geminiQuizResponseFromJson(jsonString);

import 'dart:convert';

import 'package:ai_tutor_quiz/domain/entities/entities.dart';

List<GeminiQuizResponse> geminiQuizResponseFromJson(
        String str, QuizType type) =>
    List<GeminiQuizResponse>.from(
        json.decode(str).map((x) => GeminiQuizResponse.fromJson(x, type)));

String geminiQuizResponseToJson(List<GeminiQuizResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GeminiQuizResponse {
  final String quiz;
  final List<String> alternatives;
  final int answer;
  final QuizType type;

  GeminiQuizResponse({
    required this.quiz,
    required this.alternatives,
    required this.answer,
    required this.type,
  });

  factory GeminiQuizResponse.fromJson(
          Map<String, dynamic> json, QuizType type) =>
      GeminiQuizResponse(
        quiz: json["pregunta"],
        alternatives: List<String>.from(json["opciones"].map((x) => x)),
        answer: json["respuesta"],
        type: type,
      );

  Map<String, dynamic> toJson() => {
        "pregunta": quiz,
        "opciones": List<dynamic>.from(alternatives.map((x) => x)),
        "respuesta": answer,
        "type": type
      };
}
