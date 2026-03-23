import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';

class CustomSheetContainerView extends StatelessWidget {
  final Widget _child;
  final BoxConstraints? _constraints;

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final isKeyboardOpen = keyboardHeight > 0;

    // Reduce padding when keyboard is open to maximize available space
    final padding = isKeyboardOpen
        ? EdgeInsets.only(left: kScreenPadding.left, right: kScreenPadding.right, top: kFormPaddingAllLarge, bottom: keyboardHeight,)
        : kScreenPadding.copyWith(bottom: 40 + keyboardHeight, top: kFormPaddingAllLarge);


    return Container(
      // margin: const EdgeInsets.only(top: 40),
      padding: padding,
      decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(kCartRadius)), color: Theme.of(context).cardColor),
      // margin: const EdgeInsets.only(top: 40),
      // padding:EdgeInsets.all(kScreenPaddingNormal).copyWith(top: 0/*,bottom: 40+ MediaQuery.of(context).viewInsets.bottom,*/) ,
      // decoration:  BoxDecoration(borderRadius:const BorderRadius.vertical(top: Radius.circular(20))).customColor(Theme.of(context).cardColor),
      child: _child,
      constraints: _constraints,
    );
  }

  const CustomSheetContainerView({
    required Widget child,
     BoxConstraints? constraints,
  })  : _child = child,
        _constraints = constraints;
}
