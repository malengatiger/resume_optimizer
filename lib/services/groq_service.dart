import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pretty_json/pretty_json.dart';

import '../models/groq/groq_chat_response.dart';
import '../models/groq/groq_models.dart';
import '../util/functions.dart';
import 'dio_util.dart';


class GroqService {
  //
  static const mm = '🔵🔵🔵🔵🔵🔵 GroqService 🔵🔵';
  static const a0 = 'gs';
  static const a1 = 'k_Kzg7aWj5dg6JVVF4DPftWGdyb3';
  static const a2 = 'FYYF2CcYD2kBWNLD4bgDm2Imaw';
  static const prefix = 'https://api.groq.com/openai/v1/chat/completions';
  static const String _key = '$a0$a1$a2';

/*
curl -X POST "https://api.groq.com/openai/v1/chat/completions" \
     -H "Authorization: Bearer $GROQ_API_KEY" \
     -H "Content-Type: application/json" \
     -d '{"messages": [{"role": "user", "content": "Explain the importance of low latency LLMs"}], "model": "mixtral-8x7b-32768"}'
 */
  final DioUtil dioUtil;

  GroqService(this.dioUtil);

  final List<GroqRequest> _requestHistory = [];
  final List<GroqChatResponse> _responseHistory = [];

  StreamController<List<GroqChatResponse> > streamController = StreamController.broadcast();
  Stream<List<GroqChatResponse> >  get chatStream => streamController.stream;

  StreamController<dynamic> errorController = StreamController.broadcast();
  Stream<dynamic>  get errorStream => errorController.stream;

  Future sendChatMessages(
      {required List<GroqRequest> messages,
      required String model,
      required bool stream,
      String? titleForContext}) async {
    var url = prefix;

    // _requestHistory.addAll(messages);
    var headers = {
      'Authorization': 'Bearer $_key',
      'Content-Type': 'application/json',
    };

    var start = DateTime.now();
    pp('$mm sending post request: $url');

    if (titleForContext != null) {
      messages.insertAll(0, getMessageContext(model, titleForContext, []));
    }
    Map<String, dynamic> body = {
      'messages': jsonEncode(messages),
      'model': model,
      'stream': stream,
    };
    pp('$mm sending with body: $body');
    try {
      Response response = await dioUtil.sendPostRequest(
          path: url, body: body, headers: headers);
      var end = DateTime.now();
      if (response.statusCode == 200 || response.statusCode == 201) {
        pp('$mm GOOD response from Groq,  🍀 🍀 🍀 statusCode: ${response.statusCode}\n${response.data}  🍀');
        pp('$mm elapsed time: ${end.difference(start).inSeconds} seconds');

        try {
          String responseText = response.data['response'];
          GroqChatResponse responseMessage =
              GroqChatResponse.fromJson(jsonDecode(responseText));
          _responseHistory.add(responseMessage);
          pp('$mm response history: ${_responseHistory.length} responseText: $responseText');
        } catch (e) {
          print(e);
        }
        return response.data;
      } else {
        pp('$mm BAD response: ${response.statusCode} ${response.statusMessage} - body: ${response.data}');
        pp('$mm elapsed time: ${end.difference(start).inSeconds} seconds');
        throw Exception(
            'Request execution failed; 👿👿statusCode: ${response.statusCode} 👿${response.statusMessage}\n${response.data}');
      }
    } catch (e, s) {
      pp('$mm $e $s');
      var end = DateTime.now();
      pp('$mm elapsed time: ${end.difference(start).inSeconds} seconds');
      throw Exception('Failed to send request: $e');
    }
  }

  Future<List<GroqChatResponse>> sendGroqRequests(
      {required List<Message> messages}) async {
    var url = prefix;

    List<GroqChatResponse> allResponses = [];
    var headers = {
      'Authorization': 'Bearer $_key',
      'Content-Type': 'application/json',
    };

    var start = DateTime.now();
    pp('$mm sending post request: $url');

    List xMessages = [];
    for (var msg in messages) {
      xMessages.add({'role': msg.role, 'content': msg.content});
    }
    Map<String, dynamic> body = {
      'messages': xMessages,
      'model': modelStringMixtral,
      'stream': false,
    };
    pp('$mm sending with body .... check params ...');
    pp(prettyJson(body));
    try {

      allResponses = await dioUtil.sendGroqRequest(
        url: prefix,
        body: body,
        headers: headers,
      );


      pp('$mm responses ..... ${allResponses.length}');
      return allResponses;
    } catch (e, s) {
      pp('$mm $e $s');
      var end = DateTime.now();
      pp('$mm elapsed time: ${end.difference(start).inSeconds} seconds');
      throw Exception('Failed to send request: $e');
      // errorController.sink.add(e);
    }
  }

  List<GroqRequest> getMessageContext(String model, String profile, List<String> skills) {
    var sb = StringBuffer();

    sb.write('You are a Resume Assistant. You are going to consider the following skills to respond:');
    for (var skill in skills) {
      sb.write(' $skill, ');
    }
    sb.write('\n\n ');
    sb.write('The example resume profile: $profile');
    //
    List<GroqRequest> messages = [
      GroqRequest(
          role: 'system',
          content:
             sb.toString()),
      GroqRequest(
          role: 'user',
          content: 'Help me prepare a resume profile based on the profile I provided. The profile is for this job: $profile'),
    ];

    return messages;
  }
  static const modelStringLlama2 = 'llama2-70b-4096';
  static const modelStringMixtral = 'mixtral-8x7b-32768';
  static const modelStringGemma = 'gemma-7b-it';

  List<String> mySkills = [
    'Google Cloud Platform',
    'AWS',
    'AI Chatbot Developing using OpenAI, Gemini, Claude, Groq and Mistral',
    'Java with Springboot',
  ];
}

