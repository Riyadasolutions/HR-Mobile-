import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class ModalSheet {
  static Future<dynamic>  showModalSheet({required BuildContext context, required Widget screen}) async {
   return await showMaterialModalBottomSheet(
      context: context,
      barrierColor: Theme.of(context).primaryColor.withOpacity(0.3),
      expand: false,
        backgroundColor: Colors.transparent,
      duration: const Duration(milliseconds: 700),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20.r), topLeft: Radius.circular(20.r))),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 40.h, 0,  MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: const BoxDecoration().customColor(Colors.white).customRadius(borderRadius: BorderRadius.vertical(top: Radius.circular(kFormRadius))),
            child: screen,
          ),
        ),
      ),
    );
  }
}
