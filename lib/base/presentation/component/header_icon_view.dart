import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

import 'package:base_app/core/res/resources.dart';
import '../component/component.dart';
class HeaderIconView extends StatelessWidget {

  final String _title;
  const HeaderIconView({super.key,
    required String title,
  }) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20.h,
          width: 12.w,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(kFormRadius),
              topRight: const Radius.circular(kFormRadius),
              bottomRight: context.locale.languageCode == 'ar' ? Radius.zero : const Radius.circular(kFormRadiusLarge),
              bottomLeft: context.locale.languageCode == 'ar' ?  const Radius.circular(kFormRadiusLarge) : Radius.zero,
            ),
          ),
        ),
        HorizontalSpace(kFormPaddingAllLarge.w),
        Text(_title,style: const TextStyle().titleStyle(fontSize: 16)),
      ],
    );
  }


}
