import 'dart:async';

import 'package:base_app/base/presentation/component/animation/grid_animator_data.dart';
import 'package:base_app/base/presentation/component/screen/background_with_background_color.dart';
import 'package:base_app/core/constants/globals.dart';
import 'package:base_app/core/res/decoration.dart';
import 'package:base_app/features/auth/domain/provider/local_auth_provider.dart';
import 'package:base_app/features/auth/route_generator.dart';
import 'package:base_app/features/common/route_generator.dart';
import 'package:base_app/generated/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late final LocalAuthProvider _viewModel;





  @override
  void initState() {
    super.initState();

    // Initialize ViewModel
    _viewModel = Provider.of<LocalAuthProvider>(context, listen: false);
    _route();
  }


  Future<void> _route() async {
    Timer(const Duration(seconds: 2), () async {
      bool isFirstTime = await _viewModel.isFirstTime();
      bool isAuthed = await _viewModel.isLogin();

      if (isFirstTime) {
        final locale = Localizations.localeOf(context);
        context.setLocale(locale) ;
      }
      if (!context.mounted) return;


      if (isAuthed) {
        if(kUser!=null){
          Navigator.pushNamedAndRemoveUntil(context, CommonRoutes.layoutScreen, (route) => false);
        }else{
          Navigator.pushNamedAndRemoveUntil(context, AuthRoutes.loginScreen, (route) => false);
        }

      } else {
        Navigator.pushNamedAndRemoveUntil(context, AuthRoutes.loginScreen, (route) => false);

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration().imageBackground(Assets.imagesSplashBackground),
        child: Center(
            child: AnimatedScreenColor(
          size: 340,
          color: Theme.of(context).primaryColorDark,
          screenBaseColor: Theme.of(context).primaryColorDark.withAlpha(1),

          colorUpperLimit: 0.3,
          screenBaseColorUpperLimit: 0.3,
          // screenBaseColor: Colors.transparent,
          logo: Assets.logoLogo,
          fullScreenBackground: true,
          // screenBaseColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        ),
      ),
    );
  }
}
