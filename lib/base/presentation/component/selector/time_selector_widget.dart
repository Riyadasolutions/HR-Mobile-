
import 'package:base_app/core/res/color.dart';
import 'package:base_app/base/presentation/sheets/time_picker_sheet.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/utils/logger.dart';
import '../component.dart';



class TimeSelectorWidget extends StatelessWidget {
  final _tag = 'TimeSelectorWidget';
  final Function(String)? _onSelected;
  final String? _selectedValue;
  final String? _hint;
  final String? _error;
  final IconData? _iconData;
  final String? _iconSVG;
  final bool _isDark;

  const TimeSelectorWidget({super.key,
    Function(String)? onSelected,
    String? selectedValue,
    String? error,
    String? hint,
    IconData? iconData,
    String? iconSVG,
    bool isDark = false,
  })  :
        _onSelected = onSelected,
        _selectedValue = selectedValue,
        _error = error,
        _hint = hint,
        _iconData = iconData,
        _iconSVG = iconSVG,
        _isDark = isDark;

  @override
  Widget build(BuildContext context) {
    return  CustomButtonArrow(
        isDark: _isDark,
        iconSVG: _iconSVG ,
        hint: _hint,
        error: _error,
        value: _selectedValue?.toString(),
        textColor: _selectedValue == null ? Theme.of(context).hintColor :  Theme.of(context).inputDecorationTheme.labelStyle!.color,
        onTap: () => onPressed(context));
  }

  Future<void> onPressed(BuildContext context) async {
    var result = await showHoursPicker(
      context,
      defaultValue: _selectedValue,
    );

    log(_tag, 'onPressed: result= $result');
    FocusManager.instance.primaryFocus?.unfocus();

    if (result != null) {
      if (_onSelected != null) {
        _onSelected!(result);
      }
    } else {
      log(_tag, 'result == null');
    }
  }
}
