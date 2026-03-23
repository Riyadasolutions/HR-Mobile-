import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';

class CustomIconCard extends StatelessWidget {
  final String? _assets;
  final IconData? _icon;
  final GestureTapCallback? _onTap;
  final Color? _color;
  final Color? _cardColor;
  final bool? _isLoading;
  final double? _iconSize;

  const CustomIconCard({
    super.key,
     bool? isLoading,
     String? assets,
     IconData? icon,
     GestureTapCallback? onTap,
     Color? color,
     double? iconSize,
     Color? cardColor,
  })  : _assets = assets,_icon = icon,_iconSize = iconSize,_color = color,_cardColor = cardColor,_isLoading = isLoading,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        // padding: EdgeInsets.all(kFormPaddingAllLarge.r),

        width: 40.r,
        height: 40.r,
        decoration: const BoxDecoration().customColor( _cardColor??Theme.of(context).cardColor.withOpacity(0.25)).radius(),
        child: _isLoading==true?CustomLoadingSpinner(size: 20.r,):GestureDetector(
          onTap: _onTap,
          child: _assets!=null?Center(child: CustomSVGIcon(_assets,width: _iconSize??24.r,color: _color)):_icon!=null?Icon(_icon,size: _iconSize??20.r,color: _color):const SizedBox(),
        ),
      ),
    );
  }
}
