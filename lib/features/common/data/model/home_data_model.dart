// import 'package:base_app/core/constants/enums.dart';
// import 'package:base_app/features/common/domain/entity/home_data_entity.dart';
//
// // Helper function to convert API facilities object format to HotelTagsType
// List<HotelTagsType> _parseFacilities(Map<String, dynamic>? facilitiesJson) {
//   if (facilitiesJson == null) return [];
//
//   final List<HotelTagsType> facilities = [];
//
//   // Check each facility key
//   if (facilitiesJson["wifi"] == true) {
//     facilities.add(HotelTagsType.freeWifi);
//   }
//   if (facilitiesJson["swimming-pool"] == true || facilitiesJson["pool"] == true) {
//     facilities.add(HotelTagsType.pool);
//   }
//   if (facilitiesJson["utensils"] == true || facilitiesJson["restaurant"] == true) {
//     facilities.add(HotelTagsType.restaurant);
//   }
//   if (facilitiesJson["spa"] == true) {
//     facilities.add(HotelTagsType.spa);
//   }
//   if (facilitiesJson["gym"] == true || facilitiesJson["fitness"] == true) {
//     facilities.add(HotelTagsType.gym);
//   }
//   if (facilitiesJson["parking"] == true) {
//     facilities.add(HotelTagsType.parking);
//   }
//
//   return facilities;
// }
//
// class SelectedOfferModel {
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
//   const SelectedOfferModel({
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
//   factory SelectedOfferModel.fromJson(Map<String, dynamic>? json) => SelectedOfferModel(
//         hotelCode: json?["hotel_code"] ?? '',
//         name: json?["name"] ?? '',
//         address: json?["address"] ?? '',
//         city: json?["city"] ?? '',
//         country: json?["country"] ?? '',
//         image: json?["image"] ?? '',
//         rating: num.tryParse((json?["rating"] ?? 0).toString()) ?? 0,
//         discount: json?["discount"] ?? '',
//         source: json?["source"] ?? '',
//         amenities: _parseFacilities(json?["facilities"] as Map<String, dynamic>?),
//       );
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
//
//   SelectedOfferEntity toEntity() => SelectedOfferEntity(
//         hotelCode: _hotelCode,
//         name: _name,
//         address: _address,
//         city: _city,
//         country: _country,
//         image: _image,
//         rating: _rating,
//         discount: _discount,
//         source: _source,
//         amenities: _amenities,
//       );
// }
//
// class FeaturedDestinationModel {
//   final int _id;
//   final String _name;
//   final String _image;
//   final String _code;
//   final String _countryCode;
//   final int _hotelsCount;
//   final bool _trending;
//
//   const FeaturedDestinationModel({
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
//   factory FeaturedDestinationModel.fromJson(Map<String, dynamic>? json) => FeaturedDestinationModel(
//         id: json?["id"] ?? 0,
//         name: json?["name"] ?? '',
//         image: json?["image"] ?? '',
//         code: json?["code"] ?? '',
//         countryCode: json?["country_code"] ?? '',
//         hotelsCount: json?["hotels_count"] ?? 0,
//         trending: json?["trending"] ?? false,
//       );
//
//   int get id => _id;
//   String get name => _name;
//   String get image => _image;
//   String get code => _code;
//   String get countryCode => _countryCode;
//   int get hotelsCount => _hotelsCount;
//   bool get trending => _trending;
//
//   FeaturedDestinationEntity toEntity() => FeaturedDestinationEntity(
//         id: _id,
//         name: _name,
//         image: _image,
//         code: _code,
//         countryCode: _countryCode,
//         hotelsCount: _hotelsCount,
//         trending: _trending,
//       );
// }
//
// class FeaturedStayModel {
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
//   const FeaturedStayModel({
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
//   factory FeaturedStayModel.fromJson(Map<String, dynamic>? json) => FeaturedStayModel(
//         hotelCode: json?["hotel_code"] ?? '',
//         name: json?["name"] ?? '',
//         address: json?["address"] ?? '',
//         city: json?["city"] ?? '',
//         country: json?["country"] ?? '',
//         image: json?["image"] ?? '',
//         rating: num.tryParse((json?["rating"] ?? 0).toString()) ?? 0,
//         source: json?["source"] ?? '',
//         amenities: _parseFacilities(json?["facilities"] as Map<String, dynamic>?),
//       );
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
//
//   FeaturedStayEntity toEntity() => FeaturedStayEntity(
//         hotelCode: _hotelCode,
//         name: _name,
//         address: _address,
//         city: _city,
//         country: _country,
//         image: _image,
//         rating: _rating,
//         source: _source,
//         amenities: _amenities,
//       );
// }
//
// class TestimonialModel {
//   final int _id;
//   final String _name;
//   final String _avatarLetter;
//   final String _timeAgo;
//   final num _rating;
//   final String _review;
//   final bool _verified;
//
//   const TestimonialModel({
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
//   factory TestimonialModel.fromJson(Map<String, dynamic>? json) => TestimonialModel(
//         id: json?["id"] ?? 0,
//         name: json?["name"] ?? '',
//         avatarLetter: json?["avatar_letter"] ?? '',
//         timeAgo: json?["time_ago"] ?? '',
//         rating: num.tryParse((json?["rating"] ?? 0).toString()) ?? 0,
//         review: json?["review"] ?? '',
//         verified: json?["verified"] ?? false,
//       );
//
//   int get id => _id;
//   String get name => _name;
//   String get avatarLetter => _avatarLetter;
//   String get timeAgo => _timeAgo;
//   num get rating => _rating;
//   String get review => _review;
//   bool get verified => _verified;
//
//   TestimonialEntity toEntity() => TestimonialEntity(
//         id: _id,
//         name: _name,
//         avatarLetter: _avatarLetter,
//         timeAgo: _timeAgo,
//         rating: _rating,
//         review: _review,
//         verified: _verified,
//       );
// }
//
// class FiltersAvailableModel {
//   final List<dynamic> _stars;
//
//   const FiltersAvailableModel({
//     required List<dynamic> stars,
//   }) : _stars = stars;
//
//   factory FiltersAvailableModel.fromJson(Map<String, dynamic>? json) => FiltersAvailableModel(
//         stars: List<dynamic>.from(json?["stars"] ?? []),
//       );
//
//   List<dynamic> get stars => _stars;
//
//   FiltersAvailableEntity toEntity() => FiltersAvailableEntity(
//         stars: _stars,
//       );
// }
//
// class HomeDataModel {
//   final List<SelectedOfferModel> _selectedOffers;
//   final List<FeaturedDestinationModel> _featuredDestinations;
//   final List<FeaturedStayModel> _featuredStays;
//   final List<TestimonialModel> _testimonials;
//   final FiltersAvailableModel _filtersAvailable;
//
//   const HomeDataModel({
//     required List<SelectedOfferModel> selectedOffers,
//     required List<FeaturedDestinationModel> featuredDestinations,
//     required List<FeaturedStayModel> featuredStays,
//     required List<TestimonialModel> testimonials,
//     required FiltersAvailableModel filtersAvailable,
//   })  : _selectedOffers = selectedOffers,
//         _featuredDestinations = featuredDestinations,
//         _featuredStays = featuredStays,
//         _testimonials = testimonials,
//         _filtersAvailable = filtersAvailable;
//
//   factory HomeDataModel.fromJson(Map<String, dynamic>? json) {
//     // The new API structure has data as an array of sections
//     final filtersJson = json?["filters_available"] as Map<String, dynamic>?;
//     final sections = json?["data"] as List<dynamic>?;
//
//     List<SelectedOfferModel> selectedOffers = [];
//     List<FeaturedDestinationModel> featuredDestinations = [];
//     List<FeaturedStayModel> featuredStays = [];
//     List<TestimonialModel> testimonials = [];
//
//     if (sections != null) {
//       for (var section in sections) {
//         final sectionMap = section as Map<String, dynamic>?;
//         if (sectionMap == null) continue;
//
//         final type = sectionMap["type"]?.toString() ?? '';
//         final data = sectionMap["data"] as List<dynamic>?;
//
//         if (data == null) continue;
//
//         switch (type) {
//           case 'amazing_deals':
//             selectedOffers = List<SelectedOfferModel>.from(
//               data.map((x) => SelectedOfferModel.fromJson(x as Map<String, dynamic>?)),
//             );
//             break;
//           case 'featured_destinations':
//             featuredDestinations = List<FeaturedDestinationModel>.from(
//               data.map((x) => FeaturedDestinationModel.fromJson(x as Map<String, dynamic>?)),
//             );
//             break;
//           case 'hotels_inspired':
//             featuredStays = List<FeaturedStayModel>.from(
//               data.map((x) => FeaturedStayModel.fromJson(x as Map<String, dynamic>?)),
//             );
//             break;
//           case 'reviews':
//             testimonials = List<TestimonialModel>.from(
//               data.map((x) => TestimonialModel.fromJson(x as Map<String, dynamic>?)),
//             );
//             break;
//         }
//       }
//     }
//
//     return HomeDataModel(
//       selectedOffers: selectedOffers,
//       featuredDestinations: featuredDestinations,
//       featuredStays: featuredStays,
//       testimonials: testimonials,
//       filtersAvailable: FiltersAvailableModel.fromJson(filtersJson),
//     );
//   }
//
//   List<SelectedOfferModel> get selectedOffers => _selectedOffers;
//   List<FeaturedDestinationModel> get featuredDestinations => _featuredDestinations;
//   List<FeaturedStayModel> get featuredStays => _featuredStays;
//   List<TestimonialModel> get testimonials => _testimonials;
//   FiltersAvailableModel get filtersAvailable => _filtersAvailable;
//
//   HomeDataEntity toEntity() => HomeDataEntity(
//         selectedOffers: _selectedOffers.map((e) => e.toEntity()).toList(),
//         featuredDestinations: _featuredDestinations.map((e) => e.toEntity()).toList(),
//         featuredStays: _featuredStays.map((e) => e.toEntity()).toList(),
//         testimonials: _testimonials.map((e) => e.toEntity()).toList(),
//         filtersAvailable: _filtersAvailable.toEntity(),
//       );
// }
