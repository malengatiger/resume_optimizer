import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'functions.dart';

class HttpUtility {
  static const mm = '🔵🔵🔵 HttpUtility 💛💛';

  static Future<http.Response> get(
      {required String url, required dynamic headers}) async {
    try {
      pp('$mm .... sending http get request: $url \nheaders: $headers');

      final response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(Duration(seconds: 60));
      return response;
    } catch (e, stackTrace) {
      pp('$mm Error occurred during GET request: $e');
      pp(stackTrace);
      rethrow;
    }
  }

  static Future<http.Response> post(
      {required String url,
      required dynamic body,
      required dynamic headers}) async {
    var start = DateTime.now();

    try {
      pp('$mm .... sending http post request: '
          '$url \nheaders: $headers - timeout is 5 minutes');
      http.Response response = await http
          .post(Uri.parse(url), body: jsonEncode(body), headers: headers)
          .timeout(Duration(minutes: 5));
      var end = DateTime.now();
      pp('$mm ... 🔵🔵🔵 post request: ${end.difference(start)} seconds elapsed');
      return response;
    } catch (e, stackTrace) {
      pp('$mm Error occurred during POST request: $e');
      if (e is TimeoutException) {
        var end = DateTime.now();
        pp('$mm Timeout occurred during POST request: $e\n'
            ' 👿 👿It took ${end.difference(start)} seconds before we fell downstairs! 👿 ');
      } else {
        // Handle other types of exceptions
        pp('$mm  👿 👿 Error occurred during POST request:  👿$e - $stackTrace');
      }
      pp(stackTrace);
      rethrow;
    }
  }
}
