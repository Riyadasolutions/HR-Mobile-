import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:base_app/features/common/domain/entity/home_entity.dart';
import 'package:base_app/features/common/domain/entity/home_item_entity.dart';
import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  final HomeEntity _entity;

  const TestimonialsSection({
    super.key,
    required HomeEntity entity,
  }) : _entity = entity;

  @override
  Widget build(BuildContext context) {
    if (_entity.list.isEmpty) return const SizedBox.shrink();

    // Calculate average rating
    final averageRating = _entity.list.isNotEmpty
        ? _entity.list.map((t) => t.rating).reduce((a, b) => a + b) / _entity.list.length
        : 0.0;
    final totalReviews = _entity.list.length;

    return Container(
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        //   colors: [
        //     const Color(0xFF6B46C1).withValues(alpha: 0.8),
        //     const Color(0xFF4C1D95).withValues(alpha: 0.6),
        //   ],
        // ),
      ).radius().imageBackground(Assets.imagesTestimonialsBackgroundImage),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          VerticalSpace(kFormPaddingAllLarge.h),
          // Testimonials Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF8B4513),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Text(
              _entity.title,
              style: TextStyle().semiBoldStyle(fontSize: 12).colorWhite(),
            ),
          ),
          VerticalSpace(kFormPaddingAllNormal.h),
          // Main Title
          Text(
            tr(LocaleKeys.whatOurCustomersSay),
            style: TextStyle().titleStyle(fontSize: 28).colorWhite(),
            textAlign: TextAlign.center,
          ),
          VerticalSpace(4.h),
          Text(
            tr(LocaleKeys.realReviewsFromCustomers),
            style: TextStyle().regularStyle(fontSize: 14).customColor(Colors.white.withValues(alpha: 0.8)),
            textAlign: TextAlign.center,
          ),
          VerticalSpace(kFormPaddingAllLarge.h),
          // Overall Rating Box
          Container(
            margin: EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
            padding: EdgeInsets.all(kFormPaddingAllLarge.r),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 24.r,
                    ),
                  ),
                ),
                HorizontalSpace(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      averageRating.toStringAsFixed(1),
                      style: TextStyle().titleStyle(fontSize: 32).colorWhite(),
                    ),
                    Text(
                      "BASED ON $totalReviews ${tr(LocaleKeys.reviews).toUpperCase()}",
                      style: TextStyle().regularStyle(fontSize: 10).customColor(Colors.white.withValues(alpha: 0.8)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          VerticalSpace(kFormPaddingAllLarge.h),
          // Testimonial Cards
          Container(
            padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),

            // height: 200.h,
            child: CustomListAnimatorData(
              scrollDirection: Axis.horizontal ,
              itemCount: _entity.list.length,
              itemBuilder: (context, index) =>
                  SizedBox(width: deviceWidth-(deviceWidth/5), child: _TestimonialCard(testimonial: _entity.list[index])),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: kFormPaddingAllLarge.w),
          //   child: SingleChildScrollView(
          //     child: Row(
          //       children: _entity.list.take(2).map((testimonial) {
          //         return Container(
          //           margin: EdgeInsetsDirectional.only(
          //             end: testimonial != _entity.list.first ? kFormPaddingAllNormal.w : 0,
          //           ),
          //           child: _TestimonialCard(testimonial: testimonial),
          //         );
          //       }).toList(),
          //     ),
          //   ),
          // ),
          VerticalSpace(kFormPaddingAllLarge.h),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final HomeItemEntity _testimonial;

  const _TestimonialCard({required HomeItemEntity testimonial})
      : _testimonial = testimonial;

  Color _getAvatarColor(String letter) {
    // Generate a color based on the first letter
    final colors = [
      const Color(0xFF4A90E2), // Blue
      const Color(0xFFE91E63), // Pink
      const Color(0xFF9C27B0), // Purple
      const Color(0xFF00BCD4), // Cyan
      const Color(0xFFFF9800), // Orange
    ];
    final index = letter.codeUnitAt(0) % colors.length;
    return colors[index];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 190.h),
      padding: EdgeInsets.all(kFormPaddingAllLarge.r),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stars
          Row(
            children: List.generate(
              5,
              (index) => Icon(
                Icons.star,
                color: Colors.amber,
                size: 16.r,
              ),
            ),
          ),
          VerticalSpace(12.h),
          // Review Text
          Text(
            _testimonial.review,
            style: TextStyle().regularStyle(fontSize: 14).colorWhite(),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          VerticalSpace(16.h),
          // User Info
          Row(
            children: [
              // Avatar
              Container(
                width: 40.r,
                height: 40.r,
                decoration: BoxDecoration(
                  color: _getAvatarColor(_testimonial.avatarLetter),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    _testimonial.avatarLetter,
                    style: TextStyle().semiBoldStyle(fontSize: 18).colorWhite(),
                  ),
                ),
              ),
              HorizontalSpace(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _testimonial.name,
                      style: TextStyle().semiBoldStyle(fontSize: 14).colorWhite(),
                    ),
                    VerticalSpace(2.h),
                    Text(
                      _testimonial.timeAgo,
                      style: TextStyle().regularStyle(fontSize: 12).customColor(Colors.white.withValues(alpha: 0.7)),
                    ),
                  ],
                ),
              ),
              // Verified Badge
              if (_testimonial.verified)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Colors.white, size: 14.r),
                      HorizontalSpace(4.w),
                      Text(
                        tr(LocaleKeys.verifiedBooking),
                        style: TextStyle().semiBoldStyle(fontSize: 10).colorWhite(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
