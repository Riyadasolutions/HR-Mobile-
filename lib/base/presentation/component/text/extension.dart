import 'package:base_app/core/res/color.dart';
import 'package:flutter/material.dart';

extension UnderLine on Widget {
  Widget get underLine => Column(
    children: [
      Container(
        decoration:  BoxDecoration( border: Border(bottom: BorderSide(color:AppColor. primaryColorLight.themeColor))),
        child: this,
      )
    ],
  );

  Widget get underLineActiveColor => Column(
    children: [
      Container(
        decoration:  BoxDecoration( border: Border(bottom: BorderSide(color: AppColor.primaryColor.themeColor))),
        child: this,
      )
    ],
  );


}