// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:io';

import 'package:ai_tutor_quiz/domain/datasources/quiz/question_datasource.dart';
import 'package:ai_tutor_quiz/infrastructure/helpers/extraer_json_from_text.dart';
import 'package:ai_tutor_quiz/infrastructure/mappers/chat/msg_mapper.dart';
import 'package:ai_tutor_quiz/infrastructure/mappers/quiz/question_mapper.dart';
import 'package:ai_tutor_quiz/infrastructure/models/gemini_response/gemini_msg_chat_response.dart';
import 'package:ai_tutor_quiz/infrastructure/models/gemini_response/gemini_question_response.dart';
import 'package:ai_tutor_quiz/config/constants/enviroment.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ai_tutor_quiz/domain/datasources/datasources.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/entities.dart';

class GeminiChatDatasource implements MessageDatasource, QuestionDatasource {
  final model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: Env.geminiKey,
    generationConfig: GenerationConfig(
      temperature: 1.0,
      topK: 32,
      topP: 1,
    ),
  );
  final modelProvision =
      GenerativeModel(model: 'gemini-pro-vision', apiKey: Env.geminiKey);

  @override
  Future<Message?> getMessage(
      {required String prompt,
      required String? imgUrl,
      required Topic topic}) async {
    // if (imgUrl == null) {
    // return await getSimpleResponseForText(prompt);

    List<Content> history = [];

    if (topic.messages.isNotEmpty) {
      for (var message in topic.messages) {
        if (message!.sender == SenderType.user) {
          final Content content =
              await promtToContent(message.content, message.imgUrl);
          history.add(content);
        } else {
          history.add(Content.model([TextPart(message.content)]));
        }
      }
    }

    return await getSimpleResponseStream(
        prompt: prompt,
        history: history,
        languaje: 'Spanish',
        imageUrl: imgUrl);
  }

  Future<Message?> getSimpleResponseStream(
      {required String prompt,
      required List<Content> history,
      String languaje = 'Spanish',
      String? imageUrl}) async {
    String mainPrompt = '$prompt ';

    var chat = model.startChat(history: [...history]);

    // var content = Content.text(mainPrompt);
    try {
      var content = await promtToContent(mainPrompt, imageUrl);

      var response = await chat.sendMessage(content);
      // print(response.text);
      if (response.text == null) return null;

      final String jsonExtractor =
          '{"responseData":"${response.text!.replaceAll("\"", "\\\"").replaceAll("\n", "\\n")}", "suggestions": [], "resumenQuestion": "", "resumenAnswer": ""}';

      final geminiMsgResponse = geminiMsgResponseFromJson(jsonExtractor);

      return geminiMsgResponse.toDomain();
    } catch (e) {
      // print('ERROR RESPONSE:');
      // print(e);
      if (e.toString() ==
          "GenerativeAIException: Candidate was blocked due to recitation") {
        const String jsonExtractor =
            '{"responseData":"Try to rephrase your question", "suggestions": [], "resumenQuestion": "", "resumenAnswer": ""}';

        final geminiMsgResponse = geminiMsgResponseFromJson(jsonExtractor);

        return geminiMsgResponse.toDomain();
      }
      return null;
    }
  }

  Future<Content> promtToContent(String promp, String? imageUrl) async {
    if (imageUrl == null) {
      return Content.text(promp);
    } else {
      final File imageProvider = File(imageUrl);

      final imgBuffer = await imageProvider.readAsBytes();

      final imageParts = [
        DataPart('image/jpeg', imgBuffer),
      ];

      final prompt = TextPart(promp);

      return Content.multi([prompt, ...imageParts]);
    }
  }

  @override
  Future<String> saveImageOfMessage({required XFile img}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Question>> getQuizFromBot(
      {required String prompt, required Quiz quiz}) async {
    final List<String> questionsType =
        quiz.type.map((e) => e.toString()).toList();
    final String formato = 'Reply to me using a valid JSON using the following structure:' +
        '{"question": \$question, "alternatives": \$alternatives ,answer: \$answer ,"type": \$type} ' +
        'question should be a string. ' +
        'alternatives should be of type List<String>, ' +
        'if the question is of the "${QuizType.openAnswer}" type, the list should only have one alternative, which contains a very short explanation to the question'
            'answer must be of type integer, it must indicate the index of the correct answer in the list of alternatives. ' +
        'type should be a String from this list: $questionsType. ' +
        'The json keys must not change. ' +
        'The  values of  question and alternatives must be in the same language as that used in the question, unless a different one is indicated in the question.';

    String mainPrompt =
        'You are a virtual tutor who helps me to study.I would like you to generate questions about: $prompt.' +
            'this questions should be of type: $questionsType.' +
            'Generate me just one question for now, then I will ask you more.  \n $formato';

    final content = Content.text(mainPrompt);

    var chat = model.startChat(history: []);

    final List<Question> questionsGenerated = [];

    GenerateContentResponse response;

    try {
      response = await chat.sendMessage(content);
      extraerJSON(response.text!);
    } catch (e) {
      print('ERROR RESPONSE:');
      print(e);
      rethrow;
    }

    for (var i = 0; i < quiz.numberOfQuestions; i++) {
      try {
        if (i != 0) {
          response =
              await chat.sendMessage(Content.text('one more question please'));
        }

        final String? jsonExtractor = extraerJSON(response.text!);

        if (jsonExtractor == null) continue;

        final geminiQuizResponse =
            geminiQuestionResponseFromJson(jsonExtractor);

        if (geminiQuizResponse == null) continue;

        questionsGenerated.add(geminiQuizResponse.toDomain());
      } catch (e) {
        print('ERROR RESPONSE in FOR:');
        print(e);
        continue;
      } finally {
        await Future.delayed(const Duration(seconds: 1));
      }
    }
    print(questionsGenerated);
    return questionsGenerated;
  }
}
