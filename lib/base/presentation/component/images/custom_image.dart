import 'dart:io';

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/color.dart';
import 'package:base_app/core/res/decoration.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/res/values_manager.dart';
import '../../../../../../core/utils/validators.dart';
import '../../../../generated/assets.dart';

class CustomImage extends StatelessWidget {
  final double _radius;
  final BorderRadiusGeometry? _borderRadius;
  final Border? _border;
  final Color? _svgImageColor;
  final Color? _backgroundColor;

  final double? _width;
  final double _height;

  final String? _imageUrl;
  final String _placeholder;
  final String? _error;
  final BoxFit? _fit;

  final bool _canEdit;
  final bool _showHighlight;
  final bool _showPlaceholder;
  final bool _showBorder;
  final bool _canOpenImage;

  final Function(String path)? _onAttachImage;


  const CustomImage({super.key,
    double radius = kFormRadiusSmall,
    BorderRadiusGeometry? borderRadius,
    Border? border,
    double? width,
    double height = 140,
    String? imageUrl,
    String? error,
    BoxFit? fit = BoxFit.fill,
    Color? svgImageColor,
    String placeholder =Assets.imagesPlaceholder,
    Color? backgroundColor,
    bool canEdit = false,

    bool showHighlight = false,
    bool canOpenImage = false,
    bool showPlaceholder = true,
    bool showBorder = false,
    Function(String path)? onAttachImage,
  })  : _radius = radius,
        _borderRadius = borderRadius,
        _border = border,
        _width = width,
        _height = height,
        _imageUrl = imageUrl,
        _showHighlight = showHighlight,
        _error = error,
        _fit = fit,
        _canOpenImage = canOpenImage,
        _canEdit = canEdit,
        _svgImageColor = svgImageColor,
        _backgroundColor =backgroundColor,
        _placeholder = placeholder,
        _showPlaceholder = showPlaceholder,
        _showBorder = showBorder,
        _onAttachImage = onAttachImage;

  @override
  Widget build(BuildContext context) {
    // log('zzzzzzzzzzzzzzzzz', '$_imageUrl ::::${_imageUrl!.startsWith('assets/').toString()}');

    return  SizedBox(
      width: _width,
      height: _height,
      child: GestureDetector(
        onTap: (_canOpenImage && _imageUrl!=null)? (){Navigator.pushNamed(context, CommonRoutes.imageSliderScreen, arguments: {'images':[_imageUrl]});}:null,

        child: Stack(
          fit: StackFit.expand,
          children:[

            Container(
            width: _width,
            height: _height,
            decoration: const BoxDecoration().customColor(_backgroundColor)
                  .borderStyle(color: _error != null ? Theme.of(context).colorScheme.error : _showBorder ? Theme.of(context).hintColor : Colors.transparent,width: _showBorder?1:0).borderAll(border: _border)
                  .customRadius(borderRadius: _borderRadius ?? BorderRadius.all(Radius.circular(_radius))),
            child: ClipRRect(
              borderRadius: _borderRadius ?? BorderRadius.all(Radius.circular(_radius)),
              child: (_imageUrl ?? '' ).isEmpty
                    ? _buildPlaceholder(context)
                    : _imageUrl!.endsWith('.svg') && _imageUrl.startsWith('assets/')
                    ? Center(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset(_imageUrl ,width: _width ?? deviceWidth, height: _height,color: _svgImageColor)))
                    :_imageUrl.startsWith('assets/')
                    ? Image.asset(_imageUrl ,width: _width ?? deviceWidth, height: _height,color: _svgImageColor,fit:_fit)
                    : !Validators.isURL(_imageUrl)
                    ? Image.file(File(_imageUrl), width: _width ?? deviceWidth, height: _height,fit:_fit)
                    // ? Container(color:  Colors.red,width: _width ?? deviceWidth, height: _height)//Image.asset(_imageUrl ,width: _width ?? deviceWidth, height: _height,color: _svgImageColor)
                    :_imageUrl.endsWith('.svg')
                    ? SvgPicture.network(_imageUrl ,width: _width ?? deviceWidth, height: _height,color: _svgImageColor,fit:_fit??BoxFit.contain)
                    : CachedNetworkImage(
                      placeholder: (ctx, url) => _buildPlaceholder(context),
                      width:_width ?? deviceWidth,
                      height: _height,
                      fit: _fit,
                      imageUrl: _imageUrl ?? '',
                      errorWidget: (c, o, s) => _buildPlaceholder(context),
                    ),
            ),
          ),

          if(_showHighlight)
            Container(     width: _width,decoration: const BoxDecoration().gradientStyle(gradient: getImageGradient(),isEnable: _showHighlight)
                .customRadius(borderRadius: _borderRadius ?? BorderRadius.all(Radius.circular(_radius))), ),
          if (_canEdit)
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                height: 32.r,
                width: 32.r,
                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 3, color: Theme.of(context).scaffoldBackgroundColor), color: Theme.of(context).primaryColor),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _attachImage(context),
                    // onTap: () async {
                    //   String? path = await onPickImagesPressed(context);
                    //   if (path != null && _onAttachImage != null) {_onAttachImage(path);}
                    // },
                    borderRadius: BorderRadius.circular(100),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],),
      ),
    );
  }
  _attachImage(BuildContext context)async{
    if(_onAttachImage==null)return;
    showSelectAttachChatMethods(context,onAttachImage: (path)async{
      if (path.isNotEmpty) {
        await _onAttachImage(path);
      }
    });
  }
  _buildPlaceholder(BuildContext context) {
    return _showPlaceholder
        ?  _onAttachImage != null?SizedBox(
            height: _height,
            width: _width ?? deviceWidth,
            // padding: EdgeInsets.all(kScreenPaddingNormal.r),
            child: Center(
                    child: GestureDetector(
                        onTap: () => _attachImage(context),
                        // onTap: () async {
                        //   String? path = await onPickImagesPressed(context);
                        //   if (path != null && _onAttachImage != null) { _onAttachImage(path); }
                        // },
                        child: Image.asset(_placeholder, width: _width ?? deviceWidth, height: _height, fit: BoxFit.fill))),
          ): Image.asset(_placeholder, width: _width ?? deviceWidth, height: _height, fit: BoxFit.fill)
        : const SizedBox();
  }
}
