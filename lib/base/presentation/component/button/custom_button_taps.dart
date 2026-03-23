
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../component.dart';

class CustomButtonTaps<T> extends StatelessWidget {
  final List<MapEntry<T,String>> _list;
  final Function(T) _onTap;
  final T _selected;

  const CustomButtonTaps({
    super.key,
    required List<MapEntry<T,String>> list,
    required Function(T) onTap,
    required T selected,
  })  : _list = list,
        _onTap = onTap,
        _selected = selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration().cardStyle(color: AppColor.dividerColor.themeColor),
      padding: EdgeInsets.all(kFormPaddingAllNormal.r),
      child: Row(
        children: _list.map((e) {
          bool isSelected = e.key == _selected;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllSmall.w),
              child:  CustomButton(
                onTap: () => _onTap(e.key),
                fontSize: 13,
                height: 40,

                title: tr(e.value),
                color: isSelected ? Theme.of(context).primaryColor :  Colors.transparent,
                textColor: isSelected ?null : Theme.of(context).hintColor,
              ),

            ),
          );
        }).toList(),
      ),
    );
  }
}
