import 'package:base_app/core/constants/enums.dart' show HomeItemsType;
import 'package:base_app/features/common/domain/entity/home_entity.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/home/widgets/amazing_deals_section.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/home/widgets/social_links_section.dart';
import 'package:base_app/features/common/presentation/modules/layout/children/home/widgets/testimonials_section.dart';
import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final HomeEntity _entity;
  final int _index;

  const HomeItem({super.key,
    required HomeEntity entity,
    required int index,
  })  : _entity = entity,
        _index = index;
  // enum HomeItemsType { non, amazing_deals, featured_destinations, hotels_inspired, reviews, hero_slider, social_links }
  @override
  Widget build(BuildContext context) {
    switch (_entity.type) {
      case HomeItemsType.amazing_deals:return AmazingDealsSection(entity: _entity);
      // case HomeItemsType.featured_destinations:return FeaturedDestinationsSection(entity: _entity);

      // case HomeItemsType.hotels_inspired:return FeaturedStaysSection(entity: _entity);
      // case HomeItemsType.hotels_inspired:return HotelsInspiredSection(entity: _entity);
      case HomeItemsType.reviews:return TestimonialsSection(entity: _entity);
      case HomeItemsType.social_links:return SocialLinksSection(entity: _entity);
      //

      // case HomeItemsType.amazing_deals:return FeaturedDestinationsSection(entity: _entity);

      // case HomeItemsType.categories:return HomeCategoryView(entity: _entity);
      // case HomeItemsType.banners:return GestureDetector(onTap: () {}, child: CustomImageSlider(sliders: _entity.banners.map((e) => e.image).toList()));
      // case HomeItemsType.bookingCount:return BookingView(count: _entity.bookingCount);
      default:const SizedBox();
    }
    return const SizedBox();
  }

}
