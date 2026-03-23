import 'package:base_app/app.dart';
import 'package:base_app/core/notification/data/notification_data_model.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/booking/route_generator.dart';


import 'package:flutter/material.dart';

import '../constants/enums.dart';

class NotificationHelper {
  static const kFileDownloaded ='kFileDownloaded';

  static notificationNav(NotificationPayload  entity, {BuildContext? context,GlobalKey<NavigatorState>? navigatorKey} ){
    if (appContext == null && navigatorKey==null && entity.id == 0) {return;}
    _navHelper(entity,context: context,navigatorKey: navigatorKey);
  }
}

_navHelper(NotificationPayload  entity, {BuildContext? context,GlobalKey<NavigatorState>? navigatorKey}){
  switch(entity.type){
    case NotificationType.general:break;

    // case NotificationType.booking:NavigationService.push(BookingRoutes.detailsScreen,arguments: {'id':entity.id});break;
    case NotificationType.completed:break;
    // case NotificationType.labOrder:NavigationService.push(LabResultRoutes.detailsScreen,arguments: {'id':entity.id});break;
    // case NotificationType.labResult:NavigationService.push(LabResultRoutes.detailsScreen,arguments: {'id':entity.id});break;
    // case NotificationType.medication:NavigationService.push(MedicationRoutes.detailsScreen,arguments: {'id':entity.id});break;
    case NotificationType.dialysisOrder:break;
    case NotificationType.incident:break;
    case NotificationType.holidayTreatment:break;
    case NotificationType.patientDocumentReminder:break;
    case NotificationType.employeeDocumentReminder:break;
    case NotificationType.bookingRescheduled:break;
    case NotificationType.labOrder:
    case NotificationType.booking:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificationType.labResult:
      // TODO: Handle this case.
      throw UnimplementedError();
    case NotificationType.medication:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

