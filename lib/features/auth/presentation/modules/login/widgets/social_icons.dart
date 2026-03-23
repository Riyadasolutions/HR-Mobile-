
import 'dart:io';

import 'package:base_app/base/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter_svg/flutter_svg.dart';


import '../../../../../../generated/assets.dart';
import '../../../../../../generated/locale_keys.g.dart';

class CustomSocialMediaLoginWidget extends StatelessWidget {
  final VoidCallback? _loginByFacebook;
  final VoidCallback? _loginByGoogle;
  final VoidCallback? _loginByApple;
  final bool _loginWithFaceBook;
  final bool _loginWithGoogle;
  final bool _loginWithApple;


  const CustomSocialMediaLoginWidget({super.key,
     GestureTapCallback? loginByFacebook,
     GestureTapCallback? loginByGoogle,
     GestureTapCallback? loginByApple,
     bool loginWithFaceBook=true,
     bool loginWithGoogle=true,
     bool loginWithApple=true,
  })  : _loginByFacebook = loginByFacebook,
        _loginByGoogle = loginByGoogle,
        _loginByApple = loginByApple,
        _loginWithFaceBook = loginWithFaceBook,
        _loginWithGoogle = loginWithGoogle,
        _loginWithApple = loginWithApple;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
          child: Row(
            children: [
              Expanded(child: Container(height: 2,color: Colors.white.withOpacity(0.5))),
              HorizontalSpace( kFormPaddingAllLarge.w),
              Text(tr(LocaleKeys.or), style: const TextStyle().regularStyle().boldStyle().customColor( AppColor.hintColor.themeColor )),
              HorizontalSpace( kFormPaddingAllLarge.w),
              Expanded(child: Container(height: 2,color: Colors.white.withOpacity(0.5))),

            ],
          ),
        ),
        VerticalSpace( kFormPaddingAllLarge.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [

            if (_loginWithGoogle) ...[
              VerticalSpace( kFormPaddingAllLarge.w),
              _buildItem(context,assets: Assets.iconsGoogleIcon,onTap: _loginByGoogle,text: tr(LocaleKeys.signInWithGoogle)),
              VerticalSpace( kFormPaddingAllLarge.w),
            ],
            // if (_loginWithFaceBook) ...[
            //   VerticalSpace( kFormPaddingAllLarge.w),
            //   _buildItem(context,assets:Assets.iconsFacebookIcon,onTap: _loginByFacebook ),
            //   VerticalSpace( kFormPaddingAllLarge.w),
            // ],

            if (_loginWithApple && Platform.isIOS) ...[
              VerticalSpace( kFormPaddingAllLarge.w),
              _buildItem(context,assets: Assets.iconsAppleIcon,onTap: _loginByApple,text: tr(LocaleKeys.signInWithApple)),
              VerticalSpace( kFormPaddingAllLarge.w),
            ]
          ],
        )
      ],
    );
  }
  _buildItem(BuildContext context ,{VoidCallback? onTap,required String text,required String assets})=>CustomButton(onTap: onTap??(){},
    isOutlined: true,
    color: Colors.white.withOpacity(0.5),
    child: CustomIconText(title: text,icon: assets,

      textColor: Colors.white,
      mainAxisAlignment: MainAxisAlignment.center,
    ),
  );

  // _buildItem(BuildContext context ,{VoidCallback? onTap,required String assets})=>CustomTapEffect(
  //   onTap: onTap,
  //   child: Container(
  //     width: 44.r,
  //     height: 44.r,
  //     decoration: const BoxDecoration().radius().customColor(Theme.of(context).primaryColorLight.withOpacity(0.1)),
  //     alignment: Alignment.center,
  //     child:  SvgPicture.asset(assets,height: 28.r,width: 28.r,),
  //   ),
  // );

  Widget _buildFacebookIcon(BuildContext context) {
    return CustomTapEffect(
      onTap: _loginByFacebook,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: const BoxDecoration().radius().borderStyle(),
        alignment: Alignment.center,
        child:  SvgPicture.asset(Assets.iconsFacebookIcon,height: 28.r,width: 28.r,),
      ),
    );

  }


  Widget _buildAppleIcon(BuildContext context) {
    return CustomTapEffect(
      onTap: _loginByApple,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: const BoxDecoration().radius().borderStyle(),
        alignment: Alignment.center,
        child:  SvgPicture.asset(Assets.iconsAppleIcon,height: 28.r,width: 28.r,),
      ),
    );


  }

  Widget _buildGoogleIcon(BuildContext context) {
    return CustomTapEffect(
      onTap: _loginByGoogle,
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: const BoxDecoration().radius().borderStyle(),
        alignment: Alignment.center,
        child:  SvgPicture.asset(Assets.iconsGoogleIcon,height: 28.r,width: 28.r,),
      ),
    );

  }


}
