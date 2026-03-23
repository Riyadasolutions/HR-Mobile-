import 'package:base_app/features/common/domain/entity/orders_entity.dart';

enum OrderType {
  hotelBookings,
  flightBookings,
  carRentals,
  visaApplications,
  packageInquiries,
  unknown;

  static OrderType fromString(String? value) {
    switch (value) {
      case 'hotel_bookings':
        return OrderType.hotelBookings;
      case 'flight_bookings':
        return OrderType.flightBookings;
      case 'car_rentals':
        return OrderType.carRentals;
      case 'visa_applications':
        return OrderType.visaApplications;
      case 'package_inquiries':
        return OrderType.packageInquiries;
      default:
        return OrderType.unknown;
    }
  }
}

// Hotel Booking Model
class HotelBookingModel {
  final int _id;
  final String _reference;
  final String _hotelName;
  final String _roomName;
  final String _checkIn;
  final String _checkOut;
  final String _status;

  const HotelBookingModel({
    required int id,
    required String reference,
    required String hotelName,
    required String roomName,
    required String checkIn,
    required String checkOut,
    required String status,
  })  : _id = id,
        _reference = reference,
        _hotelName = hotelName,
        _roomName = roomName,
        _checkIn = checkIn,
        _checkOut = checkOut,
        _status = status;

  factory HotelBookingModel.fromJson(Map<String, dynamic>? json) => HotelBookingModel(
        id: (json?["id"] is num) ? (json?["id"] as num).toInt() : int.tryParse(json?["id"]?.toString() ?? '0') ?? 0,
        reference: json?["reference"]?.toString() ?? '',
        hotelName: json?["hotel_name"]?.toString() ?? '',
        roomName: json?["room_name"]?.toString() ?? '',
        checkIn: json?["check_in"]?.toString() ?? '',
        checkOut: json?["check_out"]?.toString() ?? '',
        status: json?["status"]?.toString() ?? '',
      );

  int get id => _id;
  String get reference => _reference;
  String get hotelName => _hotelName;
  String get roomName => _roomName;
  String get checkIn => _checkIn;
  String get checkOut => _checkOut;
  String get status => _status;

  HotelBookingEntity toEntity() => HotelBookingEntity(
        id: _id,
        reference: _reference,
        hotelName: _hotelName,
        roomName: _roomName,
        checkIn: _checkIn,
        checkOut: _checkOut,
        status: _status,
      );
}

// Flight Booking Model
class FlightBookingModel {
  final int _id;
  final String _origin;
  final String _destination;
  final String _departureDate;
  final String _returnDate;
  final String _status;
  final String _createdAt;

  const FlightBookingModel({
    required int id,
    required String origin,
    required String destination,
    required String departureDate,
    required String returnDate,
    required String status,
    required String createdAt,
  })  : _id = id,
        _origin = origin,
        _destination = destination,
        _departureDate = departureDate,
        _returnDate = returnDate,
        _status = status,
        _createdAt = createdAt;

  factory FlightBookingModel.fromJson(Map<String, dynamic>? json) => FlightBookingModel(
        id: (json?["id"] is num) ? (json?["id"] as num).toInt() : int.tryParse(json?["id"]?.toString() ?? '0') ?? 0,
        origin: json?["origin"]?.toString() ?? '',
        destination: json?["destination"]?.toString() ?? '',
        departureDate: json?["departure_date"]?.toString() ?? '',
        returnDate: json?["return_date"]?.toString() ?? '',
        status: json?["status"]?.toString() ?? '',
        createdAt: json?["created_at"]?.toString() ?? '',
      );

  int get id => _id;
  String get origin => _origin;
  String get destination => _destination;
  String get departureDate => _departureDate;
  String get returnDate => _returnDate;
  String get status => _status;
  String get createdAt => _createdAt;

  FlightBookingEntity toEntity() => FlightBookingEntity(
        id: _id,
        origin: _origin,
        destination: _destination,
        departureDate: _departureDate,
        returnDate: _returnDate,
        status: _status,
        createdAt: _createdAt,
      );
}

// Car Rental Model
class CarRentalModel {
  final int _id;
  final String _destination;
  final String _pickupDate;
  final String _pickupTime;
  final String _status;
  final String _createdAt;

  const CarRentalModel({
    required int id,
    required String destination,
    required String pickupDate,
    required String pickupTime,
    required String status,
    required String createdAt,
  })  : _id = id,
        _destination = destination,
        _pickupDate = pickupDate,
        _pickupTime = pickupTime,
        _status = status,
        _createdAt = createdAt;

  factory CarRentalModel.fromJson(Map<String, dynamic>? json) => CarRentalModel(
        id: (json?["id"] is num) ? (json?["id"] as num).toInt() : int.tryParse(json?["id"]?.toString() ?? '0') ?? 0,
        destination: json?["destination"]?.toString() ?? '',
        pickupDate: json?["pickup_date"]?.toString() ?? '',
        pickupTime: json?["pickup_time"]?.toString() ?? '',
        status: json?["status"]?.toString() ?? '',
        createdAt: json?["created_at"]?.toString() ?? '',
      );

  int get id => _id;
  String get destination => _destination;
  String get pickupDate => _pickupDate;
  String get pickupTime => _pickupTime;
  String get status => _status;
  String get createdAt => _createdAt;

  CarRentalEntity toEntity() => CarRentalEntity(
        id: _id,
        destination: _destination,
        pickupDate: _pickupDate,
        pickupTime: _pickupTime,
        status: _status,
        createdAt: _createdAt,
      );
}

// Visa Application Model
class VisaApplicationModel {
  final int _id;
  final String _country;
  final String _visaType;
  final String _status;
  final String _createdAt;

  const VisaApplicationModel({
    required int id,
    required String country,
    required String visaType,
    required String status,
    required String createdAt,
  })  : _id = id,
        _country = country,
        _visaType = visaType,
        _status = status,
        _createdAt = createdAt;

  factory VisaApplicationModel.fromJson(Map<String, dynamic>? json) => VisaApplicationModel(
        id: (json?["id"] is num) ? (json?["id"] as num).toInt() : int.tryParse(json?["id"]?.toString() ?? '0') ?? 0,
        country: json?["country"]?.toString() ?? '',
        visaType: json?["visa_type"]?.toString() ?? '',
        status: json?["status"]?.toString() ?? '',
        createdAt: json?["created_at"]?.toString() ?? '',
      );

  int get id => _id;
  String get country => _country;
  String get visaType => _visaType;
  String get status => _status;
  String get createdAt => _createdAt;

  VisaApplicationEntity toEntity() => VisaApplicationEntity(
        id: _id,
        country: _country,
        visaType: _visaType,
        status: _status,
        createdAt: _createdAt,
      );
}

// Package Inquiry Model
class PackageInquiryModel {
  final int _id;
  final String _packageName;
  final String _image;
  final String _status;
  final String _createdAt;

  const PackageInquiryModel({
    required int id,
    required String packageName,
    required String image,
    required String status,
    required String createdAt,
  })  : _id = id,
        _packageName = packageName,
        _image = image,
        _status = status,
        _createdAt = createdAt;

  factory PackageInquiryModel.fromJson(Map<String, dynamic>? json) => PackageInquiryModel(
        id: (json?["id"] is num) ? (json?["id"] as num).toInt() : int.tryParse(json?["id"]?.toString() ?? '0') ?? 0,
        packageName: json?["package_name"]?.toString() ?? '',
        image: json?["image"]?.toString() ?? '',
        status: json?["status"]?.toString() ?? '',
        createdAt: json?["created_at"]?.toString() ?? '',
      );

  int get id => _id;
  String get packageName => _packageName;
  String get image => _image;
  String get status => _status;
  String get createdAt => _createdAt;

  PackageInquiryEntity toEntity() => PackageInquiryEntity(
        id: _id,
        packageName: _packageName,
        image: _image,
        status: _status,
        createdAt: _createdAt,
      );
}

// Order Section Model
class OrderSectionModel {
  final OrderType _type;
  final String _title;
  final List<dynamic> _data;
  final String? _message;
  final String? _description;

  const OrderSectionModel({
    required OrderType type,
    required String title,
    required List<dynamic> data,
    String? message,
    String? description,
  })  : _type = type,
        _title = title,
        _data = data,
        _message = message,
        _description = description;

  factory OrderSectionModel.fromJson(Map<String, dynamic>? json) {
    final typeString = json?["type"]?.toString() ?? '';
    final type = OrderType.fromString(typeString);
    final title = json?["title"]?.toString() ?? '';
    final data = json?["data"] as List<dynamic>? ?? [];
    final message = json?["message"]?.toString();
    final description = json?["description"]?.toString();

    return OrderSectionModel(
      type: type,
      title: title,
      data: data,
      message: message,
      description: description,
    );
  }

  OrderType get type => _type;
  String get title => _title;
  List<dynamic> get data => _data;
  String? get message => _message;
  String? get description => _description;

  /// Parse the data list based on the order type
  List<HotelBookingModel> get hotelBookings {
    if (_type != OrderType.hotelBookings) return [];
    return _data
        .map((x) => HotelBookingModel.fromJson(x as Map<String, dynamic>?))
        .toList();
  }

  List<FlightBookingModel> get flightBookings {
    if (_type != OrderType.flightBookings) return [];
    return _data
        .map((x) => FlightBookingModel.fromJson(x as Map<String, dynamic>?))
        .toList();
  }

  List<CarRentalModel> get carRentals {
    if (_type != OrderType.carRentals) return [];
    return _data
        .map((x) => CarRentalModel.fromJson(x as Map<String, dynamic>?))
        .toList();
  }

  List<VisaApplicationModel> get visaApplications {
    if (_type != OrderType.visaApplications) return [];
    return _data
        .map((x) => VisaApplicationModel.fromJson(x as Map<String, dynamic>?))
        .toList();
  }

  List<PackageInquiryModel> get packageInquiries {
    if (_type != OrderType.packageInquiries) return [];
    return _data
        .map((x) => PackageInquiryModel.fromJson(x as Map<String, dynamic>?))
        .toList();
  }

  OrderSectionEntity toEntity() => OrderSectionEntity(
        type: _type,
        title: _title,
        hotelBookings: hotelBookings.map((e) => e.toEntity()).toList(),
        flightBookings: flightBookings.map((e) => e.toEntity()).toList(),
        carRentals: carRentals.map((e) => e.toEntity()).toList(),
        visaApplications: visaApplications.map((e) => e.toEntity()).toList(),
        packageInquiries: packageInquiries.map((e) => e.toEntity()).toList(),
        message: _message,
        description: _description,
      );
}

// Orders Model
class OrdersModel {
  final List<OrderSectionModel> _sections;

  const OrdersModel({
    required List<OrderSectionModel> sections,
  }) : _sections = sections;

  factory OrdersModel.fromJson(List<dynamic>? json) {
    if (json == null) return const OrdersModel(sections: []);

    final sections = json
        .map((x) => OrderSectionModel.fromJson(x as Map<String, dynamic>?))
        .toList();

    return OrdersModel(sections: sections);
  }

  List<OrderSectionModel> get sections => _sections;

  OrdersEntity toEntity() => OrdersEntity(
        sections: _sections.map((e) => e.toEntity()).toList(),
      );
}
