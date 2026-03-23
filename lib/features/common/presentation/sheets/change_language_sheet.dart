import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/logger.dart';


class ChangeLanguageSheet extends StatefulWidget {
  @override
  State<ChangeLanguageSheet> createState() => _ChangeLanguageSheetState();

  const ChangeLanguageSheet({super.key});
}

class _ChangeLanguageSheetState extends State<ChangeLanguageSheet> {
  final tag = 'ChangeLanguageSheet';
  late Locale locale = context.locale;

  @override
  void initState() {
    super.initState();
    // locale = context.locale
  }

  void _onLanguageSelected() {
    log('onLanguageSelected', 'change language to (${locale.languageCode})');
    Provider.of<LocalAuthProvider>(context,listen: false).getUserProfile();

    Navigator.pop(context);
    context.setLocale(locale) ;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheetContainerView(
      // margin: const EdgeInsets.only(top: 40),
      // padding:kScreenPadding.copyWith(bottom: 40+ MediaQuery.of(context).viewInsets.bottom,) ,
      // decoration:  BoxDecoration(borderRadius:const BorderRadius.vertical(top: Radius.circular(20)), color: Theme.of(context).scaffoldBackgroundColor),
      child:  Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            VerticalSpace(kFormPaddingAllLarge.h),

            CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack(), title: tr(LocaleKeys.language)),
            CustomScreenStateLayout(builder: (context) => buildBody(context, items: Constants.kSupportedLocales, selectedItem: locale),),
            VerticalSpace(kScreenPaddingNormal.h),
            CustomButton(title: tr(LocaleKeys.submit),onTap: () =>_onLanguageSelected())
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, {required List<Locale> items, required Locale selectedItem}) {
    return Container(
      constraints: BoxConstraints(maxHeight: deviceHeight / 2),
      child: ListView(
          shrinkWrap: true,
          children: items.map((e) => _buildSingleChoiceItem(context, selectedItem, e)).toList()),
    );
  }

  Widget _buildSingleChoiceItem(BuildContext context, Locale selectedItem, Locale language) =>
      CustomSheetRadioItem<Locale>(title:tr(language.languageCode), value: language, image: language.languageCode=='ar'?Assets.flagsSa:Assets.flagsUs, groupValue: selectedItem, onChanged: () =>   setState(() {locale = language;}));


// Widget _buildSingleChoiceItem(BuildContext context, Locale selectedItem, Locale item) {
  //   return RadioListTile<Locale>(
  //     materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //     visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
  //     contentPadding: EdgeInsets.zero,
  //     groupValue: selectedItem,
  //     title: Text(tr(item.languageCode)),
  //     value: item,
  //     onChanged: (value) {
  //       if (value != null) {
  //         setState(() {locale = value;});
  //       }
  //     },
  //   );
  // }
}

Future<dynamic> showChangeLanguageSheet(BuildContext context) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const SafeArea(child: ChangeLanguageSheet()),
  );


}
