import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';

import '../component.dart';


class CustomImageText extends StatelessWidget {
  final String _title;
  final String _image;
  final Color? _textColor;
  final TextStyle? _textStyle;
  final MainAxisAlignment _mainAxisAlignment;

  const CustomImageText({super.key,
    required String title,
    required String image,
    Color? iconColor,
    Color? textColor,
    TextStyle? textStyle,
    MainAxisAlignment mainAxisAlignment=MainAxisAlignment.start,
  })  : _title = title,
        _image = image,
        _textStyle = textStyle,
        _textColor = textColor,
        _mainAxisAlignment = mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      children: [
        CustomImage(
          imageUrl: _image,
          height: 20.r,
          width: 20.r,
        ),
        HorizontalSpace(kFormPaddingAllSmall.w),
        Text(_title,
            style:  _textStyle??(Theme.of(context).inputDecorationTheme.labelStyle??const TextStyle()).ellipsisStyle().customColor(_textColor),
            maxLines: 1),
      ],
    );
  }

}
