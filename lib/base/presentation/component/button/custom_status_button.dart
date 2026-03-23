import 'package:base_app/core/res/color.dart';
import 'package:flutter/material.dart';


import '../component.dart';


class CustomStatusButton extends StatelessWidget {
  final String _title;
  final bool _isActive;
  final VoidCallback _onTap ;

  const CustomStatusButton({super.key,
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  })  : _title = title,
        _isActive = isActive,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: CustomButton(
          onTap: _onTap,
          color: _isActive ? Theme.of(context).primaryColor : Theme.of(context).cardColor ,
          title: _title ,
          textColor: _isActive ? Theme.of(context).primaryColorLight : AppColor.textColor.themeColor)
    );
  }

}
