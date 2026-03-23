import 'package:flutter/material.dart';

class CustomAnimatedIconSwitch extends StatefulWidget {
  final IconData startIcon;
  final IconData endIcon;
  final double size;
  final Duration duration;
  final Color? color;
  final VoidCallback? onChanged;

  /// External controller for icon state
  final bool isStart;

  const CustomAnimatedIconSwitch({
    super.key,
    required this.startIcon,
    required this.endIcon,
    required this.isStart,
    this.size = 24.0,
    this.duration = const Duration(milliseconds: 300),
    this.color,
    this.onChanged,
  });

  @override
  State<CustomAnimatedIconSwitch> createState() =>
      _CustomAnimatedIconSwitchState();
}

class _CustomAnimatedIconSwitchState extends State<CustomAnimatedIconSwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _rotation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (!widget.isStart) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(CustomAnimatedIconSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.isStart != widget.isStart) {
      if (widget.isStart) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }

  void _handleTap() {
    widget.onChanged?.call(); // toggle logic handled outside
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: RotationTransition(
        turns: _rotation,
        child: Icon(
          widget.isStart ? widget.startIcon : widget.endIcon,
          size: widget.size,
          color: widget.color ?? Theme.of(context).iconTheme.color,
        ),
      ),
    );
  }
}
