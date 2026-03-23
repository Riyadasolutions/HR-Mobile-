import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MediaCarousel extends StatefulWidget {
  final List<String> _sliders;
  final double _height;
  final double _radius;
  final bool _showIndicator;

  const MediaCarousel({
    super.key,
    required List<String> sliders,
    double? height ,
    bool showIndicator = false,
    double radius = kFormRadius,
  })  : _sliders = sliders,
        _radius = radius,
        _showIndicator = showIndicator,
        _height = height??144;

  @override
  _MediaCarouselState createState() => _MediaCarouselState();
}

class _MediaCarouselState extends State<MediaCarousel> {
  int _currentPage = 0;
  bool _isActive = false;
  bool _isDispose = false;
  double _scale = 1;

  _updateImage()async{
    if(_isDispose)return;
    // log('_updateImage', 'start ${_scale}');


    setState(() {_currentPage = (_currentPage==widget._sliders.length-1)?0:_currentPage+1; _scale=(_scale==1)?1.2:1; });
    await Future.delayed(Duration(seconds: 7));

    _updateImage();
  }


  // _updateImage1()async{
  //   log('_updateImage', 'start');
  //   await Future.delayed(Duration(seconds: 3)).then((value) {
  //     _isActive =false;
  //     if(_currentPage==widget._sliders.length-1){
  //       _currentPage=0;
  //     }else{
  //       _currentPage++;
  //     }
  //
  //   },);
  //   setState(() {  _isActive =false;   _scale=1; });
  //   await Future.delayed(Duration(seconds: 1));
  //
  //   setState(() {
  //     _scale=1.2;
  //     _isActive =true;
  //   });
  //   await Future.delayed(Duration(seconds: 3));
  //   _updateImage();
  // }

  @override
  void initState() {
    _isDispose=false;
    super.initState();
    _updateImage();
  }
  @override
  dispose(){
    _isDispose = true;
    super.dispose();
    log('_MediaCarouselState', 'dispose');
  }
  @override
  Widget build(BuildContext context) {
    // حالة صورة واحدة فقط
    if (widget._sliders.isNotEmpty && widget._sliders.length < 2) {
      return Container(
        color: Colors.black,
        width: double.infinity,
        height: widget._height,
        child: CustomImage(
          imageUrl: widget._sliders.first,
          width: deviceWidth,
          fit: BoxFit.cover,
          height: widget._height,
          canOpenImage: true,
          radius: widget._radius,
        ),
      );
    }

    // أكثر من صورة → كاروusel مع Zoom Out
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: widget._height,
      child: Column(
        children: <Widget>[

          AnimatedScale(
            scale: _scale,//_isActive ? 1.5 : 0.9, // Zoom out للصور الجانبية
            duration: Duration(seconds: 7),
            curve: Curves.easeOut,
            child: CustomImage(
              imageUrl: widget._sliders[_currentPage],
              width: deviceWidth,
              height: widget._height,
              canOpenImage: true,
              showHighlight: true,
              radius: widget._radius,
            ),
          ),


          // Expanded(
          //   child: Container(
          //     // color: Colors.green,
          //     child: CarouselSlider(
          //
          //       items: widget._sliders.asMap().entries.map((entry) {
          //         final index = entry.key;
          //         final singleSlider = entry.value;
          //         final bool isActive = index == _currentPage;
          //
          //         return AnimatedScale(
          //           scale: isActive ? 1.1 : 1, // Zoom out للصور الجانبية
          //           duration: const Duration(milliseconds: 5000),
          //           curve: Curves.easeOut,
          //           child: CustomImage(
          //             imageUrl: singleSlider,
          //             width: deviceWidth,
          //             height: widget._height,
          //             canOpenImage: true,
          //             showHighlight: true,
          //             radius: widget._radius,
          //           ),
          //         );
          //       }).toList(),
          //       options: CarouselOptions(
          //         height: widget._height,
          //         // دي أهم حاجة عشان تشوف جزء من الصورة اللي بعدها
          //         viewportFraction: 1,
          //         // خلي السلايد يفضل في النص
          //         enlargeCenterPage: false,
          //         // Scroll & AutoPlay
          //         enableInfiniteScroll: true,
          //         reverse: false,
          //         autoPlay: true,
          //         autoPlayInterval: const Duration(seconds: 3),
          //         autoPlayAnimationDuration: const Duration(milliseconds: 800),
          //         scrollDirection: Axis.horizontal,
          //         initialPage: _currentPage,
          //         onPageChanged: (pageNo, reason) {
          //           setState(() {
          //             _currentPage = pageNo;
          //           });
          //         },
          //       ),
          //     ),
          //   ),
          // ),


          if (widget._sliders.length > 1 && widget._showIndicator)...[
            VerticalSpace(kScreenPaddingNormal.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ...widget._sliders.asMap().entries.map((entry) {
                  final index = entry.key;
                  return Container(
                    width: 10.r,
                    height: 10.r,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: _currentPage == index
                          ? BoxShape.rectangle
                          : BoxShape.circle,
                      color: _currentPage == index
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColorLight,
                    ).circle(),
                  );
                }),
              ],
            ),
          ]

        ],
      ),
    );
  }
}
