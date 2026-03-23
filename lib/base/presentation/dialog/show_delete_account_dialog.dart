
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
import 'package:base_app/features/auth/route_generator.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import '../component/component.dart';
import 'base/simple_dialogs.dart';


class _DeleteAccountDialog extends StatefulWidget {
  const _DeleteAccountDialog({super.key});

  @override
  State<_DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<_DeleteAccountDialog> {
  bool _isLoading = false ;
  _onPress(BuildContext context) {
    setState(() {_isLoading = true;});
    Provider.of<LocalAuthProvider>(context, listen: false).deleteAccount().then((isCleared) {
      setState(() {_isLoading = false;});
      // NavigationService.goBack();
      NavigationService.pushNamedAndRemoveUntil(AuthRoutes.loginScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(kScreenPaddingNormal.r),
          child: Column(
            children: [
              Text(tr(LocaleKeys.deleteAccount),style:const TextStyle().titleStyle(fontSize: 16).primaryTextColor(),textAlign: TextAlign.center,),
              VerticalSpace(kScreenPaddingNormal.h),
              Text(tr(LocaleKeys.wantToDeleteAccount),style:const TextStyle().regularStyle(fontSize: 14).customColor( AppColor.hintColor.themeColor ),textAlign: TextAlign.center,),
              VerticalSpace(kScreenPaddingNormal.h),
              if(_isLoading) CustomLoadingSpinner(size: 30.r)else
                Row(
                  children: [
                    Expanded(child: CustomButton(onTap: ()=> Navigator.pop(context),title: tr(LocaleKeys.cancel),color: Theme.of(context).hintColor,textColor: AppColor.textColorLite.themeColor,height: 40,)),
                    HorizontalSpace(kFormPaddingAllLarge.h),
                    Expanded(child: CustomButton(onTap: ()=> _onPress(context) ,title: tr(LocaleKeys.delete),height: 40)),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}



Future showCustomDialogDeleteAccount(BuildContext context,) async =>
    showCustomDialog(context, const _DeleteAccountDialog(), onDismissCallback: (){} ,isCancellable: true);

