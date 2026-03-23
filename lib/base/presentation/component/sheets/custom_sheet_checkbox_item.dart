import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';


class CustomSheetCheckboxItem extends StatelessWidget {
  final String _title;
  final String? _image;
  final bool _isSelected;
  final ValueChanged<bool> _onChanged;
  final IconData? _icon;
  final Color? _color;
  const CustomSheetCheckboxItem({
    required String title,
     String? image,
    required bool isSelected,
    required ValueChanged<bool> onChanged,
    IconData? icon,
    Color? color,
  })
      : _title = title,
        _image = image,
        _isSelected = isSelected,
        _onChanged = onChanged,
        _icon = icon,
        _color = color;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(vertical: kFormPaddingAllSmall.h),
      padding:  EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w/*,vertical: kFormPaddingAllSmall.h*/),
      decoration: BoxDecoration().customColor(_isSelected?Theme.of(context).primaryColorLight.withAlpha(5):Theme.of(context).cardColor).radius().borderStyle(color:_isSelected?Theme.of(context).primaryColor :Theme.of(context).highlightColor ),
      child: Row(
        children: [
          if(_image!=null)...[
            CustomImage(imageUrl: _image,  height: 40.h, width: 58.w, fit: BoxFit.fitWidth,showBorder:false ,),
            HorizontalSpace(kFormPaddingAllLarge.w)
          ],
          if(_icon!=null)...[
            Icon( _icon,  size: 24.h,color: _color,),
            HorizontalSpace(kFormPaddingAllLarge.w)
          ],
          Expanded(
            child: CheckboxListTile(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(horizontal: VisualDensity.minimumDensity),
              contentPadding: EdgeInsets.zero,
              dense: true,
              value: _isSelected,
              onChanged: (value) => _onChanged(value??false),
              title: Text(_title, style: const  TextStyle().semiBoldStyle(fontSize: 16).primaryTextColor()),
            ),
          ),
        ],
      ),
    );


  }


}
