// // ignore: must_be_immutable
// import 'package:base_app/core/constants/enums.dart';
//
// import '../../domain/entity/hotel_entity.dart';
//
// class HotelModel {
//   final String _hotelCode;
//   final String _hotelName;
//   final num _rating;
//   final num _minPrice;
//   final String _currency;
//   final String _source;
//   final List<HotelTagsType> _facilities;
//   final String _address;
//   final String _description;
//   final String _image;
//   final String _cancellationPolicy;
//
//
//
//   factory HotelModel.fromJson(Map<String, dynamic>? json) {
//     return HotelModel(
//       hotelCode: json?["hotel_code"] ?? '',
//       hotelName: json?["hotel_name"] ?? '',
//       cancellationPolicy: json?["cancellation_policy"] ?? '',
//       rating: num.tryParse((json?["rating"] ?? '0').toString()) ?? 0,
//       minPrice: (json?["min_price"] ?? 0).toDouble(),
//       currency: json?["currency"] ?? '',
//       source: json?["source"] ?? '',
//       facilities: HotelTagsType.getTags(json?["facilities"]),
//
//
//       // facilities: HotelFacilities(
//       //   freeWifi: facilitiesJson["free_wifi"] ?? false,
//       //   pool: facilitiesJson["pool"] ?? false,
//       //   restaurant: facilitiesJson["restaurant"] ?? false,
//       //   spa: facilitiesJson["spa"] ?? false,
//       //   gym: facilitiesJson["gym"] ?? false,
//       //   parking: facilitiesJson["parking"] ?? false,
//       // ),
//       address: json?["address"] ?? '',
//       description: json?["description"] ?? '',
//       image: json?["image"] ?? json?["image_url"] ?? '',
//     );
//   }
//
//   HotelEntity toEntity() => HotelEntity(
//     hotelCode: _hotelCode,
//     hotelName: _hotelName,
//     cancellationPolicy: _cancellationPolicy,
//     rating: _rating,
//     minPrice: _minPrice,
//     currency: _currency,
//     source: _source,
//     facilities: _facilities,
//     address: _address,
//     description: _description,
//     image: _image,
//   );
//
//   const HotelModel({
//     required String hotelCode,
//     required String hotelName,
//     required String cancellationPolicy,
//     required num rating,
//     required num minPrice,
//     required String currency,
//     required String source,
//     required List<HotelTagsType> facilities,
//     required String address,
//     required String description,
//     required String image,
//   })  : _hotelCode = hotelCode,
//         _hotelName = hotelName,
//         _rating = rating,
//         _cancellationPolicy = cancellationPolicy,
//         _minPrice = minPrice,
//         _currency = currency,
//         _source = source,
//         _facilities = facilities,
//         _address = address,
//         _description = description,
//         _image = image;
// }
