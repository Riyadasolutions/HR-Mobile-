// import 'package:base_app/core/constants/enums.dart';
// import 'package:equatable/equatable.dart';
//
// class SelectedOfferEntity extends Equatable {
//   final String _hotelCode;
//   final String _name;
//   final String _address;
//   final String _city;
//   final String _country;
//   final String _image;
//   final num _rating;
//   final String _discount;
//   final String _source;
//   final List<HotelTagsType> _amenities;
//
//   const SelectedOfferEntity({
//     required String hotelCode,
//     required String name,
//     required String address,
//     required String city,
//     required String country,
//     required String image,
//     required num rating,
//     required String discount,
//     required String source,
//     required List<HotelTagsType> amenities,
//   })  : _hotelCode = hotelCode,
//         _name = name,
//         _address = address,
//         _city = city,
//         _country = country,
//         _image = image,
//         _rating = rating,
//         _discount = discount,
//         _source = source,
//         _amenities = amenities;
//
//   @override
//   List<Object> get props => [_hotelCode, _name];
//
//   String get hotelCode => _hotelCode;
//   String get name => _name;
//   String get address => _address;
//   String get city => _city;
//   String get country => _country;
//   String get image => _image;
//   num get rating => _rating;
//   String get discount => _discount;
//   String get source => _source;
//   List<HotelTagsType> get amenities => _amenities;
// }
//
// class FeaturedDestinationEntity extends Equatable {
//   final int _id;
//   final String _name;
//   final String _image;
//   final String _code;
//   final String _countryCode;
//   final int _hotelsCount;
//   final bool _trending;
//
//   const FeaturedDestinationEntity({
//     required int id,
//     required String name,
//     required String image,
//     required String code,
//     required String countryCode,
//     required int hotelsCount,
//     required bool trending,
//   })  : _id = id,
//         _name = name,
//         _image = image,
//         _code = code,
//         _countryCode = countryCode,
//         _hotelsCount = hotelsCount,
//         _trending = trending;
//
//   @override
//   List<Object> get props => [_id, _name];
//
//   int get id => _id;
//   String get name => _name;
//   String get image => _image;
//   String get code => _code;
//   String get countryCode => _countryCode;
//   int get hotelsCount => _hotelsCount;
//   bool get trending => _trending;
// }
//
// class FeaturedStayEntity extends Equatable {
//   final String _hotelCode;
//   final String _name;
//   final String _address;
//   final String _city;
//   final String _country;
//   final String _image;
//   final num _rating;
//   final String _source;
//   final List<HotelTagsType> _amenities;
//
//   const FeaturedStayEntity({
//     required String hotelCode,
//     required String name,
//     required String address,
//     required String city,
//     required String country,
//     required String image,
//     required num rating,
//     required String source,
//     required List<HotelTagsType> amenities,
//   })  : _hotelCode = hotelCode,
//         _name = name,
//         _address = address,
//         _city = city,
//         _country = country,
//         _image = image,
//         _rating = rating,
//         _source = source,
//         _amenities = amenities;
//
//   @override
//   List<Object> get props => [_hotelCode, _name];
//
//   String get hotelCode => _hotelCode;
//   String get name => _name;
//   String get address => _address;
//   String get city => _city;
//   String get country => _country;
//   String get image => _image;
//   num get rating => _rating;
//   String get source => _source;
//   List<HotelTagsType> get amenities => _amenities;
// }
//
// class TestimonialEntity extends Equatable {
//   final int _id;
//   final String _name;
//   final String _avatarLetter;
//   final String _timeAgo;
//   final num _rating;
//   final String _review;
//   final bool _verified;
//
//   const TestimonialEntity({
//     required int id,
//     required String name,
//     required String avatarLetter,
//     required String timeAgo,
//     required num rating,
//     required String review,
//     required bool verified,
//   })  : _id = id,
//         _name = name,
//         _avatarLetter = avatarLetter,
//         _timeAgo = timeAgo,
//         _rating = rating,
//         _review = review,
//         _verified = verified;
//
//   @override
//   List<Object> get props => [_id, _name];
//
//   int get id => _id;
//   String get name => _name;
//   String get avatarLetter => _avatarLetter;
//   String get timeAgo => _timeAgo;
//   num get rating => _rating;
//   String get review => _review;
//   bool get verified => _verified;
// }
//
// class FiltersAvailableEntity extends Equatable {
//   final List<dynamic> _stars;
//
//   const FiltersAvailableEntity({
//     required List<dynamic> stars,
//   }) : _stars = stars;
//
//   @override
//   List<Object> get props => [_stars];
//
//   List<dynamic> get stars => _stars;
// }
//
// class HomeDataEntity extends Equatable {
//   final List<SelectedOfferEntity> _selectedOffers;
//   final List<FeaturedDestinationEntity> _featuredDestinations;
//   final List<FeaturedStayEntity> _featuredStays;
//   final List<TestimonialEntity> _testimonials;
//   final FiltersAvailableEntity _filtersAvailable;
//
//   const HomeDataEntity({
//     required List<SelectedOfferEntity> selectedOffers,
//     required List<FeaturedDestinationEntity> featuredDestinations,
//     required List<FeaturedStayEntity> featuredStays,
//     required List<TestimonialEntity> testimonials,
//     required FiltersAvailableEntity filtersAvailable,
//   })  : _selectedOffers = selectedOffers,
//         _featuredDestinations = featuredDestinations,
//         _featuredStays = featuredStays,
//         _testimonials = testimonials,
//         _filtersAvailable = filtersAvailable;
//
//   @override
//   List<Object> get props => [
//         _selectedOffers,
//         _featuredDestinations,
//         _featuredStays,
//         _testimonials,
//         _filtersAvailable,
//       ];
//
//   List<SelectedOfferEntity> get selectedOffers => _selectedOffers;
//   List<FeaturedDestinationEntity> get featuredDestinations => _featuredDestinations;
//   List<FeaturedStayEntity> get featuredStays => _featuredStays;
//   List<TestimonialEntity> get testimonials => _testimonials;
//   FiltersAvailableEntity get filtersAvailable => _filtersAvailable;
// }
