import 'package:base_app/base/presentation/component/component.dart';
import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/extensions/num_extensions.dart';
import 'package:base_app/core/res/resources.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TagsView extends StatelessWidget {
  final List<HotelTagsType> _facilities;
  const TagsView({
    required List<HotelTagsType> tags,
  }) : _facilities = tags;


  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.w,
      runSpacing: 8.h,
      children: _facilities.map((e) => _buildFacilityBadge(e),).toList(),
      // children: [
        // if (_facilities.freeWifi)
        //   _buildFacilityBadge(icon: Icons.wifi, label: tr(LocaleKeys.freeWiFi), color: const Color(0xFF4a94e2)),
        // if (_facilities.pool)
        //   _buildFacilityBadge(icon: Icons.pool, label: tr(LocaleKeys.withPool), color: const Color(0xFF72e09c)),
        // if (_facilities.restaurant)
        //   _buildFacilityBadge(icon: Icons.restaurant, label: tr(LocaleKeys.restaurant), color: const Color(0xffd0a4ff)),
        // if (_facilities.spa)
        //   _buildFacilityBadge(icon: Icons.spa, label: tr(LocaleKeys.spa), color: const Color(0xFF24A99D)),
        // if (_facilities.gym)
        //   _buildFacilityBadge(icon: Icons.fitness_center, label: tr(LocaleKeys.gym), color: const Color(0xFFfca59b)),
        // if (_facilities.parking)
        //   _buildFacilityBadge(icon: Icons.local_parking, label: tr(LocaleKeys.parking), color:const Color(0xffeca65d)),
      // ],
    );
  }
  Widget _buildFacilityBadge(
     HotelTagsType value
  ) {
    var color = Color(value.color);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 6.r),
      decoration: BoxDecoration(
        color: color.withAlpha(80),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color:  color.withAlpha(80)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon( value.icon, color:  color, size: 18.r),
          HorizontalSpace(6.w),
          Text(
            tr(value.name),
            style: TextStyle().titleStyle(fontSize: 12).customColor( color),
          ),
        ],
      ),
    );
  }


}

