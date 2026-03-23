import 'package:intl/intl.dart';

class CurrencyFormatterHelper {
  static String format(var val, String currency,bool showCurrency) {
    try{
      num? price = double.tryParse((val??"0").toString());
      final format = _getFormatter(currency, price);
      return "${showCurrency?_getSymbol(currency):''} ${format.format(price)}";
    }
    catch (e) {
      return '${ _getSymbol(currency) } ${val??0}';

    }


  }

  static NumberFormat _getFormatter(String currency, num? price) {
    bool isInt = price != null && price == price.toInt();
    final pattern = isInt ? "#,##0" : "#,##0.0#";
    return NumberFormat(pattern, _getLocale(currency));
  }

  static String _getLocale(String currency) {
    switch (currency) {
      case 'USD':return 'en_US';
      case 'GBP':return 'en_GB';
      case 'EUR':return 'de_DE';
      case 'TZS':return 'en_TZ';
      default:return 'en_TZ';
    }
  }

  static String _getSymbol(String currency) {
    switch (currency) {
      case 'USD':return '\$';
      case 'GBP':return '£';
      case 'EUR':return '€';
      case 'TZS':return 'TSh';
      default:return 'TSh';
    }
  }
}

// import 'package:base_app/core/constants/globals.dart';
// import 'package:intl/intl.dart';
//
// class CurrencyFormatterHelper {
//   static String format(num price, String currency) {
//     final format = _getFormatter(currency);
//     return format.format(price);
//   }
//
//   static NumberFormat _getFormatter(num price) {
//     bool isInt = price != null && price == price.toInt();
//
//     switch (kUserCurrency) {
//       case 'USD':
//         return NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2,customPattern: isInt?"#,##0":"#,##0.0#");
//       case 'GBP':
//         return NumberFormat.currency(locale: 'en_GB', symbol: '£', decimalDigits: 2,customPattern: isInt?"#,##0":"#,##0.0#");
//       case 'EUR':
//         return NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 2,customPattern: isInt?"#,##0":"#,##0.0#");
//       case 'TZS':
//         return NumberFormat.currency(locale: 'en_TZ', symbol: 'TSh', decimalDigits: 2,customPattern: isInt?"#,##0":"#,##0.0#");
//       default:
//         return NumberFormat.currency(locale: 'en_TZ', symbol: 'TSh', decimalDigits: 2,customPattern: isInt?"#,##0":"#,##0.0#");
//     }
//   }
// }
