import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();

  const ServicesScreen({super.key,
  });
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppBar(
        title: tr(LocaleKeys.services), isBackButtonExist: false,),
      body: Padding(padding: kScreenPadding,
          child: CustomListAnimator(
              children: [
                // ServiceItem(image: Assets.imagesPackagesRequestImage, title: tr(LocaleKeys.packages), desc:  tr(LocaleKeys.packagesDesc), onTap: ()=>NavigationService.push(ServicesRoutes.packagesScreen)),
                // ServiceItem(image: Assets.imagesFlightBookingsRequestImage, title:  tr(LocaleKeys.flightBooking), desc:  tr(LocaleKeys.flightBookingDesc), onTap: ()=>NavigationService.push(ServicesRoutes.storeFlightBookingRequestScreen)),
                // ServiceItem(image: Assets.imagesCarRentalRequestImage, title:  tr(LocaleKeys.transportation), desc:  tr(LocaleKeys.transportationDesc), onTap: ()=>NavigationService.push(ServicesRoutes.storeTransportationRequestScreen)),
                // ServiceItem(image: Assets.imagesTransferRequestImage, title:  tr(LocaleKeys.transferBooking), desc:  tr(LocaleKeys.transferBookingDesc), onTap: ()=>NavigationService.push(ServicesRoutes.storeTransferBookingRequestScreen)),
                // ServiceItem(image: Assets.imagesVisaRequestImage, title:  tr(LocaleKeys.visaService), desc:  tr(LocaleKeys.visaServiceDesc), onTap: ()=>NavigationService.push(ServicesRoutes.storeVisaServiceRequestScreen)),
          ])
      ),
    );
  }
/*  static const packages = 'packages';
  static const packagesDesc = 'packagesDesc';
  static const flightBooking = 'flightBooking';
  static const flightBookingDesc = 'flightBookingDesc';
  static const transferBooking = 'transferBooking';
  static const transferBookingDesc = 'transferBookingDesc';
  static const visaService = 'visaService';
  static const visaServiceDesc = 'visaServiceDesc';
  static const transportation = 'transportation';
  static const transportationDesc = 'transportationDesc';
  */

}
