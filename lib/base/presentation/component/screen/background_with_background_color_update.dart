// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
// class AnimatedScreenColorUpdate extends StatefulWidget {
//   final double size;
//   final Color color;
//   final String logo;
//
//   /// Auto-play once on mount
//   final bool autoPlay;
//
//   /// Repeat forever
//   final bool loop;
//
//   /// Animate the entire screen background color behind the widget
//   final bool animateScreenColor;
//
//   /// Colors to cycle the screen background through (used when animateScreenColor = true)
//   final List<Color> screenColors;
//
//   const AnimatedScreenColorUpdate({
//     super.key,
//     this.size = 140,
//     required this.color,
//     required this.logo,
//     this.autoPlay = true,
//     this.loop = false,
//     this.animateScreenColor = false,
//     this.screenColors = const [
//       Colors.white,
//       Color(0xFFEEF2FF),
//       Color(0xFFE3F2FD),
//       Color(0xFFFFF3E0),
//       Color(0xFFFCE4EC),
//     ],
//   });
//
//   @override
//   State<AnimatedScreenColorUpdate> createState() => _AnimatedScreenColorUpdateState();
// }
//
// class _AnimatedScreenColorUpdateState extends State<AnimatedScreenColorUpdate>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _c;
//
//   late final Animation<double> _scale;       // logo pop
//   late final Animation<double> _rotate;      // small settle rotation
//   late final Animation<double> _opacity;     // logo fade-in
//   late final Animation<double> _ring;        // 0..1 local ring radius
//   late final Animation<double> _ringAlpha;   // 1..0 ring fade
//   late final Animation<double> _bgPulse;     // 0..1 soft glow
//   late final Animation<Color?> _screenColor; // full-screen color (optional)
//
//   @override
//   void initState() {
//     super.initState();
//
//     _c = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1600),
//     );
//
//     // --- Motion tracks
//     _scale = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween<double>(begin: 0.6, end: 1.15)
//             .chain(CurveTween(curve: Curves.easeOutBack)),
//         weight: 40,
//       ),
//       TweenSequenceItem(
//         tween: Tween<double>(begin: 1.15, end: 1.0)
//             .chain(CurveTween(curve: Curves.easeOut)),
//         weight: 20,
//       ),
//       TweenSequenceItem(tween: ConstantTween<double>(1.0), weight: 40),
//     ]).animate(_c);
//
//     _rotate = TweenSequence<double>([
//       TweenSequenceItem(
//         tween: Tween<double>(begin: -6 * math.pi / 180, end: 3 * math.pi / 180)
//             .chain(CurveTween(curve: Curves.easeOut)),
//         weight: 35,
//       ),
//       TweenSequenceItem(
//         tween: Tween<double>(begin: 3 * math.pi / 180, end: 0.0)
//             .chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 25,
//       ),
//       TweenSequenceItem(tween: ConstantTween<double>(0.0), weight: 40),
//     ]).animate(_c);
//
//     _opacity = CurvedAnimation(
//       parent: _c,
//       curve: const Interval(0.0, 0.35, curve: Curves.easeOut),
//     );
//
//     _ring = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _c,
//         curve: const Interval(0.25, 0.85, curve: Curves.easeOutQuart),
//       ),
//     );
//     _ringAlpha = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(
//         parent: _c,
//         curve: const Interval(0.55, 1.0, curve: Curves.easeOut),
//       ),
//     );
//
//     _bgPulse = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _c,
//         curve: const Interval(0.15, 0.55, curve: Curves.easeOut),
//       ),
//     );
//
//     // --- Screen color cycle (optional)
//     final seq = <TweenSequenceItem<Color?>>[];
//     for (int i = 0; i < widget.screenColors.length - 1; i++) {
//       seq.add(TweenSequenceItem(
//         tween: ColorTween(
//           begin: widget.screenColors[i],
//           end: widget.screenColors[i + 1],
//         ).chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 1,
//       ));
//     }
//     // Loop back
//     if (widget.screenColors.isNotEmpty) {
//       seq.add(TweenSequenceItem(
//         tween: ColorTween(
//           begin: widget.screenColors.last,
//           end: widget.screenColors.first,
//         ).chain(CurveTween(curve: Curves.easeInOut)),
//         weight: 1,
//       ));
//     }
//     _screenColor = TweenSequence<Color?>(seq).animate(_c);
//
//     // --- Start
//     if (widget.loop) {
//       _c.repeat();
//     } else if (widget.autoPlay) {
//       _c.forward();
//     }
//   }
//
//   @override
//   void dispose() {
//     _c.dispose();
//     super.dispose();
//   }
//
//   void _replay() {
//     if (!widget.loop) _c.forward(from: 0.0);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = widget.size;
//
//     return GestureDetector(
//       onTap: _replay,
//       child: AnimatedBuilder(
//         animation: _c,
//         builder: (context, _) {
//           return Stack(
//             children: [
//               // FULL-SCREEN SOLID COLOR BACKGROUND (optional)
//               if (widget.animateScreenColor)
//                 Positioned.fill(
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       color: _screenColor.value ?? Colors.white,
//                     ),
//                   ),
//                 ),
//
//               // Centered badge + local FX
//               Align(
//                 alignment: Alignment.center,
//                 child: SizedBox(
//                   width: s,
//                   height: s,
//                   child: Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       // soft local radial glow
//                       Opacity(
//                         opacity: _bgPulse.value * 0.5,
//                         child: Container(
//                           width: s,
//                           height: s,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             gradient: RadialGradient(
//                               colors: [
//                                 widget.color.withOpacity(0.25 * _bgPulse.value),
//                                 Colors.transparent,
//                               ],
//                               stops: const [0.0, 1.0],
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       // local expanding ring
//                       IgnorePointer(
//                         child: CustomPaint(
//                           size: Size(s, s),
//                           painter: _RingPainter(
//                             color: widget.color.withOpacity(
//                               _ringAlpha.value.clamp(0.0, 1.0),
//                             ),
//                             radius: (_ring.value * (s * 0.95) / 2),
//                             stroke: 3.0,
//                           ),
//                         ),
//                       ),
//
//                       // center badge with pop + rotate + fade
//                       Transform.rotate(
//                         angle: _rotate.value,
//                         child: Transform.scale(
//                           scale: _scale.value,
//                           child: Opacity(
//                             opacity: _opacity.value,
//                             child: _Badge(
//                               size: s * 0.62,
//                               color: widget.color,
//                               logo: widget.logo,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _Badge extends StatelessWidget {
//   final double size;
//   final Color color;
//   final String logo;
//   const _Badge({
//     required this.size,
//     required this.color,
//     required this.logo,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size,
//       height: size,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: BorderRadius.circular(size * 0.28),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.35),
//             blurRadius: 28,
//             spreadRadius: 2,
//             offset: const Offset(0, 8),
//           ),
//         ],
//         border: Border.all(color: color.withOpacity(0.2), width: 1),
//       ),
//       alignment: Alignment.center,
//       child: SvgPicture.asset(
//         logo,
//         width: size * 0.48,
//         height: size * 0.48,
//       ),
//     );
//   }
// }
//
// class _RingPainter extends CustomPainter {
//   final Color color;
//   final double radius;
//   final double stroke;
//   _RingPainter({
//     required this.color,
//     required this.radius,
//     this.stroke = 3,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = size.center(Offset.zero);
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = stroke
//       ..color = color;
//     if (radius > 0.5) {
//       canvas.drawCircle(center, radius, paint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant _RingPainter old) =>
//       old.color != color || old.radius != radius || old.stroke != stroke;
// }
