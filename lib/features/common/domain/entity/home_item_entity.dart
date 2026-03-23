import 'package:base_app/core/constants/enums.dart';

class HomeItemEntity {
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



 bool get verified => _verified;

  String get review => _review;

  String get timeAgo => _timeAgo;

  String get avatarLetter => _avatarLetter;

  bool get trending => _trending;

  int get hotelsCount => _hotelsCount;

  String get countryCode => _countryCode;

  String get code => _code;

  int get id => _id;

 List<HotelTagsType> get facilities => _facilities;

  String get source => _source;

  String get discount => _discount;

  int get rating => _rating;

  String get image => _image;

  String get country => _country;

  String get city => _city;

  String get address => _address;

  String get name => _name;

  String get hotelCode => _hotelCode;

 const HomeItemEntity({
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
  }) : _hotelCode = hotelCode,
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
}


