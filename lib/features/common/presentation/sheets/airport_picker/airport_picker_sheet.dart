
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart' show CustomShimmerView;
import 'package:base_app/base/presentation/component/inputs/custom_text_field_search.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/common/presentation/sheets/airport_picker/airport_picker_view_model.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';




class _AirportPickerSheet extends StatefulWidget {
  final List<DropDownEntity> _defaultList;
  final DropDownEntity? _defaultValue;
  final bool _isMultiChoice;
  final bool _addAll;
  final int _countryId;
  const _AirportPickerSheet({required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
    required bool addAll,
    required bool isMultiChoice,
    required int countryId,
  })  : _defaultList = defaultList,
        _defaultValue = defaultValue,
        _addAll = addAll,
        _isMultiChoice = isMultiChoice,
        _countryId = countryId;

  @override
  State<_AirportPickerSheet> createState() => __AirportPickerSheetState();


}

class __AirportPickerSheetState extends State<_AirportPickerSheet> {
  late AirportPickerViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = Provider.of<AirportPickerViewModel>(context, listen: false);
    _viewModel.init(defaultValue: widget._defaultValue,defaultList: widget._defaultList,addAll: widget._addAll, countryId: widget._countryId) ;

  }

  @override
  Widget build(BuildContext context) {

    var responseModel = context.watch<AirportPickerViewModel>().responseModel;
    var selectedList = context.watch<AirportPickerViewModel>().selectedList;
    var selected = context.watch<AirportPickerViewModel>().selected;
    List<DropDownEntity> viewList = context.watch<AirportPickerViewModel>().viewList;


    return CustomSheetContainerView(

      child: LayoutBuilder(
          builder: (context, constraints) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                VerticalSpace(kFormPaddingAllLarge.h),

                CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack(), title: tr(LocaleKeys.airport)),

                CustomTextFieldSearch(
                  hint: tr(LocaleKeys.searchHint),
                  onChange: (value) => _viewModel.onSearch(value),
                ),
                VerticalSpace(kFormPaddingAllLarge.h),

                Flexible(
                  child: CustomScreenStateLayout(
                    isLoading: responseModel == null,
                    loadingBuilder: (context) => const CustomShimmerView.sheet(),
                    isEmpty: viewList.isEmpty,
                    onRetry: () => _viewModel.getList(reload: true, countryId: widget._countryId),
                    builder: (context) =>
                        _buildBody(
                            context,
                            selectedItemIds: selectedList!.map((e) => e.id).toList(),
                            list: viewList,
                            selectedItem: selected
                        ),
                  ),
                ),

                const SizedBox(height: kFormPaddingAllLarge),
                CustomButton(title: tr(LocaleKeys.confirm),onTap: () => Navigator.pop(context, widget._isMultiChoice ? selectedList : selected)),

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

Future<dynamic> showAirportPicker(BuildContext context,
    {required List<DropDownEntity> defaultList,
    required DropDownEntity? defaultValue,
     bool addAll=false,
    required bool isMultiChoice,
    required int countryId}) async {
  return showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
        child: _AirportPickerSheet(
      defaultList: defaultList,
      defaultValue: defaultValue,
      addAll: addAll,
      isMultiChoice: isMultiChoice,
      countryId: countryId,
    )),
  );
}
