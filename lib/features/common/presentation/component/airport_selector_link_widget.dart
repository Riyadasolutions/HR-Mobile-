
import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/utils/alerts.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/features/common/presentation/sheets/airport_picker/airport_picker_sheet.dart';
import 'package:base_app/features/common/presentation/sheets/airport_picker_by_country/airport_picker_by_country_sheet.dart';
import 'package:base_app/generated/locale_keys.g.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';




class AirportSelectorWidget extends StatelessWidget {
  final _tag = 'AirportSelectorWidget';
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
  final DropDownEntity? _country;

  const AirportSelectorWidget({super.key,
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
    DropDownEntity? country,
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
        _isDark = isDark,
        _country = country;

  @override
  Widget build(BuildContext context) {
    return CustomButtonArrow(
      // isDark:_isDark,
      // iconSVG: _iconSVG,
        error: _error,
        value: _selectedValue?.title ?? ((_selectedList ?? []).isNotEmpty ? (_selectedList ?? []).map((e) => e.title).toList().join(' , ') :null),
        label: _title??tr(LocaleKeys.airport),
        hint: _hint?? _title??tr(LocaleKeys.airport),
        textColor: _selectedValue?.title == null ? Theme.of(context).hintColor :  Theme.of(context).inputDecorationTheme.labelStyle!.color,
        onTap: () => _onPressed(context));
  }

  Future<void> _onPressed(
      BuildContext context,
      ) async {
    // If country is provided, use the country-filtered picker
    if (_country == null) {
      Alerts.showSnackBar( tr(LocaleKeys.youMustSelectTheCountryFirst));
      return ;
    }
    var result = await showAirportPickerByCountry(
      context,
      isMultiChoice: _isMultiChoice,
      defaultList: _selectedList ?? [],
      defaultValue: _selectedValue,
      country: _country,
    );

    log(_tag, 'onPressed: result= $result');
    FocusManager.instance.primaryFocus?.unfocus();

    if (result != null) {
      if (_isMultiChoice) {
        _onSelectList?.call(result);
      } else {
        _onSelected?.call(result);
      }
    } else {
      log(_tag, 'result == null');
    }
    // } else {
    //   // Fallback to original airport picker if no country is provided
    //   var result = await showAirportPicker(
    //     context,
    //     isMultiChoice: _isMultiChoice,
    //     defaultList: _selectedList ?? [],
    //     defaultValue: _selectedValue,
    //   );
    //
    //   log(_tag, 'onPressed: result= $result');
    //   FocusManager.instance.primaryFocus?.unfocus();
    //
    //   if (result != null) {
    //     if (_isMultiChoice) {
    //       _onSelectList?.call(result);
    //     } else {
    //       _onSelected?.call(result);
    //     }
    //   } else {
    //     log(_tag, 'result == null');
    //   }
    // }
  }
}
