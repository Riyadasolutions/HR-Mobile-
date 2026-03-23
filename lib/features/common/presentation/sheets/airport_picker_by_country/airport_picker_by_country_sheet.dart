import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/common/presentation/sheets/airport_picker_by_country/airport_picker_by_country_view_model.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class _AirportPickerByCountrySheet extends StatefulWidget {
  final List<DropDownEntity> _defaultList;
  final DropDownEntity? _defaultValue;
  final bool _isMultiChoice;
  final DropDownEntity? _country;

  const _AirportPickerByCountrySheet({
    required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
    required bool isMultiChoice,
    required DropDownEntity? country,
  })  : _defaultList = defaultList,
        _defaultValue = defaultValue,
        _isMultiChoice = isMultiChoice,
        _country = country;

  @override
  State<_AirportPickerByCountrySheet> createState() =>
      __AirportPickerByCountrySheetState();
}

class __AirportPickerByCountrySheetState
    extends State<_AirportPickerByCountrySheet> {
  late AirportPickerByCountryViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<AirportPickerByCountryViewModel>(context,
        listen: false);
    _viewModel.init(
      defaultValue: widget._defaultValue,
      defaultList: widget._defaultList,
      country: widget._country,
    );
  }

  @override
  Widget build(BuildContext context) {
    var airports = context.watch<AirportPickerByCountryViewModel>().airports;
    var isLoading = context.watch<AirportPickerByCountryViewModel>().isLoading;
    var error = context.watch<AirportPickerByCountryViewModel>().error;
    var selectedList =
        context.watch<AirportPickerByCountryViewModel>().selectedList;
    var selected = context.watch<AirportPickerByCountryViewModel>().selected;

    return CustomSheetContainerView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          VerticalSpace(kFormPaddingAllLarge.h),
          CustomSheetHeader(
            onCancelPress: () => NavigationService.goBack(),
            title: tr(LocaleKeys.airport),
          ),
          if (widget._country == null) ...[
            VerticalSpace(kFormPaddingAllLarge.h),
            Padding(
              padding: kCardPadding,
              child: Text(
                tr(LocaleKeys.youMustSelectTheCountryFirst),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ] else if (isLoading) ...[
            VerticalSpace(kFormPaddingAllLarge.h),
            const CustomShimmerView.sheet(),
          ] else if (error != null) ...[
            VerticalSpace(kFormPaddingAllLarge.h),
            Padding(
              padding: kCardPadding,
              child: Column(
                children: [
                  Text(
                    error,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  VerticalSpace(kFormPaddingAllLarge.h),
                  CustomButton(
                    title: tr(LocaleKeys.retry),
                    onTap: () => _viewModel.loadAirports(reload: true),
                  ),
                ],
              ),
            ),
          ] else ...[
            CustomScreenStateLayout(
              isLoading: false,
              isEmpty: airports.isEmpty,
              loadingBuilder: (context) => const CustomShimmerView.sheet(),
              onRetry: () => _viewModel.loadAirports(reload: true),
              builder: (context) => _buildBody(
                context,
                selectedItemIds: selectedList.map((e) => e.id).toList(),
                list: airports,
                selectedItem: selected,
              ),
            ),
          ],
          VerticalSpace(kFormPaddingAllLarge.h),
          CustomButton(
            title: tr(LocaleKeys.confirm),
            onTap: () => Navigator.pop(
                context, widget._isMultiChoice ? selectedList : selected),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(
    BuildContext context, {
    List<int?>? selectedItemIds,
    required List<DropDownEntity> list,
    DropDownEntity? selectedItem,
  }) {
    return list.isEmpty
        ? const SizedBox.shrink()
        : Container(
            constraints: BoxConstraints(maxHeight: deviceHeight / 2),
            child: ListView(
              shrinkWrap: true,
              children: list
                  .map((e) => widget._isMultiChoice
                      ? _buildMultiChoiceItem(context, selectedItemIds, e)
                      : _buildSingleChoiceItem(context, selectedItem, e))
                  .toList(),
            ),
          );
  }

  Widget _buildMultiChoiceItem(
      BuildContext context, List<int?>? selectedIds, DropDownEntity entity) {
    return CustomSheetCheckboxItem(
      title: entity.title,
      isSelected: selectedIds!.contains(entity.id),
      onChanged: (value) =>
          _viewModel.onItemChecked(isChecked: value, selectedItem: entity),
    );
  }

  Widget _buildSingleChoiceItem(BuildContext context,
      DropDownEntity? selectedItem, DropDownEntity entity) {
    return CustomSheetRadioItem<int>(
      title: entity.title,
      value: entity.id,
      groupValue: selectedItem?.id,
      onChanged: () => _viewModel.onSelected(entity),
    );
  }
}

Future<dynamic> showAirportPickerByCountry(
  BuildContext context, {
  required List<DropDownEntity> defaultList,
  required DropDownEntity? defaultValue,
  required bool isMultiChoice,
  required DropDownEntity? country,
}) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
      child: _AirportPickerByCountrySheet(
        defaultList: defaultList,
        defaultValue: defaultValue,
        isMultiChoice: isMultiChoice,
        country: country,
      ),
    ),
  );
}
