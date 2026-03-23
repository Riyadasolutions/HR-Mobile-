import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/decoration.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';

class SheetCloseWidget extends StatelessWidget {
  final VoidCallback _onTap;
  const SheetCloseWidget({super.key,
    required VoidCallback onTap,
  }) : _onTap = onTap;
  @override
  Widget build(BuildContext context) {
    return CustomTapEffect(
      onTap: _onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
        width: 40.r,
        height: 40.r,
        decoration: const BoxDecoration().cardStyle(),
        child:  CustomSVGIcon(
          color:AppColor.textColor.themeColor,
          Assets.iconsCloseSheetIcon,
        ),
      ),
    );
  }


}
