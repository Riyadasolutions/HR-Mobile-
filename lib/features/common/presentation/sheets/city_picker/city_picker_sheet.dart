
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart';
import 'package:base_app/base/presentation/component/inputs/custom_text_field_search.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'city_picker_view_model.dart';

class _CityPickerSheet extends StatefulWidget {
  final List<DropDownEntity> _defaultList;
  final DropDownEntity? _defaultValue;
  final bool _isMultiChoice;
  final bool _isSelectAllEnable;
  final int _countryId;

  @override
  State<_CityPickerSheet> createState() => __CityPickerSheet();

  const _CityPickerSheet({
    required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
    required bool isMultiChoice,
    required bool isSelectAllEnable,
    required int countryId,
  })  : _defaultList = defaultList,
        _defaultValue = defaultValue,
        _isMultiChoice = isMultiChoice,
        _isSelectAllEnable = isSelectAllEnable,
        _countryId = countryId;
}

class __CityPickerSheet extends State<_CityPickerSheet> {
  late CityPickerViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<CityPickerViewModel>(context, listen: false);
    _viewModel.init(context,defaultValue: widget._defaultValue,defaultList: widget._defaultList,isSelectAllEnable: widget._isSelectAllEnable,countryId: widget._countryId) ;
  }

  _onSubmit(){
    if(widget._isMultiChoice){
      _viewModel.selectedList?.removeWhere((element) => element.key=='selectAll');
      NavigationService.goBack(_viewModel.selectedList);

    }else{
      NavigationService.goBack(_viewModel.selected);

    }
  }
  @override
  Widget build(BuildContext context) {
    var responseModel = context.watch<CityPickerViewModel>().responseModel;
    var selectedList = context.watch<CityPickerViewModel>().selectedList;
    var selected = context.watch<CityPickerViewModel>().selected;
    List<DropDownEntity> viewList = context.watch<CityPickerViewModel>().viewList;

    return CustomSheetContainerView(

      child: LayoutBuilder(
          builder: (context, constraints) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                VerticalSpace(kFormPaddingAllLarge.h),

                CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack(), title: tr(LocaleKeys.city)),

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
                    onRetry: () => _viewModel.getList(reload: true,countryId: widget._countryId),
                    builder: (context) =>
                        _buildBody(context, selectedItemIds: selectedList!.map((e) => e.id).toList(), list: viewList, selectedItem: selected),
                  ),
                ),
                const SizedBox(height: kFormPaddingAllLarge),
                CustomButton(title: tr(LocaleKeys.confirm),onTap: () =>_onSubmit())
              ]);
        }
      ),
    );

  }

  Widget _buildBody(BuildContext context, {List<int?>? selectedItemIds, required List<DropDownEntity> list, DropDownEntity? selectedItem}) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
      constraints: BoxConstraints(maxHeight: deviceHeight / 2),
      child: CustomListAnimatorData(
        itemCount: list.length,
        itemBuilder: (context, index) => widget._isMultiChoice
            ? _buildMultiChoiceItem(context, selectedItemIds, list[index])
            : _buildSingleChoiceItem(context, selectedItem, list[index]),
      ),
    );
  }

  Widget _buildMultiChoiceItem(BuildContext context, List<int?>? selectedIds, DropDownEntity entity) =>
      CustomSheetCheckboxItem(title: entity.title, isSelected: selectedIds!.contains(entity.id), onChanged: (value) => _viewModel.onItemChecked(isChecked: value, selectedItem: entity));
  Widget _buildSingleChoiceItem(BuildContext context, DropDownEntity? selectedItem, DropDownEntity entity) =>
      CustomSheetRadioItem<int>(title: entity.title, value: entity.id,  groupValue: selectedItem?.id, onChanged: () => _viewModel.onSelected(entity));

}

Future<dynamic> showCityPicker(BuildContext context, {required List<DropDownEntity> defaultList, required DropDownEntity? defaultValue, required int countryId, bool isSelectAllEnable=false, required bool isMultiChoice}) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
        child: _CityPickerSheet(
          defaultList: defaultList,
          defaultValue: defaultValue,
          countryId: countryId,
          isSelectAllEnable: isSelectAllEnable,
          isMultiChoice: isMultiChoice,
        )),
  );
}
