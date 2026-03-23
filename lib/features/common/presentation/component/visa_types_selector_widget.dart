
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/common/presentation/sheets/country_picker/country_picker_sheet.dart';
import 'package:base_app/features/common/presentation/sheets/visa_type_picker/visa_type_picker_sheet.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';




class VisaTypesSelectorWidget extends StatelessWidget {
  final _tag = 'VisaTypesSelectorWidget';
  final bool _isMultiChoice;
  final Function(DropDownEntity)? _onSelected;
  final Function(List<DropDownEntity>)? _onSelectList;
  final DropDownEntity? _selectedValue;
  final List<DropDownEntity>? _selectedList;
  final String? _error;
  final IconData? _iconData;
  final String? _iconSVG;
  final String? _title;
  final String? _hint;
  final bool _isDark;

  const VisaTypesSelectorWidget({super.key,
    bool isMultiChoice = false,
    Function(DropDownEntity)? onSelected,
    Function(List<DropDownEntity>)? onSelectList,
    DropDownEntity? selectedValue,
    List<DropDownEntity>? selectedList,
    String? error,
    String? title,
    String? hint,
    IconData? iconData,
    String? iconSVG,
    bool isDark = false,
  })  : _isMultiChoice = isMultiChoice,
        _onSelected = onSelected,
        _onSelectList = onSelectList,
        _title = title,
        _selectedValue = selectedValue,
        _hint  = hint,
        _selectedList = selectedList,
        _error = error,
        _iconData = iconData,
        _iconSVG = iconSVG,
        _isDark = isDark;

  @override
  Widget build(BuildContext context) {
    return CustomButtonArrow(
        // isDark:_isDark,
        // iconSVG: _iconSVG,
        error: _error,
        value: _selectedValue?.title ?? ((_selectedList ?? []).isNotEmpty ? (_selectedList ?? []).map((e) => e.title).toList().join(' , ') :null),

        label: _title??tr(LocaleKeys.visaType),
        hint: _hint?? _title??tr(LocaleKeys.visaType),
        textColor: _selectedValue?.title == null
            ? Theme.of(context).hintColor
            :  Theme.of(context).inputDecorationTheme.labelStyle!.color,
        onTap: () => _onPressed(context));
  }

  Future<void> _onPressed(
    BuildContext context,
  ) async {
    var result = await showVisaTypePicker(
      context,
      isMultiChoice: _isMultiChoice,

      defaultList: _selectedList ?? [],
      defaultValue: _selectedValue,
    );

    log(_tag, 'onPressed: result= $result');
    FocusManager.instance.primaryFocus?.unfocus();

    if (result != null) {
      if (_isMultiChoice) {
        if (_onSelectList != null) {
          _onSelectList!(result);
        }
      } else {
        if (_onSelected != null) {
          _onSelected!(result);
        }
      }
    } else {
      log(_tag, 'result == null');
    }
  }
}
