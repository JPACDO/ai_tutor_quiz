import 'dart:io';

import 'package:ai_tutor_quiz/domain/datasources/quiz/question_datasource.dart';
import 'package:ai_tutor_quiz/infrastructure/helpers/extraer_json_from_text.dart';
import 'package:ai_tutor_quiz/infrastructure/mappers/chat/msg_mapper.dart';
import 'package:ai_tutor_quiz/infrastructure/models/gemini_response/gemini_msg_chat_response.dart';
import 'package:flutter/services.dart';
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

    // topic.messages.isEmpty
    //     ? []
    //     : topic.messages
    //         .map((e) => (e!.sender == SenderType.user)
    //             ? Content.text(e.content)
    //             : Content.model([TextPart(e.content)]))
    //         .toList();

    return await getSimpleResponseStream(
        entradaDeTexto: prompt,
        history: history,
        languaje: 'Spanish',
        imageUrl: imgUrl);
    // }

    // return await getRessponseForImage(prompt, imgUrl);
  }

  Future<Message?> getSimpleResponseForText(String entradaDeTexto) async {
    final String formato = 'Reply to me using a valid JSON using the following structure: ' +
        '{"responseData": \$responseData, "suggestions": \$suggestions , "resumenQuestion": \$resumenQuietion , "resumenAnswer": \$resumenAnswer} ' +
        // 'responseData should be of Markdown format. ' +
        // 'resumenQuestion and resumenAnswer should be of String type. ' +
        'suggestions should be of type List<String>. ' +
        'suggestions are a list of possible questions to continue the conversation. ' +
        'resumenQuestion should be a summary of the question. ' +
        'resumenAnswer should be a summary of the $entradaDeTexto. ' +
        'The json keys must not change. ' +
        // 'The Json values must be understandable to someone who speaks Spanish. ';
        'The Json values ​​must be in the same language as that used in the question, unless a different one is indicated in the question.';

    String mainPrompt =
        'You are a virtual tutor who helps me to study.I would like you to answer and explain me to the following question : $entradaDeTexto. \n $formato';
    // 'You are a virtual tutor who helps me to study.I would like you to answer  me to the following question : $entradaDeTexto. The reply  must be understandable to someone who speaks Spanish. ';
    // final mainText = TextPart(mainPrompt);
    // final additionalTextParts = [formato].map((t) => TextPart(t)).join("\n");

    final content = [Content.text(mainPrompt)];

    final GenerateContentResponse response;

    response = await model.generateContent(
        content); // generationConfig: GenerationConfig(responseMimeType: 'application/json')

    try {
      if (response.text == null) return null;
      print(response.text);

      final String? jsonExtractor = extraerJSON(response.text!);
      print("NUEVO JSON");
      print(jsonExtractor);
      if (jsonExtractor == null) return null;

      // final String jsonExtractor =
      //     '{"responseData":"${response.text!.replaceAll("\"", "\\\"").replaceAll("\n", "\\n")}", "suggestions": [], "resumenQuestion": "", "resumenAnswer": ""}';

      final geminiMsgResponse = geminiMsgResponseFromJson(jsonExtractor);

      return geminiMsgResponse.toDomain();
    } catch (e) {
      print('ERROR RESPONSE:');
      print(e);
      return null;
    }
  }

  Future<Message?> getSimpleResponseStream(
      {required String entradaDeTexto,
      required List<Content> history,
      String languaje = 'Spanish',
      String? imageUrl}) async {
    String mainPrompt = '$entradaDeTexto ';

    var chat = model.startChat(history: [
      ...history
      // Content.text('Hello, I have 2 dogs in my house.'),
      // Content.model([TextPart('Great to meet you. What would you like to know?')])
    ]);

    // var content = Content.text(mainPrompt);
    try {
      var content = await promtToContent(mainPrompt, imageUrl);

      var response = await chat.sendMessage(content);
      print(response.text);
      if (response.text == null) return null;

      final String jsonExtractor =
          '{"responseData":"${response.text!.replaceAll("\"", "\\\"").replaceAll("\n", "\\n")}", "suggestions": [], "resumenQuestion": "", "resumenAnswer": ""}';

      final geminiMsgResponse = geminiMsgResponseFromJson(jsonExtractor);

      return geminiMsgResponse.toDomain();
    } catch (e) {
      print('ERROR RESPONSE:');
      print(e);
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

  Future<Message?> comparateImages(
      String entradaDeTexto, String pathImg1, String pathImg2) async {
    final img1Bytes = await rootBundle.load(pathImg1);
    final img2Bytes = await rootBundle.load(pathImg2);

    final img1Buffer = img1Bytes.buffer.asUint8List();
    final img2Buffer = img2Bytes.buffer.asUint8List();

    final imageParts = [
      DataPart('image/jpeg', img1Buffer),
      DataPart('image/jpeg', img2Buffer),
    ];

    final prompt = TextPart(entradaDeTexto);
    final response = await modelProvision.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    print(response.text);
    if (response.text == null) return null;
    final geminiMsgResponse = geminiMsgResponseFromJson(response.text!);

    return geminiMsgResponse.toDomain();
  }

  Future<Message?> getRessponseForImage(
      String entradaDeTexto, String pathImg) async {
    final File imageProvider = File(pathImg);

    final imgBuffer = await imageProvider.readAsBytes();

    final imageParts = [
      DataPart('image/jpeg', imgBuffer),
    ];

    final prompt = TextPart(entradaDeTexto);
    final response = await modelProvision.generateContent([
      Content.multi([prompt, ...imageParts])
    ]);
    print(response.text);

    if (response.text == null) return null;

    final String jsonExtractor =
        '{"responseData":"${response.text!.replaceAll("\"", "\\\"").replaceAll("\n", "\\n")}", "suggestions": [], "resumenQuestion": "", "resumenAnswer": ""}';

    final geminiMsgResponse = geminiMsgResponseFromJson(jsonExtractor);

    return geminiMsgResponse.toDomain();
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
  Future<List<Question>> getQuizFromBot({required String prompt}) {
    // TODO: implement getQuizFromBot
    throw UnimplementedError();
  }
}
