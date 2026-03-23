import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/dialog/show_delete_account_dialog.dart';
import 'package:base_app/base/presentation/dialog/show_logout_dialog.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';

import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/features/common/presentation/modules/layout/layout_view_model.dart';
import 'package:base_app/features/common/presentation/sheets/change_currency/currency_sheet.dart';
import 'package:base_app/features/common/presentation/sheets/change_language_sheet.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
      appBar: const CustomAppBar(
        height: 0,
        bottomSize: 0,
        isBackButtonExist: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: kScreenPadding,
          child: Column(
            children: [
              VerticalSpace(kFormPaddingAllLarge.h),
              // CustomPersonImage(imageUrl: kUser?.image,canEdit: kIsAuth,onEditClick:() => NavigationService.push(UserRoutes.profileScreen).then((value) =>setState(()=>kUser = value??kUser) )),
        
              
              if(kIsAuth)...[
                Row(
                  children: [
                    CustomPersonImage(imageUrl: kUser?.image ,size: 56.r,),
                    HorizontalSpace(kFormPaddingAllLarge.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(kUser!.name,style: const TextStyle().titleStyle(fontSize: 18).primaryTextColor()),
                        Text(kUser!.mobile,style: const TextStyle().regularStyle().customColor( AppColor.hintColor.themeColor )),
                      ],
                    )
                  ],
                ),

                // VerticalSpace(kScreenPaddingNormal.h),
                // GestureDetector(
                //   onTap: ()=>NavigationService.push(CommonRoutes.pointsScreen),
                //   child: Container(
                //     height: 75.h,
                //     width: deviceWidth,
                //     padding: EdgeInsets.all(kFormPaddingAllLarge.r),
                //     decoration: const BoxDecoration().imageBackground(Assets.imagesPointsBackgroundImage),
                //     child: CustomIconText(
                //       isExpanded: true,
                //       title:  '${kUser?.points.balance} ${tr(LocaleKeys.point)} = ${kUser?.points.amount ?? 0}',
                //       icon: Assets.iconsPointsIcon,
                //       iconSize: 38.r,
                //       textStyle: const TextStyle().titleStyle(fontSize: 24).customColor(const Color(0xffFFF6E0)),
                //     ),
                //   ),
                // ),
                VerticalSpace(kScreenPaddingNormal.h),

              ],

              
              Expanded(
                child: CustomListAnimator(
                  verticalSpace: kFormPaddingAllSmall,
                  children: [
                    if(kIsAuth)...[
                      Text(tr(LocaleKeys.personalInfo),style: const TextStyle().semiBoldStyle(fontSize: 18).primaryTextColor()),
                      _buildItem(context,title: tr(LocaleKeys.personalData),icon: Assets.iconsMenuPersonalDataIcon,onTap: () =>NavigationService.push(CommonRoutes.profileScreen)),
                      // _buildItem(context,title: tr(LocaleKeys.myAddresses),icon: Assets.iconsMenuMyAddressesIcon,onTap: () =>NavigationService.push(CommonRoutes.myAddressesScreen)),
                      _buildItem(context,title: tr(LocaleKeys.bookings),icon: Assets.iconsMenuBookingIcon, onTap: ()=> Provider.of<LayoutViewModel>(context,listen: false).setCurrentIndex(2)),
                      // _buildItem(context,title: tr(LocaleKeys.notifications),icon: Assets.iconsBillIcon,onTap: () {}),
                      // _buildItem(context,title: tr(LocaleKeys.favorites),icon: Assets.iconsMenuFavouritesIcon, onTap: ()=> Provider.of<LayoutViewModel>(context,listen: false).setCurrentIndex(1)),
                      // _buildItem(context,title: tr(LocaleKeys.wallet),icon: Assets.iconsMenuWalletIcon,onTap: () =>NavigationService.push(CommonRoutes.walletScreen)),
                      // _buildItem(context,title: tr(LocaleKeys.coupons),icon: Assets.iconsMenuCouponsIcon,onTap: () =>NavigationService.push(CommonRoutes.couponsScreen)),
                    ],



                    Text(tr(LocaleKeys.general),style: const TextStyle().semiBoldStyle(fontSize: 18).primaryTextColor()),
                    _buildItem(context,title: tr(LocaleKeys.settings),icon: Assets.iconsMenuSettingsIcon ,  onTap: () =>NavigationService.push(CommonRoutes.settingScreen)),
                    // _buildItem(context,title: tr(LocaleKeys.language),icon: Assets.iconsMenuLanguageIcon, onTap: ()async{await showChangeLanguageSheet(context);setState(() {});}),
                    // _buildItem(context,title: tr(LocaleKeys.currency),icon: Assets.iconsCurrencies, onTap: ()async{await showChangeCurrencySheet(context);setState(() {});}),



                    Text(tr(LocaleKeys.about),style: const TextStyle().semiBoldStyle(fontSize: 18).primaryTextColor()),
                    _buildItem(context,title: tr(LocaleKeys.contactUs),icon: Assets.iconsMenuContactUsIcon, onTap: ()=>NavigationService.push(CommonRoutes.contactUsScreen)),
                    _buildItem(context,title: tr(LocaleKeys.privacyPolicy),icon: Assets.iconsMenuPrivacyPolicyIcon, onTap: ()=>NavigationService.push(CommonRoutes.privacyScreen)),
                    // _buildItem(context,title: tr(LocaleKeys.privacyPolicy),icon: Assets.iconsMenuPrivacyPolicyIcon, onTap: ()=>NavigationService.push(CommonRoutes.privacyScreen)),
                    _buildItem(context,title: tr(LocaleKeys.termsAndConditions),icon: Assets.iconsMenuTermConditionIcon, onTap: ()=>NavigationService.push(CommonRoutes.termsScreen)),
                    // _buildItem(context,title: tr(LocaleKeys.termsAndConditions),icon: Assets.iconsMenuTermConditionIcon, onTap: ()=>NavigationService.push(CommonRoutes.pagesScreen,arguments: {'type':PagesType.terms})),
                    // _buildItem(context,title: tr(LocaleKeys.aboutApp),icon: Assets.iconsMenuAboutUsIcon, onTap: ()=>NavigationService.push(CommonRoutes.pagesScreen,arguments: {'type':PagesType.about})),
                    // _buildItem(context,title: tr(LocaleKeys.aboutApp),icon: Assets.iconsMenuAboutUsIcon ,  onTap: ()=>NavigationService.push(CommonRoutes.aboutUsScreen)),



                    if(kIsAuth) _buildItem(context,title: tr(LocaleKeys.deleteAccount),icon: Assets.iconsMenuDeleteAccountIcon,color:Colors.red, onTap:  ()=>showCustomDialogDeleteAccount(context)),
                    if(kIsAuth) _buildItem(context,title: tr(LocaleKeys.logout),icon: Assets.iconsMenuLogoutIcon,color:Colors.red, onTap: ()=>showCustomDialogLogout(context)),
                    if(!kIsAuth)_buildItem(context,title: tr(LocaleKeys.login),icon: Assets.iconsMenuLogoutIcon,onTap: ()=>NavigationService.push(AuthRoutes.loginScreen)),
        
        
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildItem(BuildContext context,{required String title, String? icon,Widget? endWidget, Color? color, required GestureTapCallback? onTap}) {
      return Container(
        decoration: const BoxDecoration().cardStyle(),
        margin:  EdgeInsets.symmetric(vertical: kFormPaddingAllSmall.h),
        padding:  EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
        height: 56.h,
        child: GestureDetector(
          onTap: onTap,
          child: Row(
            children: [
              if(icon!=null)...[
                Center(child: CustomSVGIcon(icon,size: 26.r,color: color??Theme.of(context).primaryColor)),
                HorizontalSpace(kFormPaddingAllLarge.w),
              ],
              Expanded(child: Text(title,style: const TextStyle().semiBoldStyle().primaryTextColor().customColor(color))),
              endWidget?? Icon(Icons.arrow_forward_ios,size: 19.r,color: color??Theme.of(context).hintColor),
            ],
          ),
        ),
      );
  }
}
