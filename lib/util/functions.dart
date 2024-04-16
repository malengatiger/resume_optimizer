
import 'package:logger/logger.dart';


Logger logger = Logger();
void pp(dynamic msg) {
   // defaults to Level.INFO

  print('${DateTime.now().toIso8601String()} $msg');
  //logger.d(msg, time: DateTime.now());
  // var logger = Logger(
  //   printer: PrettyPrinter(
  //       methodCount: 2, // Number of method calls to be displayed
  //       errorMethodCount: 8, // Number of method calls if stacktrace is provided
  //       lineLength: 120, // Width of the output
  //       colors: true, // Colorful log messages
  //       printEmojis: true, // Print an emoji for each log message
  //       printTime: false // Should each log print contain a timestamp
  //   ),
  // );
}


String formatMilliseconds(int milliseconds) {
  int seconds = (milliseconds / 1000).truncate();
  int minutes = (seconds / 60).truncate();
  seconds %= 60;

  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');

  return '$minutesStr:$secondsStr';
}

bool isMarkdownFormats(String text) {
  // Markdown heading pattern: # Heading
  final headingPattern = RegExp(r'^#\s');

  // Markdown bold pattern: **Bold**
  final boldPattern = RegExp(r'\*\*.*\*\*');

  // Markdown italic pattern: *Italic*
  final italicPattern = RegExp(r'\*.*\*');

  // Markdown link pattern: [Link](https://example.com)
  final linkPattern = RegExp(r'\[.*\]\(.*\)');

  // Check if the text matches any of the Markdown patterns
  if (headingPattern.hasMatch(text) ||
      boldPattern.hasMatch(text) ||
      italicPattern.hasMatch(text) ||
      linkPattern.hasMatch(text)) {
    return true;
  }

  return false;
}

