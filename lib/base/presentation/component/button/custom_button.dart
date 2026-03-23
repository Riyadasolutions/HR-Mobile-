
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

import 'package:base_app/core/res/resources.dart';
import '../component.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback _onTap;
  final Widget? _child;
  final String? _title;
  final Color? _color;
  final Color? _textColor;
  final Color? _borderColor;
  final double? _width;
  final double _height;
  final double _fontSize;
  final double _radius;
  final bool _isOutlined;
  final bool _widerPadding;
  final bool _isCircle;
  final bool _loading;
  final double? _loadingSize;
  final bool _enable;


  const CustomButton({super.key,
    required VoidCallback onTap,
    Widget? child,
    String? title,
    Color? color,
    Color? textColor,
    Color? borderColor,
    double? width,
    double fontSize = 16,
    double height=48,
    double radius=kButtonRadius,
    double? loadingSize,
    bool isCircle= false,
    bool isOutlined= false,
    bool widerPadding= false,
    bool loading= false,
    bool enable= true,
  })  : _onTap = onTap,
        _child = child,
        _title = title,
        _color = color,
        _isCircle = isCircle,
        _borderColor = borderColor,
        _textColor = textColor,
        _radius = radius,
        _width = width,
        _fontSize = fontSize,
        _loadingSize = loadingSize,
        _height = height,
        _isOutlined = isOutlined,
        _widerPadding = widerPadding,
        _enable = enable,
        _loading = loading;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:_width==0?null: (_width??deviceWidth),
      height: _height.h,
      child: CustomTapEffect(
        isClickable: ! (!_enable||(_loading && !kDebugMode)),
        onTap: (!_enable||(_loading && !kDebugMode))?null:_onTap,
        child: Container(
          width:_width==0?null: (_width??deviceWidth),
          height: _height.h,
          decoration: _isOutlined
              ? null
              : _color==null? BoxDecoration(shape: _isCircle?BoxShape.circle:BoxShape.rectangle).radius(radius: _radius).gradientStyle(gradient: getButtonGradient())
              :  BoxDecoration(shape: _isCircle?BoxShape.circle:BoxShape.rectangle).customColor(_color).radius(radius: _radius),
          child: MaterialButton(
            highlightElevation: 0,
            onPressed: (!_enable||(_loading && !kDebugMode))?(){}: _onTap,
            padding: !_widerPadding ? EdgeInsets.symmetric(vertical: 4.r, horizontal:_width==0?0: 8.r) : EdgeInsets.symmetric(vertical: 12.h, horizontal:_width==0?0:16.w),
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_radius), side: BorderSide(color: _borderColor??_color??Colors.transparent, width: 1.5.w,)),
            child: _loading
                ? CustomLoadingSpinner( size: (_loadingSize ?? 20).h,color:_textColor?? Colors.white)
                : _title != null
                    ? FittedBox(fit: BoxFit.scaleDown, child: Center(child: AutoSizeText(_title, style: const TextStyle().semiBoldStyle(fontSize: _fontSize).customColor(_textColor ?? Colors.white),),))
                    : _child,
          ),
        ),
      ),
    );
  }
}
