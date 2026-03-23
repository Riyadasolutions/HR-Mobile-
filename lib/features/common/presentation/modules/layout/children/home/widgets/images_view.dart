import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/routing/navigation_services.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class HomeImagesSliderView extends StatelessWidget {
  final String _image;
  final List<String> _gallery;
  const HomeImagesSliderView({super.key,
    required String image,
    required List<String> gallery,
  })  : _image = image,
        _gallery = gallery;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _gallery.isNotEmpty? 335.h: 300.h ,
      color:  Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // SizedBox( height: 335.h, width: 375.w,),
          Positioned(
            top: 0,
            bottom: _gallery.isNotEmpty? 33.h:0,
            left: 0,
            right: 0,
            child: CustomImage(
              // border: Border.all(width: 10,color: AppColor.textColorLite.themeColor),
              showBorder: false,
              radius: kFormRadius,
              fit: BoxFit.fill,
              height: deviceHeight,
              width: deviceWidth,
              imageUrl: _image,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                // height: 375.h,
                width: deviceWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(_gallery.isNotEmpty)...[
                      _buildImage(context, 0),

                      // CustomImage(width: 75.r,height: 75.r,imageUrl: _gallery[0],border: Border.all(width: 2,color: Theme.of(context).cardColor)),
                      HorizontalSpace(kFormPaddingAllNormal.w),
                    ],
                    if(_gallery.length>1)...[
                      _buildImage(context, 1),

                      // CustomImage(width: 75.r,height: 75.r,imageUrl: _gallery[1],border: Border.all(width: 2,color: Theme.of(context).cardColor)),
                      HorizontalSpace(kFormPaddingAllNormal.w),
                    ],
                    if((_gallery).length>2)...[
                      _buildImage(context, 2),

                      // CustomImage(width: 75.r,height: 75.r,imageUrl: _gallery[2],border: Border.all(width: 2,color: Theme.of(context).cardColor)),
                      HorizontalSpace(kFormPaddingAllNormal.w),

                    ],
                    if(_gallery.length>3)...[
                      GestureDetector(
                        onTap: () => NavigationService.push(CommonRoutes.imageSliderScreen, arguments: {'images': _gallery, 'index': 3}),

                        child: Stack(
                          children: [
                            _buildImage(context, 3),
                            // CustomImage(width: 75.r,height: 75.r,imageUrl: _gallery[3],border: Border.all(width: 2,color: Theme.of(context).cardColor)),
                            Container(width: 75.r,height: 75.r,decoration: const BoxDecoration().radius().customColor(Colors.black.withOpacity(0.2)),alignment: Alignment.center,
                              child: Text('+${_gallery.length}\n${tr(LocaleKeys.images)}',style: const TextStyle().titleStyle(fontSize:14 ).colorWhite(),textAlign: TextAlign.center,),)
                          ],
                        ),
                      ),

                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildImage(context,int index) =>
      GestureDetector(
          onTap: () => NavigationService.push(CommonRoutes.imageSliderScreen, arguments: {'images': _gallery, 'index': index}),
          child: CustomImage(width: 75.r,
            height: 75.r,
            imageUrl: _gallery[index],
            border: Border.all(width: 2, color: Theme.of(context).cardColor),
          ),
      );






}
