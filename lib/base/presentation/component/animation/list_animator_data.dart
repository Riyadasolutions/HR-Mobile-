import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:base_app/core/res/resources.dart';

import '../component.dart';

class CustomListAnimatorData extends StatefulWidget {
  final int? itemCount;
  final int? duration;
  final double? verticalOffset;
  final double? verticalSpace;
  final double? horizontalSpace;
  final ScrollPhysics? physics;
  final bool primary;
  final bool shrinkWrap;
  final bool isAnimated;
  final Widget? loadingWidget;
  final int? simmerItemCount;
  final Widget? noDataWidget;
  final Widget? separatorWidget;
  final bool isReverse;
  final Axis scrollDirection;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;

  //pagination
  final Function? onNextCall;
  final int? totalPages;
  final int? currentPage;
  final bool isNextPageLoading;

  const CustomListAnimatorData({
    Key? key,
    this.itemCount,
    this.duration,
    this.horizontalSpace,
    this.isAnimated = true,
    this.scrollDirection = Axis.vertical,
    this.primary = false,
    this.shrinkWrap = true,
    this.isReverse = false,
    required this.itemBuilder,
    this.noDataWidget,
    this.separatorWidget,
    this.verticalSpace,
    this.loadingWidget,
    this.verticalOffset,
    this.padding,
    this.physics,
    this.simmerItemCount,
    this.isNextPageLoading=false,
    this.onNextCall,
    this.currentPage,
    this.totalPages,
  }) : super(key: key);

  @override
  _CustomListAnimatorDataState createState() => _CustomListAnimatorDataState();
}

class _CustomListAnimatorDataState extends State<CustomListAnimatorData> {


  @override
  Widget build(BuildContext context) {
    if (widget.itemCount == null) {return widget.loadingWidget != null ? _buildSimmerList() : const Center(child: CustomLoadingSpinner());
    } else if (widget.itemCount == 0) {
      return widget.noDataWidget ?? const SizedBox();
    } else {
      final listView = AnimationConfiguration.synchronized(
        child: SlideAnimation(
            verticalOffset: widget.scrollDirection == Axis.vertical && widget.isAnimated ? 50.0 : null,
            horizontalOffset: widget.scrollDirection == Axis.horizontal && widget.isAnimated ? 50.0 : null,
            child: AnimationLimiter(
                child: ListView.separated(
              itemCount: widget.itemCount ?? 0,
              itemBuilder: widget.itemBuilder,
              scrollDirection: widget.scrollDirection,

              primary: widget.primary,
              physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
              shrinkWrap: widget.scrollDirection == Axis.horizontal ? false : widget.shrinkWrap,
              padding: widget.padding,
              reverse: widget.isReverse,
              separatorBuilder: (context, index) {
                return widget.separatorWidget ??
                    (widget.scrollDirection == Axis.vertical
                        ?  VerticalSpace(widget.verticalSpace?? kFormPaddingVertical)
                        : HorizontalSpace(widget.horizontalSpace??  kFormPaddingHorizontal)
                    );
              },
            ),
          ),
        ),
      );

      // For horizontal lists, wrap in CustomPrototypeHeight to ensure proper height constraints
      if (widget.scrollDirection == Axis.horizontal) {
        return CustomPrototypeHeight(
          itemBuilder: widget.itemBuilder,
          child: listView,
          enable: (widget.itemCount??0)>1
        );
      } else {
        return listView;
      }
    }
  }

  _buildSimmerList() {
    return ListView.separated(
      itemCount: widget.simmerItemCount ?? 1,
      itemBuilder: (context, index) {
        return widget.loadingWidget ?? Container();
      },
      scrollDirection: widget.scrollDirection,
      primary: widget.primary,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      reverse: widget.isReverse,
      separatorBuilder: (context, index) {
        return widget.separatorWidget ??
            (widget.scrollDirection == Axis.vertical
                ?  VerticalSpace(widget.verticalSpace?? kFormPaddingVertical)
                :const HorizontalSpace( kFormPaddingHorizontal)
            );
      },
    );
  }
}
