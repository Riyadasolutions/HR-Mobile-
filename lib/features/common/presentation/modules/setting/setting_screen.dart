import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/dialog/show_delete_account_dialog.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/color.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/res/theme_helper.dart';
import 'package:base_app/features/common/presentation/modules/setting/setting_view_model.dart';
import 'package:base_app/features/common/presentation/modules/setting/widgets/setting_item.dart';
import 'package:base_app/features/common/presentation/sheets/change_currency/currency_sheet.dart';
import 'package:base_app/features/common/presentation/sheets/change_language_sheet.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  late ThemeHelper _viewThemeModel ;
  late SettingViewModel _viewModel ;
  @override
  void initState() {
    _viewThemeModel =Provider.of<ThemeHelper>(context,listen: false);
    _viewModel =Provider.of<SettingViewModel>(context,listen: false);
    _viewModel.init();
    _viewThemeModel.getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeHelper>().isDarkMode;
    return CustomScaffold(
      appBar: CustomAppBar(title: tr(LocaleKeys.settings),),
      body: SafeArea(
        child:Padding(
          padding: kScreenPadding,
          child: CustomListAnimator(
            // mainAxisSize: MainAxisSize.min,
            children: [

             SettingItem(icon: Assets.iconsDarkModeIcon, title: tr(LocaleKeys.darkMode), endWidget: CustomSwitch(value: isDarkMode, onChanged: (isDarkMode)=>_viewThemeModel.changeTheme(isDarkMode,reload: true)),),
              // SettingItem(icon: Assets.iconsFaceIdIcon, title: tr(LocaleKeys.authenticateUsingFaceID), endWidget: CustomSwitch(value: faceIdToken!=null, onChanged: _updateFaceId),),
              SettingItem(icon: Assets.iconsMenuLanguageIcon, title: tr(LocaleKeys.language), onTap: ()=>showChangeLanguageSheet(context),endWidget: Image.asset(context.locale.languageCode=='ar'?Assets.flagsSa:Assets.flagsUs,width: 32.w,height: 24.h,),),
              SettingItem(icon: Assets.iconsCurrencies, title: tr(LocaleKeys.currency), onTap: ()async{
               await showChangeCurrencySheet(context);
               setState(() {

               });
              },endWidget: Text(tr(kUserCurrency),style: TextStyle().semiBoldStyle(fontSize: 14).primaryTextColor(),),),
              // SettingItem(icon: Assets.iconsNotificationIcon, title: tr(LocaleKeys.notifications), endWidget: CustomSwitch(value: true, onChanged: (v){}),),
              // SettingItem(icon: Assets.iconsStatisticsIcon, title: tr(LocaleKeys.statistics),onTap: (){}),
              // SettingItem(icon: Assets.iconsProfilePrivacyIcon, title: tr(LocaleKeys.privacyPolicy),onTap: (){}),
              // SettingItem(icon: Assets.iconsMyReviewsIcon, title: tr(LocaleKeys.myReviews),onTap: (){}),
              SettingItem(icon: Assets.iconsMenuDeleteAccountIcon,color: AppColor.errorColor.themeColor, title: tr(LocaleKeys.deleteAccount),onTap: ()=>showCustomDialogDeleteAccount(context)),
              // SettingItem(icon: Assets.iconsMenuLogoutIcon,color: AppColor.errorColor.themeColor, title: tr(LocaleKeys.logout),onTap: ()=>showCustomDialogLogout(context)),
            ],
          ),
        ),
      )
    );
  }
}
