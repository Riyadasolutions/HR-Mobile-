import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import '../../../../generated/assets.dart';
import '../component.dart';
import 'base_form.dart';

class CustomTextFieldPassword extends StatefulWidget {
  final String? suffixText;
  final String? hint;
  final String? defaultValue;
  final String? label;

  final bool readOnly;
  final bool autoValidate;
  final bool noBorder;
  final bool isRequired;
  final bool autofocus;
  final bool enable;
  final bool isDark;

  final int? lines;
  final int? maxLength;

  final double? fontSize;
  final double? radius;
  final double? contentPaddingH;

  final List<TextInputFormatter>? formatter;

  final Widget? icon;
  final Widget? suffixData;
  final Widget? prefixWidget;
  final Widget? endWidget;

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

  const CustomTextFieldPassword({
    Key? key,
    this.suffixText,
    this.labelColor,
    this.hint,
    this.defaultValue,
    this.label,
    this.readOnly = false,
    this.autoValidate = false,
    this.noBorder = false,
    this.isRequired = true,
    this.autofocus = false,
    this.enable = true,
    this.isDark = false,
    this.lines,
    this.maxLength,
    this.fontSize,
    this.endWidget,
    this.radius,
    this.contentPaddingH,
    this.formatter,
    this.icon,
    this.suffixData,
    this.prefixWidget,
    this.iconData,
    this.suffixIconData,
    this.background,
    this.onTap,
    this.onChange,
    this.validateFunc,
    this.onSubmit,
    this.controller,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<CustomTextFieldPassword> createState() =>
      _CustomTextFieldPasswordState();
}

class _CustomTextFieldPasswordState extends State<CustomTextFieldPassword> {
  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      background: widget.background,
      labelColor: widget.labelColor,
      prefixIcon: widget.iconData ,
      // prefixWidget:widget.suffixData??SizedBox(height: 18.r,width: 18.r,child: Center(child:CustomSVGIcon(Assets.svgLockIcon))),
      prefixWidget:widget.prefixWidget,

      defaultValue: widget.defaultValue,
      endWidget: widget.endWidget,
      hint: widget.hint??tr(LocaleKeys.passwordHint),
      onTap: widget.onTap,
      autoValidate: widget.autoValidate,
      enable: widget.enable,
      isDark: widget.isDark,
      noBorder: widget.noBorder,
      obscureText: _showPassword,
      isRequired: widget.isRequired,
      label: widget.label,
      contentPaddingH: widget.contentPaddingH,
      lines: widget.lines ?? 1,
      fontSize: widget.fontSize,
      radius: widget.radius,
      onChange: widget.onChange,
      suffixIconData: widget.suffixIconData,
      validateFunc: widget.validateFunc ??
          (value) {
            if ((value ?? '').isEmpty) {
              return tr(LocaleKeys.msgPasswordRequired);
            } else if (value.toString().length < 6) {
              return tr(LocaleKeys.msgInvalidPasswordShort);
            }
          },
      suffixText: widget.suffixText,
      formatter: widget.formatter,
      type: TextInputType.name,
      controller: widget.controller,
      suffixData: widget.suffixData ??
          GestureDetector(
            child: Icon(_showPassword ? Icons.visibility : Icons.visibility_off,color:widget.isDark?Theme.of(context).cardColor:Theme.of(context).hintColor),
            onTap: () {
              _togglePasswordVisibility();
            },
          ),
      onSubmit: widget.onSubmit,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      autofocus: widget.readOnly,
      textInputAction: widget.textInputAction,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }
}
