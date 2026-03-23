import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final String _title;
  final String? _icon;
  final int _maxLines;
  final IconData? _iconData;
  final Color? _iconColor;
  final double _iconSize;
  final Color? _textColor;
  final Color? _activeTrackColor;
  final MainAxisAlignment _mainAxisAlignment;
  final MainAxisSize _mainAxisSize;
  final TextStyle? _textStyle;
  final bool _isExpanded;
  final bool _isShowStatus;


  final bool _value;
  final ValueChanged<bool> _onChanged;



  @override
  _CustomSwitchState createState() => _CustomSwitchState();

  const CustomSwitch({super.key,
    required bool value,
    required ValueChanged<bool> onChanged,
    String? title,
    String? icon,
    Color? iconColor,
    Color? activeTrackColor,
    IconData? iconData,
    int maxLines =1,
    double iconSize =20,
    Color? textColor,
    bool? isExpanded ,
    bool? isShowStatus ,
    TextStyle? textStyle,
    MainAxisSize? mainAxisSize,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,

  })  : _title = title??'',
        _icon = icon,
        _iconSize = iconSize,
        _onChanged = onChanged,
        _activeTrackColor = activeTrackColor,
        _mainAxisSize = mainAxisSize??MainAxisSize.max,
        _isExpanded = isExpanded??false,
        _isShowStatus = isShowStatus??false,
        _iconData = iconData,
        _textStyle = textStyle,
        _maxLines = maxLines,
        _textColor = textColor,
        _mainAxisAlignment = mainAxisAlignment,
        _iconColor = iconColor,_value = value;

}

class _CustomSwitchState extends State<CustomSwitch>{



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        if(widget._isExpanded)Expanded(child: CustomIconText(title: widget._title, icon: widget._icon, iconColor:  widget._iconColor, iconData:  widget._iconData, maxLines:  widget._maxLines, iconSize:  widget._iconSize, textColor:  widget._textColor, isExpanded:  widget._isExpanded, textStyle:  widget._textStyle, mainAxisSize:  widget._mainAxisSize, mainAxisAlignment:  widget._mainAxisAlignment)),
        if(!widget._isExpanded)CustomIconText(title: widget._title, icon: widget._icon, iconColor:  widget._iconColor, iconData:  widget._iconData, maxLines:  widget._maxLines, iconSize:  widget._iconSize, textColor:  widget._textColor, isExpanded:  widget._isExpanded, textStyle:  widget._textStyle, mainAxisSize:  widget._mainAxisSize, mainAxisAlignment:  widget._mainAxisAlignment),
        if(widget._isShowStatus)...[
          HorizontalSpace(kFormPaddingAllSmall.w),
          Text(widget._value?tr(LocaleKeys.active):tr(LocaleKeys.inActive),style: const TextStyle().regularStyle().primaryTextColor(),)
        ],
        Transform.scale(

          scale: 0.9,
          child: Switch(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            // value: kAccountType ==AccountType.user,
            value: widget._value,
            onChanged: widget._onChanged,

            activeColor: Colors.white,
            activeTrackColor: widget._activeTrackColor??Theme.of(context).primaryColor,
            inactiveTrackColor:const Color(0xffDED9DA) ,
            focusColor: Colors.white,
            inactiveThumbColor: Colors.white,
            activeThumbImage: const AssetImage(Assets.iconsDoneIcon),
            inactiveThumbImage: const AssetImage(Assets.iconsCloseIcon),
            thumbColor: MaterialStateProperty.all(   Theme.of(context).cardColor),
            overlayColor: MaterialStateProperty.all(   Theme.of(context).cardColor),
            trackOutlineColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
              return states.contains(MaterialState.selected)
                  ?  widget._activeTrackColor??Theme.of(context).primaryColor
                  : const Color(0xffDED9DA);
            }),
            hoverColor: Theme.of(context).cardColor,
          ),
        )
        // Switch.adaptive(
        //   activeColor: Theme.of(context).primaryColor,
        //   value: widget._value,
        //   onChanged: widget._onChanged,
        // ),


      ],
    );
  }
}