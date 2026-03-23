
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';
import '../../../generated/assets.dart';
import 'component.dart';


class CustomSheetHeader extends StatelessWidget {
  final VoidCallback _onCancelPress;

  final String? _title;
  final String? _desc;
  const CustomSheetHeader({super.key,
    required VoidCallback onCancelPress,
     String? title,
     String? desc,
  })  : _onCancelPress = onCancelPress,
        _title = title,
        _desc = desc;
  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Stack(
          children: [
            Align(alignment: AlignmentDirectional.center,child: Container(decoration: const BoxDecoration().radius().customColor(AppColor.primaryColor.themeColor), width: 80.w, height: 5.h)),
            Align(alignment: AlignmentDirectional.centerEnd,child: GestureDetector(onTap: _onCancelPress , child:const CustomSVGIcon(Assets.iconsCloseSheetIcon))),

          ],
        ),


        if(_title!=null)Text(_title, style: const TextStyle().semiBoldStyle(fontSize: 18).primaryTextColor()),
        if((_desc??'').isNotEmpty)Text(_desc!, style: const TextStyle().regularStyle(fontSize: 14).customColor( AppColor.hintColor.themeColor )),
        // HorizontalSpace(kFormPaddingAllLarge.w),
        VerticalSpace(kFormPaddingAllLarge.h),
        const CustomDivider(),
        VerticalSpace(kFormPaddingAllLarge.h),
      ],
    );
  }


}
