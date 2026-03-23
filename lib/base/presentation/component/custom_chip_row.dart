
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';



class CustomChipRow extends StatefulWidget {
  final bool _isMultipleSelection;
  final bool _canBeNull;
  final bool _enable;

  final List<DropDownEntity> _list;
  final DropDownEntity? _selected;
  final ValueChanged<DropDownEntity>? _onSelected;
  final ValueChanged<List<DropDownEntity>>? _onSelectedList;


  @override
  State<CustomChipRow> createState() => _CustomChipRowState();


  const CustomChipRow({super.key,
    bool isMultipleSelection= false,
    bool canBeNull  = true,
    bool enable  = true,
    required List<DropDownEntity> list,
    DropDownEntity? selected,
    ValueChanged<DropDownEntity>? onSelected,
    ValueChanged<List<DropDownEntity>>? onSelectedList,
  })  : _isMultipleSelection = isMultipleSelection,
        _canBeNull = canBeNull,
        _enable = enable,
        _list = list,
        _selected = selected,
        _onSelected = onSelected,
        _onSelectedList = onSelectedList;
}

class _CustomChipRowState extends State<CustomChipRow> {
   List<DropDownEntity> selectedTags = []; //["love", "me", "summer"];

  @override
  void initState() {
    super.initState();

    if (widget._selected != null || widget._list.isNotEmpty) {
      selectedTags =widget._canBeNull? widget._selected==null?[]:[widget._selected!]:[widget._selected??widget._list.first];
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [..._generateTags()],
      ),
    );
  }

  List<Widget> _generateTags()=> widget._list.map((tag) => _getChip(tag)).toList();


  Widget _getChip(DropDownEntity children) {
    bool isSelected = !widget._canBeNull && selectedTags.isEmpty
        ? (widget._list[0].key ?? widget._list[0].id).toString() == (children.key ?? children.id).toString()
        : selectedTags.map((e) => (e.key??e.id).toString() ,).contains((children.key??children.id).toString() );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllSmall.w),
      child: FilterChip(
        padding: EdgeInsets.all(kFormPaddingAllSmall.r),
        shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.all(Radius.circular(kFormRadiusSmall))),
        selected: false,
        backgroundColor: isSelected?AppColor.primaryColor.themeColor:AppColor.primaryColorDark.themeColor,
        selectedColor:  widget._enable?Theme.of(context).primaryColor:AppColor.primaryColor.themeColor,
        disabledColor: AppColor.primaryBackgroundDarkColor.themeColor,
        label: Center(child: Text(tr(children.title), style: const TextStyle().regularStyle().boldStyle().customColor(isSelected ? Colors.white : Colors.white)),),
        elevation: 2,
        showCheckmark: isSelected,
        onSelected: (bool value) {
          setState(() {
            if (widget._isMultipleSelection && widget._enable) {
              if (value) {
                selectedTags.add(children);
              } else {
                selectedTags.remove(children);
              }
            } else {
              if( widget._enable)selectedTags = [children];
              if(widget._onSelected!=null) widget._onSelected!(children);
            }
          });
        },
      ),
    );
  }
}
