// import 'package:base_app/base/presentation/component/app/facilities_view.dart';
// import 'package:base_app/base/presentation/component/component.dart';
// import 'package:base_app/core/extensions/num_extensions.dart';
// import 'package:base_app/core/res/resources.dart';
// import 'package:base_app/core/routing/navigation_services.dart';
// import 'package:base_app/features/common/domain/entity/home_data_entity.dart';
// import 'package:base_app/features/common/domain/entity/home_entity.dart';
// import 'package:base_app/features/common/domain/entity/home_item_entity.dart';
// import 'package:base_app/features/hotels/domain/parameters/hotel_filter_parameters.dart';
// import 'package:base_app/features/hotels/route_generator.dart';
// import 'package:base_app/generated/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// var itemWidth =  deviceWidth-(deviceWidth/5);
// class HotelsInspiredSection extends StatelessWidget {
//   final HomeEntity _entity;
//
//   const HotelsInspiredSection({
//     super.key,
//     required HomeEntity entity,
//   }) : _entity = entity;
//
//   @override
//   Widget build(BuildContext context) {
//     if (_entity.list.isEmpty) return const SizedBox.shrink();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         CustomTitle(title: _entity.title,desc: tr(LocaleKeys.hotelsInspiredDestinations)),
//         VerticalSpace(kFormPaddingAllNormal.h),
//         SizedBox(
//           // height: 228.h,
//           child: CustomListAnimatorData(
//             scrollDirection: Axis.horizontal ,
//             itemCount: _entity.list.length,
//             itemBuilder: (context, index) => SizedBox(width: itemWidth, child: _HotelItem(entity: _entity.list[index],)),
//           ),
//         ),
//
//       ],
//     );
//   }
// }
//
// class _HotelItem extends StatelessWidget {
//   final HomeItemEntity _entity;
//
//   const _HotelItem({
//     required HomeItemEntity entity,
//   })
//       :
//         _entity = entity;
//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//       child: GestureDetector(
//         onTap: () => NavigationService.push(HotelRoutes.hotelDetailScreen, arguments: {'parameters':HotelParameters(hotelCode: _entity.hotelCode)}),
//
//         child: Container(
//           // height: 100,
//           // width: 100,
//           decoration: BoxDecoration().cardStyle(),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Image Section with Badges
//               Stack(
//                 children: [
//                   CustomImage(
//                     imageUrl: _entity.image,
//                     height: 150.h,
//                     showHighlight: true,
//                     // width: double.infinity,
//                     fit: BoxFit.cover,
//
//                   ),
//                   // Hotel Name
//                   PositionedDirectional(
//                     bottom: kFormPaddingAllLarge.r,
//                     start: kFormPaddingAllLarge.r,
//                     child: Text(
//                       _entity.name,
//                       style: TextStyle().titleStyle(fontSize: 20).colorWhite(),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   // Top-left: Popular Badge
//                   // PositionedDirectional(start: 12.r,
//                   //     top: 12.r,
//                   //     child: CustomBadgeView(badge: BadgeEntity(
//                   //         name: tr(LocaleKeys.todayDeals),
//                   //         icon: Assets.iconsDealsIcon,
//                   //         color: 0xFFFFffff,
//                   //         backgroundColor: 0xFFFF6B35)
//                   //     )
//                   // ),
//                   // PositionedDirectional(
//                   //     start: 12.r,
//                   //     top: 12.r,
//                   //     child: CustomBadgeView(badge: BadgeEntity(
//                   //         name: _entity.cancellationPolicy,
//                   //         icon: Assets.iconsMoneyIcon,
//                   //         color: 0xFFFFffff,
//                   //         backgroundColor: 0xFFFF6B35)
//                   //     )
//                   // ),
//                   // PositionedDirectional(
//                   //   start: 12.r,
//                   //   top: 12.r,
//                   //   child: Container(
//                   //     padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 6.r),
//                   //     decoration: BoxDecoration(color: const Color(0xFFFF6B35),),
//                   //     child: Row(
//                   //       mainAxisSize: MainAxisSize.min,
//                   //       children: [
//                   //         Icon(Icons.local_fire_department, color: Colors.white, size: 16.r),
//                   //         HorizontalSpace(4.w),
//                   //         Text(
//                   //           tr(LocaleKeys.todayDeals),
//                   //           style: TextStyle().titleStyle(fontSize: 12).colorWhite(),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // Top-right: Rating Badge
//                   PositionedDirectional(
//                     end: 12.r,
//                     top: 12.r,
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 6.r),
//                       decoration: BoxDecoration(
//                         color: Colors.grey[800]!.withOpacity(0.8),
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       child: CustomRateWidget(initialRating: _entity.rating ,textColor:AppColor.textColorLite.themeColor),/*Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text('${_entity.rating}', style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite()),
//                           HorizontalSpace(4.w),
//                           Icon(Icons.star, color: Colors.amber, size: 16.r),
//                         ],
//                       ),*/
//                     ),
//                   ),
//
//                   // Bottom-right: Photo Badge
//                   // PositionedDirectional(
//                   //   end: 12.r,
//                   //   bottom: 12.r,
//                   //   child: Container(
//                   //     padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 6.r),
//                   //     decoration: BoxDecoration(color: const Color(0xFF1E3A8A).withOpacity(0.8), // Dark blue
//                   //       borderRadius: BorderRadius.circular(8.r),
//                   //     ),
//                   //     child: Row(
//                   //       mainAxisSize: MainAxisSize.min,
//                   //       children: [
//                   //         Icon(Icons.camera_alt, color: Colors.white, size: 16.r),
//                   //         HorizontalSpace(4.w),
//                   //         Text(
//                   //           tr(LocaleKeys.images),
//                   //           style: TextStyle().titleStyle(fontSize: 12).colorWhite(),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                 ],
//               ),
//               // Hotel Details Section
//               Padding(
//                 padding: EdgeInsets.all(16.r),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//
//                     CustomIconText(title: _entity.address, iconData: Icons.location_on, iconSize: 18.r,iconColor: Theme.of(context).primaryColor,isExpanded: true,),
//
//
//                     VerticalSpace(kFormPaddingAllNormal.h),
//
//                     // Facilities Badges
//                     TagsView(tags: _entity.facilities),
//
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
