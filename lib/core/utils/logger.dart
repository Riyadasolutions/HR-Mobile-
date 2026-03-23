import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;

// final logger = Logger(
//   printer: PrettyPrinter(
//       methodCount: 0, // number of method calls to be displayed
//       // errorMethodCount: 8, // number of method calls if stacktrace is provided
//       // lineLength: 120, // width of the output
//       // colors: true, // Colorful log messages
//       // printEmojis: false, // Print an emoji for each log message
//       // printTime: false // Should each log print contain a timestamp
//       ),
// );

getLines(String message) {
  List<String> words = message.split(' ');

  String msg = verticalLine;
  int count = 20;
  for (int index = 0; index < words.length; ++index) {
    msg = '$msg ${words[index]}';
    if (index == count) {
      if (count + 20 > words.length) {
        count = words.length;
      } else {
        count = (count + 20);
      }
      msg='\n$verticalLine';
    }
  }
  return msg;
}

 boxedLog(String tag, String message) {
  String m1 = '$topLeftCorner$line';
  String m2 = '$verticalLine 🐛 $tag';
  String m3 = '$middleCorner$line';
  String m4 = '$verticalLine $message';
  // String m4 = message;
  // String m4 = '${getLines(message)}';
  String m5 = '$bottomLeftCorner$line';
  // debugPrint("$m1\n$m2\n$m3\n$m4\n$m5");
  // dev.log("$m1\n$m2\n$m3\n$m4\n$m5");

}

 boxedLogVsCode(String tag, String message) {
  String m1 = '$topLeftCorner$line';
  String m2 = '$verticalLine 🐛 $tag';
  String m3 = '$middleCorner$line';
  String m4 = '$verticalLine $message';
  // String m4 = message;
  // String m4 = '${getLines(message)}';
  String m5 = '$bottomLeftCorner$line';
  // debugPrint("$m1\n$m2\n$m3\n$m4\n$m5");
  // dev.log("$m1\n$m2\n$m3\n$m4\n$m5");

}

  //android 
  // const _lineWidth = 180;
  // final _topBorder = '┌${'─' * (_lineWidth - 8)}┐';
  // final _bottomBorder = '└${'─' * (_lineWidth - 2)}┘';
  // final _separator = '├${'─' * (_lineWidth - 2)}┤';

  //VS code
  const _lineWidth = 140;
  final _topBorder = '┌${'─' * (_lineWidth - 4)}┐';
  final _bottomBorder = '└${'─' * (_lineWidth - 2)}┘';
  final _separator = '├${'─' * (_lineWidth - 2)}┤';


/// Logs a formatted debug message inside a clean visual box.
void log(String title, String content) {
  if(!kDebugMode)return;
  // const lineWidth = 180;
  // final topBorder = '┌${'─' * (lineWidth - 8)}┐';
  // final bottomBorder = '└${'─' * (lineWidth - 2)}┘';
  // final separator = '├${'─' * (lineWidth - 2)}┤';

  final buffer = StringBuffer();
  buffer.writeln(_topBorder);

  // Safe title line
  final trimmedTitle = title.length > (_lineWidth - 4) ? title.substring(0, _lineWidth - 4) : title;
  buffer.writeln('│ $trimmedTitle${' ' * (_lineWidth - 3 - trimmedTitle.length)}│');

  buffer.writeln(_separator);

  // Lines with optional wrapping
  for (final line in content.trim().split('\n')) {
    final chunks = _wrapLine(line, _lineWidth - 4); // 4 = space + border
    for (final chunk in chunks) {
      buffer.writeln('│ $chunk${' ' * (_lineWidth - 3 - chunk.length)}│');
    }
  }

  buffer.writeln(_bottomBorder);

  dev.log(buffer.toString());
}
/// Wraps a line to a fixed width for logging
List<String> _wrapLine(String text, int maxWidth) {
  if (text.length <= maxWidth) return [text];
  final result = <String>[];
  for (int i = 0; i < text.length; i += maxWidth) {
    result.add(text.substring(i, i + maxWidth > text.length ? text.length : i + maxWidth));
  }
  return result;
}


// ┇
const topLeftCornera = '┬';
const topLeftCorner = '┌';
const bottomLeftCorner = '└';
const middleCorner = '├';
const middleCorner1 = '┤';
const verticalLine = '│';
const doubleDivider = '─';
const line = '───────────────────────────────────────────────────────────────────';
const singleDivider = '┄';