import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'base_form.dart';


class CustomTextFieldNormal extends StatelessWidget {
  final String? suffixText;
  final String? hint;
  final String? defaultValue;
  final String? label;
  final String? iconSVG;
  final String? validateMassage;

  final bool readOnly;
  final bool isHorizontal;
  final bool autoValidate;
  final bool noBorder;
  final bool isRequired;
  final bool autofocus;
  final bool enable;
  final bool showPrefixIcon;

  final int? lines;
  final int? maxLength;

  final double? fontSize;
  final double? radius;
  final double? contentPaddingH;

  final List<TextInputFormatter>? formatter;

  final Widget? icon;
  final Widget? prefixWidget;
  final Widget? suffixData;
  final double? suffixMaxWidth;

  final IconData? iconData;
  final IconData? suffixIconData;

  final Color? background;
  final Color? labelColor;

  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final Function? validateFunc;
  final Function? onSubmit;

  final TextEditingController? controller;
  final TextInputAction? textInputAction;

   const CustomTextFieldNormal({
    Key? key,
    this.suffixText,
    this.labelColor,
    this.hint,
    this.defaultValue,
    this.label,
    this.iconSVG,
    this.isHorizontal = false,
    this.showPrefixIcon = true,
    this.autoValidate = false,
    this.readOnly = false,
    this.noBorder = false,
    this.isRequired = true,
    this.autofocus = false,
    this.enable = true,
    this.lines,
    this.maxLength,
    this.fontSize,
    this.radius,
    this.contentPaddingH,
    this.formatter,
    this.icon,
    this.prefixWidget,
    this.suffixMaxWidth,
    this.suffixData,
    this.iconData,
    this.suffixIconData,
    this.background,
    this.onTap,
    this.validateMassage,
    this.onChange,
    this.validateFunc,
    this.onSubmit,
    this.controller,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      background: background,
      labelColor: labelColor,
      icon: icon,
      prefixIcon: iconData,
      prefixWidget: prefixWidget,
      showPrefixIcon: showPrefixIcon,
      // startWidget:prefixWidget??(iconSVG==null?null: SizedBox(height: 20.r,width: 20.r,child: Center(child:CustomSVGIcon(iconSVG!,color:enable?Theme.of(context).primaryColor:Theme.of(context).hintColor)  ))),

      isHorizontal: isHorizontal,
      defaultValue: defaultValue,
      hint: hint,
      onTap: onTap,
      maxLength: maxLength,
      readOnly: readOnly,
      autoValidate: autoValidate,
      enable: enable,
      noBorder: noBorder,
      isRequired: isRequired,
      label: label,
      contentPaddingH: contentPaddingH,
      lines: lines,
      fontSize: fontSize,
      radius: radius,
      onChange: onChange,
      suffixIconData: suffixIconData,
      validateFunc: validateFunc ,
      suffixText: suffixText,
      validateMassage: validateMassage,
      formatter: formatter,
      type: TextInputType.text,
      controller: controller ?? TextEditingController(),
      suffixData: suffixData,
      suffixMaxWidth: suffixMaxWidth,
      onSubmit: onSubmit,
      autofocus: autofocus,
      textInputAction: textInputAction,
    );
  }
}
