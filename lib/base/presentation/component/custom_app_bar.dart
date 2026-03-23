import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/res/color.dart';
import 'package:base_app/core/res/decoration.dart';
import 'package:base_app/core/res/text_styles.dart';
import 'package:base_app/generated/assets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/res/values_manager.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? _title;
  final String? _backgroundImage;

  final Color? _titleColor;
  final bool? _isDark;
  final bool _isBackButtonExist;
  final bool _isShowBackgroundImage;

  final VoidCallback? _onBackPress;
  // final IconData? icon;
  final bool _showIcon;
  final Widget? _titleWidget;
  final Widget? _leading;
  final double _height;
  final Color? _color;
  final Color? _statusBarColor;

  final List<Widget>? _actions;
  final Widget? _logo;
  final bool _isCenterTitle;
  final Widget? _bottomWidget;
  final double _bottomSize;
  final double _fontSize;
  final Color? _bottomColor;
  final double _elevation;
  final double? _leadingWidth;
  final IconData? _iconBack;
  final String? _iconSVGBack;
  final double? _iconBackSize;


  const CustomAppBar({super.key,
    String? title,
    Color? titleColor,
    bool? isDark ,
    bool isBackButtonExist = true,
    bool isShowBackgroundImage = false,
    VoidCallback? onBackPress,
    bool showIcon = false,
    Widget? titleWidget,
    String? backgroundImage,

    Widget? leading,
    double? leadingWidth,
    double height = 50,
    Color? color,
    Color? statusBarColor,
    List<Widget>? actions,
    Widget? logo,
    bool isCenterTitle = true,
    Widget? bottomWidget,
    double bottomSize = 20,
    double fontSize = 16,
    Color? bottomColor,
    Widget? centerLogo,
    double elevation = 0.0,
    IconData? iconBack,
    String? iconSVGBack,
    double iconBackSize = 24,
  })  : _title = title,
        _isDark = isDark,
        _titleColor = titleColor,
        _leadingWidth = leadingWidth,
        _backgroundImage = backgroundImage,
        _isBackButtonExist = isBackButtonExist,
        _isShowBackgroundImage = isShowBackgroundImage,
        _iconSVGBack = iconSVGBack,
        _onBackPress = onBackPress,
        _showIcon = showIcon,
        _titleWidget = titleWidget,
        _leading = leading,
        _height = height,
        _statusBarColor = statusBarColor,
        _color = color,
        _actions = actions,
        _logo = logo,
        _isCenterTitle = isCenterTitle,
        _bottomWidget = bottomWidget,
        _bottomSize = bottomSize,
        _fontSize = fontSize,
        _bottomColor = bottomColor,
        _elevation = elevation,
        _iconBack = iconBack,
        _iconBackSize = iconBackSize;

  @override
  Widget build(BuildContext context) {
    bool isDark = _isDark??AppColor.isDarkMode;
    return PreferredSize(
      preferredSize: Size.fromHeight((_height + _bottomSize ).h),
      child: AppBar(

        systemOverlayStyle: SystemUiOverlayStyle(
          //   // Status bar color
          statusBarColor: _statusBarColor ?? Colors.transparent,
          systemNavigationBarColor: _statusBarColor ?? Colors.transparent,
          systemNavigationBarDividerColor: _statusBarColor ?? Colors.transparent,
          systemStatusBarContrastEnforced: false,
          systemNavigationBarContrastEnforced: true,

          // Status bar brightness (optional)
          statusBarIconBrightness: isDark?Brightness.light: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: isDark?Brightness.light: Brightness.dark , // For iOS (dark icons)
          systemNavigationBarIconBrightness: isDark?Brightness.light : Brightness.dark,

        ),
        backgroundColor:_color??Colors.transparent,
        surfaceTintColor:_color??Colors.transparent,
        // backgroundColor:color??Theme.of(context).scaffoldBackgroundColor/* Colors.transparent*/,
        title: _titleWidget ?? (_title != null ? Text(_title, style: const TextStyle().semiBoldStyle(fontSize: _fontSize).customColor(_titleColor?? AppColor.textColor.themeColor)) :  const SizedBox.shrink()),
        centerTitle: _isCenterTitle,
        leading:_leading ?? (
            _isBackButtonExist ? Center(
                child: CustomBackIcon(onTap:_onBackPress , icon: _iconBack, iconSVG: _iconSVGBack, iconSize: _iconBackSize, color: _titleColor,)
              /*Container(
                    padding: EdgeInsets.all(kFormPaddingAllNormal.r),
                    decoration: const BoxDecoration().radius().customColor(Theme.of(context).cardColor.withOpacity(0.3)),
                    child: GestureDetector(
                        onTap: _onBackPress ?? () => Navigator.pop(context),
                        child: _iconBack!=null
                            ?Icon(_iconBack , color: _titleColor ?? AppColor.textColor.themeColor, size: _iconBackSize)
                            :SvgPicture.asset(_iconSVGBack ??( context.locale.languageCode=='ar'?Assets.iconsBackArIcon:Assets.iconsBackEnIcon), color: _titleColor?? AppColor.textColor.themeColor , width: _iconBackSize,height: _iconBackSize,)
                    )
                )*/
            ) : const SizedBox()
        ),

        elevation: _elevation,
        leadingWidth: _leadingWidth??(_isBackButtonExist ? null : 0),
        bottomOpacity: 0.0,
        flexibleSpace: Container(
          decoration: _isShowBackgroundImage&&_backgroundImage!=null
              ? BoxDecoration(image:  DecorationImage(image: AssetImage(_backgroundImage), fit: BoxFit.fill), color: _color ?? Colors.transparent)
              : BoxDecoration(color: _color ?? Colors.transparent),
          // decoration: BoxDecoration(color: _color??Colors.transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _logo ?? const SizedBox()),

              if(_bottomWidget!=null)
                Column(
                  children: [
                    Container(
                      height:_bottomSize.h,
                      width: deviceWidth,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Colors.transparent,
                        color:_bottomColor?? Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(kFormRadius), topRight: Radius.circular(kFormRadius)),
                      ),
                      child: _bottomWidget,
                    ),
                  ],
                ),
            ],
          ),
        ),
        actions: _actions,
      ),
    );
  }
  @override
  Size get preferredSize => Size(double.maxFinite,(_height + _bottomSize ));

}
