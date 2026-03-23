// import 'dart:async';
//
// import 'package:base_app/base/presentation/component/screen/background.dart';
// import 'package:base_app/core/constants/globals.dart';
// import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
// import 'package:base_app/features/auth/route_generator.dart';
// import 'package:base_app/features/common/route_generator.dart';
// import 'package:base_app/generated/assets.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
//   late final LocalAuthProvider _viewModel;
//
//   // Animation controllers
//   late AnimationController _animationController;
//   late Animation<double> _fadeAnimation;
//   late Animation<double> _scaleAnimation;
//
//   void _playAnimation() async{
//     // Start animation
//     await  Future.delayed(const Duration(seconds: 1) );
//
//     _animationController.forward();
//     // Timer(const Duration(seconds: 1), _route);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Initialize ViewModel
//     _viewModel = Provider.of<LocalAuthProvider>(context, listen: false);
//
//     // Initialize animations
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     );
//
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
//     );
//
//     _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
//     );
//
//     // Start animations
//     _playAnimation();
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _route() async {
//     Timer(const Duration(seconds: 2), () async {
//       bool isFirstTime = await _viewModel.isFirstTime();
//       bool isAuthed = await _viewModel.isLogin();
//       bool isUseFaceID = await _viewModel.isUseFaceID();
//
//       if (isFirstTime) {
//         final locale = Localizations.localeOf(context);
//         context.setLocale(locale) ;
//       }
//       if (!context.mounted) return;
//
//
//       if (isAuthed) {
//         if(kUser!=null && !isUseFaceID){
//           Navigator.pushNamedAndRemoveUntil(context, CommonRoutes.layoutScreen, (route) => false);
//         }else{
//           Navigator.pushNamedAndRemoveUntil(context, AuthRoutes.loginScreen, (route) => false);
//
//         }
//
//       } else {
//         Navigator.pushNamedAndRemoveUntil(context, AuthRoutes.loginScreen, (route) => false);
//
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       body: Container(
//         color: Theme.of(context).primaryColor,
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Center(
//           child: AnimatedBuilder(
//             animation: _animationController,
//             builder: (context, child) {
//               return Opacity(
//                 opacity: _fadeAnimation.value,
//                 child: Transform.scale(
//                   scale: _scaleAnimation.value,
//                   child: SvgPicture.asset(Assets.logoLogo),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
