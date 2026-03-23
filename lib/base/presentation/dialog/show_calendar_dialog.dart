

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import '../../../core/utils/date/date_converter.dart';
import 'package:base_app/core/utils/logger.dart';
import '../../../core/utils/modal_sheet.dart';
import '../component/component.dart';
import 'base/simple_dialogs.dart';



class CustomCalendarDialog extends StatefulWidget {
  final Function(DateTime?,DateTime?) _onSelect;
  final List<DateTime> _busyDays ;

  @override
  State<CustomCalendarDialog> createState() => CustomCalendarDialogState();

  const CustomCalendarDialog({super.key,
    required Function(DateTime?, DateTime?) onSelect,
    required List<DateTime> busyDays,
  })  : _onSelect = onSelect,
        _busyDays = busyDays;
}

class CustomCalendarDialogState extends State<CustomCalendarDialog> {
  late DateRangePickerController _controller;
  DateTime? _start ;
  DateTime? _end ;
  _onSubmit(){
    widget._onSelect(_start,_end);
    NavigationService.goBack();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    log('_onSelectionChanged', '${args.value}');
    try {
      if (args.value is PickerDateRange) {
        if (args.value.startDate != null) {
          _start = DateConverter.formatDateAPIForm(args.value.startDate);
        }
        if (args.value.endDate != null) {
          _end = DateConverter.formatDateAPIForm(args.value.endDate);
        }
        // for(){}
        if (_start != null && _end != null) {
          for (var date in widget._busyDays) {
            if (date.isAfter(_start!) && date.isBefore(_end!)) {
              _controller.selectedRange = null;
              break;
            }
          }
        }

        // widget._onSelect(_start, _end);
      } else {
        _start= null;
        _end= null;
        // widget._onSelect(null, null);
      }
    } catch (e) {
      _start= null;
      _end= null;
      // widget._onSelect(null, null);
    }
  }

  @override
  void initState() {
    _controller = DateRangePickerController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(kFormPaddingAllLarge.r),
          child: Column(
            children: [

              SfDateRangePicker(
                controller: _controller,
                // enable: true,
                enablePastDates: false,
                monthViewSettings: DateRangePickerMonthViewSettings(
                  showTrailingAndLeadingDates: true,
                  blackoutDates:  widget._busyDays,
                ),

                onSelectionChanged:_onSelectionChanged,

                monthCellStyle: DateRangePickerMonthCellStyle(
                  // blackoutDatesDecoration: _buildBoxDecoration(Colors.transparent),
                  blackoutDatesDecoration: _buildBoxDecoration(Colors.grey),
                  disabledDatesDecoration: _buildBoxDecoration(Colors.grey),
                  specialDatesDecoration: _buildBoxDecoration(Theme.of(context).primaryColor),

                  // textStyle: TextStyle().descriptionStyle().colorBlack(),
                  blackoutDateTextStyle: const TextStyle(color: Colors.black, decoration: TextDecoration.lineThrough),
                  specialDatesTextStyle: const TextStyle(color: Colors.white),
                  disabledDatesTextStyle: const TextStyle(color: Colors.black),

                ),


                selectionColor: Theme.of(context).primaryColor,
                selectionMode: DateRangePickerSelectionMode.range,
              ),

              CustomButton(onTap: ()=> _onSubmit() ,title: tr(LocaleKeys.confirm),height: 40),

            ],
          ),
        ),
      ],
    );
  }
  _buildBoxDecoration(Color color) {
    return BoxDecoration(
        color: color,
        border: Border.all(color: color, width: 1),
        // shape: BoxShape.circle
    );
  }
}



Future showCustomCalendarSheet(BuildContext context,
        {required Function(DateTime?, DateTime?) onSelect,
        required List<DateTime> busyDays}) async =>
    ModalSheet.showModalSheet(
        screen: CustomCalendarDialog(busyDays: busyDays, onSelect: onSelect),
        context: context);

Future showCustomDialogCalendar(BuildContext context,
        {required Function(DateTime?, DateTime?) onSelect,
        required List<DateTime> blockedDays}) async =>
    showCustomDialog(
        context, CustomCalendarDialog(busyDays: blockedDays, onSelect: onSelect),
        onDismissCallback: () => NavigationService.goBack(),
        isCancellable: true);
