import 'package:base_app/core/res/color.dart';
import 'package:base_app/core/utils/date/date_utils.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/generated/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/utils/date/date_converter.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import 'base_form.dart';

class CustomTextFieldTime extends StatefulWidget {
  final String? suffixText;
  final String? hint;
  final String? defaultValue;
  final String? iconSVG;
  final String? label;
  final bool autoValidate;
  final bool noBorder;
  final bool isRequired;
  final bool autofocus;
  final VoidCallback? onTap;
  final int lines;
  final ValueChanged<String>? onChange;
  final Function? validateFunc;
  final ValueChanged<String>? onSubmit;
  final IconData? iconData;
  final IconData? suffixIconData;
  final Widget? suffixData;
  final double fontSize;
  final double? radius;
  final double contentPaddingH;
  final TextInputType type;
  final List<TextInputFormatter>? formatter;
  final Color? background;
  final TextEditingController controller;
  final TextInputAction? textInputAction;

  const CustomTextFieldTime({
    Key? key,
    this.background,
    this.iconData,
    this.iconSVG,
    this.defaultValue,
    this.hint,
    this.onTap,
    this.autoValidate = false,
    this.noBorder = false,
    this.autofocus = false,
    this.isRequired = true,
    this.label,
    this.contentPaddingH = 16,
    this.lines = 1,
    this.fontSize = 14,
    this.radius,
    this.onChange,
    this.textInputAction,
    this.suffixIconData,
    this.validateFunc,
    this.suffixText,
    this.formatter,
    this.type = TextInputType.text,
    required this.controller,
    this.suffixData,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<CustomTextFieldTime> createState() => _CustomTextFieldTimeState();
}

class _CustomTextFieldTimeState extends State<CustomTextFieldTime> {
  final tag = 'CustomFieldDate';
  late TimeOfDay? _selectedTime;



  @override
  void initState() {
    TimeOfDay time = TimeOfDay.now();
    _selectedTime = widget.defaultValue != null?DateConverter.formatTimeFromStringToTimeOfDay(widget.defaultValue):null;
    // _selectedTime = widget.defaultValue != null?DateConverter.formatTimeFromStringToTimeOfDay(widget.defaultValue):time.addTime(minute: 5,hour: 0);

    super.initState();

    // if (_selectedTime != null) {
    //
    //   widget.controller.text = _selectedTime!.format(context);
    // }
  }




  @override
  Widget build(BuildContext context) {
    widget.controller.text =_selectedTime==null?'': DateFormat('hh:mm a').format(DateTime(0, 0, 0, _selectedTime!.hour, _selectedTime!.minute, 0, 0, 0)) ;

    // widget.controller.text = _selectedTime!.format(context);

    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: CustomTextField(
        background: widget.background,
        prefixIcon: widget.iconData ,

        // prefixWidget: SizedBox(height: 20.r,width: 20.r,child: Center(child:CustomInputIcon(Assets.iconsTimeIcon,color: AppColor.iconColor.themeColor)  )),
        // suffixData: SizedBox(height: 24.r,width: 24.r,child: Center(child:CustomInputIcon(Assets.iconsTimeIcon,color: AppColor.iconColor.themeColor)  )),
        suffixData: SizedBox(height: 22.r,width: 22.r,child: Center(child:CustomIcon(assets: Assets.iconsTimeIcon,color: AppColor.iconColor.themeColor)  )),

        // prefixWidget:widget.iconSVG==null?null: SizedBox(height: 20.r,width: 20.r,child: Center(child:CustomInputIcon(widget.iconSVG!,color: AppColor.iconColor.themeColor)  )),
        // prefixWidget:widget.iconSVG==null?null: SizedBox(height: 20.r,width: 20.r,child: Center(child:CustomSVGIcon(widget.iconSVG!,color: Colors.black,)  )),

        // defaultValue: _selectedTime!.format(context),
        // defaultValue: widget.defaultValue,
        hint: widget.hint,
        onTap: widget.onTap ??
            () {
              _selectTime(context);
            },
        autoValidate: widget.autoValidate,
        // enable: false,
        readOnly: true,

        noBorder: widget.noBorder,
        isRequired: widget.isRequired,
        label: widget.label,
        contentPaddingH: widget.contentPaddingH,
        lines: widget.lines,
        fontSize: widget.fontSize,
        radius: widget.radius,
        onChange: widget.onChange,
        suffixIconData:widget.suffixIconData/*??Icons.timelapse*/,
        validateFunc: (value) {
          if ((value == null || value.isEmpty) && widget.isRequired) {
            return tr(LocaleKeys.msgFormFieldRequired);
          }

          if (widget.validateFunc != null) return widget.validateFunc!(value);
          return null;
        },
        suffixText: widget.suffixText,
        formatter: widget.formatter,
        // type: widget.TextInputType.number,
        controller: widget.controller,
        // suffixData: widget.suffixData,
        onSubmit: widget.onSubmit,
        // readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        // maxLength: widget.maxLength,
        // icon: widget.icon,
        textInputAction: widget.textInputAction,
      ),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.dial,

      initialTime:(_selectedTime??TimeOfDay.now()) ,
      builder: (context, Widget? child) => MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), child: child!),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        // widget.controller.text =( _selectedTime??TimeOfDay.now()).format(context);
        // TimeOfDay time =  ( _selectedTime??TimeOfDay.now());
        // widget.controller.text = DateFormat('hh:mm a').format(DateTime(0, 0, 0, time.hour, time.minute, 0, 0, 0)) ;

      });
    }

  }
}
