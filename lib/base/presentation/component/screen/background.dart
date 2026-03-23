// import 'dart:math' as math;
// import 'package:base_app/core/res/resources.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
//
//
// import 'package:flutter/material.dart';
//
// class AnimatedScreenColor extends StatefulWidget {
//   final double _size;
//   final Color _color;
//   final String _logo;
//
//   @override
//   State<AnimatedScreenColor> createState() => _AnimatedScreenColorState();
//
//   const AnimatedScreenColor({
//     required double size,
//     required Color color,
//     required String logo,
//   })  : _size = size,
//         _color = color,
//         _logo = logo;
// }
//
// class _AnimatedScreenColorState extends State<AnimatedScreenColor> {
//   Color _backgroundColor = Colors.white;
//
//   @override
//   void initState() {
//     _backgroundColor  = Colors.white;
//     super.initState();
//     _changeColor();
//   }
//   void _changeColor() {
//
//       // Pick a random color or cycle through a list
//      Future.delayed(Duration(seconds: 1), () {
//        setState(() {
//        _backgroundColor  =widget._color;
//        });
//        // _backgroundColor = Colors.primaries[
//         //   math.Random().nextInt(Colors.primaries.length)
//         // ].shade200;
//       });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _changeColor,
//       child: AnimatedContainer(
//         duration: const Duration(seconds: 1), // animation duration
//         curve: Curves.easeInOut,              // animation curve
//         color: _backgroundColor,
//         child:  Center(
//           child: ShortsLikePop(color: widget._color, logo: widget._logo,size: widget._size,),
//         ),
//       ),
//     );
//   }
// }
//
// class ShortsLikePop extends StatefulWidget {
//   final double _size;
//   final Color _color;
//   final String _logo;
//
//   @override
//   State<ShortsLikePop> createState() => _ShortsLikePopState();
//
//   const ShortsLikePop({
//      double size= 140,
//     required Color color,
//     required String logo,
//   })  : _size = size,
//         _color = color,
//         _logo = logo;
// }
//
// class _ShortsLikePopState extends State<ShortsLikePop>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _c;
//
//   late final Animation<double> _scale;       // logo pop
//   late final Animation<double> _rotate;      // tiny settle
//   late final Animation<double> _opacity;     // fade in
//   late final Animation<double> _ring;        // expanding ring radius
//   late final Animation<double> _ringAlpha;   // ring fade
//   late final Animation<double> _bgPulse;     // soft background pulse
//   Color _backgroundColor = Colors.white;
//
//
//   void _changeColor() {
//
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         _backgroundColor  =widget._color;
//       });
//     });
//   }
//
//
//   @override
//   void initState() {
//     _backgroundColor  = Colors.white;
//     super.initState();
//     _changeColor();
//     _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600));
//
//     _scale = TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: 0.6, end: 1.15).chain(CurveTween(curve: Curves.easeOutBack)), weight: 40),
//       TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0).chain(CurveTween(curve: Curves.easeOut)), weight: 20),
//       TweenSequenceItem(tween: ConstantTween(1.0), weight: 40),
//     ]).animate(_c);
//
//     _rotate = TweenSequence<double>([
//       TweenSequenceItem(tween: Tween(begin: -6 * math.pi / 180, end: 3 * math.pi / 180).chain(CurveTween(curve: Curves.easeOut)), weight: 35),
//       // TweenSequenceItem(tween: Tween(begin: (3 * math.pi / 180), end: 0).chain(CurveTween(curve: Curves.easeInOut)), weight: 25),
//       TweenSequenceItem<double>(tween: Tween<double>(begin: 3 * math.pi / 180, end: 0.0).chain(CurveTween(curve: Curves.easeInOut)), weight: 25,
//       ),
//       TweenSequenceItem(tween: ConstantTween(0), weight: 40),
//     ]).animate(_c);
//
//     _opacity = CurvedAnimation(parent: _c, curve: const Interval(0.0, 0.35, curve: Curves.easeOut));
//
//     _ring = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _c, curve: const Interval(0.25, 0.85, curve: Curves.easeOutQuart)),
//     );
//     _ringAlpha = Tween<double>(begin: 1, end: 0).animate(
//       CurvedAnimation(parent: _c, curve: const Interval(0.55, 1.0, curve: Curves.easeOut)),
//     );
//
//     _bgPulse = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _c, curve: const Interval(0.15, 0.55, curve: Curves.easeOut)),
//     );
//
//     // auto play once
//     _c.forward();
//   }
//
//   @override
//   void dispose() {
//     _c.dispose();
//     super.dispose();
//   }
//
//   void _replay() {
//     _c.forward(from: 0);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final s = widget._size;
//     return GestureDetector(
//       onTap: (){
//         setState(() {
//           _backgroundColor = Colors.white;
//         });
//         _replay();
//         _changeColor();
//       },
//       child: AnimatedContainer(
//         width: deviceWidth,
//         height: deviceHeight,
//         duration: const Duration(seconds: 1), // animation duration
//         curve: Curves.easeOutExpo,              // animation curve
//         color: _backgroundColor,
//
//         child: AnimatedBuilder(
//           animation: _c,
//           builder: (context, _) {
//             final ringMax = s * 0.95; // how far the ring travels
//             final ringRadius = _ring.value * ringMax / 2;
//
//             return Container(
//               width: s,
//               height: s,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   // Soft background pulse (radial)
//                   Opacity(
//                     opacity: _bgPulse.value * 0.5,
//                     child: Container(
//                       width: s,
//                       height: s,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         gradient: RadialGradient(
//                           colors: [
//                             widget._color.withOpacity(0.25 * _bgPulse.value),
//                             Colors.transparent,
//                           ],
//                           stops: const [0.0, 1.0],
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   // Expanding ring
//                   IgnorePointer(
//                     child: CustomPaint(
//                       size: Size(s, s),
//                       painter: _RingPainter(
//                         color: widget._color.withOpacity(_ringAlpha.value.clamp(0, 1)),
//                         radius: ringRadius,
//                         stroke: 3.0,
//                       ),
//                     ),
//                   ),
//
//                   // Center badge (logo/title) with pop + rotate
//                   Transform.rotate(
//                     angle: _rotate.value,
//                     child: Transform.scale(
//                       scale: _scale.value,
//                       child: Opacity(
//                         opacity: _opacity.value,
//                         child: _Badge(
//                           size: s * 0.62,
//                           logoColor: _backgroundColor,
//                           color: widget._color,
//                           logo: widget._logo,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
//
// class _Badge extends StatelessWidget {
//   final double size;
//   final Color color;
//   final Color logoColor;
//   final String logo;
//   const _Badge({required this.size, required this.logoColor, required this.color, required this.logo});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: size, height: size,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: BorderRadius.circular(size * 0.28),
//         boxShadow: [
//           BoxShadow(color:  logoColor, blurRadius: 28, spreadRadius: 2, offset: const Offset(0, 8)),
//         ],
//         border: Border.all(color: color, width: 1),
//       ),
//       alignment: Alignment.center,
//       child: SvgPicture.asset(logo,width: size * 0.48,height: size * 0.48,/*color: logoColor,*/),
//     );
//   }
// }
//
// class _RingPainter extends CustomPainter {
//   final Color color;
//   final double radius;
//   final double stroke;
//   _RingPainter({required this.color, required this.radius, this.stroke = 3});
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
