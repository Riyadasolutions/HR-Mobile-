import 'package:flutter/material.dart';

class CustomSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minHeight;
  final double _maxHeight;
  final Widget _child;

  @override
  double get minExtent => _minHeight;

  @override
  double get maxExtent => _maxHeight;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    final bool isPinned = shrinkOffset >= (maxExtent - minExtent);

    return Container(color:  isPinned ? Theme.of(context).scaffoldBackgroundColor : Colors.transparent,child: _child);
  }

  @override
  bool shouldRebuild(covariant CustomSliverHeaderDelegate oldDelegate) {
    return _minHeight != oldDelegate._minHeight ||
        _maxHeight != oldDelegate._maxHeight ||
        _child != oldDelegate._child;
  }

  const CustomSliverHeaderDelegate({
    required double minHeight,
    required double maxHeight,
    required Widget child,
  })
      : _minHeight = minHeight,
        _maxHeight = maxHeight,
        _child = child;
}
