

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../component/component.dart';
import 'base/simple_dialogs.dart';


Future showAuthDialog(BuildContext context,) async =>
    showCustomDialog(context, _buildBody(context), onDismissCallback: ()=>NavigationService.goBack() ,isCancellable: true);


_buildBody(BuildContext context){
  return Padding(
    padding: kScreenPadding,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
           CustomNoDataView(title: tr(LocaleKeys.noAuthMessage), imageSvg: Assets.emptyStateNoAuthImage),
          Row(
            children: [
              Expanded(child: CustomButton(onTap: () => NavigationService.pushNamedAndRemoveUntil(AuthRoutes.loginScreen),title: tr(LocaleKeys.login))),
              HorizontalSpace(kFormPaddingAllLarge.w),
              Expanded(child: CustomButton(onTap: () => NavigationService.goBack(),title: tr(LocaleKeys.cancel),color: Theme.of(context).primaryColorLight,)),
            ],
          ),
        ],
      ),
    ),
  );
}


