

import 'package:base_app/generated/assets.dart';
import 'package:base_app/generated/locale_keys.g.dart';
import 'package:flutter/material.dart';



enum GenderType{ male , female }
// enum PaymentMethodType {  cash, card, wallet, points, coupon, mada, stc, sadad, tamara, tabby }

// enum NotificationType { general  }
enum AuthMethodTypes { login , register , reset, socialLogin}


enum HomeItemsType { non, amazing_deals, featured_destinations, hotels_inspired, reviews, hero_slider, social_links }
enum BookingType { non, hotel_bookings, flight_bookings, car_rentals, visa_applications, package_inquiries }


enum NotificationType {
  general('', 0xFF4CAF50,Assets.iconsBillIcon),                 // أخضر قوي وواضح
  booking('booking', 0xFFFFEB3B,Assets.iconsMenuBookingIcon),  // أصفر فاقع
  completed('emergency_referral', 0xFFE91E63,Assets.iconsBillIcon), // وردي غامق واضح
  labOrder('lab_order', 0xFF2196F3,Assets.homeTestResultsIcon),        // أزرق سماوي قوي
  labResult('lab_result', 0xFF00E676,Assets.homeTestResultsIcon),      // أخضر فسفوري
  medication('medication', 0xFF3F51B5,Assets.homeMedicationsIcon),     // أزرق بنفسجي قوي
  dialysisOrder('dialysis_order', 0xFFFF9800,Assets.iconsBillIcon), // برتقالي فاقع
  incident('incident', 0xFFF44336,Assets.iconsBillIcon),         // أحمر واضح
  holidayTreatment('holiday_treatment', 0xFF9C27B0,Assets.iconsBillIcon), // بنفسجي فاقع
  patientDocumentReminder('patient_document_reminder', 0xFF00C853,Assets.iconsBillIcon), // أخضر غامق مشبع
  employeeDocumentReminder('employee_document_reminder', 0xFF03A9F4,Assets.iconsBillIcon), // أزرق فاتح قوي
  bookingRescheduled('booking_rescheduled', 0xFFFFC107,Assets.iconsMenuBookingIcon); // أصفر برتقالي قوي

  const NotificationType(this.value,this.color,this.icon);

  final String value;
  final String icon;
  final int color;
}


// enum BookingStatus { non, pending, failed, cancelled, successful }

enum BookingStatus {
  pending('pending',LocaleKeys.pending, 0xffFFBE4C),
  completed('successful',LocaleKeys.completed, 0xFF43A047),
  followup('followup',LocaleKeys.followup, 0xFFD4F7E3),
  failed('failed',LocaleKeys.failed, 0xFFE3E7FC),
  canceled('cancelled',LocaleKeys.canceled, 0xFFFFE2D4);

  // bool get canReschedule => this != BookingStatus.canceled && this != BookingStatus.completed && (this == BookingStatus.newOrder || this == BookingStatus.confirmed || this == BookingStatus.rescheduled );
  // bool get canCancel => this != BookingStatus.canceled && this != BookingStatus.completed && (this == BookingStatus.newOrder || this == BookingStatus.confirmed || this == BookingStatus.rescheduled );
  // bool get canCancel => this == BookingStatus.newOrder || this == BookingStatus.confirmed || this == BookingStatus.rescheduled;

  const BookingStatus(this.value,this.name,this.color);

  final String value;
  final String name;
  final int color;
}


enum MedicationType {
  homeMedications('home_medications',LocaleKeys.homeMedications, 0xFFD4F7E3),
  medications('medications',LocaleKeys.activeMedications, 0xFFE3E7FC );


  const MedicationType(this.value,this.name,this.color);

  final String value;
  final String name;
  final int color;
}


enum HotelSortType {
  defaultSort('', LocaleKeys.defaultSort),
  highestPrice('hotels_desc', LocaleKeys.highestPrice),
  lowestPrice('hotels_asc', LocaleKeys.lowestPrice);

  const HotelSortType(this.value, this.name);

  final String value;
  final String name;
}


enum HotelTagsType {
  defaultSort(value: '', name: LocaleKeys.defaultSort,icon:  Icons.face,color: 0xFFFF6B35),
  freeWifi( value:'free_wifi', name: LocaleKeys.freeWiFi,icon:  Icons.wifi,color:  0xFF4a94e2),

  pool(value: 'pool',name: LocaleKeys.withPool,icon: Icons.pool,color:  0xFF72e09c),
  swimmingPool(value: 'swimming-pool',name: LocaleKeys.withPool,icon: Icons.pool,color:  0xFF72e09c),

  restaurant(value:'restaurant', name:LocaleKeys.restaurant ,icon:  Icons.restaurant,color:  0xffd0a4ff),
  utensils(value:'utensils', name:LocaleKeys.utensils  ,icon:  Icons.restaurant_menu_sharp,color:  0xffd0a4ff),

  spa(value:'spa',name: LocaleKeys.spa ,icon:  Icons.spa,color:  0xFF24A99D),
  gym(value:'gym', name:LocaleKeys.gym ,icon:  Icons.fitness_center,color:  0xFFfca59b),
  parking(value:'parking',name: LocaleKeys.parking ,icon:  Icons.local_parking,color:  0xffeca65d),

  roomOnly(value:'room_only',name: LocaleKeys.roomOnly ,icon:  Icons.room_preferences_rounded,color:  0xFF4a94e2),
  refundable(value:'refundable',name: LocaleKeys.refundable ,icon:  Icons.monetization_on,color: 0xFF2196F3);


  // static List<HotelTagsType> get allValues => HotelTagsType.values..removeAt(0);
  static List<HotelTagsType> get facility => [freeWifi,pool,restaurant,spa,gym,parking];
  static List<HotelTagsType> get roomTags => [roomOnly,refundable];

  static List<HotelTagsType> getTags(Map<String, dynamic>? json){
    List<HotelTagsType> tags = [];
    if(json!=null){
      if(json[HotelTagsType.freeWifi.value]==true){tags.add(HotelTagsType.freeWifi);}
      if(json[HotelTagsType.pool.value]==true){tags.add(HotelTagsType.pool);}
      if(json[HotelTagsType.restaurant.value]==true){tags.add(HotelTagsType.restaurant);}
      if(json[HotelTagsType.utensils.value]==true){tags.add(HotelTagsType.restaurant);}
      if(json[HotelTagsType.spa.value]==true){tags.add(HotelTagsType.spa);}
      if(json[HotelTagsType.gym.value]==true){tags.add(HotelTagsType.gym);}
      if(json[HotelTagsType.parking.value]==true){tags.add(HotelTagsType.parking);}
      if(json[HotelTagsType.roomOnly.value]==true){tags.add(HotelTagsType.roomOnly);}
      if(json[HotelTagsType.refundable.value]==true){tags.add(HotelTagsType.refundable);}
      if(json[HotelTagsType.swimmingPool.value]==true){tags.add(HotelTagsType.swimmingPool);}
      if(json[HotelTagsType.utensils.value]==true){tags.add(HotelTagsType.utensils);}



    }
    return tags ;
  }




  // const HotelFacilityType(this.value, this.name);
  const HotelTagsType({required String value, required String name,required IconData icon,required int color}) : _value=value, _name=name, _icon=icon, _color=color;

  String get value => _value;
  String get name => this._name;
  IconData get icon => this._icon;
  int get color => this._color;


  final String _value;
  final String _name;
  final IconData _icon;
  final int _color;
}


//         if (_facilities.freeWifi)
//           _buildFacilityBadge(icon: Icons.wifi, label: tr(LocaleKeys.freeWiFi), color: const Color(0xFF4a94e2)),
//         if (_facilities.pool)
//           _buildFacilityBadge(icon: Icons.pool, label: tr(LocaleKeys.withPool), color: const Color(0xFF72e09c)),
//         if (_facilities.restaurant)
//           _buildFacilityBadge(icon: Icons.restaurant, label: tr(LocaleKeys.restaurant), color: const Color(0xffd0a4ff)),
//         if (_facilities.spa)
//           _buildFacilityBadge(icon: Icons.spa, label: tr(LocaleKeys.spa), color: const Color(0xFF24A99D)),
//         if (_facilities.gym)
//           _buildFacilityBadge(icon: Icons.fitness_center, label: tr(LocaleKeys.gym), color: const Color(0xFFfca59b)),
//         if (_facilities.parking)
//           _buildFacilityBadge(icon: Icons.local_parking, label: tr(LocaleKeys.parking), color:const Color(0xffeca65d)),
GenderType kGetGenderTypeByKey(var type){
  switch(type){
    case 1: return GenderType.male;
    case 2: return GenderType.female;
    case"male": return GenderType.male;
    case"female": return GenderType.female;
    default:return GenderType.male;
  }
}