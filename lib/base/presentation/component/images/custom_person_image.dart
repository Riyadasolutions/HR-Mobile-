import 'dart:io';

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/utils/validators.dart';
import '../../../../generated/assets.dart';


class CustomPersonImage extends StatefulWidget {
  final String? _imageUrl;
  final String _avatar;
  final String? _error;
  final double _borderSize;
  final double _radius;
  final double _size;
  final bool _canEdit;
  final bool _showShadow;
  final bool _isLoading;
  final Function(String path)? _onAttachImage;
  final Function()? _onEditClick;
  final String? _title;
  final BoxFit _fit;
  const CustomPersonImage({
    super.key,
    String? imageUrl,
    String avatar=Assets.imagesImagesUserAvatarPlaceholder,
    String? error,
    String? title,
    double borderSize = 1,
    double size = 100,
    double radius = 160,
    bool canEdit = false,
    bool showShadow = false,
    bool isLoading = false,
    Function(String path)? onAttachImage,
    BoxFit fit = BoxFit.contain,
    Function()? onEditClick,
  })  : _imageUrl = imageUrl,
        _avatar = avatar,
        _borderSize = borderSize,
        _title = title,
        _error = error,
        _fit = fit,
        _radius = radius,
        _size = size,
        _isLoading = isLoading,
        _showShadow = showShadow,
        _canEdit = canEdit,
        _onEditClick = onEditClick,
        _onAttachImage = onAttachImage;

  @override
  State<CustomPersonImage> createState() => _CustomPersonImageState();
}

class _CustomPersonImageState extends State<CustomPersonImage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // log('CustomPersonImage', widget._imageUrl.toString());
    return SizedBox(
      width: widget._size.r,
      height: widget._size.r,
      child: Center(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              width: widget._size.r,
              height: widget._size.r,
              // margin: EdgeInsets.all(kFormPaddingAllNormal.r),
              decoration: BoxDecoration(

                border: Border.all(width: widget._borderSize, color: widget._error!=null?Theme.of(context).colorScheme.error:Theme.of(context).dividerColor),
                boxShadow:widget._showShadow? [BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1), offset: const Offset(0, 10),)]:null,
                // shape: BoxShape.circle,
              ).radius(radius: widget._radius).customColor(Theme.of(context).cardColor)/*.radius(radius: _radius)*/,

              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget._radius),
                child: (widget._imageUrl ?? '' ).isEmpty
                    ? _buildPlaceholder(context)
                    : widget._imageUrl!.endsWith('.svg') &&  widget._imageUrl!.startsWith('assets/')
                    ? Center(child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset( widget._imageUrl! ,width: widget._size.r, height: widget._size.r)))
                    : widget._imageUrl!.startsWith('assets/')
                    ? Image.asset( widget._imageUrl! ,width: widget._size.r, height: widget._size.r, fit: widget._fit)
                    : !Validators.isURL( widget._imageUrl)
                    ? Image.file(File( widget._imageUrl!), width: widget._size.r, height: widget._size.r, fit: widget._fit)
                    : widget._imageUrl!.endsWith('.svg')
                    ? SvgPicture.network( widget._imageUrl! ,width: widget._size.r, height: widget._size.r, fit: widget._fit)
                    : CachedNetworkImage(
                  placeholder: (ctx, url) => _buildPlaceholder(context),
                  width:widget._size.r,
                  height: widget._size.r,
                  fit: widget._fit,
                  imageUrl:  widget._imageUrl ?? '',
                  errorWidget: (c, o, s) => _buildPlaceholder(context),
                ),
                // child: (widget. _imageUrl ?? '' ).isEmpty
                //     ? _buildPlaceholder(context)
                //     : widget._imageUrl!.endsWith('.svg')
                //     ? SvgPicture.network(widget._imageUrl! ,width:  widget._size.r , height:  widget._size.r )
                //     : widget._imageUrl!.contains('assets/images/') &&  !Validators.isURL(widget._imageUrl)
                //     ? Image.asset(widget._imageUrl! ,width: widget._size.r , height:  widget._size.r )
                //     : !Validators.isURL(widget._imageUrl)
                //     ? Image.file(File(widget._imageUrl!), width:  widget._size.r , height:  widget._size.r , fit: BoxFit.fill)
                //     : CachedNetworkImage(placeholder: (ctx, url) => _buildPlaceholder(context), width: widget._size.r, height: widget._size.r, fit: BoxFit.cover, imageUrl: widget._imageUrl!, errorWidget: (c, o, s) => _buildPlaceholder(context),),
              ),
            ),
            if (widget._canEdit)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: const BoxDecoration().radius(radius: widget._radius).customColor(Theme.of(context).primaryColor),
                  child: widget._isLoading? CustomLoadingSpinner(color: Theme.of(context).cardColor):Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () =>_attachImage(context),
                      borderRadius: BorderRadius.circular(widget._radius),
                      child:  CustomSVGIcon(Assets.iconsEditImageIcon,width: 16.r,height: 16.r,),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _attachImage(BuildContext context)async{
    if(widget._onAttachImage==null)return;
    showSelectAttachChatMethods(context,title:widget._title,onAttachImage: (path)async{
      if (path.isNotEmpty) {
        setState(() {_isLoading= true;});
        await widget._onAttachImage!(path);
        setState(() {_isLoading = false;});
      }
    });
  }

  Widget _buildPlaceholder(BuildContext context){
    return Center(
      child: Container(
        decoration: const BoxDecoration().cardStyle(radius: widget._radius),
        width: widget._size.r,
        height:widget._size.r,
        child: Center(child: SvgPicture.asset(widget._avatar, fit: widget._fit),
        ),
      ),
    );
  }
}
