import 'dart:async';


import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/utils/date/date_converter.dart';

import 'package:flutter/material.dart';

import 'package:base_app/core/utils/logger.dart';


class CustomTimerView extends StatefulWidget {
  final String? _endDate;

  @override
  State<CustomTimerView> createState() => _CustomTimerViewState();

  const CustomTimerView({super.key,
    required String? endDate,
  }) : _endDate = endDate;
}

class _CustomTimerViewState extends State<CustomTimerView> {

  Timer? _timer;
  Duration _duration = const Duration(seconds: 65);
  List<String>? _timerValues ;

  _supTime() {
    const addSeconds = 1;
    final seconds = _duration.inSeconds - addSeconds;

    if (seconds < 0) {
      _timer?.cancel();
    } else {
      _duration = Duration(seconds: seconds);
      // notifyListeners();
      _buildTime();
    }
  }



  int _daysBetween(DateTime from, DateTime to) {
    DateTime fromDate = DateTime(from.year, from.month, from.day,from.hour,from.minute,from.second);
    DateTime toDate = DateTime(to.year, to.month, to.day,to.hour,to.minute,to.second);
    return (toDate.difference(fromDate).inSeconds ).round();
  }


  _startTimer({required String? endDate}) {

    if( endDate == null  )return;



    try{
      DateTime dateTime = DateConverter.isoStringToLocalDateWithOutTimer(endDate);
      // log('_buildTime', '$dateTime');

      final difference = _daysBetween( DateTime.now(),dateTime);

      if(difference>0){
        _duration = Duration(seconds: difference);
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _supTime());
        // log('_buildTime', '$_timerValues');
        // log('_buildTime', 'start');
      }else{
        _text = DateConverter.estimatedDateEn(endDate);
      }
      // log('_buildTime', 'difference::$difference -- from ${DateTime.now()} to :: ${dateTime}');


    }catch(e){
      log('_buildTime', '${_timer != null} --- ${ endDate == null}');

    }
  }

  _buildTime() {
    try{
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(_duration.inHours);
      final minutes = twoDigits(_duration.inMinutes.remainder(60));
      final seconds = twoDigits(_duration.inSeconds.remainder(60));

      // log('_buildTime', '$_timerValues');
      setState(() {
        _timerValues =  [/*days,*/ hours, minutes, seconds];
        _text = [_timerValues![0],_timerValues![1], _timerValues![2]/*, _timerValues![3]*/].join(':');
      });
      // ignore: empty_catches
    }catch(e){}
  }

 String _text = '';

  @override
  void initState() {
    super.initState();
    _text = '';
    _startTimer(endDate: widget._endDate);
  }
  @override
  Widget build(BuildContext context) {

    return Text(_text, style: const TextStyle().regularStyle(fontSize: 16).customColor(_text.contains(':')?AppColor.errorColor .themeColor:AppColor.textColor.themeColor));
    // return (_timerValues ?? []).isEmpty ? const SizedBox()
    //     :Text([_timerValues![0],_timerValues![1], _timerValues![2]/*, _timerValues![3]*/].join(':'), style: const TextStyle().regularStyle(fontSize: 18).errorStyle());


  }


}


