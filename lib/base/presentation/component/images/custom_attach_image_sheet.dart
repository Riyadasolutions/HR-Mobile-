import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/sheets/widgets/bar_widget.dart';
import 'package:base_app/base/presentation/sheets/widgets/close_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/generated/locale_keys.g.dart';



class _CustomAttachImageSheet extends StatefulWidget {
  final ValueChanged<String> _onAttachImage;
  final String? _title;


  @override
  State<_CustomAttachImageSheet> createState() => __CustomAttachImageSheetState();

  const _CustomAttachImageSheet({
    required ValueChanged<String> onAttachImage,
    required String? title,
  })  : _onAttachImage = onAttachImage,
        _title = title;
}

class __CustomAttachImageSheetState extends State<_CustomAttachImageSheet> {
  final pickerQu = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 120,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: kFormPaddingAllLarge.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            VerticalSpace(kFormPaddingAllLarge.h),
            const SheetBarWidget(),
            Align(alignment: AlignmentDirectional.centerEnd,child: SheetCloseWidget(onTap: ()=>NavigationService.goBack())),
            VerticalSpace(kFormPaddingAllLarge.h),
            if(widget._title!=null)
              Text(widget._title!,style: const TextStyle().semiBoldStyle(fontSize: 20).primaryTextColor()),

            VerticalSpace(kScreenPaddingLarge.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildItem(title: tr(LocaleKeys.camera), icon: Assets.iconsCameraIcon, onTap:_takesPhoto),
                _buildItem(title: tr(LocaleKeys.gallery), icon: Assets.iconsGalleryIcon, onTap:_fromGallery),
              ],
            ),
            VerticalSpace(kScreenPaddingLarge.h),

            // ListTile(
            //   leading: const Icon(Icons.photo_library),
            //   title: Text(tr(LocaleKeys.gallery)),
            //   onTap: _fromGallery,
            // ),
            // ListTile(
            //   leading: const Icon(Icons.photo_camera),
            //   title: Text(tr(LocaleKeys.camera)),
            //   onTap: _takesPhoto,
            // ),
          ],
        ),
      ),
    );
  }
  _buildItem({required String title , required String icon, required VoidCallback onTap})=>GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 64.r,
          height: 64.r,
          decoration: const BoxDecoration().cardStyle(),
          child: CustomSVGIcon(icon,size: 32.r,color: AppColor.textColor.themeColor,),
        ),
        VerticalSpace(kFormPaddingAllLarge.h),
        Text(title,style: const TextStyle().regularStyle().primaryTextColor()),

      ],
    ),
  );

  _takesPhoto() async {
    final pickedFile = await pickerQu.pickImage(source: ImageSource.camera);
    if (pickedFile!=null) {
      NavigationService.goBack();
      widget._onAttachImage(pickedFile.path);
    }
  }

  Future<dynamic> _fromGallery() async {
    log('_fromGallery', '_fromGallery');
    final pickedFile = await pickerQu.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      NavigationService.goBack();
      widget._onAttachImage(pickedFile.path);
    }
  }

}

showSelectAttachChatMethods(BuildContext context,{ String? title,required ValueChanged<String> onAttachImage}){
  FocusScope.of(context).unfocus();

  showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return _CustomAttachImageSheet(onAttachImage: onAttachImage,title: title);
      });
}