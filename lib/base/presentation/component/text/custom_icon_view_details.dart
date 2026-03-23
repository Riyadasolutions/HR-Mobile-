import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';

import 'package:base_app/generated/locale_keys.g.dart';
import '../component.dart';


class CustomIconViewDetails extends StatelessWidget {
  final String? _title;
  final GestureTapCallback? _onTap;

  const CustomIconViewDetails({super.key,
     String? title,
     GestureTapCallback? onTap,
  })  : _title = title,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_title??tr(LocaleKeys.seeAll),style:const TextStyle().regularStyle()),
          HorizontalSpace(kFormPaddingAllSmall.w),
          Icon(Icons.arrow_forward_ios,color: Theme.of(context).primaryColor,size: 12.r,),
        ],
      ),
    );
  }


}
