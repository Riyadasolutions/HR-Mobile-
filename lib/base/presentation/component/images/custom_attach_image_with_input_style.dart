
import 'package:base_app/core/res/color.dart';
import 'package:base_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/decoration.dart';

import '../../../../../../core/res/values_manager.dart';
import '../component.dart';

class CustomAttachTopImageWithInputStyleView extends StatefulWidget {
  final String? _selectedImage;
  final String? _title;
  final String? _error;
  final String? _hint;
  final Function(String path) _onAttachImage;

  const CustomAttachTopImageWithInputStyleView({super.key,
    String? selectedImage,
    String? title,
    String? error,
    String? hint,
    required Function(String path) onAttachImage,
  })  : _selectedImage = selectedImage,
        _title = title,
        _error = error,
        _hint = hint,
        _onAttachImage = onAttachImage;

  @override
  State<CustomAttachTopImageWithInputStyleView> createState() => _CustomAttachTopImageWithInputStyleViewState();
}

class _CustomAttachTopImageWithInputStyleViewState extends State<CustomAttachTopImageWithInputStyleView> {
  final _tag = 'AttachTopImageView';
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _buildPictures(context, widget._selectedImage);
  }

  Widget _buildPictures(BuildContext context, String? selectedImage) {
    return Container(
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(kFormRadiusSmall))),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(kFormRadiusSmall)),
        child: selectedImage == null ? _buildEmptyImage(context) : CustomItemPickedImage(path: selectedImage),
      ),
    );
  }

  _buildEmptyImage(BuildContext context) {
    return CustomButtonArrow(
      error: widget._error,
      value: widget._selectedImage,
      color: Colors.white,
      label: widget._title,
      hint: widget._hint,
      selectWidget:Container(
        height: 36.r,
        width: 36.r,
        decoration: const BoxDecoration().cardStyle(radius: kFormRadiusSmall),
        child: CustomSVGIcon(Assets.iconsAttachImageIcon,width: 20.r,color:  AppColor.textColor.themeColor,),
      ),
      textColor: widget._selectedImage == null ? AppColor.textColor.themeColor :  Theme.of(context).inputDecorationTheme.labelStyle!.color,
      onTap: () => _attachImage(context),
    );
  }

  _attachImage(BuildContext context)async{
    if(widget._onAttachImage==null)return;
    showSelectAttachChatMethods(context,onAttachImage: (path)async{
      if (path.isNotEmpty) {
        setState(() {_isLoading= true;});
        await widget._onAttachImage!(path);
        setState(() {_isLoading = false;});
      }
    });
  }

  onRemoveServiceImagePressed(BuildContext context, String selectedImag) {}
}
