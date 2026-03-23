import 'package:flutter/cupertino.dart';

class CustomPrototypeHeight extends StatelessWidget {
  final IndexedWidgetBuilder? _itemBuilder;
  final Widget _child;
  final bool _enable;
  const CustomPrototypeHeight({
    IndexedWidgetBuilder? itemBuilder,
    required Widget child,
    required bool enable,
  })
      : _itemBuilder = itemBuilder,
        _child = child,
        _enable = enable;
  @override
  Widget build(BuildContext context) {
    if(_itemBuilder==null|| !_enable)return _child;

    return Stack(
      children: [
        IgnorePointer(
          child: Opacity(
            opacity: 0.0,
            child: _itemBuilder(context, 1),
          ),
        ),
        SizedBox(width: double.infinity),
        Positioned.fill(child: _child),
      ],
    );
  }


}