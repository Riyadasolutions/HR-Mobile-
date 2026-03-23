import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomNotAuthStatusView extends StatelessWidget {
  final Widget _widget;
  final Widget? _notAuthWidget;

  const CustomNotAuthStatusView({
    super.key,
    required Widget child,
     Widget? notAuthWidget,
  })  : _widget = child,
        _notAuthWidget = notAuthWidget;

  @override
  Widget build(BuildContext context) {
    return kIsAuth
        ? _widget
        : Padding(
          padding: kScreenPadding,
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _notAuthWidget ?? CustomNoDataView(title: tr(LocaleKeys.noAuthMessage), imageSvg: Assets.emptyStateNoAuthImage),
                  CustomButton(onTap: () => NavigationService.pushNamedAndRemoveUntil(AuthRoutes.loginScreen),title: tr(LocaleKeys.login)),
                ],
              ),
          ),
        );
  }
}
