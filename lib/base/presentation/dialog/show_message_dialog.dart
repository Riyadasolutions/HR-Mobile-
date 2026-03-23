

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import '../component/component.dart';
import 'base/simple_dialogs.dart';

Future showCustomMessageDialog(BuildContext context,{required String title ,required String desc ,required Function onOKPressed}) async =>
  showCustomDialog(context, _buildBody(context,title: title,desc: desc,onOKPressed: onOKPressed), onDismissCallback: onOKPressed ,isCancellable: true);

_buildBody(BuildContext context,{required String title ,required String desc ,required Function onOKPressed}){
  return Column(
    children: [
      Padding(
       padding: EdgeInsets.all(kScreenPaddingNormal.r),
        child: Column(
          children: [

            Text(title,style:const TextStyle().titleStyle(fontSize: 16).colorBlack(),textAlign: TextAlign.center,),
            VerticalSpace(kScreenPaddingNormal.h),
            Text(desc,style:const TextStyle().regularStyle(fontSize: 14).customColor( AppColor.hintColor.themeColor ),textAlign: TextAlign.center,),
            VerticalSpace(kScreenPaddingNormal.h),
            Row(
              children: [
                Expanded(child: CustomButton(onTap: ()=>NavigationService.goBack(),title: tr(LocaleKeys.cancel),color: Theme.of(context).hintColor,height: 40,)),
                HorizontalSpace(kFormPaddingAllLarge.h),
                Expanded(child: CustomButton(onTap: (){NavigationService.goBack();onOKPressed();},title: tr(LocaleKeys.delete),height: 40,/*,isOutlined: true,textColor: Theme.of(context).primaryColor*/)),

              ],
            ),
          ],
        ),
      ),
    ],
  );
}
