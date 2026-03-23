
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/common/presentation/sheets/nationality_picker/nationality_picker_view_model.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';




class _NationalityPickerSheet extends StatefulWidget {
  final List<DropDownEntity> _defaultList;
  final DropDownEntity? _defaultValue;
  final bool _isMultiChoice;
  final bool _addAll;
  const _NationalityPickerSheet({required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
    required bool addAll,
    required bool isMultiChoice,
  })  : _defaultList = defaultList,
        _defaultValue = defaultValue,
        _addAll = addAll,
        _isMultiChoice = isMultiChoice;

  @override
  State<_NationalityPickerSheet> createState() => __NationalityPickerSheetState();


}

class __NationalityPickerSheetState extends State<_NationalityPickerSheet> {
  late NationalityPickerViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = Provider.of<NationalityPickerViewModel>(context, listen: false);
    _viewModel.init(defaultValue: widget._defaultValue,defaultList: widget._defaultList,addAll: widget._addAll) ;

  }

  @override
  Widget build(BuildContext context) {

    var responseModel = context.watch<NationalityPickerViewModel>().responseModel;
    var selectedList = context.watch<NationalityPickerViewModel>().selectedList;
    var selected = context.watch<NationalityPickerViewModel>().selected;


    return CustomSheetContainerView(

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            VerticalSpace(kFormPaddingAllLarge.h),

            CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack(), title: tr(LocaleKeys.nationality)),




            CustomScreenStateLayout(
              isLoading: responseModel == null,
              isEmpty: ( responseModel?.data?.length??0)==0,
              loadingBuilder: (context) => const CustomShimmerView.sheet(),
              onRetry: () => _viewModel.getList(reload: true),
              builder: (context) =>
                  _buildBody(
                      context,
                      selectedItemIds: selectedList!.map((e) => e.id).toList(),
                      list: responseModel?.data??[],
                      selectedItem: selected
                  ),
            ),

            VerticalSpace(kFormPaddingAllLarge.h),
            CustomButton(title: tr(LocaleKeys.confirm),onTap: () => Navigator.pop(context, widget._isMultiChoice ? selectedList : selected)),

          ]),
    );
  }

  Widget _buildBody(BuildContext context, {List<int?>? selectedItemIds, required List<DropDownEntity> list, DropDownEntity? selectedItem}) {
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
                    .toList()),
          );
  }

  Widget _buildMultiChoiceItem(BuildContext context, List<int?>? selectedIds, DropDownEntity entity) =>
      CustomSheetCheckboxItem(title: entity.title, isSelected: selectedIds!.contains(entity.id), onChanged: (value) => _viewModel.onItemChecked(isChecked: value, selectedItem: entity));
  Widget _buildSingleChoiceItem(BuildContext context, DropDownEntity? selectedItem, DropDownEntity entity) =>
      CustomSheetRadioItem<int>(title: entity.title, value: entity.id,  groupValue: selectedItem?.id, onChanged: () => _viewModel.onSelected(entity));

}

Future<dynamic> showNationalityPicker(BuildContext context,
    {required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
     bool addAll=false,
    required bool isMultiChoice}) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
        child: _NationalityPickerSheet(
      defaultList: defaultList,
      defaultValue: defaultValue,
      addAll: addAll,
      isMultiChoice: isMultiChoice,
    )),
  );
}
