import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/utils/launch_links_and_apps/map_launcher/map_launcher.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectMapType extends StatelessWidget {
  final num _lat;
  final num _long;

  const SelectMapType({
    super.key,
    required num lat,
    required num long,
  })  : _lat = lat,
        _long = long;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(kFormRadius)),
          color: Theme.of(context).cardColor),
      // height: 120,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.all(kFormPaddingAllNormal.r),
            child: Text(tr(LocaleKeys.whichAppDoYouWantToUse), style: const TextStyle().titleStyle().activeColor()),
          ),
          const SizedBox(height: 16),
          const Divider(),
          Padding(
            padding: EdgeInsets.all(kFormPaddingAllNormal.r),
            child: GestureDetector(
              onTap: ()=>_launchGoogleMap(),
              child: Text(tr(LocaleKeys.googleMap), style: const TextStyle().semiBoldStyle()),
              ),
            ),
          const Divider(),
          Padding(
          padding: EdgeInsets.all(kFormPaddingAllNormal.r),
            child: GestureDetector(
              onTap: ()=>_launchAppleMap(),
              child: Text(tr(LocaleKeys.appleMap),style: const TextStyle().semiBoldStyle()
              ),
            ),
          ),
          const SizedBox(height: 30),

        ],
      ),
    );
  }

   Future<void> _launchGoogleMap() async {
     var uri = Uri.parse("google.navigation:q=$_lat,$_lat&mode=d");

     String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$_lat,$_long';
     if (await canLaunchUrl(uri)) {
       await launchUrl(uri);
     }else if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else if (await MapLauncher.isMapAvailable(MapType.google)??false) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(double.parse(_lat.toString()), double.parse(_long.toString())),
        title: "Hello Egypt",
      );
    }else {
      throw 'Could not open the map.';
    }
  }


  void _launchAppleMap() async {
    Uri url = Uri.parse('https://maps.apple.com/?sll=$_lat,$_long');

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      await launchUrl(
          Uri.parse('https://apps.apple.com/us/app/google-maps/id585027354'));
    }
  }


}

showSelectMapType(BuildContext context, {num lat = 47.6, num long = -122.3}) {
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SelectMapType(lat: lat, long: long);
      });
}
