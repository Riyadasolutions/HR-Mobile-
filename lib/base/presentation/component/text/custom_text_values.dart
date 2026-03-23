import 'package:flutter/material.dart';
import 'package:base_app/core/res/resources.dart';




class CustomTextValuesWidget extends StatelessWidget {
  final List<TextValueData> _data;

  const CustomTextValuesWidget({
    required List<TextValueData> data,
  }) : _data = data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: _data.map((v) =>Text(v.title,style: TextStyle().regularStyle().customColor( AppColor.hintColor.themeColor ).heightStyle(height: 1.6))).toList()),
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: _data.map((v) =>Text(' : ',style: TextStyle().titleStyle().activeColor().heightStyle(height: 1.3))).toList()),
        Column(crossAxisAlignment: CrossAxisAlignment.start,children: _data.map((v) =>Text(v.value,style: TextStyle().regularStyle().heightStyle(height: 1.6))).toList()),
      ],
    );
  }
}
class TextValueData {
  final String _title;
  final String _value;

  const TextValueData({
    required String title,
    required String value,
  })  : _title = title,
        _value = value;

  String get value => _value;

  String get title => _title;
}