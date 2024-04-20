import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../models/groq/groq_chat_response.dart';
import '../util/functions.dart';

class DioUtil {
  final Dio dio;
  static const mm = '🥬🥬🥬🥬 DioUtil 🥬';

  DioUtil(this.dio);

  static const urlPrefix =
      'https://generativelanguage.googleapis.com/v1beta/models/';

  Future<Response> sendGetRequestWithHeaders(
      {required String path,
      required Map<String, dynamic> queryParameters,
      required dynamic headers}) async {
    pp('$mm Dio sendGetRequestWithHeaders ...: 🍎🍎🍎 path: $path 🍎🍎');
    try {
      Response response;
      // The below request is the same as above.
      response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers, responseType: ResponseType.json),
      );

      pp('$mm Dio network response: 🥬🥬🥬🥬🥬🥬 status code: ${response.statusCode}');
      return response;
    } catch (e) {
      pp('$mm Dio network response: 👿👿👿👿 ERROR: $e');
      pp(e);
      rethrow;
    }
  }

  Future<Response> sendGetRequest(
      {required String path, required Map<String, dynamic> params}) async {
    pp('$mm Dio sendGetRequest ...: 🍎🍎🍎 path: $path 🍎 '
        '\n 🍎params: $params 🍎\n');
    try {
      Response response;
      response = await dio
          .get(
        path,
        queryParameters: params,
        options: Options(responseType: ResponseType.json),
      )
          .catchError((error, stackTrace) {
        pp('$mm Error occurred during the GET request: '
            '👿 $error 👿\n 👿$stackTrace 👿');
      });

      pp('$mm Dio network response: 🥬🥬🥬🥬🥬🥬 status code: ${response.statusCode}');
      return response;
    } catch (e) {
      pp('$mm Dio network response: 👿👿👿👿 ERROR: $e');
      pp(e);
      rethrow;
    }
  }

  Future<Response> sendPostRequest({
    required String path,
    required dynamic body,
    dynamic headers,
  }) async {
    pp('$mm Dio sendPostRequest ...: 🍎🍎🍎 path: $path 🍎🍎');
    try {
      Response response = await dio.post(
        path,
        data: body,
        options: Options(responseType: ResponseType.json, headers: headers),
        onReceiveProgress: (count, total) {
          pp('$mm onReceiveProgress: count: $count total: $total');
        },
        onSendProgress: (count, total) {
          pp('$mm onSendProgress: count: $count total: $total');
        },
      ).timeout(const Duration(seconds: 300));

      pp('$mm .... network POST response, 💚status code: ${response.statusCode} 💚💚 $path');
      return response;
    } catch (e, stackTrace) {
      pp('$mm .... network POST error response, '
          '👿👿👿👿 $e 👿👿👿👿');
      pp(stackTrace);
      rethrow;
    }
  }

  Future<List<GroqChatResponse>> sendGroqRequest({
    required String url,
    required dynamic body,
    dynamic headers,
  }) async {
    pp('$mm Dio sendPostRequestAsStream ...: 🍎🍎🍎 url: $url 🍎🍎');
    List<GroqChatResponse> chatResponses = [];
    try {
      final Response response = await dio.post(
        url,
        data: body,
        options: Options(
          // responseType: ResponseType.json,
          headers: headers,
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        pp('\n\n\n$mm response.statusCode: ${response.statusCode} message: ${response.statusMessage} ');
        pp('$mm response.data: ${response.data}');
        var gcr = GroqChatResponse.fromJson(response.data);
        pp('$mm ...GroqChatResponse:  🤟🏽 ${gcr.toJson()} 🤟🏽 ');
        chatResponses.add(gcr);
        // List<String> lines = response.data.split('\n');
        // for (String line in lines) {
        //   if (line.startsWith('data: ')) {
        //     if (line.contains('[DONE]')) {
        //       pp('\n$mm ...DONE parsing responses 🥬🥬🥬🥬🥬🥬🥬🥬🥬');
        //     } else {
        //       String jsonString = line.substring(5);
        //       dynamic jsonObject = jsonDecode(jsonString);
        //       var gcr = GroqChatResponse.fromJson(jsonObject);
        //       pp('$mm ...GroqChatResponse:  🤟🏽 ${gcr.toJson()} 🤟🏽 ');
        //       chatResponses.add(gcr);
        //     }
        //   }
        // }

        pp('\n\n$mm  🥬🥬🥬🥬🥬🥬🥬🥬🥬 GroqChatResponses: ${chatResponses.length}');
        return chatResponses;
      } else {
        pp('$mm BAD response.statusCode: ${response.statusCode}');
        throw Exception('BAD response, status code: ${response.statusCode}');
      }
    } catch (e, s) {
      throw Exception('$mm 👿👿Failed to send POST request: $e - $s');
    }
  }
/*
    Stream<List<GroqChatResponse> > sendPostRequestReturnStream({
    required String url,
    required dynamic body,
    dynamic headers,
  }) async* {
    pp('$mm Dio sendPostRequestAsStream ...: 🍎🍎🍎 url: $url 🍎🍎');
    try {
      final Response response = await dio.post(
        url,
        data: body,
        options: Options(
          responseType: ResponseType.stream,
          headers: headers,
        ),
      );

      if (response.statusCode == HttpStatus.ok) {
        pp('\n\n\n$mm response.statusCode: ${response.statusCode} message: ${response.statusMessage} ');

        final stream = response.data.stream
            .transform(StreamTransformer<Uint8List, dynamic>.fromHandlers(
          handleData: (data, sink) {
            try {
              pp('\n\n\n$mm ... handleData: ${data.length} bytes');
              String s = utf8.decode(data);
              pp('$mm ... uint decoded: 🍎 $s 🍎');

              List<String> lines = s.split('\n');
              List<dynamic> jsonList = [];

              for (String line in lines) {
                if (line.startsWith('data: ')) {
                  String jsonString = line.substring(6);
                  dynamic jsonObject = jsonDecode(jsonString);
                  jsonList.add(jsonObject);
                }
              }
              pp('$mm ... handleData, after regex; jsonList: 🍎 ${jsonList.length} 🍎');
              List<GroqChatResponse> gcrs = [];
              for (var gx in jsonList) {
                gcrs.add(GroqChatResponse.fromJson(gx));
              }

              pp('$mm ... handleData, after regex; gcrs: 🍎 ${gcrs.length} 🍎');
              sink.add(gcrs);
              pp('$mm ............. added to sink, yae!!!! ');
            } catch (e, s) {
              pp('$mm ERROR handleData: $e $s');
            }
          },
          handleError: (error, stackTrace, sink) {
            // Handle error if needed
            pp('$mm handleError: $error $stackTrace');
          },
          handleDone: (sink) {
            pp('$mm ............. handleDone?? ');
          },
        ));

        await for (List<GroqChatResponse> chunk in stream) {
          pp('$mm ...handling chunks in stream:  🤟🏽 🤟🏽 '
              '${chunk.length}  🤟🏽 🤟🏽 ... will yield data');
          yield chunk;
        }
      } else {
        pp('$mm BAD response.statusCode: ${response.statusCode}');
        throw Exception('BAD response, status code: ${response.statusCode}');
      }
    } catch (e, s) {
      throw Exception('$mm 👿👿Failed to send POST request: $e - $s');
    }
  }
   */
}
