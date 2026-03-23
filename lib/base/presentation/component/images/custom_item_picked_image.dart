import 'dart:io';

import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/res/decoration.dart';

import '../../../../../../core/res/values_manager.dart';
import '../../../../../../core/utils/validators.dart';
import '../component.dart';

class CustomItemPickedImage extends StatelessWidget {
  final String? _path;
  final bool? _isLoading;
  final GestureTapCallback? _onRemovePressed;
  const CustomItemPickedImage({super.key,
    String? path,
    bool isLoading = false,
    GestureTapCallback? onRemovePressed,
  })  : _path = path,
        _isLoading = isLoading,
        _onRemovePressed = onRemovePressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: _onRemovePressed,
      child: Container(
        decoration: const BoxDecoration().listStyle(),
        height: 150,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Validators.isURL(_path) || _path == null
                ? CustomImage(imageUrl: _path, height: 150,radius: kFormRadius,canOpenImage: _onRemovePressed==null,)
                : ClipRRect(borderRadius:const BorderRadius.all(Radius.circular(kFormRadius)),child: Image.file(File(_path), fit: BoxFit.cover,)),


            if( _onRemovePressed != null)...[
              Container(
                  decoration: BoxDecoration(
                    borderRadius:const BorderRadius.all(Radius.circular(kFormRadius)),
                    color: Colors.black45.withOpacity(.3),
                  )
              ),
              if(!(_isLoading??false))
                const Icon(Icons.clear, color: Colors.white, size: kTextFieldIconSize),

              if(_isLoading??false)
                CustomLoadingSpinner(size: 20.r)
            ]
          ],
        ),
      ),
    );
  }


}
