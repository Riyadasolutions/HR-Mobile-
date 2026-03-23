import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class CustomModalSheet {
  static Future<dynamic>  showModalSheet({required BuildContext context, required Widget screen}) async {
   return await showMaterialModalBottomSheet(
      context: context,

      barrierColor: Theme.of(context).primaryColor.withOpacity(0.3),
      // barrierColor: ColorsManager.primary.withOpacity(0.3),
      // backgroundColor: Colors.white,
      expand: false,
      backgroundColor: Colors.transparent,

      duration: Duration(milliseconds: 700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(100.r))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0,  0/*MediaQuery.of(context).viewInsets.bottom*/),
          child: Container(
            decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(100)), color: Theme.of(context).cardColor),
            child: screen,
          ),
        ),
      ),
    );
  }
}
