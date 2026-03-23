import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/core/res/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  final String? _image;
  final Widget? _body;
  final bool _extendBodyBehindAppBar;
  final bool _drawerEnableOpenDragGesture;
  final PreferredSizeWidget? _appBar;
  final Widget? _drawer;
  final Widget? _bottomNavigationBar;
  final Widget? _floatingActionButton;
  final GlobalKey<ScaffoldState>? _key;

  const CustomScaffold({
    String? image,
    bool extendBodyBehindAppBar = true,
    bool drawerEnableOpenDragGesture = false,
    Widget? body,
    GlobalKey<ScaffoldState>? scaffoldKey,
    Widget? bottomNavigationBar,
    Widget? drawer,
    Widget? floatingActionButton,
    PreferredSizeWidget? appBar,
  })  : _image = image,
        _appBar = appBar,
        _key = scaffoldKey,
        _floatingActionButton = floatingActionButton,
        _drawerEnableOpenDragGesture = drawerEnableOpenDragGesture,
        _extendBodyBehindAppBar = extendBodyBehindAppBar,
        _bottomNavigationBar = bottomNavigationBar,
        _drawer = drawer,
        _body = body;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemeHelper>().isDarkMode;

    return CustomStatusBar(


      color: Colors.transparent,

      // color: Theme.of(context).primaryColor,
      isDark: false,

      child: Scaffold(
        floatingActionButton:_floatingActionButton ,
        key: _key,
        drawer: _drawer,
        drawerEnableOpenDragGesture:_drawerEnableOpenDragGesture ,
        extendBodyBehindAppBar: _extendBodyBehindAppBar,
        extendBody: _extendBodyBehindAppBar,
        bottomNavigationBar: _bottomNavigationBar,
        appBar: _appBar,
        body: Container(
          height: deviceHeight,
          width: deviceWidth,
          decoration:  BoxDecoration(
              image: _image==null?null:DecorationImage(image: AssetImage(_image), fit: BoxFit.cover),
            gradient: LinearGradient(
              stops: isDarkMode?const [0.0, 0.15]:const [0.0, 0.6],
              colors: isDarkMode
                  ? [Theme.of(context).primaryColorDark, Theme.of(context).scaffoldBackgroundColor]
                  : [const Color(0xffeaf6f6), Theme.of(context).scaffoldBackgroundColor
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(child: _body??const SizedBox()),
          // top: !_extendBodyBehindAppBar,
        ),
      ),
    );
  }
}
