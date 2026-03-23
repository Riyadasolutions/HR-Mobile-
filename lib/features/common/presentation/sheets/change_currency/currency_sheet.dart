import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
import 'package:base_app/features/common/presentation/sheets/change_currency/currency_view_model.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ChangeCurrencySheet extends StatefulWidget {
  @override
  State<ChangeCurrencySheet> createState() => _ChangeCurrencySheetState();

  const ChangeCurrencySheet({super.key});
}

class _ChangeCurrencySheetState extends State<ChangeCurrencySheet> {
  final tag = 'ChangeCurrencySheet';
  CurrencyPickerViewModel get _viewModel =>
      Provider.of<CurrencyPickerViewModel>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _viewModel.init();
    // locale = context.locale
  }

  void _onCurrencySelected() {
    if (_viewModel.selected == null) {
      return;
    }
    // log('onCurrencySelected', 'change language to (${locale.languageCode})');
    Provider.of<LocalAuthProvider>(context, listen: false).saveCurrency(_viewModel.selected!);

    kUserCurrency = _viewModel.selected!;
    Navigator.pop(context, _viewModel.selected!);
    // context.setLocale(Locale(_viewModel.selected!));
  }

  @override
  Widget build(BuildContext context) {
    var currencies = context.watch<CurrencyPickerViewModel>().currencies;
    var selected = context.watch<CurrencyPickerViewModel>().selected;
    return CustomSheetContainerView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          VerticalSpace(kFormPaddingAllLarge.h),
          CustomSheetHeader(onCancelPress: () => NavigationService.goBack(), title: tr(LocaleKeys.currencies)),

          CustomScreenStateLayout(
            loadingBuilder: (context) => CustomShimmerView(itemCount: 8, height:40.h),
            isLoading: currencies == null,
            builder: (context) => buildBody(context,
                items: currencies!, selectedItem: selected),
          ),
          VerticalSpace(kScreenPaddingNormal.h),
          CustomButton(
              title: tr(LocaleKeys.submit), onTap: () => _onCurrencySelected())
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, {required List<String> items, required String? selectedItem}) {
    return Container(
      constraints: BoxConstraints(maxHeight: deviceHeight / 2),
      child: ListView(shrinkWrap: true, children: items.map((e) => _buildSingleChoiceItem(context, selectedItem, e)).toList()),
    );
  }

 Widget _buildSingleChoiceItem(BuildContext context, String? selectedItem, String entity) =>
      CustomSheetRadioItem<String>(title: tr(entity), value: entity,  groupValue: selectedItem, onChanged: () => _viewModel.onSelected(entity));


}

Future<dynamic> showChangeCurrencySheet(BuildContext context) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => const SafeArea(child: ChangeCurrencySheet()),
  );
}
