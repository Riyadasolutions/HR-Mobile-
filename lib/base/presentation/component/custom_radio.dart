import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';



class CustomRadio<T> extends StatelessWidget {
  final String? _title;
  final T _value;
  final T? _groupValue;
  final ValueChanged<T> _onChanged;

  const CustomRadio({
    super.key,
    String? title,
    required T value,
    T? groupValue,
    required ValueChanged<T> onChanged,
  })  : _title = title,
        _value = value,
        _groupValue = groupValue,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    bool isSelected= _value== _groupValue&&_groupValue!=null;
    return Row(
      children: [
        GestureDetector(
          onTap: () => _onChanged(_value),
          child: Container(
            decoration: const BoxDecoration().circle().customColor(isSelected?Theme.of(context).primaryColorDark:Colors.transparent).borderStyle(color: isSelected?Colors.transparent:AppColor.textColor.themeColor),
            width: 20.r,
            height: 20.r,
            child: Center(child: Icon(Icons.done,color: Theme.of(context).cardColor,size: 14.r,)),

          ),
        ),


        // Radio<T>(
        //   value: _value,
        //   groupValue: _groupValue,
        //   onChanged: (value) => _onChanged(_value),
        // ),
        if(_title!=null)
          Expanded(child: Text(_title, style: const TextStyle().regularStyle().customColor( AppColor.hintColor.themeColor ), textAlign: TextAlign.start)),

      ],
    );
  }
}
