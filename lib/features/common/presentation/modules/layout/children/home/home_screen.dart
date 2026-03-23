import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/base/presentation/component/custom_shimmer_view.dart';
import 'package:base_app/base/presentation/component/images/custom_image_slider1.dart';
import 'package:base_app/core/constants/constants.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/home/home_view_model.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/home/widgets/home_item_view.dart';
import 'package:base_app/features/common/presentation/modules/layout/layout_view_model.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';




_getData(BuildContext context, bool reload)=>
    Provider.of<HomeViewModel>(context, listen: false).init( reload: reload);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  Color _appBarColor = Colors.transparent;
  void _onScroll() {
    setState(() {
      _appBarColor = _scrollController.offset > 200
          ? Theme.of(context).primaryColorDark // Change to your desired color
          : Colors.transparent; // Default color
    });
  }

  // late HomeViewModel _viewModel ;
  @override
  void initState() {
    // _viewModel= Provider.of<HomeViewModel>(context, listen: false);
    super.initState();
    _getData(context, false);
    _scrollController.addListener(_onScroll);

  }
  @override
  Widget build(BuildContext context) {
    var responseModel = context.watch<HomeViewModel>().responseModel;
    
    // Extract hero_slider images from response
    List<String> heroSliderImages = [];
    if (responseModel?.data != null) {
      final heroSliderEntity = responseModel!.data!.firstWhere(
        (entity) => entity.type == HomeItemsType.hero_slider,
        orElse: () => responseModel.data!.first, // fallback
      );
      if (heroSliderEntity.type == HomeItemsType.hero_slider && heroSliderEntity.rawData != null) {
        heroSliderImages = (heroSliderEntity.rawData as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList() ?? [];
      }
    }
    
    // Fallback to default images if no hero slider data
    if (heroSliderImages.isEmpty) {
      heroSliderImages = [
        'https://assets.kerzner.com/api/public/content/ee8f360722de459a93ca4eaa257b308b?v=a3566083&t=w576',
        'https://static-new.lhw.com/HotelImages/Final/LW0430/lw0430_177729896_720x450.jpg',
        'https://www.travelplusstyle.com/wp-content/uploads/2016/01/sonevajani-1880.jpg'
      ];
    }
    
    // Filter out hero_slider from the list to display
    final itemsToDisplay = responseModel?.data
        ?.where((entity) => entity.type != HomeItemsType.hero_slider)
        .toList() ?? [];
    
    return CustomStatusBar(
      isDark: true,
      child: Scaffold(
        drawerEnableOpenDragGesture: false,
        key: _key,
        body:  CustomScrollView(
          controller: _scrollController,
          primary: false,
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: false,

              floating: true,
              backgroundColor: _appBarColor,
              // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(kFormRadius), bottomRight: Radius.circular(kFormRadius))),
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: NotificationIcon(count: 3),
              //   ),
              // ],
              leading: CustomImage(imageUrl: Assets.logoLogo,width: 100,height: 100,),
              leadingWidth: 80,
              elevation: 0.0,
              expandedHeight:   280.h  ,
              surfaceTintColor: Theme.of(context).primaryColorDark,
              foregroundColor: Theme.of(context).primaryColorDark,
      
              flexibleSpace:  FlexibleSpaceBar(
                
      
      
                background: Container(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
      
                      MediaCarousel(
                        sliders: heroSliderImages,
                        // autoScroll: true,
                        // autoScrollInterval: const Duration(seconds: 4),
                        // onIndexChange: (i) => debugPrint('Slide: $i'),
                        height: 280.h,
                      ),
      
                      // CustomImageSlider(
                      //   sliders: [Assets.imagesHomeImage,Assets.imagesHomeImage,Assets.imagesHomeImage],
                      //   height: 280.h,
                      // ),
                      // HomeImagesSliderView(
                      //     i: [],
                      //     gallery: gallery
                      // ),
                      // CustomImage(
                      //   imageUrl: Assets.imagesHomeImage,
                      //   fit: BoxFit.cover,
                      //   height: 280.h,
                      //   showBorder: false,
                      //   showHighlight: true,
                      //   borderRadius:  BorderRadius.only(bottomLeft: Radius.circular(kFormRadius), bottomRight: Radius.circular(kFormRadius),
                      //   ),
                      // ),
                      // Image.asset(Assets.imagesHomeImage,fit: BoxFit.cover),
                      Positioned(
                        bottom: kFormPaddingAllLarge,
                        top: kScreenPaddingLarge,
      
                        left: kFormPaddingAllLarge,
                        right: kFormPaddingAllLarge,
      
                        child: Column(
      
                          children: [
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(tr(LocaleKeys.findYourPerfectHotel),style: TextStyle().titleStyle(fontSize: 24).colorWhite()),
                                    VerticalSpace(kFormPaddingAllSmall.h),
                                    Text(tr(LocaleKeys.bestDealsAndServicesInOnePlace),style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite()),
                                    VerticalSpace(kFormPaddingAllNormal.h),
                                    Text(tr(LocaleKeys.bookNowAndSaveUpToOnYourStay,namedArgs: {'value':'40%'}),style: TextStyle().regularStyle(fontSize: 12).colorWhite()),
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () =>Provider.of<LayoutViewModel>(context,listen: false).setCurrentIndex(2),
                              // onTap: () => NavigationService.push(HotelRoutes.hotelsScreen),
                              child: Container(
                                child: CustomTextFieldSearch(
                                  hint: tr(LocaleKeys.findYourPerfectHotel),
                                  background: Theme.of(context).cardColor.withOpacity(0.9),
                                  // prefixIconColor: Theme.of(context).cardColor,
                                  readOnly: true,
                                  onTap: () =>Provider.of<LayoutViewModel>(context,listen: false).setCurrentIndex(2),
                                  // onTap: () => NavigationService.push(HotelRoutes.hotelsScreen),
                                  // isDark: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
      
      
              ),
      
            ),
      
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     child: CustomImage(imageUrl: Assets.logoLogo,),
            //     // height: 40,
            //   ),
            // ),
      
      
            SliverPadding(
              padding:kCardPadding.copyWith(top: 0),
              sliver: SliverToBoxAdapter(
                child: CustomScreenStateLayout(
                  isLoading: responseModel==null,
                  isEmpty: itemsToDisplay.isEmpty,
                  error: responseModel?.error,
                  loadingBuilder: (context) => const CustomShimmerView(),
                  builder: (context) =>  CustomListAnimatorData(
                    physics: NeverScrollableScrollPhysics(),
                    // verticalSpace: kFormPaddingAllSmall,
                    itemCount: itemsToDisplay.length,
                    itemBuilder: (context, index) => HomeItem(entity: itemsToDisplay[index],index: index),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
