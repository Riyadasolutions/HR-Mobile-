import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';

import 'package:base_app/core/res/resources.dart';



class CustomCheckBox extends StatelessWidget {
  final String? _title;
  final bool _value;
  final Function(bool) _onChanged;

  const CustomCheckBox({
    super.key,
     String? title,
    required bool value,
    required Function(bool) onChanged,
  })  : _title = title,
        _value = value,
        _onChanged = onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => _onChanged(!_value),
          child: Container(
            decoration: const BoxDecoration()
                .radius(radius: 4)
                .customColor(_value ? Theme.of(context).primaryColor: Colors.transparent)
                .borderStyle(color: _value ? Colors.transparent : Theme.of(context).hintColor),
            width: 20.r,
            height: 20.r,
            child: Center(child: Icon(Icons.done,color: Theme.of(context).cardColor,size: 14.r,)),

          ),
        ),


        if(_title!=null)...[
          HorizontalSpace(kFormPaddingAllNormal.w),
          Text(_title, style: const TextStyle().regularStyle(fontSize: 12).primaryTextColor(), textAlign: TextAlign.start),

        ]

      ],
    );
  }
}
