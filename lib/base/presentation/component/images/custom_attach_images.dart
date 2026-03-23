
import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../component.dart';

class CustomAttachImagesView extends StatefulWidget {
  final List<String>? _selectedImages;
  final String? _selectedImage;
  final bool _isMultiChoice;
  final bool _isRequired;
  final bool _loading;

  final double _height;
  final double _width;
  final String? _error;
  final String? _title;
  final Function(String path)? _onAttachImage;
  final Function(int index)? _onRemoveImage;

  const CustomAttachImagesView({super.key,
    List<String>? selectedImages,
    String? selectedImage,
    bool isMultiChoice = false,
    bool loading = false,
    bool isRequired = false,
    double height = 150,
    double width = 150,
    String? error,
    String? title,
    Function(String path)? onAttachImage,
    Function(int index)? onRemoveImage,
  })  : _selectedImages = selectedImages,
        _height = height,
        _loading = loading,
        _isRequired = isRequired,
        _selectedImage = selectedImage,
        _isMultiChoice = isMultiChoice,
        _width = width,
        _error = error,
        _title = title,
        _onRemoveImage = onRemoveImage,
        _onAttachImage = onAttachImage;

  @override
  State<CustomAttachImagesView> createState() => _CustomAttachImagesViewState();
}

class _CustomAttachImagesViewState extends State<CustomAttachImagesView> {
  final _tag = 'AttachTopImageView';

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(widget._title!=null)...[
          Row(
            children: [
              Text(widget._title!,style:Theme.of(context).inputDecorationTheme.labelStyle!),
             if(widget._isRequired) Text(' ( ${tr(LocaleKeys.msgFormFieldRequired)} )',style:Theme.of(context).inputDecorationTheme.errorStyle!),
            ],
          ),
          VerticalSpace(kFormPaddingAllLarge.h),
        ],

        if((widget._selectedImages ?? []).isNotEmpty && widget._isMultiChoice ) _buildPictureList(context, widget._selectedImages ?? [])
        else if(widget._selectedImage != null && !widget._isMultiChoice) _buildPicture(context, widget._selectedImage!)
        else if(widget._onAttachImage==null )_buildNoImage(context)
        else _buildEmptyImage(context),


      ],
    );
  }

  Widget _buildPicture(BuildContext context, String image) {
    return Container(
      decoration: const BoxDecoration().radius().borderStyle(),
      padding: EdgeInsets.all(kFormPaddingAllLarge.r),
      child: CustomItemPickedImage(
        path:image,
        onRemovePressed:widget._onRemoveImage==null?null:() async{
          if(  widget._onRemoveImage != null){
            setState(() {_isLoading= true;});
            await widget._onRemoveImage!(0);
            setState(() {_isLoading = false;});
          }
        },
      ),
    );
  }

  Widget _buildPictureList(BuildContext context, List<String> images) {
    return Container(
      decoration: const BoxDecoration().radius().borderStyle(),
      padding: EdgeInsets.all(kFormPaddingAllLarge.r),
      child: CustomGridAnimatorData(
        itemCount: widget._onAttachImage == null ? images.length : images.length + 1,
        width: widget._width.w,
        height: widget._height.h,
        itemBuilder: (context, index) {
          if(widget._onAttachImage!=null&&index==0){
            return CustomTapEffect(
              onTap: () => _attachImage(context),
              child: Container(
                decoration: const BoxDecoration().radius().borderStyle(),
                alignment: Alignment.center,
                child: SvgPicture.asset(Assets.iconsUploadImageIcon),
              ),
            );
          } else {
            return CustomItemPickedImage(
              path:widget._onAttachImage==null?images[index]: images[index - 1],
                onRemovePressed:widget._onRemoveImage==null?null:() async{
                  if(  widget._onRemoveImage != null){
                    setState(() {_isLoading= true;});
                    await widget._onRemoveImage!(index - 1);
                    setState(() {_isLoading = false;});
                  }
                },
            );
          }
        },
      ),
    );
  }

  _buildNoImage(BuildContext context) {
    return Container(
      height: widget._height.h,
      padding: EdgeInsets.all(kFormPaddingAllSmall.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: widget._error!=null?Theme.of(context).colorScheme.error:Theme.of(context).hintColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Center(
          child: AutoSizeText(tr(LocaleKeys.noImages), style: const TextStyle().regularStyle(fontSize: 12).primaryTextColor(), maxLines: 1),
        ),
      ),
    );

  }
  _buildEmptyImage(BuildContext context) {
    return GestureDetector(
      onTap: () => _attachImage(context),
      child: Container(
        height: widget._height.h,
        padding: EdgeInsets.all(kFormPaddingAllSmall.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: widget._error!=null?Theme.of(context).colorScheme.error:Theme.of(context).hintColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          child: Center(
            child: SizedBox(
              height: widget._height.h,
              width: widget._width.w,
              child:widget._loading||_isLoading? CustomLoadingSpinner(size: 32.r): Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(Assets.iconsUploadImageIcon),
                  VerticalSpace(kFormPaddingAllLarge.h),
                  Text(tr(LocaleKeys.selectImageMessage),style: const TextStyle().regularStyle().customColor( AppColor.hintColor.themeColor ),),
                ],
              ),
            ),
          ),
        ),
      ),
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
}
