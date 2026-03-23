
import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/utils/modal_sheet.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';
import '../../component.dart';
import 'countries.dart';

class PickerDialogStyle {
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;

  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
}

class CountryPickerDialog extends StatefulWidget {
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;

  const CountryPickerDialog({
    Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
  }) : super(key: key);

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaWidth = MediaQuery.of(context).size.width;
    final width = widget.style?.width ?? mediaWidth;
    const defaultHorizontalPadding = 24.0;
    const defaultVerticalPadding = 40.0;
    return Container(



      decoration: BoxDecoration(
        color: widget.style?.backgroundColor??Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(Radius.circular(kFormPaddingAllLarge)),
      ),
      padding: widget.style?.padding ?? kCardPadding,
      child: Column(
        children: <Widget>[
          CustomSheetHeader(onCancelPress: ()=>NavigationService.goBack()),


          Padding(
            padding: widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
            child: CustomTextFieldSearch(
              hint: tr(LocaleKeys.searchHint),
              // isDark: true,
              onChange: (value) {
                _filteredCountries = isNumeric(value)
                    ? widget.countryList
                    .where((country) => country.dialCode.contains(value))
                    .toList()
                    : widget.countryList
                    .where((country) => country.name
                    .toLowerCase()
                    .contains(value.toLowerCase()))
                    .toList();
                if (mounted) setState(() {});
              },
            ),
          ),

          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filteredCountries.length,
              itemBuilder: (ctx, index) => GestureDetector(
                onTap: () {
                  _selectedCountry = _filteredCountries[index];
                  widget.onCountryChanged(_selectedCountry);
                  Navigator.of(context).pop();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          // CustomRadio(
                          //     value: _selectedCountry,
                          //     groupValue: _filteredCountries[index],
                          //     onChanged: (v) {
                          //       setState(() {
                          //         _selectedCountry = _filteredCountries[index];
                          //       });
                          //     }),
                          // HorizontalSpace(kFormPaddingAllLarge.w),

                          Expanded(child: Container(
                            padding: EdgeInsetsDirectional.fromSTEB(kFormPaddingAllLarge.w, kFormPaddingAllLarge.h, kFormPaddingAllSmall.r, kFormPaddingAllLarge.h),
                            decoration: const BoxDecoration().cardStyle(),
                            child: Row(
                              children: [
                                Image.asset('assets/images/flags/${_filteredCountries[index].code.toLowerCase()}.png', width: 24),
                                HorizontalSpace(kFormPaddingAllSmall.w),
                                Text('+(${(_filteredCountries[index].dialCode)})', style: widget.style?.countryCodeStyle ?? const TextStyle().regularStyle(fontSize: 12)),
                                if(_filteredCountries[index].dialCode.length==2)
                                  Text('0', style: const TextStyle().regularStyle(fontSize: 12).customColor(Colors.transparent)),

                                HorizontalSpace(kFormPaddingAllLarge.w),
                                Expanded(child: AutoSizeText(_filteredCountries[index].name, style: widget.style?.countryNameStyle ?? const TextStyle().regularStyle().primaryTextColor(),)),
                              ],
                            ),
                          ))
                        ],
                      ),
                      // ListTile(leading: Image.asset('assets/images/flags/${_filteredCountries[index].code.toLowerCase()}.png', width: 32),
                      //   contentPadding: widget.style?.listTilePadding,
                      //   title: Text(_filteredCountries[index].name, style: widget.style?.countryNameStyle ?? const TextStyle().semiBoldStyle().colorBlack(),),
                      //   trailing: Text('+${_filteredCountries[index].dialCode}', style: widget.style?.countryCodeStyle ?? const TextStyle().regularStyle()),
                      //   onTap: () {
                      //     _selectedCountry = _filteredCountries[index];
                      //     widget.onCountryChanged(_selectedCountry);
                      //     Navigator.of(context).pop();
                      //   },
                      // ),


                      widget.style?.listTileDivider ??const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // const SizedBox(height: 20),
          //
          // CustomButton(title: tr(LocaleKeys.confirm),onTap: (){
          //   widget.onCountryChanged(_selectedCountry);
          //   Navigator.of(context).pop();
          // }),
        ],
      ),
    );
  }
  /// check if the string [str] contains only numbers
  static bool isNumeric(String str) {
     final RegExp numeric =  RegExp(r'^-?[0-9]+$');

    return numeric.hasMatch(str);
  }
}

// showChangeCountry({
//   Key? key,
//   required this.searchText,
//   required this.countryList,
//   required this.onCountryChanged,
//   required this.selectedCountry,
//   required this.filteredCountries,
//   this.style,
// })=>ModalSheet.showModalSheet(context: context, screen: screen)