import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';

class PriceConverter {


  static String convertPrice(var val, {bool showCurrency = true,String?currency }) {
    try {
      double? price = double.tryParse((val??"0").toString());

      bool isInt = int.tryParse(val.toString())!=null;
      var f =NumberFormat(isInt?"#,##0":"#,##0.0#", "en_US");


      if (showCurrency) {
        return '${f.format(price)} ${currency??tr(LocaleKeys.currency)}';
      } else {
        return f.format(price);
      }
    } catch (e) {
      return '${val??0} ${currency??tr(LocaleKeys.currency)}';
    }
  }
  static String convertWithDiscount(var priceVal, var discountVal, String discountType) {
    try {
      String val = '';
      double price = double.tryParse((priceVal??"0").toString())??0;
      double discount = double.tryParse((discountVal??"0").toString())??0;
      if (discountType == LocaleKeys.currency/*'amount'*/) {
        var res =  (price - discount);
        bool isInt = int.tryParse(res.toString())!=null;
        var f =NumberFormat(isInt?"#,##0":"#,##0.0#", "en_US");
        val = '${f.format(res)} ${tr(LocaleKeys.currency)}';
      } else if (discountType =='%'/* 'percent'*/) {
        var res =  (((discount / 100) * price));
        bool isInt = int.tryParse(res.toString())!=null;
        var f =NumberFormat(isInt?"#,##0":"#,##0.0#", "en_US");
        val = '${f.format(res)} ${tr(LocaleKeys.currency)}';
        // val = '${(((discount / 100) * price)).toStringAsFixed(1)}%';
      }
      return val;
    } catch (e) {
      return '';
    }
  }
  static double convertWithDiscount1(BuildContext context, double price, double discount, String discountType) {
    if (discountType == 'amount') {
      price = price - discount;
    } else if (discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
    return price;
  }

  static double calculation(
      double amount, double discount, String type, int quantity) {
    double calculatedAmount = 0;
    if (type == 'amount') {
      calculatedAmount = discount * quantity;
    } else if (type == 'percent') {
      calculatedAmount = (discount / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(BuildContext context, String price, double discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : tr(LocaleKeys.currency)} OFF';
  }
}

double convertToDouble(var d) => d / 1;
int convertToInt(double d) => (d).round();
