
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';

import '../res/text_styles.dart';
import '../res/values_manager.dart';
import '../routing/navigation_services.dart';


enum AlertsType{error,success,info}

class Alerts {
  static void showSnackBar(String message, {AlertsType alertsType = AlertsType.error, Duration duration =const Duration(seconds: 3),}) {
    try{
      ScaffoldMessenger.of(NavigationService.navigationKey.currentContext!).clearSnackBars();
      log('showSnackBar', message);
      _showMessage(message, duration: duration,alertsType:alertsType );
    }catch(e){
      throw 'error';
    }
  }

  static  _showMessage(String message, {required AlertsType alertsType ,required Duration duration} ) {
    switch (alertsType) {
      case AlertsType.error:_buildError(message,duration);
      case AlertsType.success:_buildSuccess(message,duration);
      case AlertsType.info:_buildInfo(message,duration);
    }
  }

  static void _buildError(String message, Duration duration) {
    ScaffoldMessenger.of(NavigationService.navigationKey.currentContext!).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSVGIcon(Assets.iconsMessageErrorIcon),
            HorizontalSpace(kFormPaddingAllSmall.w),
            Expanded(child: Text(message,style: const TextStyle().regularStyle(fontSize: 12).boldStyle().customColor(Colors.black))),
          ],
        ),
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFormRadius)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffFFEBEA)  ,
        margin: const EdgeInsets.all(kScreenPaddingNormal),
      ),
    );
  }

  static void _buildSuccess(String message, Duration duration) {
    ScaffoldMessenger.of(NavigationService.navigationKey.currentContext!).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSVGIcon(Assets.iconsMessageSuccessIcon),
            HorizontalSpace(kFormPaddingAllSmall.w),
            Expanded(child: Text(message,style: const TextStyle().regularStyle(fontSize: 12).boldStyle().customColor(Colors.black))),
          ],
        ),
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFormRadius)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffEBF9EE)  ,
        margin: const EdgeInsets.all(kScreenPaddingNormal),
      ),
    );
  }


  static void _buildInfo(String message, Duration duration) {
    ScaffoldMessenger.of(NavigationService.navigationKey.currentContext!).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSVGIcon(Assets.iconsMessageInfoIcon),
            HorizontalSpace(kFormPaddingAllSmall.w),
            Expanded(child: Text(message,style: const TextStyle().regularStyle(fontSize: 12).boldStyle().customColor(Colors.black))),
          ],
        ),
        duration: duration,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(kFormRadius)),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xffE6F2FF)  ,
        margin: const EdgeInsets.all(kScreenPaddingNormal),
      ),
    );
  }

}
