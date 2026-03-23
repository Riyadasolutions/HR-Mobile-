import 'package:base_app/core/res/resources.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

class CustomInputIcon extends StatelessWidget {
  final String _assets;
  final Color? _color;
  final double? _height;
  final double? _width;
  final double? _size;

  const CustomInputIcon(String assets,{super.key,
    Color? color,
    double? height,
    double? width,
    double? size,
  })
      : _assets = assets,
        _color = color,
        _size = size,
        _height = height,
        _width = width;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      HorizontalSpace(kFormPaddingAllLarge.w),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4.h),
            child: Center(
              child: SvgPicture.asset(
                _assets,
                height: _size ?? _height ?? 24.r,
                width: _size ?? _width ?? 24.r,
                color: _color,
              ),
            ),
          ),
          HorizontalSpace(kFormPaddingAllSmall.w),

      CustomDivider(height: 26.h,width: 1),
      HorizontalSpace(kFormPaddingAllLarge.w)
    ],
  );

}
