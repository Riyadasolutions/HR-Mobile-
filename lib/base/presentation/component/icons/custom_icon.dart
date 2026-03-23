import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

import '../custom_svg_icon.dart';

class CustomIcon extends StatelessWidget {
  final String? _assets;
  final Color? _color;
  final double? _height;
  final double? _width;
  final double? _size;
  final IconData? _iconData;


  const CustomIcon({super.key,
     String? assets,
     Color? color,
     double? height,
     double? width,
     double? size ,
     IconData? iconData,
  })
      : _assets = assets,
        _color = color,
        _height = height,
        _width = width,
        _size = size,
        _iconData = iconData;


  @override
  Widget build(BuildContext context) {
    if(_iconData!=null)return Icon(_iconData,color: _color, size: _size);
    if(_assets!=null){
     return _assets.endsWith('.svg')
          ? CustomSVGIcon(_assets, color: _color, height: _height??_size, width: _width??_size)
          :Image.asset(_assets,color: _color, height: _height??_size, width: _width??_size);
    }else{
      return const SizedBox();
    }

  }


// SizedBox(
  // Widget build(BuildContext context) => SizedBox(
  //     height: _size ?? _height ?? 24.r,
  //     width: _size ?? _width ?? 24.r,
  //     child: Center(
  //         child: SvgPicture.asset(
  //       _assets,
  //       height: _size ?? _height ?? 24.r,
  //       width: _size ?? _width ?? 24.r,
  //       color: _color,
  //     )));
}
