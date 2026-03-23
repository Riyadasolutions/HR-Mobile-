import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


import '../../../app.dart';
import '../logger.dart';

/// Enum for predefined app format types
enum AppFormatType {
  date('MMM dd, yyyy'),      // App date format: MMM dd, yyyy
  time('hh:mm a'),      // App time format: hh:mm a
  dateTime('MMM dd, yyyy hh:mm a'),  // App date-time format: MMM dd, yyyy hh:mm a
  apiTime('HH:mm'),  // App date-time format: MMM dd, yyyy hh:mm a
  apiDate('yyyy-MM-dd');  // App API format: MMM dd, yyyy hh:mm a

  final String format;
  const AppFormatType(String format): this.format = format;

}

class DateConverter {
  static const  String _locale ='en';


  ///TO This App
  static String getTimeLeft(String date,{bool full = false}) {
    final now = DateTime.now();

    DateTime targetDate =  isoStringToLocalDate('${date}T${now.hour}:${now.minute}:00.000Z');
    final difference = targetDate.difference(now);

    if (difference.isNegative) return '';
    // if (difference.isNegative) return 'Expired';
    //  "minLeft": "m left",
    //   "daysLeft": "days left",
    final days = difference.inDays;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    if (full) {
      return '${days}d ${hours}h ${minutes}${tr(LocaleKeys.minLeft)}';
    } else {
      return '${(difference.inHours / 24).ceil()} ${tr(LocaleKeys.daysLeft)}';
    }
  }
  static String apiTimeFormat(String dateTime) {
    DateTime? date = convertStringToDate(dateTime);
    if(date == null)return '';
    return DateFormat('HH:mm',(appContext?.locale.languageCode ??'ar')).format(date);
  }


  static String getAppDateTimeFormat(String dateTime) {
    DateTime? date = convertStringToDate(dateTime);
    if(date == null)return '';
    return DateFormat('MMM dd, yyyy - hh:mm a',(appContext?.locale.languageCode ??'ar')).format(date);
  }

  static String getAppDateFormat(String dateTime) {
    DateTime? date = convertStringToDate(dateTime);
    if(date == null)return '';
    return DateFormat('MMM dd, yyyy',(appContext?.locale.languageCode ??'ar')).format(date);
  }
  static String getAppTimeFormat(String dateTime) {
    DateTime? date = convertStringToDate(dateTime);
    if(date == null)return '';
    return DateFormat('hh:mm a',(appContext?.locale.languageCode ??'ar')).format(date);
  }


  static String getAppDateAndTimeFormat(String dateTime) {
    DateTime? date = convertStringToDate(dateTime);
    if(date == null)return '';
    return DateFormat('MMM dd, yyyy  hh:mm a',(appContext?.locale.languageCode ??'ar')).format(date);
  }




  static DateTime?  convertStringToDate(String dateTime) {
    try{
      return  DateFormat('yyyy-MM-ddThh:mm:ss',_locale).parse(dateTime).toLocal();
    }catch(e){
      try{
        return DateFormat('dd-MM-yyy hh:mm a',_locale).parse(dateTime);
      }catch(e){
        try{
          return DateFormat('yyyy-MM-dd hh:mm:ss',_locale).parse(dateTime);
        }catch(e){
          try{
            return DateFormat('hh:mm a',_locale).parse(dateTime);
          }catch(e){
            return null;
          }
        }
      }
    }
  }





  ///-----------------------------------------------------------------------------------------



  ///Other

  static String slotDateCalenderRange({DateTime? fromDate , DateTime? toDate}) {
    if(fromDate ==null && toDate==null)return'';
    String from =fromDate ==null?'': DateFormat('yyyy-MM-dd',_locale).format(fromDate);
    String to =toDate ==null?'': DateFormat('yyyy-MM-dd',_locale).format(toDate);
    return '$from ${to.isEmpty?'':' - '} $to' ;
  }

  static DateTime formatDateAPIForm(DateTime dateTime) {
    String data= DateFormat('yyyy-MM-dd hh:mm:ss','en').format(dateTime);
    log('formatDateAPIForm', data);
    return DateFormat('yyyy-MM-dd','en').parse(data).toLocal();

  }




  static String estimatedDateEn(String date) {
    var dateTime =  DateFormat('dd-MM-yyyy','en').parse(date).toLocal();
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }


  static DateTime isoStringToLocalDateWithOutTimer(String? dateTime) {
    if(dateTime == null){return DateTime.now();}
    try{
      return DateFormat('yyyy-MM-dd',_locale).parse(dateTime).toLocal();
    }catch(e){
      return DateTime.now();
    }
  }

  static String slotDate(DateTime dateTime) {
    String date = DateFormat('MM-dd-yyyy',_locale).format(dateTime);
    return date;
  }

  static String slotDateCalender(DateTime? dateTime) {
    if(dateTime ==null)return'';
    String date = DateFormat('yyyy-MM-dd',_locale).format(dateTime);
    return date;
  }

  static DateTime changeDateFormat(DateTime date) {
    DateTime datetime = DateFormat('yyyy-MM-dd',_locale).parse(date.toString()).toLocal();

    return datetime;
  }


  static String isoStringToDateToDomain (String? dateTime) {
    try{
      DateTime date=isoStringToLocalDate(dateTime);
      return  DateFormat('yyyy-MM-dd',_locale).format(date);
    }catch(e){
      return  DateFormat('yyyy-MM-dd',_locale).format(DateTime.now());
    }
    // return DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').parse(dateTime, true).toLocal();
  }


  static DateTime isoStringToLocalDate(String? dateTime) {
    if(dateTime == null){return DateTime.now();}
    try{

      DateTime d =  DateFormat('yyyy-MM-ddThh:mm:ss',_locale).parse(dateTime).toLocal();
      log('isoStringToLocalDate', d.toString());
      return d;
    }catch(e){
      log('isoStringToLocalDate', '$dateTime:: ${e.toString()}');

      return DateTime.now();
    }
  }




  static String isoStringToLocalTimeOnly(String dateTime) {
    return DateFormat('HH:mm',_locale).format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalTimeWithAMPMOnly(String dateTime) {
    return DateFormat('hh:mm a',_locale).format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalTimeWithAMPMOnlyDate(DateTime dateTime) {
    return DateFormat('hh:mm a',_locale).format(dateTime);
  }

  static String isoStringToLocalTimeWithAmPmAndDay(String dateTime) {
    return DateFormat('hh:mm a, EEE',_locale).format(isoStringToLocalDate(dateTime));
  }


  static String isoStringToLocalAMPM(String dateTime) {
    return DateFormat('a',_locale).format(isoStringToLocalDate(dateTime));
  }

  static String isoStringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy',_locale).format(isoStringToLocalDate(dateTime));
  }


  static String localDateFromToIsoString(String? dateTime) {
    if (dateTime == null) {
      return '';
    }
    return DateFormat('dd MMM hh aa',_locale)
        .format(isoStringToLocalDate(dateTime));
  }


  static String isoDayWithDateString(String dateTime) {
    return DateFormat('EEE, MMM d, yyyy')
        .format(isoStringToLocalDate(dateTime));
  }

  static String isoDayWithDateStringForView(String dateTime) {
    return DateFormat('EEE, MMM d, yyyy',appContext!.locale.languageCode).format(isoStringToLocalDate(dateTime));
  }


  static TimeOfDay formatTimeFromStringToTimeOfDay(String? time) {
    if((time??'').isEmpty)return TimeOfDay.now();
    try{
      DateTime dateTime= DateFormat('hh:mm a',_locale).parse(time!);
      log('formatTimeFromStringToTimeOfDay', dateTime.toString());

      return TimeOfDay.fromDateTime(dateTime);
    }catch(e){
      log('formatTimeFromStringToTimeOfDay', e.toString());
      return TimeOfDay.now();
    }
  }



  static String formatTimeFromHHMMAToHHMMSS(String time) {
    // log('formatTimeFromHHMMAToHHMMSS', time);
    DateTime startTime = DateFormat('hh:mm a',_locale).parse(time);
    return DateFormat('HH:mm:ss',_locale).format(startTime);
  }

  /// Converts any date format (String or DateTime) to DateTime
  /// 
  /// [input] - Can be DateTime or String in any format
  /// [locale] - Optional locale for parsing, defaults to 'en'
  /// 
  /// Returns DateTime or null if conversion fails
  /// 
  /// Example usage:
  /// ```dart
  /// // Convert String to DateTime
  /// DateConverter.toDateTime('2024-01-15T14:30:00');
  /// DateConverter.toDateTime('15/01/2024');
  /// DateConverter.toDateTime('Jan 15, 2024');
  /// 
  /// // DateTime input returns as-is
  /// DateConverter.toDateTime(DateTime.now());
  /// ```
  static DateTime? toDateTime(dynamic input, {String? locale}) {
    try {
      // If already DateTime, return as-is
      if (input is DateTime) {
        return input;
      }
      
      // If String, parse it
      if (input is String) {
        if (input.isEmpty) return null;
        return _parseStringToDateTime(input, locale: locale??_locale);
      }
      
      log('toDateTime', 'Invalid input type: ${input.runtimeType}');
      return null;
    } catch (e) {
      log('toDateTime', 'Error converting to DateTime: $e');
      return null;
    }
  }

  /// Converts any date format (DateTime or String) to app format or custom format
  /// 
  /// [input] - Can be DateTime or String in any format
  /// [formatType] - Predefined app format type (date, time, dateTime)
  /// [customFormat] - Custom format string (e.g., 'dd/MM/yyyy', 'yyyy-MM-dd HH:mm')
  /// [locale] - Optional locale, defaults to app locale
  /// 
  /// Returns formatted string or empty string if conversion fails
  /// 
  /// Example usage:
  /// ```dart
  /// // Convert DateTime to app date format
  /// DateConverter.convertToFormat(DateTime.now(), formatType: AppFormatType.date);
  /// 
  /// // Convert String to app time format
  /// DateConverter.convertToFormat('2024-01-15T14:30:00', formatType: AppFormatType.time);
  /// 
  /// // Convert to custom format
  /// DateConverter.convertToFormat(DateTime.now(), customFormat: 'dd/MM/yyyy');
  /// ```
  static String convertToFormat(
    dynamic input, {
    AppFormatType? formatType,
    String? customFormat,
    String? locale,
  }) {
    try {
      DateTime? dateTime;
      
      // Convert input to DateTime
      dateTime = toDateTime(input, locale:  locale??_locale);
      if (dateTime == null) {
        log('convertToFormat', 'Failed to parse input: $input');
        return '';
      }

      // Determine output format
      String outputFormat;
      if (customFormat != null) {
        outputFormat = customFormat;
      } else if (formatType != null) {
          outputFormat = formatType.format;
      } else {
        // Default to app date format if nothing specified
        outputFormat = AppFormatType.date.format;
      }

      // Get locale
      final appLocale =  locale??_locale;
      
      // Format and return
      return DateFormat(outputFormat, appLocale).format(dateTime);
    } catch (e) {
      log('convertToFormat', 'Error converting format: $e');
      return '';
    }
  }

  /// Helper method to parse various string date formats to DateTime
  static DateTime? _parseStringToDateTime(String dateString, {String? locale}) {
    if (dateString.isEmpty) return null;
    
    final parseLocale = locale ?? _locale;
    
    // List of common date formats to try
    final formats = [
      'yyyy-MM-ddTHH:mm:ss.SSSZ',      // ISO 8601 with timezone
      'yyyy-MM-ddTHH:mm:ss.SSS',        // ISO 8601 with milliseconds
      'yyyy-MM-ddTHH:mm:ssZ',           // ISO 8601 with timezone
      'yyyy-MM-ddTHH:mm:ss',            // ISO 8601
      'yyyy-MM-dd HH:mm:ss',            // Standard format
      'yyyy-MM-dd hh:mm:ss',            // 12-hour format
      'yyyy-MM-dd HH:mm',               // Date and time without seconds
      'yyyy-MM-dd',                     // Date only
      'dd-MM-yyyy HH:mm:ss',            // European format with time
      'dd-MM-yyyy hh:mm a',             // European format with AM/PM
      'dd-MM-yyyy',                     // European date only
      'MM/dd/yyyy HH:mm:ss',            // US format with time
      'MM/dd/yyyy hh:mm a',              // US format with AM/PM
      'MM/dd/yyyy',                     // US date only
      'dd/MM/yyyy HH:mm:ss',            // UK format with time
      'dd/MM/yyyy hh:mm a',             // UK format with AM/PM
      'dd/MM/yyyy',                     // UK date only
      'MMM dd, yyyy',                   // App date format
      'MMM dd, yyyy hh:mm a',           // App date-time format
      'HH:mm:ss',                       // Time only 24h
      'hh:mm a',                        // Time only 12h with AM/PM
      'HH:mm',                          // Time only 24h without seconds
      'hh:mm',                          // Time only 12h without AM/PM
    ];

    // Try parsing with each format
    for (final format in formats) {
      try {
        final parsed = DateFormat(format, parseLocale).parse(dateString);
        return parsed.toLocal();
      } catch (e) {
        // Continue to next format
        continue;
      }
    }

    // Try DateTime.parse as last resort
    try {
      return DateTime.parse(dateString).toLocal();
    } catch (e) {
      log('_parseStringToDateTime', 'Failed to parse: $dateString');
      return null;
    }
  }

}
