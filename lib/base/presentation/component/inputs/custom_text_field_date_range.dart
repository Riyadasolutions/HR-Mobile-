import 'package:base_app/core/custom_calender/utils/dialog.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/utils/date/date_converter.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/custom_calender/models/calendar_date_picker2_config.dart';
import 'base_form.dart';


class CustomTextFieldDateRange extends StatefulWidget {
  final String? suffixText;
  final String? hint;
  final String? fromDate;
  final String? toDate;
  final String? iconSVG;

  final DateTime? calendarStartDate;
  final DateTime? calendarEndDate;
  final String? label;
  final bool autoValidate;
  final bool noBorder;
  final bool isRequired;
  final bool autofocus;
  final bool canBeNull;
  final VoidCallback? onTap;
  final int lines;
  final Function(String?,String?)? onChange;
  final Function? validateFunc;
  final Function(String?,String?)? onSubmit;
  final IconData? iconData;
  final IconData? suffixIconData;
  final Widget? suffixData;
  final double fontSize;
  final double? radius;
  final double contentPaddingH;
  final TextInputType type;
  final List<DateTime>? blockedDays;
  final List<TextInputFormatter>? formatter;
  final Color? background;
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  const CustomTextFieldDateRange({Key? key,
    this.background,
    this.iconData,
    this.iconSVG,
    this.fromDate,
    this.blockedDays,
    this.toDate,
    this.calendarStartDate,
    this.calendarEndDate,
    // this.error,
    this.hint,
    this.onTap,
    this.canBeNull = false,
    this.autoValidate = false,
    this.noBorder = false,
    this.autofocus = false,
    this.isRequired = true,
    this.label,
    this.contentPaddingH = 16,
    this.lines = 1,
    this.fontSize = 14,
    this.radius ,
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
  State<CustomTextFieldDateRange> createState() => _CustomTextFieldDateRangeState();
}

class _CustomTextFieldDateRangeState extends State<CustomTextFieldDateRange> {
  final tag = 'CustomFieldDate';
  late DateTime? _selectedFormDate;
  late DateTime? _selectedToDate;
  late String _defaultValue;

  _getText()=>DateConverter.slotDateCalenderRange( fromDate: _selectedFormDate,toDate: _selectedToDate) ;
  @override
  void initState() {
    log(tag, 'fromDate ${widget.fromDate} -- toDate ${widget.toDate}');
    _selectedFormDate = widget.fromDate != null?DateConverter.toDateTime(widget.fromDate??""): null;
    _selectedToDate = widget.toDate != null?DateConverter.toDateTime(widget.toDate??""): null;
    _defaultValue =_getText() ;

    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    widget.controller.text = _getText();
    return InkWell(
      onTap: () =>_showCalenderDialog(context),
      child: CustomTextField(
        background: widget.background,
        // suffixData:SizedBox(height: 24.r,width: 24.r,child: Center(child:CustomSVGIcon(Assets.svgDatePickerIcon))),

        // suffixData: _suffixData,
        defaultValue: _defaultValue,
        onTap: widget.onTap?? () {_showCalenderDialog(context);},
        autoValidate: widget.autoValidate,
        // enable: false,
        readOnly: true,

        noBorder: widget.noBorder,
        isRequired: widget.isRequired,
        label: widget.label,
        hint: widget.hint,
        contentPaddingH:widget.contentPaddingH,
        lines:widget.lines,
        fontSize:widget.fontSize,
        radius:widget.radius,
        // onChange:widget.onChange,
        suffixIconData:widget.suffixIconData,
        validateFunc: (value) {

          if (/*(value == null || value.isEmpty) &&*/((value??'') as String).length<15 && widget.isRequired) {
            return tr(LocaleKeys.msgDateRangRequired);
          }else if (widget.validateFunc != null) {
            return widget.validateFunc!(value);
          }
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
  Future<void> _showCalenderDialog(BuildContext context) async {


    List<DateTime?>? results = await showCalendarDatePicker2Dialog(

      context: context,

      barrierColor: Theme.of(context).primaryColor.withOpacity(0.2),

      dialogBackgroundColor:Theme.of(context).cardColor ,
      // blockedDays:[DateTime.now().add(const Duration(days: 3))],
      blockedDays: widget.blockedDays,
      config: CalendarDatePicker2WithActionButtonsConfig(
        weekdayLabels: ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FFI', 'SAT'],
        calendarType: CalendarDatePicker2Type.range,

        selectableDayPredicate: (day) {
          bool isFound = true;
          for (var date in (widget.blockedDays ?? [])) {
            DateTime dateTime = DateConverter.changeDateFormat(day);
            DateTime dateTimeBusy = DateConverter.changeDateFormat(date);
            // log(tag, '$dateTime--$dateTimeBusy${dateTime.isAtSameMomentAs(dateTimeBusy)}');

            if (dateTime.isAtSameMomentAs(dateTimeBusy)) {
              isFound = false;
            }
          }
          return isFound;
        },


        weekdayLabelTextStyle: const TextStyle().semiBoldStyle(fontSize: 12).colorHint(),
        dayTextStyle: const TextStyle().semiBoldStyle(fontSize: 14).activeColor(),
        selectedDayTextStyle: const TextStyle().semiBoldStyle(fontSize: 14).primaryLiteTextColor(),


        selectedDayHighlightColor: Theme.of(context).primaryColor,
        firstDate: widget.calendarStartDate ?? DateTime(2015, 8),
        lastDate: widget.calendarEndDate ?? DateTime(2101),


      ),
      dialogSize: const Size(325, 400),
      value: [(_selectedFormDate),(_selectedToDate)],



      borderRadius: BorderRadius.circular(15),

    );
    _selectedFormDate =(results??[]).isEmpty?null: results!.first!;
    _selectedToDate =(results??[]).length<=1?null: results![1]!;

    String start = _selectedFormDate==null?'':DateConverter.convertToFormat( _selectedFormDate!);
    String end = _selectedToDate==null?'':DateConverter.convertToFormat( _selectedToDate!);

    if(widget.onSubmit!=null) widget.onSubmit!(start,end);
    if(widget.onChange!=null) widget.onChange!(start,end);

    setState(() {
      widget.controller.text = _getText();
    });

    // if ((results??[]).isNotEmpty && results![0] != _selectedDate) {
    //   String data = DateConverter.slotDate( results[0]!);
    //   if(widget.onSubmit!=null) widget.onSubmit!(data);
    //   setState(() {_selectedDate = results[0]!;widget.controller.text = data;});
    // }

  }

}
