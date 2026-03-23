
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'country_picker_view_model.dart';



class _CountryPickerSheet extends StatefulWidget {
  final List<DropDownEntity> _defaultList;
  final DropDownEntity? _defaultValue;
  final bool _isMultiChoice;
  final bool _addAll;
  const _CountryPickerSheet({required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
    required bool addAll,
    required bool isMultiChoice,
  })  : _defaultList = defaultList,
        _defaultValue = defaultValue,
        _addAll = addAll,
        _isMultiChoice = isMultiChoice;

  @override
  State<_CountryPickerSheet> createState() => __CountryPickerSheetState();


}

class __CountryPickerSheetState extends State<_CountryPickerSheet> {
  late CountryPickerViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = Provider.of<CountryPickerViewModel>(context, listen: false);
    _viewModel.init(defaultValue: widget._defaultValue,defaultList: widget._defaultList,addAll: widget._addAll) ;

  }

  @override
  Widget build(BuildContext context) {

    var responseModel = context.watch<CountryPickerViewModel>().responseModel;
    var selectedList = context.watch<CountryPickerViewModel>().selectedList;
    var selected = context.watch<CountryPickerViewModel>().selected;
    List<DropDownEntity> viewList = context.watch<CountryPickerViewModel>().viewList;

    return CustomSheetContainerView(

      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                VerticalSpace(kFormPaddingAllLarge.h),

                CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack(), title: tr(LocaleKeys.countries)),

                CustomTextFieldSearch(
                  hint: tr(LocaleKeys.searchHint),
                  onChange: (value) => _viewModel.onSearch(value),
                ),
                VerticalSpace(kFormPaddingAllLarge.h),

                Flexible(
                  child: CustomScreenStateLayout(
                    isLoading: responseModel == null,
                    isEmpty: viewList.isEmpty,
                    loadingBuilder: (context) => const CustomShimmerView.sheet(),
                    onRetry: () => _viewModel.getList(reload: true),
                    builder: (context) =>
                        _buildBody(
                            context,
                            selectedItemIds: selectedList!.map((e) => e.id).toList(),
                            list: viewList,
                            selectedItem: selected
                        ),
                  ),
                ),

                VerticalSpace(kFormPaddingAllLarge.h),
                CustomButton(title: tr(LocaleKeys.confirm),onTap: () => Navigator.pop(context, widget._isMultiChoice ? selectedList : selected)),

              ],
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, {List<int?>? selectedItemIds, required List<DropDownEntity> list, DropDownEntity? selectedItem}) {
    if (list.isEmpty) {
      return const SizedBox.shrink();
    }
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: deviceHeight / 2),
      child: CustomListAnimatorData(
        itemCount: list.length,
        itemBuilder: (context, index) => widget._isMultiChoice
            ? _buildMultiChoiceItem(context, selectedItemIds, list[index])
            : _buildSingleChoiceItem(context, selectedItem, list[index]),
      ),
    );
  }
  //   return list.isEmpty
  //       ? const SizedBox.shrink()
  //       : ListView(
  //           children: list
  //               .map((e) => widget._isMultiChoice
  //                   ? _buildMultiChoiceItem(context, selectedItemIds, e)
  //                   : _buildSingleChoiceItem(context, selectedItem, e))
  //               .toList(),
  //         );
  // }

  Widget _buildMultiChoiceItem(BuildContext context, List<int?>? selectedIds, DropDownEntity entity) =>
      CustomSheetCheckboxItem(title: entity.title, isSelected: selectedIds!.contains(entity.id), onChanged: (value) => _viewModel.onItemChecked(isChecked: value, selectedItem: entity));
  Widget _buildSingleChoiceItem(BuildContext context, DropDownEntity? selectedItem, DropDownEntity entity) =>
      CustomSheetRadioItem<int>(title: entity.title, value: entity.id,  groupValue: selectedItem?.id, onChanged: () => _viewModel.onSelected(entity));

  //
  // Widget _buildMultiChoiceItem(BuildContext context, List<int?>? selectedStateIds, DropDownEntity model) {
  //   return CheckboxListTile(
  //     controlAffinity: ListTileControlAffinity.leading,
  //     contentPadding: EdgeInsets.zero,
  //     value: selectedStateIds!.contains(model.id),
  //     onChanged: (b) => _viewModel.onItemChecked(isChecked: b!, selectedItem: model),
  //     title: Text(model.title, style: const TextStyle().semiBoldStyle(fontSize: 14).colorBlack(),),
  //
  //   );
  // }
  //
  //
  // Widget _buildSingleChoiceItem(BuildContext context, DropDownEntity? selectedItem, DropDownEntity entity) {
  //   return RadioListTile<int>(
  //     controlAffinity: ListTileControlAffinity.leading,
  //     contentPadding: EdgeInsets.zero,
  //     groupValue: selectedItem?.id,
  //     title: Row(
  //       children: [
  //         Expanded(child: Text(entity.title, style: const TextStyle().semiBoldStyle(fontSize: 14).colorBlack())),
  //         CustomImage(imageUrl: entity.image,height: 24,width: 24),
  //       ],
  //     ),
  //
  //     value: entity.id,
  //     onChanged: (value) {
  //       _viewModel.onSelected(entity);
  //     },
  //   );
  // }
}

Future<dynamic> showCountryPicker(BuildContext context,
    {required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
     bool addAll=false,
    required bool isMultiChoice}) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
        child: _CountryPickerSheet(
      defaultList: defaultList,
      defaultValue: defaultValue,
      addAll: addAll,
      isMultiChoice: isMultiChoice,
    )),
  );
}
