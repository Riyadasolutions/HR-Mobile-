import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';

import '../component.dart';


class CustomIconText extends StatelessWidget {
  final String _title;
  final String? _icon;
  final int _maxLines;
  final IconData? _iconData;
  final Color? _iconColor;
  final double _iconSize;
  final double _space;
  final Color? _textColor;
  final MainAxisAlignment _mainAxisAlignment;
  final MainAxisSize _mainAxisSize;
  final TextStyle? _textStyle;
  final bool _isExpanded;

  const CustomIconText({
    super.key,
    required String title,
    String? icon,
    Color? iconColor,
    IconData? iconData,
    int maxLines =1,
    double space =4,
    double iconSize =24,
    Color? textColor,
    bool isExpanded = false,
    TextStyle? textStyle,
    MainAxisSize? mainAxisSize,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  })  : _title = title,
        _icon = icon,
        _space = space,
        _iconSize = iconSize,
        _mainAxisSize = mainAxisSize??MainAxisSize.max,
        _isExpanded = isExpanded,
        _iconData = iconData,
        _textStyle = textStyle,
        _maxLines = maxLines,
        _textColor = textColor,
        _mainAxisAlignment = mainAxisAlignment,
        _iconColor = iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      mainAxisSize: _mainAxisSize,
      children: [
        if(_iconData!=null)Icon(_iconData,color: _iconColor, size: _iconSize.r),
        if(_icon!=null&&Validators.isURL(_icon) )CustomImage(imageUrl: _icon, width: _iconSize.r, height: _iconSize.r)
        else if(_icon!=null)_icon.endsWith('.svg')
            ?CustomSVGIcon(_icon, color: _iconColor, height: _iconSize.r, width: _iconSize.r)
            :Image.asset(_icon,color: _iconColor, width: _iconSize.r, height: _iconSize.r),
        // Image.network(_icon,color: _iconColor, width: _iconSize.r, height: _iconSize.r)

        HorizontalSpace(_space.w),
        if(_isExpanded)
          Expanded(
            child: AutoSizeText(_title,
                style:  _textStyle??(Theme.of(context).inputDecorationTheme.labelStyle??const TextStyle()).regularStyle().ellipsisStyle().customColor(_textColor??AppColor.textColor.themeColor),
                maxLines: _maxLines),
          )
        else
            Text(_title,
              style:  _textStyle??(Theme.of(context).inputDecorationTheme.labelStyle??const TextStyle()).regularStyle().ellipsisStyle().customColor(_textColor??AppColor.textColor.themeColor),
              maxLines: _maxLines),
      ],
    );
  }
}
