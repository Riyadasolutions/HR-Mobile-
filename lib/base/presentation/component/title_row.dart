
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/text_styles.dart';
import 'package:base_app/core/res/values_manager.dart';

import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'component.dart';


class TitleRow extends StatelessWidget {
  final String title;
  final Color? colorText;
  final String? destinationScreen;
  final Map<String, dynamic>? arguments;

  const TitleRow({required this.title, this.destinationScreen, this.arguments, this.colorText, Key? key}) : super(key: key);

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
        Text(title,style: const TextStyle().titleStyle(fontSize: 16)),
        const Spacer(),
        if (destinationScreen != null)...[
          InkWell(
            onTap: () => NavigationService.push(destinationScreen!, arguments: arguments),
            child:  Row(
              children: [
                Text(tr(LocaleKeys.all),style:  const TextStyle().regularStyle().activeColor()),
                HorizontalSpace(kFormPaddingAllSmall.w),
                Icon(Icons.arrow_forward,color: Theme.of(context).primaryColor,size: 16.r),
              ],
            ),
          ),
        ]
      ],
    );
  }
}
