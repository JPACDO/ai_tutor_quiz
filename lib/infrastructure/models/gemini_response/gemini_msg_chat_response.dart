// To parse this JSON data, do
//
//     final geminiMsgResponse = geminiMsgResponseFromJson(jsonString);

import 'dart:convert';

GeminiMsgResponse geminiMsgResponseFromJson(String str) =>
    GeminiMsgResponse.fromJson(json.decode(str));

String geminiMsgResponseToJson(GeminiMsgResponse data) =>
    json.encode(data.toJson());

class GeminiMsgResponse {
  final String response;
  final List<String> suggestions;

  GeminiMsgResponse({
    required this.response,
    required this.suggestions,
  });

  GeminiMsgResponse copyWith({
    String? response,
    List<String>? suggestions,
  }) =>
      GeminiMsgResponse(
        response: response ?? this.response,
        suggestions: suggestions ?? this.suggestions,
      );

  factory GeminiMsgResponse.fromJson(Map<String, dynamic> json) =>
      GeminiMsgResponse(
        response: json["responseData"] is String
            ? json["responseData"]
            : json["responseData"].toString(),
        suggestions: List<String>.from(json["suggestions"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "suggestions": List<dynamic>.from(suggestions.map((x) => x)),
      };
}
