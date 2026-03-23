import 'package:auto_size_text/auto_size_text.dart';
import 'package:base_app/base/presentation/component/bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/generated/assets.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layout_view_model.dart';
import 'navigation_tabs.dart';

class LayoutScreen extends StatefulWidget {
  final int? _currentPage;

  const LayoutScreen({
    Key? key,
     int? currentPage,
  })  : _currentPage = currentPage,
        super(key: key);

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  late LayoutViewModel _viewModel ;
  @override
  void initState() {
    super.initState();
   _viewModel =  Provider.of<LayoutViewModel>(context, listen: false);
    _viewModel.init(widget._currentPage);
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.watch<LayoutViewModel>().currentIndex;

    return Scaffold(
      body: PopScope(
        onPopInvoked: (didPop) => _viewModel.setCurrentIndex(0),
        canPop: currentIndex == 0,
        child: kUserTabs[currentIndex].initialRoute,
      ),

        floatingActionButton: FloatingActionButton(
          child:  CustomIcon(assets: Assets.iconsNavHomeIcon,color: Colors.white/*Theme.of(context).cardColor*/),//CardIcon(count: 3),
          onPressed: () =>_viewModel.setCurrentIndex(4),
          elevation: 0,
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: _buildBottomNavigationBar(currentIndex)

    );
  }
  _buildBottomNavigationBar(int currentIndex){

    // List<NavigationTabData>   taps = [...kUserTabs];
    //  taps.removeAt(2);
    return CustomBottomNavigationBar.builder(
      itemCount: kUserTabs.length-1,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: kFormRadius,
      rightCornerRadius: kFormRadius,
      height: 70.h,
      backgroundColor: AppColor.cardColor.themeColor,


      tabBuilder: (index, isActive) => Column(
        children: [
          VerticalSpace(kFormPaddingAllLarge.h),

          CustomSVGIcon(
            kUserTabs[index].icon,
            width: 26.r,
            height: 26.r,
            color: isActive
                ? Theme.of(context).primaryColor
                : Theme.of(context).hintColor,
          ),
          Expanded(child:  FittedBox(fit: BoxFit.scaleDown,child: AutoSizeText(tr(kUserTabs[index].title),style: const TextStyle().regularStyle(fontSize: 14).primaryTextColor().customColor(  isActive?Theme.of(context).primaryColor:null),))),

          VerticalSpace(kFormPaddingAllLarge.h),
        ],
      ),
      activeIndex: currentIndex,
      onTap:  _viewModel.setCurrentIndex,
    );
  }
}

//FcmHandler(navigatorKey:NavigationService.navigationKey,
