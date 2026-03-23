import 'package:base_app/generated/assets.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import 'base_form.dart';



class CustomTextFieldSearch extends StatelessWidget {
  final String? suffixText;
  final String? hint;
  final String? defaultValue;
  final bool enable;
  final String? label;
  final Color? prefixIconColor;
  final bool autoValidate;
  final bool noBorder;
  final bool isRequired;
  final VoidCallback? onTap;
  final int? lines;
  final ValueChanged<String>? onChange;
  final GestureTapCallback? onFilterTap;
  final GestureTapCallback? onRemoveTap;
  final Function? validateFunc;
  final Function? onSubmit;
  final IconData? iconData;
  final IconData? suffixIconData;
  final Widget? suffixData;
  final Widget? prefixWidget;
  final double? fontSize;
  final bool isDarkBackground;
  final bool isDark;
  final bool ?readOnly;
  final bool isSearch;
  final double? radius;
  final double? contentPaddingH;
  final List<TextInputFormatter>? formatter;
  final Color? background;
  final TextEditingController? controller;

  const CustomTextFieldSearch({
    Key? key,
    this.background,
    this.iconData,
    this.defaultValue,
    this.onFilterTap,
    this.onRemoveTap,
    this.hint,
    this.onTap,
    this.prefixWidget,
    this.prefixIconColor,
    this.autoValidate = false,
    this.enable = true,
    this.noBorder = false,
    this.isDarkBackground = false,
    this.isDark = false,
    this.isRequired = true,
    this.label,
    this.readOnly,
    this.contentPaddingH,
    this.lines,
    this.fontSize,
    this.radius,
    this.isSearch=true,
    this.onChange,
    this.suffixIconData,
    this.validateFunc,
    this.suffixText,
    this.formatter,
    this.controller,
    this.suffixData,
    this.onSubmit,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            background: background,
            // background: background??Theme.of(context).cardColor.withOpacity(0.5),
            prefixIcon: iconData ,
            prefixWidget:prefixWidget?? const CustomSVGIcon(Assets.iconsSearchIcon),


            prefixIconColor:prefixIconColor,

            defaultValue: defaultValue,
            hint: hint??tr(LocaleKeys.searchHint),
            onTap: onTap,
            autoValidate: autoValidate,
            enable: enable,
            noBorder: noBorder,
            isRequired: isRequired,
            readOnly: readOnly??false,
            label: label,
            isDark: isDark,
            contentPaddingH: contentPaddingH,
            lines: lines ?? 1,
            fontSize: fontSize,
            radius: radius,
            onChange: onChange,
            suffixIconData: suffixIconData,
            validateFunc: validateFunc ,
            suffixText: suffixText,
            formatter: formatter,
            type: TextInputType.text,
            textInputAction: TextInputAction.search,
            isDarkBackground:isDarkBackground,
            controller: controller,
            suffixData: suffixData ??  (onRemoveTap!=null?_onRemoveView(context):const SizedBox()),
            // suffixData: suffixData ??  (onRemoveTap!=null?_onRemoveView(context):onFilterTap!=null? _onFilterView(context):const SizedBox()),
            onSubmit: onSubmit,
          ),
        ),
        if(onFilterTap!=null)
        _onFilterView(context)
      ],
    );
  }

  Widget _onRemoveView(BuildContext context) => Padding(
        padding: EdgeInsets.all(kFormPaddingAllSmall.w),
        child: Material(
          elevation: 2,
          color: Theme.of(context).colorScheme.error,
          borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
            onTap: onRemoveTap,
            child: Padding(
              padding: EdgeInsets.all(kFormPaddingAllSmall.w),
              child: Icon(Icons.close, color: Theme.of(context).cardColor,),
            ),
          ),
        ),
      );
  Widget _onFilterView1(BuildContext context)=>  Padding(
      padding: EdgeInsets.all(kFormPaddingAllSmall.w),
      child: Material(
        elevation: 2,
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
          onTap: onFilterTap,
          child: Padding(
            padding: EdgeInsets.all(kFormPaddingAllSmall.w),
            child: Icon(Icons.filter_list_alt, color: Theme.of(context).cardColor),
          ),
        ),
      ),
  );
  Widget _onFilterView(BuildContext context)=>  Container(
    height: 60.h,
      width: 60.h,
      padding: EdgeInsets.all(kFormPaddingAllSmall.w),
      child: Material(
        elevation: 2,
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
          onTap: onFilterTap,
          child: Padding(
            padding: EdgeInsets.all(kFormPaddingAllSmall.w),
            child: CustomSVGIcon(Assets.iconsFilterIcon, color: Theme.of(context).cardColor),
          ),
        ),
      ),
  );
}
