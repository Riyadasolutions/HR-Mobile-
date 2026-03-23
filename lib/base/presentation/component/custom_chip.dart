
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

import 'package:base_app/core/res/resources.dart';

List<DropDownEntity> kCustomChipMapperEnums(var enums)=>
    enums.values.map((e) => DropDownEntity(key: e.value, id: 0, title: e.name)).toList();

List<DropDownEntity> kCustomChipMapper(List<MapEntry<String, String>> values)=>
    values.map((e) => DropDownEntity(key: e.key, id: 0, title: e.value)).toList();



class CustomChip extends StatefulWidget {
  final String? _title;
  final bool _isMultipleSelection;
  final bool _canBeNull;

  final List<DropDownEntity> _list;
  final String? _selected;
  final ValueChanged<String>? _onSelected;
  final ValueChanged<List<String>>? _onSelectedList;


  @override
  State<CustomChip> createState() => _CustomChipState();


  const CustomChip({super.key,
    bool isMultipleSelection =false,
    bool canBeNull= true,
    String? title,
    required  List<DropDownEntity> list,
    String? selected,
    ValueChanged<String>? onSelected,
    ValueChanged<List<String>>? onSelectedList,
  })  : _isMultipleSelection = isMultipleSelection,
        _canBeNull = canBeNull,
        _list = list,
        _title = title,
        _selected = selected,
        _onSelected = onSelected,
        _onSelectedList = onSelectedList;
}

class _CustomChipState extends State<CustomChip> {
  var selectedTags = []; //["love", "me", "summer"];

  @override
  void initState() {
    super.initState();

    if (widget._selected != null) {
      selectedTags = [widget._selected];
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        if(widget._title != null)
          Padding(
            padding: EdgeInsets.all(kFormPaddingAllSmall.w),
            child: Text(
                widget._title!,
                style: Theme.of(context).inputDecorationTheme.labelStyle!.customColor(AppColor.labelColor.themeColor)
              // style: const TextStyle().regularStyle().boldStyle().customColor(Theme.of(context).primaryColor),
            ),
          ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: deviceWidth,
              padding: EdgeInsets.all(kFormPaddingAllSmall.w),

              child: Wrap(
                spacing: 5.0, // gap between adjacent chips
                runSpacing: -5.0, // gap between lines

                children:  widget._list.map((tag) => _getChip(tag)).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }



  Widget _getChip(DropDownEntity children) {bool isSelected = !widget._canBeNull && selectedTags.isEmpty ? widget._list[0].key == children : selectedTags.contains(children);
  return FilterChip(
    padding: EdgeInsets.all(kFormPaddingAllSmall.w),

    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(kCartRadius))),
    selected: isSelected,
    backgroundColor: Theme.of(context).cardColor,
    selectedColor: Theme.of(context).primaryColor,
    disabledColor: AppColor.hintColor.themeColor,
    label: Text(tr(children.title), style: const TextStyle().regularStyle().boldStyle().customColor(isSelected ? Colors.white : Colors.black)),
    elevation: 2,
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
          widget._onSelected!(children.key!);
        }
      });
    },
  );
  }
}

