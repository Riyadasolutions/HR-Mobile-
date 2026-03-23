import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';

class SettingItem extends StatelessWidget {
  final String _icon ;
  final String _title ;
  final Widget? _endWidget ;
  final Color? _color ; 
  final GestureTapCallback? _onTap;

  const SettingItem({super.key,
    required String icon,
    required String title,
    Widget? endWidget,
    Color? color,
    GestureTapCallback? onTap,
  })
      : _icon = icon,
        _title = title,
        _color = color,
        _endWidget = endWidget,
        _onTap = onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: _onTap,
      child: Container(
        decoration: const BoxDecoration().cardStyle(),
        padding:  EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
        height: 56.h,
        child: Row(
          children: [
            CustomIconCard(assets: _icon,color:  _color??AppColor.primaryColor.themeColor,),
            HorizontalSpace(kFormPaddingAllLarge.w),
            Expanded(child: Text(_title,style: const TextStyle().regularStyle().customColor(_color??AppColor.textColor.themeColor))),
            _endWidget??  CustomIconCard(icon: Icons.arrow_forward_sharp,onTap: _onTap,color: _color??AppColor.textColor.themeColor,),
          ],
        ),
      ),
    );
  }


}
