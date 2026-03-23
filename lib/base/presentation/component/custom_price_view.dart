import 'package:base_app/core/constants/globals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/res/text_styles.dart';

import '../../../../../core/utils/price_converter.dart';
import 'package:base_app/generated/locale_keys.g.dart';

class CustomPriceView extends StatelessWidget {
  final num _value;
  final bool _showCurrency;
  final bool _oldPrice;

  final int? _maxLines;
  final String? _currency;

  final TextStyle? _numberStyle;
  final TextStyle? _currencyStyle;

  const CustomPriceView({
    super.key,
    int? maxLines,
    required num value,
    bool showCurrency = true,
    bool oldPrice = false,
    TextStyle? numberStyle,
    String? currency,
    TextStyle? currencyStyle,
  })  : _value = value,
        _oldPrice = oldPrice,
        _showCurrency = showCurrency,
        _currency = currency,
        _maxLines = maxLines,
        _numberStyle = numberStyle,
        _currencyStyle = currencyStyle;

  @override
  Widget build(BuildContext context) {
    return Text(PriceConverter.convertPrice(_value,showCurrency: _showCurrency,currency: _currency),style: _numberStyle??const TextStyle().titleStyle(fontSize: 14).activeColor().heightStyle(height: 1.4).lineThroughStyle(enable: _oldPrice));
/*    return  RichText(
      maxLines: _maxLines,
      text: TextSpan(
        children: [
          if(_showCurrency)
            TextSpan(
              text: kUserCurrency,
              style: _currencyStyle??const TextStyle().semiBoldStyle(fontSize: 14).activeColor().heightStyle(height: 1.4),
            ),
          TextSpan(
            text: ' ${PriceConverter.convertPrice(_value,showCurrency: false)}',
            style: _numberStyle??const TextStyle().semiBoldStyle(fontSize: 14).activeColor().heightStyle(height: 1.4).lineThroughStyle(enable: _oldPrice)
          ),

        ],
      ),
    );*/
  }


}
