import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/common/presentation/modules/layout/layout_view_model.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BookingView extends StatelessWidget {
  final int _count;
  const BookingView({super.key,
    required int count,
  }) : _count = count;
  @override
  Widget build(BuildContext context) {

  return  GestureDetector(
    onTap: () => Provider.of<LayoutViewModel>(context, listen: false).setCurrentIndex(2),
    child: Container(
      height: 56.h,
     margin: EdgeInsets.only(top: kFormPaddingAllLarge.h),
     decoration: const BoxDecoration().borderStyle(color: Theme.of(context).primaryColor).customColor(Theme.of(context).primaryColorLight.withOpacity(0.2)).radius(),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
           children: [
             Expanded(
               child: RichText(
                 maxLines: 1,
                 text: TextSpan(
                   children: [
                     TextSpan(
                       text: '${tr(LocaleKeys.myBookings)} ',
                       style: const TextStyle().semiBoldStyle(fontSize: 18).primaryTextColor().heightStyle(height: 1.4),
                     ),
                       TextSpan(
                         text: '($_count ${tr(LocaleKeys.bookings)})',
                         style: const TextStyle().regularStyle(fontSize: 14).customColor( AppColor.hintColor.themeColor ).heightStyle(height: 1.4),
                       ),
                   ],
                 ),
               ),
             ),
             Container(
               width: 32.r,
               height: 32.r,
               decoration: const BoxDecoration().customColor(Theme.of(context).primaryColor).radius(radius: kFormPaddingAllNormal),

               child: Icon(context.locale.languageCode=='ar'?Icons.keyboard_double_arrow_left_rounded:Icons.keyboard_double_arrow_right_rounded,color: Theme.of(context).cardColor,),
               // child: Icon(Icons.arrow_forward_ios_sharp,color: Theme.of(context).cardColor,),
               // child: SvgPicture.asset(Assets.iconsNextIcon,color: Theme.of(context).cardColor,),
             )

           ],
              ),
        )),
  );
  }


}
