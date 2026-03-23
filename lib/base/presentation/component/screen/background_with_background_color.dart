import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AnimatedScreenColor extends StatefulWidget {
  final double _size;
  final Color _color;
  final String _logo;
  final bool _autoPlay;
  final bool _loop;

  /// NEW: paint expanding background from center to whole screen
  final bool _fullScreenBackground;
  final Color _screenBaseColor; // base screen color under the pulse
  final double _screenBaseColorUpperLimit; // base screen color under the pulse
  final double _colorUpperLimit; // base screen color under the pulse

  @override
  State<AnimatedScreenColor> createState() => _AnimatedScreenColorState();

  // const AnimatedScreenColor({
  //   super.key,
  //   this.size = 140,
  //   required this.color,
  //   required this.logo,
  //   this.autoPlay = true,
  //   this.loop = false,
  //   this.fullScreenBackground = false,
  //   this.screenBaseColor = Colors.white,
  //   this.screenBaseColorUpperLimit = 1,
  // });
  const AnimatedScreenColor({
    bool fullScreenBackground = false,
    Color screenBaseColor = Colors.white,
     double screenBaseColorUpperLimit=1,
     double colorUpperLimit=1,
    double size = 140,
    required Color color,
    required String logo,
     bool autoPlay= true,
     bool loop= false,
  })  : _size = size,
        _fullScreenBackground = fullScreenBackground,
        _screenBaseColor = screenBaseColor,
        _screenBaseColorUpperLimit = screenBaseColorUpperLimit,
        _colorUpperLimit = colorUpperLimit,
        _color = color,
        _logo = logo,
        _autoPlay = autoPlay,
        _loop = loop;
}

class _AnimatedScreenColorState extends State<AnimatedScreenColor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;


  late final Animation<double> _scale;
  late final Animation<double> _rotate;
  late final Animation<double> _opacity;
  late final Animation<double> _ring;       // 0..1 progress
  late final Animation<double> _ringAlpha;  // 1..0 fade
  late final Animation<double> _bgPulse;    // 0..1 intensity

  @override
  void initState() {
    super.initState();
    _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));

    _scale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.6, end: 1.15).chain(CurveTween(curve: Curves.easeOutBack)), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 1.15, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 20),
      TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 40),
    ]).animate(_c);

    _rotate = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: -6 * math.pi / 180, end: 3 * math.pi / 180).chain(CurveTween(curve: Curves.easeOut)), weight: 35),
      TweenSequenceItem(tween: Tween<double>(begin: 3 * math.pi / 180, end: 0.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 25),
      TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 40),
    ]).animate(_c);



    _opacity = CurvedAnimation(parent: _c, curve: const Interval(0.0, 0.35, curve: Curves.easeOut));

    _ring = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.25, 0.85, curve: Curves.easeOutQuart)),
    );
    _ringAlpha = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.55, 1.0, curve: Curves.easeOut)),
    );
    _bgPulse = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _c, curve: const Interval(0.15, 0.55, curve: Curves.easeOut)),
    );

    Future.delayed(const Duration(milliseconds: 100), () {


      if (widget._loop) {
        _c.repeat();
      } else if (widget._autoPlay) {
        _c.forward();
      }



    });


  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  void _replay() {
    if (!widget._loop) _c.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final s = widget._size;
    final screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _replay,
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          // Max radius needed to cover the whole screen from center
          final maxRadius = math.sqrt(
            screenSize.width * screenSize.width + screenSize.height * screenSize.height,
          ) / 2;

          return Stack(
            alignment: Alignment.center,
            children: [
              // FULL-SCREEN BACKGROUND PULSE (new)
              if (widget._fullScreenBackground)
                Positioned.fill(
                  child: CustomPaint(
                    painter: _FullScreenPulsePainter(
                      baseColor: widget._screenBaseColor,
                      pulseColor: widget._color,
                      progress: _ring.value,        // 0..1
                      // fade: _ringAlpha.value,       // 1..0
                      // intensity: _bgPulse.value,    // 0..1
                      fade: 1,       // 1..0
                      intensity: 1,    // 0..1
                      opacity: widget._colorUpperLimit,

                      maxRadius: maxRadius,
                    ),
                  ),
                )
              else
              // Fallback: plain base color container so stacking still works
                Container(color: widget._screenBaseColor),

              // Positioned(
              //   width: deviceWidth,
              //   height: deviceHeight,
              //   child: AnimatedContainer(
              //     width: deviceWidth,
              //     height: deviceHeight,
              //     duration: const Duration(seconds: 1), // animation duration
              //     curve: Curves.easeOutExpo,              // animation curve
              //     color: _backgroundColor,
              //
              //   ),
              // ),
              // Foreground animated badge + local ring
              SizedBox(
                width: s,
                height: s,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // (Optional) local soft background pulse around the badge
                    Opacity(
                      opacity: _bgPulse.value * 0.5,
                      child: Container(
                        width: s,
                        height: s,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              widget._color.withOpacity(0.25 * _bgPulse.value),
                              // widget.screenBaseColor.withOpacity(0.25 * _bgPulse.value),
                              Colors.transparent,
                            ],
                            stops: const [0.0, 1.0],
                          ),
                        ),
                      ),
                    ),

                    // Local expanding ring around the badge
                    IgnorePointer(
                      child: CustomPaint(
                        size: Size(s, s),
                        painter: _RingPainter(
                          color: widget._screenBaseColor.withOpacity(_ringAlpha.value.clamp(0.0, widget._screenBaseColorUpperLimit)),
                          radius: (_ring.value * (s * 0.95) / 2),
                          stroke: 3.0,
                        ),
                      ),
                    ),

                    // Center badge (SVG logo)
                    Transform.rotate(
                      angle: _rotate.value,
                      child: Transform.scale(
                        scale: _scale.value,
                        child: Opacity(
                          opacity: _opacity.value,
                          child: _Badge(
                            bgPulse: _ringAlpha,
                            size: s * 0.62,
                            color: widget._color,
                            logo: widget._logo,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final double _size;
  final Color _color;
  final Animation<double> _bgPulse;
  final String _logo;
  const _Badge({
    required double size,
    required Color color,
    required Animation<double> bgPulse,
    required String logo,
  })  : _size = size,
        _color = color,
        _bgPulse = bgPulse,
        _logo = logo;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size, height: _size,
      decoration: BoxDecoration(
        // color: _color.withOpacity(0 * 1),
        color: _color.withOpacity(_bgPulse.value * 1),
        borderRadius: BorderRadius.circular(_size * 0.28),

        // boxShadow: [
        //   BoxShadow(color: color/*.withOpacity(0.35)*/, blurRadius: 28, spreadRadius: 2, offset: const Offset(0, 8)),
        // ],
        // border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(_logo, width: _size * 0.48, height: _size * 0.48),
    );
  }


}

class _RingPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double stroke;
  _RingPainter({required this.color, required this.radius, this.stroke = 3});

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..color = color;
    if (radius > 0.5) {
      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.color != color || old.radius != radius || old.stroke != stroke;
}

/// FULL-SCREEN radial pulse from screen center
class _FullScreenPulsePainter extends CustomPainter {
  final Color _baseColor;
  final Color _pulseColor;
  final double? _opacity;  // 0..1 (expansion)
  final double _progress;  // 0..1 (expansion)
  final double _fade;      // 1..0 (alpha)
  final double _intensity; // 0..1 (glow)
  final double _maxRadius;
  const _FullScreenPulsePainter({
    required Color baseColor,
    required Color pulseColor,
     double? opacity,
    required double progress,
    required double fade,
    required double intensity,
    required double maxRadius,
  })  : _baseColor = baseColor,
        _pulseColor = pulseColor,
        _opacity = opacity,
        _progress = progress,
        _fade = fade,
        _intensity = intensity,
        _maxRadius = maxRadius;
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);

    // Base fill
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = _baseColor,
    );

    // Expanding radial gradient “wave”
    final radius = (_progress.clamp(0.0, 1.0)) * _maxRadius;
    if (radius <= 1) return;

    final opacity = _opacity??(0.45 * _intensity * _fade).clamp(0.0, 1.0); // softer as it expands
    final shader = RadialGradient(
      colors: [
        _pulseColor.withOpacity(opacity),
        _pulseColor.withOpacity(0.0),
      ],
      stops:  [_opacity??0.0, 1.0],
    ).createShader(Rect.fromCircle(center: center, radius: radius));

    final paint = Paint()..shader = shader;
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _FullScreenPulsePainter old) =>
      old._baseColor != _baseColor ||
          old._pulseColor != _pulseColor ||
          old._progress != _progress ||
          old._fade != _fade ||
          old._intensity !=_intensity ||
          old._maxRadius !=_maxRadius;


}
