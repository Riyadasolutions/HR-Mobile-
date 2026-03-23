import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:base_app/core/extensions/num_extensions.dart';

import 'package:base_app/core/res/resources.dart';
import '../../../../generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'component.dart';



class CustomNoDataView extends StatelessWidget {
  final String?  _title;
  final String? _desc;
  final String? _image;
  final String _imageSvg;
  final double _padding;
  final VoidCallback? _onReload;

  const CustomNoDataView({super.key,
    String? title ,
    String? desc,
    String? image,
    double padding = kFormPaddingHorizontal,
    VoidCallback? onReload,

    String imageSvg=Assets.emptyStateNoData,
  })  : _title = title,
        _padding = padding,
        _onReload = onReload,
        _desc = desc,
        _image = image,
        _imageSvg = imageSvg;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.all(_padding.r),
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center, children: [
           (_image != null)? Image.asset(_image) : SvgPicture.asset(_imageSvg, width: 240.w, height: 240.h, fit: BoxFit.fill),
          // const VerticalSpace(kFormPaddingAllLarge),
          Text(_title??tr( LocaleKeys.noResultFound), style: const TextStyle().semiBoldStyle(fontSize: 20).primaryTextColor(), textAlign: TextAlign.center),
          if(_desc != null)...[
            VerticalSpace(kFormPaddingAllSmall.h),
            Text(_desc??'', style: const TextStyle().regularStyle(fontSize: 16).primaryTextColor(), textAlign: TextAlign.center),
          ],

          if(_onReload != null)...[
            VerticalSpace(kFormPaddingAllLarge.h),
            CustomButton(onTap: _onReload , title: tr(LocaleKeys.retry),width: 200.w,isOutlined: true,color: Theme.of(context).hintColor,textColor: Theme.of(context).hintColor),

          ],

          ],
        ),
      ),
    );
  }
}
