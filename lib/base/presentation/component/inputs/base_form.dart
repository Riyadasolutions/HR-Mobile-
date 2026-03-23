
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/color.dart';
import 'package:base_app/core/res/text_styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../../core/res/values_manager.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import '../spaces.dart';
import 'expanded_form_view.dart';
import 'orientation_view.dart';





class CustomTextField extends StatefulWidget {
  final String? suffixText;
  final String? hint;
  final String? defaultValue;
  final String? label;
  final String? validateMassage;
  final bool isHorizontal;

  final bool enable;
  final bool isDark;
  final bool isDarkBackground;
  final bool autoValidate;
  final bool readOnly;
  final bool obscureText;
  final bool noBorder;
  final bool isRequired;
  final bool autofocus;
  final bool showPrefixIcon;

  final int? maxLength;
  final int? lines;

  final double? fontSize;
  final double? radius;
  final double? contentPaddingH;
  final double? suffixMaxWidth;
  final double? prefixMaxWidth;

  final List<TextInputFormatter>? formatter;

  final Color? prefixIconColor;
  final Color? labelColor;
  final Color? background;

  final IconData? prefixIcon;
  final IconData? suffixIconData;

  final Widget? suffixData;
  final Widget? prefixWidget;
  final Widget? startWidget;
  final Widget? endWidget;
  final Widget? icon;


  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onSaved;
  final Function? validateFunc;
  final Function? onSubmit;


  final TextAlign? textAlign;
  final TextInputType type;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const CustomTextField({Key? key,
    this.background,
    this.prefixIcon,
    this.textAlign,
    this.prefixIconColor,
    this.defaultValue,
    this.startWidget,
    this.endWidget,
    // this.error,
    this.hint,
    this.onTap,
    this.prefixMaxWidth,
    this.suffixMaxWidth,
    this.autoValidate = false,
    this.isDarkBackground = false,
    this.obscureText = false,
    this.readOnly=false,
    this.isHorizontal=false,
    this.showPrefixIcon = true,
    this.enable = true,
    this.isDark = false,
    this.noBorder = false,
    this.isRequired = true,
    this.autofocus=false,

    this.label,
    this.labelColor,
    this.contentPaddingH = 16,
    this.lines = 1,
    this.fontSize = 14,
    this.radius = kFormRadius,
    this.onChange,
    this.onSaved,
    this.suffixIconData,
    this.validateFunc,
    this.suffixText,
    this.validateMassage,
    this.formatter,
    this.type = TextInputType.text,
    this.controller,
    this.suffixData,
    this.onSubmit,
    this.maxLength,
    this.icon,
    this.textInputAction,
    this.prefixWidget,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
    if (widget.defaultValue != null && widget.controller != null) {widget.controller!.text = widget.defaultValue!;}
  }
  @override
  Widget build(BuildContext context) {
    // if (widget.error == '') {
    //   widget.error = null;
    // }
    return Column(
      children: [


        if(widget.label!=null)...[
          Row(
            children: [
              if (widget.startWidget != null) ...[
                widget.startWidget!,
                HorizontalSpace(kFormPaddingAllLarge.w)
              ],
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: widget.label!, style: Theme.of(context).inputDecorationTheme.labelStyle!.customColor(widget.labelColor??AppColor.labelColor.themeColor)),
                     TextSpan(text:  widget.isRequired?null:' (${tr(LocaleKeys.optional)})', style: const TextStyle().semiBoldStyle(fontSize: 12).colorHint()),
                    ],
                  ),
                ),
              ),
              // Expanded(child: Text(widget.label!,style:  Theme.of(context).inputDecorationTheme.labelStyle!)),
              if (widget.endWidget != null) ...[
                HorizontalSpace(kFormPaddingAllLarge.w),
                widget.endWidget!,
              ],
            ],
          ),
          VerticalSpace(kFormPaddingAllSmall.h)
        ],


        GestureDetector(
          onTap: widget.onTap,
          child: OrientationView(
            isHorizontal: widget.isHorizontal,
            children: [
              if (widget.isHorizontal)...[
                CircleAvatar(radius: 4.r, backgroundColor: widget.isDark?Colors.white:Theme.of(context).hintColor),
                HorizontalSpace(8.h),
                if (widget.label != null)...[
                  Expanded(flex: 2,child: Text(widget.label!, style: const TextStyle().regularStyle().customColor( widget.isDark?/*Theme.of(context).cardColor*/Colors.white:Theme.of(context).hintColor),)),
                ]
              ],

              // if (!widget.isHorizontal && widget.label != null) ...[
              //   Text(widget.label!, style: const TextStyle().regularStyle(fontSize: 16).boldStyle().customColor( widget.isDark?Theme.of(context).cardColor:Colors.black),),
              //   const VerticalSpace(kFormPaddingAllSmall,),
              // ],

              if (widget.isHorizontal) HorizontalSpace(16.w),
              ExpandedHelperView(
                isExpanded: widget.isHorizontal ,
                child: TextFormField(

                  scrollPadding: const EdgeInsets.only(bottom: 30),

                  cursorColor:widget.isDark? Colors.white: Theme.of(context).primaryColor,
                  readOnly:widget.readOnly,
                  textInputAction: widget.textInputAction,
                  maxLength: widget.maxLength,
                  enableSuggestions: false,
                  autofocus: widget.autofocus,

                  obscureText: widget.obscureText,
                  onTap: widget.onTap,
                  controller:  widget.controller,
                  textAlign: widget.textAlign??TextAlign.start,
                  autovalidateMode: widget.autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
                  style:  const TextStyle().regularStyle(fontSize: 16).customColor( widget.isDark?AppColor.textColor.darkColor:AppColor.textColor.themeColor),

                  enableInteractiveSelection: widget.readOnly ? false : true, // will disable paste operation

                  decoration: InputDecoration(

                      counterText: '',
                      border: widget.noBorder ? InputBorder.none : Theme.of(context).inputDecorationTheme.border,
                      disabledBorder: widget.noBorder ? InputBorder.none : Theme.of(context).inputDecorationTheme.disabledBorder,
                      focusedBorder: widget.noBorder ? InputBorder.none :  Theme.of(context).inputDecorationTheme.focusedBorder,
                      errorBorder: widget.noBorder ? InputBorder.none :Theme.of(context).inputDecorationTheme.errorBorder,


                      errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(color: widget.isDark?AppColor.hintColor.darkColor :AppColor.hintColor.themeColor ,fontSize: 13),
                      labelStyle: Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(color: widget.isDark?AppColor.labelColor.themeColor:Theme.of(context).cardColor),
                      suffixStyle: Theme.of(context).inputDecorationTheme.suffixStyle,

                      hintText: widget.hint,
                      // labelText:widget.label,
                      filled: true,
                      // focusColor: Theme.of(context).primaryColor,


                      fillColor:widget.background??(widget.isDark?Theme.of(context).primaryColor:widget.enable? widget.background??AppColor.fieldFillColor.themeColor /*Theme.of(context).highlightColor enable background*/:widget.background??Theme.of(context).disabledColor/*disable background*/),
                      counterStyle:  TextStyle(color: Theme.of(context).primaryColor),
                      suffixText: widget.suffixText,
                    suffixIcon: widget.suffixData != null ? Container(width: (widget.suffixMaxWidth??50).w, alignment: Alignment.center, child: widget.suffixData,) : (widget.suffixData ?? (widget.suffixIconData == null ? null : Icon(widget.suffixIconData, color: AppColor.iconColor.themeColor))),
                    suffixIconConstraints: BoxConstraints(maxWidth:(widget.suffixMaxWidth??47).w, maxHeight: 48.h, minWidth: 45.w, minHeight: 20.h),
                    prefixIconConstraints: BoxConstraints(maxWidth:(widget.prefixMaxWidth??47).w, maxHeight: 48.h, minWidth: (widget.prefixMaxWidth??47).w, minHeight: 20.h),

                    // suffixIconConstraints: BoxConstraints(maxWidth: 47.w, maxHeight: 55.h, minWidth: 45.w, minHeight: 20.h),
                    // suffixIcon: widget.suffixData != null ? Container(width: 50, alignment: Alignment.center, child: widget.suffixData,) : (widget.suffixData ?? (widget.suffixIconData == null ? null : Icon(widget.suffixIconData, color: Theme.of(context).primaryColor,))),




                    contentPadding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 12.w),
                      // prefixIconConstraints: BoxConstraints(maxWidth: 47.w, minWidth: 35.w),

                      prefixIcon:!widget.showPrefixIcon?null:widget.prefixWidget??( widget.prefixIcon == null ?null : Icon(widget.prefixIcon, size: 24,color:widget.prefixIconColor??(widget.isDark?Theme.of(context).cardColor:Colors.black),)),
                      // suffixIcon: widget.suffixData??( widget.suffixIconData == null ?null : Icon(widget.suffixIconData, size: 24)),
                      // suffixIcon: widget.suffixData != null ? Container(width: 50, alignment: Alignment.center, child: widget.suffixData,) : (widget.suffixData ?? (widget.suffixIconData == null ? null : Icon(widget.suffixIconData, color: Theme.of(context).primaryColor,))),

                    alignLabelWithHint: true,



                  ),
                  keyboardType: widget.type,
                  validator: (value) {
                    if (widget.validateFunc != null&& widget.isRequired) {
                      return widget.validateFunc!(value);
                    }else
                    if ((value == null || value.isEmpty) && widget.isRequired) {
                      return widget.validateMassage??tr(LocaleKeys.msgFormFieldRequired);
                    }
                    return null;
                  },
                  enabled: widget.enable,
                  maxLines: widget.lines,

                  inputFormatters: widget.formatter,
                  onChanged: (String newValue) {
                    if (widget.onChange != null) return widget.onChange!(newValue);
                    return;
                  },
                  onFieldSubmitted: (String newValue) {
                    if (widget.onSubmit != null) return widget.onSubmit!(newValue);
                    return;
                  },
                  onSaved: (String? newValue) {
                    if (widget.onSaved != null) return widget.onSaved!(newValue??'');
                    return;
                  },

                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

