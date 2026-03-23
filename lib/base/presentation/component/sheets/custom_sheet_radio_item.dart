import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';


class CustomSheetRadioItem<T> extends StatelessWidget {
  final String _title;
  final T _value;
  final T? _groupValue;
  final VoidCallback _onChanged;
  final String? _image;
  final IconData? _icon;
  final Color? _color;
  CustomSheetRadioItem({
    required String title,
    required T value,
     T? groupValue,
    required VoidCallback onChanged,
     String? image,
     IconData? icon,
     Color? color,
  })
      : _title = title,
        _value = value,
        _groupValue = groupValue,
        _onChanged = onChanged,
        _image = image,
        _icon = icon,
        _color = color;

  @override
  Widget build(BuildContext context) {
    bool isSelected = _groupValue == _value;

    return Container(
      margin:  EdgeInsets.symmetric(vertical: kFormPaddingAllSmall.h),
      padding:  EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w/*,vertical: kFormPaddingAllSmall.h*/),
      decoration: BoxDecoration().customColor(isSelected?Theme.of(context).primaryColorLight.withAlpha(5):Theme.of(context).cardColor).radius().borderStyle(color:isSelected?Theme.of(context).primaryColor :Theme.of(context).highlightColor ),
      child: Row(
        children: [
          if(_image!=null)...[
            CustomImage(imageUrl: _image,  height: 32.h, width: 32.w, fit: BoxFit.contain,showBorder:false ,),
            HorizontalSpace(kFormPaddingAllLarge.w)
          ],
          if(_icon!=null)...[
            Icon( _icon,  size: 24.h,color: _color,),
            HorizontalSpace(kFormPaddingAllLarge.w)
          ],
          Expanded(
            child: RadioListTile<T?>(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),

              // tileColor: AppColor.borderColor.themeColor,

              contentPadding: EdgeInsets.zero,
              dense: true,
              groupValue: _groupValue,
              title: Text(_title, style: const  TextStyle().semiBoldStyle(fontSize: 16).primaryTextColor()),
              value: _value,
              controlAffinity: ListTileControlAffinity.trailing,
              autofocus: true,
              activeColor: Theme.of(context).primaryColor,
              onChanged: (value) => _onChanged(),

            ),
          ),
        ],
      ),
    );


  }


}
