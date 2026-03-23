import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/features/common/domain/entity/home_item_entity.dart';

// // Helper function to parse facilities and get the first one (since entity expects single HotelTagsType)
// List<HotelTagsType> _parseFacility(Map<String, dynamic>? facilitiesJson) {
//   if (facilitiesJson == null) return null;
  
//   // Return the first facility found
//   if (facilitiesJson["wifi"] == true) {
//     return HotelTagsType.freeWifi;
//   }
//   if (facilitiesJson["swimming-pool"] == true || facilitiesJson["pool"] == true) {
//     return HotelTagsType.pool;
//   }
//   if (facilitiesJson["utensils"] == true || facilitiesJson["restaurant"] == true) {
//     return HotelTagsType.restaurant;
//   }
//   if (facilitiesJson["spa"] == true) {
//     return HotelTagsType.spa;
//   }
//   if (facilitiesJson["gym"] == true || facilitiesJson["fitness"] == true) {
//     return HotelTagsType.gym;
//   }
//   if (facilitiesJson["parking"] == true) {
//     return HotelTagsType.parking;
//   }
  
//   return null;
// }

class HomeItemModel {
  final String _hotelCode;
  final String _name;
  final String _address;
  final String _city;
  final String _country;
  final String _image;
  final int _rating;
  final String _discount;
  final String _source;
  final List<HotelTagsType> _facilities;
  final int _id;
  final String _code;
  final String _countryCode;
  final int _hotelsCount;
  final bool _trending;
  final String _avatarLetter;
  final String _timeAgo;
  final String _review;
  final bool _verified;

  const HomeItemModel({
    required String hotelCode,
    required String name,
    required String address,
    required String city,
    required String country,
    required String image,
    required int rating,
    required String discount,
    required String source,
    required List<HotelTagsType> facilities,
    required int id,
    required String code,
    required String countryCode,
    required int hotelsCount,
    required bool trending,
    required String avatarLetter,
    required String timeAgo,
    required String review,
    required bool verified,
  })  : _hotelCode = hotelCode,
        _name = name,
        _address = address,
        _city = city,
        _country = country,
        _image = image,
        _rating = rating,
        _discount = discount,
        _source = source,
        _facilities = facilities,
        _id = id,
        _code = code,
        _countryCode = countryCode,
        _hotelsCount = hotelsCount,
        _trending = trending,
        _avatarLetter = avatarLetter,
        _timeAgo = timeAgo,
        _review = review,
        _verified = verified;

  factory HomeItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const HomeItemModel(
        hotelCode: '',
        name: '',
        address: '',
        city: '',
        country: '',
        image: '',
        rating: 0,
        discount: '',
        facilities: [],
        source: '',
        id: 0,
        code: '',
        countryCode: '',
        hotelsCount: 0,
        trending: false,
        avatarLetter: '',
        timeAgo: '',
        review: '',
        verified: false,
      );
    }

    return HomeItemModel(
      hotelCode: json['hotel_code']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      country: json['country']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      rating: (json['rating'] is num) ? (json['rating'] as num).toInt() : int.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      discount: json['discount']?.toString() ?? '',
      source: json['source']?.toString() ?? '',
      facilities: HotelTagsType.getTags(json["facilities"]),
      id: (json['id'] is num) ? (json['id'] as num).toInt() : int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      code: json['code']?.toString() ?? '',
      countryCode: json['country_code']?.toString() ?? '',
      hotelsCount: (json['hotels_count'] is num) ? (json['hotels_count'] as num).toInt() : int.tryParse(json['hotels_count']?.toString() ?? '0') ?? 0,
      trending: json['trending'] == true,
      avatarLetter: json['avatar_letter']?.toString() ?? '',
      timeAgo: json['time_ago']?.toString() ?? '',
      review: json['review']?.toString() ?? '',
      verified: json['verified'] == true,
    );
  }

  String get hotelCode => _hotelCode;
  String get name => _name;
  String get address => _address;
  String get city => _city;
  String get country => _country;
  String get image => _image;
  int get rating => _rating;
  String get discount => _discount;
  String get source => _source;
  List<HotelTagsType> get facilities => _facilities;
  int get id => _id;
  String get code => _code;
  String get countryCode => _countryCode;
  int get hotelsCount => _hotelsCount;
  bool get trending => _trending;
  String get avatarLetter => _avatarLetter;
  String get timeAgo => _timeAgo;
  String get review => _review;
  bool get verified => _verified;

  HomeItemEntity toEntity() => HomeItemEntity(
        hotelCode: _hotelCode,
        name: _name,
        address: _address,
        city: _city,
        country: _country,
        image: _image,
        rating: _rating,
        discount: _discount,
        source: _source,
        facilities: _facilities, // Default value if null
        id: _id,
        code: _code,
        countryCode: _countryCode,
        hotelsCount: _hotelsCount,
        trending: _trending,
        avatarLetter: _avatarLetter,
        timeAgo: _timeAgo,
        review: _review,
        verified: _verified,
      );
}
