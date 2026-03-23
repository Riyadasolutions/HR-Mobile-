import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'date/date_converter.dart';

class TimerHelper extends ChangeNotifier{
  Timer? _timer;
  Duration _duration = const Duration(seconds: 65);
   List<String>? _timerValues ;


  List<String>? get timerValues => _timerValues;

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
    return (toDate.difference(fromDate).inSeconds )/*.round()*/;
  }


  startTimer({required String? endDate}) {
    // log('_buildTime', '${_timer != null} --- ${ kUser?.packageEndAt == null}');

    if( endDate == null || _timer != null )return;
    try{
      DateTime dateTime = DateConverter.isoStringToLocalDateWithOutTimer(endDate);
      final difference = _daysBetween( DateTime.now(),dateTime);
      _duration = Duration(seconds: difference);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _supTime());
      // log('_buildTime', '$_timerValues');
      // log('_buildTime', 'start');
    // ignore: empty_catches
    }catch(e){
      // log('_buildTime', '${_timer != null} --- ${ kUser?.packageEndAt == null}');

    }
  }

  _buildTime() {
    try{
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final days = twoDigits(_duration.inDays);
      final hours = twoDigits(_duration.inHours.remainder(24));
      final minutes = twoDigits(_duration.inMinutes.remainder(60));
      final seconds = twoDigits(_duration.inSeconds.remainder(60));
      _timerValues =  [days, hours, minutes, seconds];
      // log('_buildTime', '$_timerValues');
      notifyListeners();
      // ignore: empty_catches
    }catch(e){}
  }
}