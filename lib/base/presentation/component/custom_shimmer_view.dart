import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmerView extends StatelessWidget {
  final int _itemCount;
  final bool _isGrid; // Toggle between list and grid
  final Color? _baseColor;
  final Color? _highlightColor;
  final Axis _scrollDirection;
  final double _height;

  const CustomShimmerView({super.key,
    int itemCount = 6,
    bool isGrid = false,
    Color? baseColor,
    Color? highlightColor,
    // Color baseColor = const Color(0xFFE0E0E0),
    // Color highlightColor= const Color(0xFFF5F5F5),
    Axis scrollDirection = Axis.vertical,
    double height = 228,
  })  : _itemCount = itemCount,
        _height = height,
        _isGrid = isGrid,
        _scrollDirection = scrollDirection,
        _baseColor = baseColor,
        _highlightColor = highlightColor;


  const CustomShimmerView.sheet({super.key})
      : _itemCount = 8,
        _height = 40,
        _isGrid = false,
        _scrollDirection = Axis.vertical,
        _baseColor = null,
        _highlightColor = null;


  @override
  Widget build(BuildContext context) {
    if (_isGrid) {
      return GridView.builder(
        // padding: const EdgeInsets.all(16.0),

        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          mainAxisExtent: _height.h,
          childAspectRatio: 1,
        ),
        itemCount: _itemCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => _CustomShimmerCard(
          baseColor: _baseColor??AppColor.shimmer1.themeColor,
          height: _height,
          highlightColor: _highlightColor??AppColor.shimmer2.themeColor,
        ),
      );
    } else {
      return SizedBox(
        height: _scrollDirection==Axis.horizontal?_height.h:(_height.h*_itemCount),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),

          scrollDirection: _scrollDirection,
          itemCount: _itemCount,
          itemBuilder: (context, index) => SizedBox(
            height: _scrollDirection==Axis.horizontal?_height.h:null,
            // height: _scrollDirection==Axis.horizontal?248.h:null,

            width: _scrollDirection==Axis.horizontal?deviceWidth/2:null,
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: _scrollDirection==Axis.horizontal?8:0,vertical: _scrollDirection==Axis.vertical?8:0),
              child: _CustomShimmerCard(
                height: _height,
                baseColor: _baseColor??AppColor.shimmer1.themeColor,
                highlightColor: _highlightColor??AppColor.shimmer2.themeColor,
              ),
            ),
          ),
        ),
      );
    }
  }


}


class _CustomShimmerCard extends StatelessWidget {
  final Color baseColor;
  final Color highlightColor;
  final bool isGrid;
  final double height;

  const _CustomShimmerCard({
    Key? key,
    required this.height,
    required this.baseColor,
    required this.highlightColor,
    this.isGrid = true, // Default is Grid view
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Placeholder
          Container(
            width: double.infinity,
            height: isGrid ?height/1.5  : height-(height/1.5 ), // Adjust size for grid/list
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: kFormPaddingAllSmall),

          // Name Placeholder
          Container(
            height: 16.0,
            width: double.infinity,
            color: baseColor,
          ),

          const SizedBox(height: kFormPaddingAllSmall),

          // Rating Placeholder
          Row(

            children: [
              // Price Placeholder
              Container(
                height: 16.0,
                width: 100.0,
                color: baseColor,
              ),
              HorizontalSpace(kFormPaddingAllLarge.w),
              Container(
                width: 16.0,
                height: 16.0,
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}