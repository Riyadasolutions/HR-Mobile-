import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as sheet;

import 'package:base_app/generated/locale_keys.g.dart';
import '../component/component.dart';

class _CustomPickerSheet extends StatefulWidget {
  final List _list;
  final DropDownEntity? _defaultValue;
  final String _title;
  final List<DropDownEntity> _defaultList;
  final bool _isMultiChoice;



  @override
  State<_CustomPickerSheet> createState() => __CustomPickerSheetState();

  const _CustomPickerSheet({
    required List list,
    required DropDownEntity? defaultValue,
    required String title,
    required List<DropDownEntity> defaultList,
    required bool isMultiChoice,
  })
      : _list = list,
        _defaultValue = defaultValue,
        _title = title,
        _defaultList = defaultList,
        _isMultiChoice = isMultiChoice;
}

class __CustomPickerSheetState extends State<_CustomPickerSheet> {

  ///variables
  DropDownEntity? _selected;
  List<DropDownEntity> _selectedList = [];




  void _onSelected(DropDownEntity value) {
    if (value == _selected) {
      _selected = null;
    } else {
      _selected = value;
    }
    setState(() {});
  }
  void _onItemChecked({required bool isChecked, required DropDownEntity selectedItem}) {
    if (isChecked) {
      _selectedList.add(selectedItem);
    } else {
      _selectedList.removeWhere((item) => item.id == selectedItem.id);
    }
    setState(() {
      _selectedList = [..._selectedList];
    });
  }


  @override
  void initState() {
    _selectedList = widget._defaultList;
    _selected = widget._defaultValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheetContainerView(
      // margin: EdgeInsets.only(top: 40,bottom:MediaQuery.of(context).viewInsets.bottom ),
      // padding: const EdgeInsets.only(bottom: 32, top: 4),
      // decoration: const BoxDecoration(borderRadius:BorderRadius.vertical(top: Radius.circular(20)), color: Colors.white),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            VerticalSpace(kFormPaddingAllLarge.h),

            CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack(), title:  widget._title,),


            _buildBody(context, selectedItem: _selected,selectedItems: _selectedList.map((e) => e.key??e.id.toString()).toList(),),
            const VerticalSpace(kScreenPaddingNormal),
            CustomButton(title: tr(LocaleKeys.submit),onTap: () => Navigator.pop(context,   widget._isMultiChoice ? _selectedList : _selected))
        ],
      ),
    );
  }


  Widget _buildBody(BuildContext context, {List<String?>? selectedItems, DropDownEntity? selectedItem}) {
    return  Container(
      constraints: BoxConstraints(maxHeight: deviceHeight / 2),
      child: ListView(
          shrinkWrap: true,
          children: widget._list
              .map((e) => widget._isMultiChoice
              ? _buildMultiChoiceItem(context, selectedItems, e)
              : _buildSingleChoiceItem(context, selectedItem, e))
              .toList()),
    );
  }


  Widget _buildMultiChoiceItem(BuildContext context, List<String?>? selectedItems, DropDownEntity entity) =>
      CustomSheetCheckboxItem(title: entity.title,icon: entity.icon,image: entity.image,color:  entity.color==0xffffff?null:Color( entity.color), isSelected: (selectedItems??[]).contains(entity.key??entity.id.toString()), onChanged: (value) => _onItemChecked(isChecked: value, selectedItem: entity));
  Widget _buildSingleChoiceItem(BuildContext context, DropDownEntity? selectedItem, DropDownEntity entity) =>
      CustomSheetRadioItem<String>(title: entity.title,icon: entity.icon,image: entity.image,color:  entity.color==0xffffff?null:Color( entity.color), value: entity.key??entity.id.toString(),  groupValue: selectedItem?.key, onChanged: () =>_onSelected(entity));

}

Future<dynamic> showCustomPicker<T>(BuildContext context, {required DropDownEntity? defaultValue , required List list ,required String title,  List<DropDownEntity>? defaultList,  bool? isMultiChoice}) async {
  return sheet.showMaterialModalBottomSheet(
    expand: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => SafeArea(
      child: _CustomPickerSheet(defaultValue: defaultValue, title: title, list: list, defaultList: defaultList??[], isMultiChoice: isMultiChoice??false,),
    ),
  );
}
