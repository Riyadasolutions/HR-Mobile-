import 'package:base_app/base/presentation/component/container/custom_container.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';




class NotificationIcon extends StatelessWidget {
  final int _count;
  final GestureTapCallback? _onTap;
  const NotificationIcon({super.key,
    required int count,
     GestureTapCallback? onTap,
  })  : _count = count,
        _onTap = onTap;
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: Colors.transparent,
      padding: EdgeInsets.zero,

      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: kScreenPaddingNormal.w),
        width: 40.r,
        height: 40.r,
        decoration: const BoxDecoration().customColor( AppColor.textColor.themeColor.withOpacity(0.25)).radius(),
        child: Center(
          child: GestureDetector(
            onTap: kIsAuth?(_onTap??()=>NavigationService.push(CommonRoutes.notificationsScreen)):null,
            child: Stack(clipBehavior: Clip.none, children: [
              // Gif(image:const  AssetImage(Assets.gifGifBell),height: 28, width: 28,autostart: _count>0?Autostart.loop  :Autostart.no,),
              CustomSVGIcon(Assets.iconsBillIcon, size: 24.h, color: Theme.of(context).cardColor),
             if(_count>0)
                Positioned(
                  right: -4,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    alignment: Alignment.center,
                    width: 18.r,
                    height: 18.r,
                    decoration: const BoxDecoration().circle().customColor(Theme.of(context).primaryColorDark),
                    child: FittedBox(fit: BoxFit.scaleDown,child: Text('$_count', style: const TextStyle().liteStyle(fontSize: 10).boldStyle().colorWhite())),//color: Theme.of(context).backgroundColor, fontSize: 8)),
                  ),
                ),
            ])
          ),
        ),
      ),
    );
  }
}
