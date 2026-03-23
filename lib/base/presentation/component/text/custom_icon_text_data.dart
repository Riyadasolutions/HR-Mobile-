import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';

import '../component.dart';


class CustomIconTextData extends StatelessWidget {
  final String _title;
  final String _icon;
  final String? _value;
  final int _maxLines;
  final Color? _iconColor;
  final Color? _textColor;
  final double _iconSize;
  final TextStyle? _textStyle;

  const CustomIconTextData({
    super.key,
    required String title,
     String? value,
    required String icon,
    Color? iconColor,
    int maxLines =1,
    Color? textColor,
    double? iconSize,
    TextStyle? textStyle,
  })  : _title = title,
        _icon = icon,
        _value = value,
        _iconSize = iconSize??20,
        _textStyle = textStyle,
        _maxLines = maxLines,
        _textColor = textColor,
        _iconColor = iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _icon.endsWith('.svg')
                ?CustomSVGIcon(_icon, color: _iconColor, height: _iconSize.r, width: _iconSize.r)
                :Image.asset(_icon,color: _iconColor, width: _iconSize.r, height: _iconSize.r),

            // CustomSVGIcon(_icon, color: _iconColor, height: 20.r, width: 20.r),
            HorizontalSpace(kFormPaddingAllLarge.w),
            Text(_title, style:  const TextStyle().semiBoldStyle().primaryTextColor().ellipsisStyle().customColor(_textColor), maxLines: _maxLines
            ),
          ],
        ),
        if((_value??'').isNotEmpty)...[
          VerticalSpace(kFormPaddingAllSmall.h),
          Text(_value!, style:  _textStyle??const TextStyle().regularStyle().customColor( AppColor.hintColor.themeColor ).ellipsisStyle().customColor(_textColor), maxLines: _maxLines),
        ]
/*        Row(
          children: [
            CustomSVGIcon(_svgIcon, color: _iconColor, height: 20.r, width: 20.r),
            HorizontalSpace(kFormPaddingAllLarge.w),
            Text(_title, style:  const TextStyle().regularStyle().colorHover().ellipsisStyle().customColor(_textColor).boldStyle(), maxLines: _maxLines),
          ],
        ),
        if((_value??'').isNotEmpty)...[
          VerticalSpace(kFormPaddingAllSmall.h),
          Text(_value!, style:  _textStyle??const TextStyle().regularStyle().colorBlack().ellipsisStyle().customColor(_textColor), maxLines: _maxLines),
        ]*/
      ],
    );
  }

}
