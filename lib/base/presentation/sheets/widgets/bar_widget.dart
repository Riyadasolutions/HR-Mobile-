import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/decoration.dart';
import 'package:flutter/material.dart';

class SheetBarWidget extends StatelessWidget {
  const SheetBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 48.w,
      height: 4.h,
      decoration: BoxDecoration().radius().customColor(Theme.of(context).primaryColorDark),
    );
  }
}
