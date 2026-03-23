
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/utils/date/date_converter.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../component/component.dart';


class _TimePickerSheet extends StatefulWidget {
  final  String? _defaultValue;

  @override
  State<_TimePickerSheet> createState() => __TimePickerSheetState();

  const _TimePickerSheet({
    required String? defaultValue,
  }) : _defaultValue = defaultValue;
}

class __TimePickerSheetState extends State<_TimePickerSheet> {

  String _hourTypeValue = 'AM';
  String _hourValue = '01';
  String _minuteValue = '00';
  final List<String> _hourTypes=['AM','PM'];
  // final List<String> _hourTypes=['صباحًا','مساءً'];
  final List<String> _hours=['01','02','03','04','05','06','07','08','09','10','11','12'];
  // final List<String> _minutes=['00','30'];
  final List<String> _minutes=['00','01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59'];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.w, vertical: kFormPaddingAllSmall.h),

        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))
        ),
        child: Column(
          children: [
            VerticalSpace(kScreenPaddingNormal.h),

            CustomSheetHeader(onCancelPress: () => NavigationService.goBack(), title: tr(LocaleKeys.timePicker)),
            VerticalSpace(kFormPaddingAllLarge.h),

            CustomDivider(),
            // Container(
            //   height: 70.h,
            //
            //   decoration: BoxDecoration(
            //
            //       border: Border.all(color: Theme.of(context).primaryColor,width: 0.5),
            //       borderRadius: const BorderRadius.vertical(top: Radius.circular(20))
            //   ),
            //   padding:  EdgeInsets.symmetric(horizontal: 22,vertical: kFormPaddingAllLarge.h),
            //   child: Center(
            //     child: Row(
            //       children: [
            //         Expanded(child: Text(tr(LocaleKeys.timePicker),style: const TextStyle().semiBoldStyle().colorBlack())),
            //         GestureDetector(child: SvgPicture.asset(Assets.iconsExitIcon),onTap: ()=>NavigationService.goBack(),)
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    scrollController: FixedExtentScrollController(initialItem: 0),
                    itemExtent: 30,
                    onSelectedItemChanged: (int index) =>_hourTypeValue = _hourTypes[index],
                    children: [ ... _hourTypes.map((e) =>  Text(tr(e),style: TextStyle(color: Theme.of(context).primaryColor)),)],
                  ),
      
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    scrollController: FixedExtentScrollController(initialItem: 0),
                    itemExtent: 30,
                    onSelectedItemChanged: (int index) =>_minuteValue = _minutes[index],
                    children: [ ... _minutes.map((e) =>  Text(e,style: TextStyle(color: Theme.of(context).primaryColor)),)],
      
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CupertinoPicker(
                    backgroundColor: Colors.white,
                    scrollController: FixedExtentScrollController(initialItem: 0),
                    itemExtent: 30,
                    onSelectedItemChanged: (int index) =>_hourValue = _hours[index],
                    children: [ ... _hours.map((e) =>  Text(e,style: TextStyle(color: Theme.of(context).primaryColor)),)],
      
                  ),
                ),
      
              ],
            ),),
            const SizedBox(height: kFormPaddingAllLarge),
            Padding(
              padding: const EdgeInsets.all(22),
              child: CustomButton(onTap: () =>NavigationService.goBack(_getTime(hour: _hourValue, min: _minuteValue, type: _hourTypeValue)),title: tr(LocaleKeys.save)),
            ),
            VerticalSpace(kFormPaddingAllSmall.h)
          ],
        ),
      ),
    );
  }

}

Future<dynamic> showHoursPicker(BuildContext context,{required String? defaultValue}) async {

  return showCupertinoModalPopup(
    context: context,
    builder:  (context) =>Container(
      color: Colors.transparent,
      width: double.infinity,

      height: 250.h,
      child: _TimePickerSheet(defaultValue: defaultValue),
    ) ,
  );



}
String _getTime({required String hour ,required String min ,required String type}){
  String time = DateConverter.formatTimeFromHHMMAToHHMMSS('$hour:$min $type');
  log('TimePickerSheet', time);
  return time;
}


