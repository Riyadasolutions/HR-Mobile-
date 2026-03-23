import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBackIcon extends StatelessWidget {
  final VoidCallback? _onTap;
  final IconData? _icon;
  final String? _iconSVG;
  final double _iconSize;
  final Color? _color;



  @override
  Widget build(BuildContext context) {
    return CustomIconCard(
        onTap: _onTap ?? () => Navigator.pop(context),
        assets: _iconSVG ??( context.locale.languageCode=='ar'?Assets.iconsBackArIcon:Assets.iconsBackEnIcon),
        icon: _icon,
        iconSize: _iconSize,

        color: _color?? AppColor.textColor.themeColor ,


        // child: GestureDetector(
        //
        //     child: _icon!=null
        //         ?Icon(_icon , color: _color ?? AppColor.textColor.themeColor, size: _iconSize)
        //         :SvgPicture.asset(_iconSVG ??( context.locale.languageCode=='ar'?Assets.iconsBackArIcon:Assets.iconsBackEnIcon), color: _color?? AppColor.textColor.themeColor , width: _iconSize,height: _iconSize,)
        // )
    );
    // return Container(
    //     padding: EdgeInsets.all(kFormPaddingAllNormal.r),
    //     decoration: const BoxDecoration().radius().customColor(Theme.of(context).cardColor.withOpacity(0.3)),
    //     child: GestureDetector(
    //         onTap: _onTap ?? () => Navigator.pop(context),
    //         child: _icon!=null
    //             ?Icon(_icon , color: _color ?? AppColor.textColor.themeColor, size: _iconSize)
    //             :SvgPicture.asset(_iconSVG ??( context.locale.languageCode=='ar'?Assets.iconsBackArIcon:Assets.iconsBackEnIcon), color: _color?? AppColor.textColor.themeColor , width: _iconSize,height: _iconSize,)
    //     )
    // );
  }

  const CustomBackIcon({
     VoidCallback? onTap,
     IconData? icon,
     String? iconSVG,
     double? iconSize,
     Color? color,
  })
      : _onTap = onTap,
        _icon = icon,
        _iconSVG = iconSVG,
        _iconSize = iconSize??24,
        _color = color;
}
