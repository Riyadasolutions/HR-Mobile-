

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import '../component/component.dart';
import 'base/simple_dialogs.dart';

Future showDeleteDialog(BuildContext context,{required String title ,required Function onDeletePressed}) async =>
  showCustomDialog(context, _DeleteDialog(title: title,onDeletePressed: onDeletePressed), onDismissCallback: (){} ,isCancellable: true);




class _DeleteDialog extends StatelessWidget {
  final String _title;
final Function _onDeletePressed;

  const _DeleteDialog({
    required String title,
    required Function onDeletePressed,
  })  : _title = title,
        _onDeletePressed = onDeletePressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Padding(
          padding: EdgeInsets.all(kScreenPaddingNormal.r),
          child: Column(
            children: [

              Text(_title,style:const TextStyle().titleStyle(fontSize: 16).primaryTextColor(),textAlign: TextAlign.center,),
              VerticalSpace(kScreenPaddingNormal.h),
              Text(tr(LocaleKeys.deleteMassage),style:const TextStyle().regularStyle(fontSize: 14).customColor( AppColor.hintColor.themeColor ),textAlign: TextAlign.center,),
              VerticalSpace(kScreenPaddingNormal.h),
              Row(
                children: [
                  Expanded(child: CustomButton(onTap: (){NavigationService.goBack();_onDeletePressed();},title: tr(LocaleKeys.delete),height: 40,/*,isOutlined: true,textColor: Theme.of(context).primaryColor*/)),


                  HorizontalSpace(kFormPaddingAllLarge.h),
                  Expanded(child: CustomButton(onTap: ()=>NavigationService.goBack(),title: tr(LocaleKeys.cancel),color: Theme.of(context).hintColor,height: 40,)),

                ],
              ),
            ],
          ),
        ),
      ],
    );

  }

}




