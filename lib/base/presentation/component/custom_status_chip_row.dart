
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';

class CustomStatusChipRow extends StatefulWidget {
  final bool _isMultipleSelection;
  final bool _canBeNull;

  final List<DropDownEntity> _list;
  final DropDownEntity? _selected;
  final ValueChanged<DropDownEntity>? _onSelected;
  final ValueChanged<List<DropDownEntity>>? _onSelectedList;


  @override
  State<CustomStatusChipRow> createState() => _CustomStatusChipRowState();

  const CustomStatusChipRow({super.key,
    bool isMultipleSelection = false,
    bool canBeNull = true,
    required List<DropDownEntity> list,
    DropDownEntity? selected,
    ValueChanged<DropDownEntity>? onSelected,
    ValueChanged<List<DropDownEntity>>? onSelectedList,
  })  : _isMultipleSelection = isMultipleSelection,
        _canBeNull = canBeNull,
        _list = list,
        _selected = selected,
        _onSelected = onSelected,
        _onSelectedList = onSelectedList;
}

class _CustomStatusChipRowState extends State<CustomStatusChipRow> {


  List<DropDownEntity> selectedTags = [];

  @override
  void initState() {

    super.initState();
    if (widget._selected != null) {
      selectedTags = [widget._selected!];
    }
  }
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [...generateTags()],
      ),
    );
  }

  generateTags() {
    return widget._list.map((tag) => getChip(tag)).toList();
  }

  getChip(DropDownEntity children) {
    bool isSelected = !widget._canBeNull && selectedTags.isEmpty ? widget._list[0] == children : selectedTags.contains(children);

    // bool isSelected =!widget._canBeNull && selectedTags.isEmpty ? widget._list[0].id == children : selectedTags.map((e) => e.id).contains(children.id);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kFormPaddingAllSmall),
      child: FilterChip(
        shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(kFormRadius))),

        selected: isSelected,
        backgroundColor: AppColor.primaryBackgroundDarkColor.themeColor  ,
        selectedColor: Theme.of(context).primaryColorDark,
        disabledColor: AppColor.primaryBackgroundDarkColor.themeColor,


        label: Center(
          child: Text(
              tr(children.title),
              style: const TextStyle().regularStyle().customColor(isSelected? AppColor.textColorLite.themeColor :AppColor.textColor.themeColor)),
        ),
        elevation: 5,
        showCheckmark: false,
        onSelected: (bool value) {
          setState(() {
            if (widget._isMultipleSelection) {
              if (value) {
                selectedTags.add(children);
              } else {
                selectedTags.remove(children);
              }
            } else {
              selectedTags = [children];
              widget._onSelected!(children);
            }
          });
        },
      ),
    );
  }
}
