import 'package:base_app/base/presentation/component/component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:base_app/core/res/resources.dart';

class CustomListAnimator extends StatefulWidget {
  final List<Widget> _children;
  final int? _duration;
  final double? _verticalOffset;
  final ScrollPhysics? _physics;
  final Axis _scrollDirection;
  final double _verticalSpace;

  const CustomListAnimator({
    super.key,
    required List<Widget> children,
    int? duration,
    double? verticalOffset,
    ScrollPhysics? physics,
    Axis scrollDirection = Axis.vertical,
    double verticalSpace = kFormPaddingVertical,
  })  : _children = children,
        _duration = duration,
        _verticalOffset = verticalOffset,
        _physics = physics,
        _scrollDirection = scrollDirection,
        _verticalSpace = verticalSpace;

  // const CustomListAnimator({
  //   Key? key,
  //   this.children,
  //   this.duration,
  //   this.scrollDirection = Axis.vertical,
  //
  //   this.verticalOffset,
  //   this.verticalSpace =kFormPaddingVertical,
  //   this.physics,
  // }) : super(key: key);

  @override
  _CustomListAnimatorState createState() => _CustomListAnimatorState();
}

class _CustomListAnimatorState extends State<CustomListAnimator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget._scrollDirection == Axis.vertical ? deviceHeight : null,
      child: ListView.separated(
        scrollDirection: widget._scrollDirection,
        itemCount: widget._children.length,
        physics: widget._physics,
        padding: EdgeInsets.zero,
        itemBuilder: (_, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: widget._verticalOffset ?? 50.0,
              duration: Duration(milliseconds: widget._duration ?? 375),
              child: FadeInAnimation(
                child: widget._children[index],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return widget._scrollDirection == Axis.vertical
              ? VerticalSpace(widget._verticalSpace)
              : const SizedBox(width: kFormPaddingHorizontal);
        },
      ),
    );
  }
}
