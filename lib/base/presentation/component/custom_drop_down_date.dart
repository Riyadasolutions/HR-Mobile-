import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../core/res/color.dart';

class CustomDropDownDate extends StatelessWidget {
  final List<dynamic> _items;
  final String? _hint;
  final Color? _color;
  final dynamic _value;
  final double _fontSize;
  final double _padding;
  final bool _isDark;
  final Color? _textColor;
  // final function(object) ;
  // final String ? validate(dynamic)

  // const CustomDropDownDate(
  //     {super.key, required this.items,
  //       this.color,
  //       this.isDark= false,
  //       required this.hint,
  //       this.textColor = AppColor.textColor.themeColor,
  //       this.fontSize = 15,
  //       this.padding = 4,
  //       required this.value});
  const CustomDropDownDate({super.key,
    required List<dynamic> items,
    String? hint,
    Color? color,
    dynamic value,
    double fontSize = 15,
    double padding = 4,
    bool? isDark,
    Color? textColor  ,
  })  : _items = items,
        _hint = hint,
        _color = color,
        _value = value,
        _fontSize = fontSize,
        _padding = padding,
        _isDark = isDark ?? false,
        _textColor = textColor;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      icon: const Visibility(visible: false, child: Icon(Icons.person)),
      validator: (v) {},
      decoration: InputDecoration(
        filled: true,
        fillColor: _color,
        hintText: _hint,
        contentPadding: EdgeInsets.symmetric(vertical: _padding.h, horizontal: 8.w),
        suffixIcon: SizedBox(
          height: 30.h,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 6.w,),
              Icon(Icons.arrow_drop_down,color: AppColor.textColor.themeColor,),

              SizedBox(
                width: 10.w,
              )
            ],
          ),
        ),
        border:  Theme.of(context).inputDecorationTheme.border,
        disabledBorder:  Theme.of(context).inputDecorationTheme.disabledBorder,
        focusedBorder:   Theme.of(context).inputDecorationTheme.focusedBorder,
        errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,



        errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(color: _isDark?Theme.of(context).highlightColor:Theme.of(context).hintColor),
        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(color: _isDark?Colors.black:Theme.of(context).hintColor),
        suffixStyle: Theme.of(context).inputDecorationTheme.suffixStyle,


        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(8.r)),
        // focusedBorder: OutlineInputBorder(borderSide:  BorderSide(color: Theme.of(context).primaryColor), borderRadius: BorderRadius.circular(8.r),),
        // errorBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.red), borderRadius: BorderRadius.circular(8.r),),
        // hintStyle: TextStyle(color: textColor, fontSize: fontSize.sp, height: 1.5.h),
        // labelStyle: TextStyle(color: textColor, fontSize: fontSize.sp),
      ),
      value: _value,
      items: _items
          .map((D) => DropdownMenuItem(
        value: D,
        child: Text(D.toString().tr(), style: TextStyle(fontSize: _fontSize.sp)),
      ))
          .toList(),
      onChanged: (v) {
        if (v == "ذكر") {
        } else {}
      },
    );
  }

}
