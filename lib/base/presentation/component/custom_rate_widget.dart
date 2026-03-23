import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'component.dart';

class CustomRateWidget extends StatelessWidget {

  final num? _initialRating;
  final ValueChanged<double>? _onRatingUpdate;
  final bool _ignoreGestures;
  final double _iconSize;
  final num? _rateCount;
  final Color? _textColor;


  const CustomRateWidget({super.key,
    num? initialRating,
    Color? textColor,
    ValueChanged<double>? onRatingUpdate,
    bool ignoreGestures = true,
    double iconSize = 16,
    num? rateCount,
  })  : _initialRating = initialRating,
        _onRatingUpdate = onRatingUpdate,
        _ignoreGestures = ignoreGestures,
        _textColor = textColor,
        _rateCount = rateCount,
        _iconSize = iconSize;


  @override
  Widget build(BuildContext context) {
    if(_onRatingUpdate==null){
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          CustomSVGIcon(Assets.iconsStarIcon, height: _iconSize.r, width: _iconSize.r),
          AutoSizeText((_initialRating??0).toDouble().toString(),  style:   const TextStyle().semiBoldStyle(fontSize: 12).customColor(_textColor??AppColor.primaryColor.themeColor)),

          // HorizontalSpace(kFormPaddingAllSmall.w),

          // CustomIconText(title: (_initialRating??0).toDouble().toString(), iconData: Icons.star,iconColor: const Color(0xffFFBE4C),iconSize: 24.r,textStyle: const TextStyle().semiBoldStyle(fontSize: 12).customColor(const Color(0xffFFBE4C)),),
          if(_rateCount!=null)
            AutoSizeText('  ($_rateCount ${tr(LocaleKeys.review)})',style: const TextStyle().regularStyle(fontSize: 12).customColor( AppColor.hintColor.themeColor )),

        ],
      );
      // return  RatingBar(
      //   initialRating: (_initialRating?? 0).toDouble(),
      //   itemSize: _iconSize,
      //   minRating: 1,
      //   ignoreGestures: _ignoreGestures,
      //   direction: Axis.horizontal,
      //   allowHalfRating: false,
      //   itemCount: 5,
      //   itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      //   onRatingUpdate:(rate){},
      //   ratingWidget: RatingWidget(
      //     full: Icon(Icons.star_outlined, size: _iconSize, color: Colors.amber,),
      //     half: Icon(Icons.star_half, size: _iconSize, color: Colors.amber,),
      //     empty: Icon(Icons.star_border, size: _iconSize, color: Colors.grey,),
      //   ),
      // );
    }else{
      return  RatingBar(
        initialRating: (_initialRating?? 0).toDouble(),
        itemSize: _iconSize,
        minRating: 1,
        ignoreGestures: _ignoreGestures,
        direction: Axis.horizontal,
        allowHalfRating: false,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
        onRatingUpdate:_onRatingUpdate,
        ratingWidget: RatingWidget(
          full: Icon(CupertinoIcons.star_fill, size: _iconSize, color: Colors.amber,),
          half: Icon(CupertinoIcons.star_lefthalf_fill, size: _iconSize, color: Colors.amber,),
          empty: Icon(CupertinoIcons.star_fill, size: _iconSize, color: Colors.grey[300],),
        ),

      );
    }


  }

}
