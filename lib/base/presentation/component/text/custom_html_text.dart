import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomHTMLTextWidget extends StatelessWidget {
  final String _text;

  final Color? _textColor;

  final double _fontSize;
  final TextStyle? _style;

  const CustomHTMLTextWidget(
    String text, {
    super.key,
    Color? textColor,
    double? fontSize,
        TextStyle? style,
  }) : _text = text,
       _style = style,
       _textColor = textColor,
       _fontSize = fontSize ?? 14;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: _text,
      style: {"html": Style(color:_textColor??_style?.color?? Colors.black,fontSize: FontSize(_style?.fontSize?? _fontSize),textAlign: TextAlign.justify)},
    );
  }
}
