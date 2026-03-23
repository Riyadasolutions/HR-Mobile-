import 'package:base_app/core/res/resources.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTextClickWidget extends StatelessWidget {
  final String _text ;
  final String _subText ;
  final Color? _textColor ;
  final double _fontSize ;
  final GestureTapCallback? _onTap;

  const CustomTextClickWidget({super.key,
    String text='',
    String subText='',
    Color? textColor,
    double? fontSize ,
    GestureTapCallback? onTap,
  })  : _text = text,
        _fontSize = fontSize??14,
        _subText = subText,
        _textColor = textColor,
        _onTap = onTap;


  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: _text ,
            style:  const TextStyle().regularStyle(fontSize: _fontSize).customColor( Theme.of(context).hintColor )
          ),
          TextSpan(
            text: ' $_subText',
            style:const TextStyle().regularStyle(fontSize: _fontSize).activeColor().customColor(_textColor),//.underLineStyle() Theme.of(context).textTheme.caption!.copyWith(color: Theme.of(context).primaryColor, height: 1.4, fontSize: 16,decoration:TextDecoration.underline ),
            recognizer: TapGestureRecognizer()..onTap = _onTap,
          ),
        ],
      ),
    );
  }


}

