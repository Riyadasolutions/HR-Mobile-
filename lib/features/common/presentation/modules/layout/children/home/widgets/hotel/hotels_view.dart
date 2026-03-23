// import 'package:base_app/base/presentation/component/component.dart';
// import 'package:base_app/core/extensions/num_extensions.dart';
// import 'package:base_app/core/res/resources.dart';
// import 'package:base_app/core/routing/navigation_services.dart';
// import 'package:base_app/features/common/domain/entity/home_entity.dart';
// import 'package:base_app/features/common/presentation/modules/layout/children/home/widgets/hotel/widget/hotel_item.dart';
// import 'package:base_app/features/hotels/domain/parameters/hotel_filter_parameters.dart';
// import 'package:base_app/features/hotels/route_generator.dart';
// import 'package:flutter/material.dart';
//
// class HomeHotelView extends StatelessWidget {
//   final HomeEntity _entity;
//   const HomeHotelView({super.key,
//     required HomeEntity entity,
//   })  : _entity = entity;
//   @override
//   Widget build(BuildContext context) {
//     var itemWidth =  deviceWidth-(deviceWidth/5);
//
//     return _entity.list.isEmpty?const SizedBox():Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//
//         CustomTitle(title: _entity.title,desc: tr(LocaleKeys.discoverTopDestinations),),
//         VerticalSpace(kFormPaddingAllNormal.h),
//
//         // CustomTitle(title: _entity.title),
//         // // CustomTitle(title: tr(LocaleKeys.mostRequestedServiceService),onViewAllTap:(responseModel!.data!.topService.length<=4)?null: ()=>NavigationService.push(UserRoutes.serviceServiceScreen,arguments: {'hotelId':_hotelId})),
//         // VerticalSpace(kFormPaddingAllSmall.h),
//
//
//
//
//         SizedBox(
//           // height: 228.h,
//           child: CustomListAnimatorData(
//
//
//             scrollDirection: Axis.horizontal ,
//             itemCount: _entity.list.length,
//             itemBuilder: (context, index) =>
//                 SizedBox(width: itemWidth, child: HomeHotelItem(
//                   entity: _entity.list[index],
//                   onTap: () => NavigationService.push(HotelRoutes.hotelDetailScreen, arguments: {'parameters':HotelParameters(hotelCode: _entity.list[index].hotelCode)}),
//                 )),
//           ),
//         ),
//       ],
//     );
//   }
//
//
// }
//
//
