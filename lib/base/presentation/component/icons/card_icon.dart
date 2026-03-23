import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';




class CardIcon extends StatelessWidget {
  final int _count;
  final GestureTapCallback? _onTap;
  const CardIcon({super.key,
    required int count,
     GestureTapCallback? onTap,
  })  : _count = count,
        _onTap = onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.w),
      width: 28.r,
      height: 28.r,
     decoration: const BoxDecoration().circle().customColor(Theme.of(context).primaryColor),
      child: Center(
        child: GestureDetector(
          onTap: kIsAuth?_onTap:(){},
          child: Stack(clipBehavior: Clip.none, children: [
            // Gif(image:const  AssetImage(Assets.gifGifBell),height: 28, width: 28,autostart: _count>0?Autostart.loop  :Autostart.no,),
            CustomSVGIcon(
              Assets.iconsNavCardIcon,
              size: 24.h,
              color: Theme.of(context).cardColor,
            ),
           if(_count>0)
              Positioned(
                right: -8,
                bottom: -8,
                child: Container(
                  padding: const EdgeInsets.all(1),
                  alignment: Alignment.center,
                  width: 18.w,
                  height: 18.h,
                  decoration: const BoxDecoration().circle().customColor(Theme.of(context).cardColor),
                  child: FittedBox(fit: BoxFit.scaleDown,child: Text('$_count', style: const TextStyle().liteStyle(fontSize: 13).boldStyle().activeColor())),//color: Theme.of(context).backgroundColor, fontSize: 8)),
                ),
              ),
          ])
        ),
      ),
    );
  }
}
