
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/sheets/custom_picker_sheet.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/utils/logger.dart';



class CustomSelectorWidget<T> extends StatelessWidget {
  final _tag = 'CustomSelectorWidget';
  final bool _isMultiChoice;
  final Function(DropDownEntity<T>)? _onSelected;
  final Function(List<DropDownEntity<T>>)? _onSelectList;
  final DropDownEntity<T>? _selectedValue;
  final List<DropDownEntity<T>> _list;
  final List<DropDownEntity<T>>? _selectedList;
  final String? _error;
  final String _title;
  final String? _hint;

  const CustomSelectorWidget({super.key,
    bool isMultiChoice = false,
    Function(DropDownEntity<T>)? onSelected,
    Function(List<DropDownEntity<T>>)? onSelectList,
    required List<DropDownEntity<T>> list,
    DropDownEntity<T>? selectedValue,
    List<DropDownEntity<T>>? selectedList,
    String? error,
   required String title,
    String? hint,

  })  : _isMultiChoice = isMultiChoice,
        _list = list,
        _onSelected = onSelected,
        _onSelectList = onSelectList,
        _title = title,
        _selectedValue = selectedValue,
        _hint  = hint,
        _selectedList = selectedList,
        _error = error;

  @override
  Widget build(BuildContext context) {
    return CustomButtonArrow(
        error: _error,
         value: _selectedValue?.title ?? ((_selectedList ?? []).isNotEmpty ? (_selectedList ?? []).map((e) => e.title).toList().join(' , ') :null),
        // color: Colors.white,
        label: _title,
        hint: _hint?? _title,
        textColor: _selectedValue?.title == null ? Theme.of(context).hintColor : Theme.of(context).inputDecorationTheme.labelStyle!.color,
        onTap: () => _onPressed(context));
  }

  Future<void> _onPressed(
    BuildContext context,
  ) async {
    var result = await showCustomPicker(
      context,
      isMultiChoice: _isMultiChoice,
      defaultList: _selectedList ?? [],
      defaultValue: _selectedValue, list: _list, title: _title,
    );

    log(_tag, 'onPressed: result= $result');
    FocusManager.instance.primaryFocus?.unfocus();

    if (result != null) {
      if (_isMultiChoice) {
        if (_onSelectList != null) {
          _onSelectList(result);
        }
      } else {
        if (_onSelected != null) {
          _onSelected(result);
        }
      }
    } else {
      log(_tag, 'result == null');
    }
  }
}
