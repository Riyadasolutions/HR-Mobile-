import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/constants.dart';

import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();

  const NotificationScreen({super.key,
  }) ;
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(isBackButtonExist: false,),
      body: Padding(padding: kScreenPadding,
        child: CustomListAnimator(
          children: [

          ],
        ),
      ),
    );
  }
}
