
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../core/utils/timer_helper.dart';

class CustomMainTimerView extends StatefulWidget {
 final String? _endDate;

 @override
  State<CustomMainTimerView> createState() => _CustomMainTimerViewState();

 const CustomMainTimerView({super.key,
    required String? endDate,
  }) : _endDate = endDate;
}

class _CustomMainTimerViewState extends State<CustomMainTimerView> {


  @override
  void initState() {
    super.initState();
    Provider.of<TimerHelper>(context, listen: false).startTimer(endDate: widget._endDate);
  }
  @override
  Widget build(BuildContext context) {
    List<String>? timerValues = context.watch<TimerHelper>().timerValues;

    return (timerValues ?? []).isEmpty
        ? const SizedBox()
        : Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFormRadius)),
          child: Container(
            width: deviceWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.all(kScreenPaddingNormal.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr(LocaleKeys.subscriptionTimer), style: const TextStyle().regularStyle().boldStyle()),
                 const CustomDivider(),
                VerticalSpace(kFormPaddingAllLarge.h),

                Container(
                   width: deviceWidth,
                   alignment: Alignment.center,
                   // padding: EdgeInsets.all(kFormPaddingAllSmall.r),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildItem(type: tr(LocaleKeys.days), value: timerValues![0]),
                        HorizontalSpace(kScreenPaddingNormal.w),
                        _buildItem(type: tr(LocaleKeys.hours), value: timerValues[1]),
                        HorizontalSpace(kScreenPaddingNormal.w),
                        _buildItem(type: tr(LocaleKeys.minutes), value: timerValues[2]),
                        HorizontalSpace(kScreenPaddingNormal.w),
                        _buildItem(type: tr(LocaleKeys.seconds), value: timerValues[3]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  _buildItem({required String type, required String? value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value ?? '', style: const TextStyle().titleStyle(fontSize: 38).boldStyle().activeColor()),
        Text(type, style: const TextStyle().regularStyle(fontSize: 12).boldStyle().activeLiteColor()),
      ],
    );
  }
}
