

import 'package:base_app/base/data/injection.dart';

import 'package:base_app/core/res/theme_helper.dart';
import 'package:base_app/core/utils/timer_helper.dart';
import 'package:base_app/features/auth/injection.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class GenerateMultiProvider extends StatelessWidget {
  final Widget _child;
  const GenerateMultiProvider({
    required Widget child,
  }) : _child = child;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [



        //Local
        ChangeNotifierProvider(create: (context) => getIt<TimerHelper>()),
        ChangeNotifierProvider(create: (context) => getIt<ThemeHelper>()),



        ... initAuthProvider(),
        // ... initCommonProvider(),
        // ... initBookingProvider(),
        //
        // ... initHotelProvider(),
        // ... initServiceProvider(),



      ],
      child: _child,
    );
  }


}
