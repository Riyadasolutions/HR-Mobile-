import 'package:base_app/base/presentation/component/custom_loading_spinner.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageSliderScreen extends StatefulWidget {
  final List<String> _images;
  final int _currentIndex;
  const ImageSliderScreen({super.key,
    required List<String> images,
     int? currentIndex,
  })  : _images = images,
        _currentIndex = currentIndex??0;

  @override
  State<ImageSliderScreen> createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {

 late PageController _pageController ;
  @override
  void initState() {
    _pageController=PageController(initialPage: widget._currentIndex);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              gaplessPlayback: true,
              pageController: _pageController,
              builder: (context, index) => PhotoViewGalleryPageOptions(imageProvider: NetworkImage(widget._images[index]), gestureDetectorBehavior: HitTestBehavior.opaque, initialScale: PhotoViewComputedScale.contained * 1.0),
              itemCount: widget._images.length,
              loadingBuilder: (context, event) =>  Center(child: SizedBox(width: 20.0.w, height: 20.0.h, child: const CustomLoadingSpinner())),
            ),
            PositionedDirectional(
              top: 16.h,
              start: 16.w,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
