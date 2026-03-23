import 'package:base_app/features/common/data/model/orders_model.dart';
import 'package:equatable/equatable.dart';

// Hotel Booking Entity
class HotelBookingEntity extends Equatable {
  final int _id;
  final String _reference;
  final String _hotelName;
  final String _roomName;
  final String _checkIn;
  final String _checkOut;
  final String _status;

  const HotelBookingEntity({
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

  @override
  List<Object> get props => [_id, _reference];

  int get id => _id;
  String get reference => _reference;
  String get hotelName => _hotelName;
  String get roomName => _roomName;
  String get checkIn => _checkIn;
  String get checkOut => _checkOut;
  String get status => _status;
}

// Flight Booking Entity
class FlightBookingEntity extends Equatable {
  final int _id;
  final String _origin;
  final String _destination;
  final String _departureDate;
  final String _returnDate;
  final String _status;
  final String _createdAt;

  const FlightBookingEntity({
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

  @override
  List<Object> get props => [_id, _origin, _destination];

  int get id => _id;
  String get origin => _origin;
  String get destination => _destination;
  String get departureDate => _departureDate;
  String get returnDate => _returnDate;
  String get status => _status;
  String get createdAt => _createdAt;
}

// Car Rental Entity
class CarRentalEntity extends Equatable {
  final int _id;
  final String _destination;
  final String _pickupDate;
  final String _pickupTime;
  final String _status;
  final String _createdAt;

  const CarRentalEntity({
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

  @override
  List<Object> get props => [_id, _destination];

  int get id => _id;
  String get destination => _destination;
  String get pickupDate => _pickupDate;
  String get pickupTime => _pickupTime;
  String get status => _status;
  String get createdAt => _createdAt;
}

// Visa Application Entity
class VisaApplicationEntity extends Equatable {
  final int _id;
  final String _country;
  final String _visaType;
  final String _status;
  final String _createdAt;

  const VisaApplicationEntity({
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

  @override
  List<Object> get props => [_id, _country, _visaType];

  int get id => _id;
  String get country => _country;
  String get visaType => _visaType;
  String get status => _status;
  String get createdAt => _createdAt;
}

// Package Inquiry Entity
class PackageInquiryEntity extends Equatable {
  final int _id;
  final String _packageName;
  final String _image;
  final String _status;
  final String _createdAt;

  const PackageInquiryEntity({
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

  @override
  List<Object> get props => [_id, _packageName];

  int get id => _id;
  String get packageName => _packageName;
  String get image => _image;
  String get status => _status;
  String get createdAt => _createdAt;
}

// Order Section Entity
class OrderSectionEntity extends Equatable {
  final OrderType _type;
  final String _title;
  final List<HotelBookingEntity> _hotelBookings;
  final List<FlightBookingEntity> _flightBookings;
  final List<CarRentalEntity> _carRentals;
  final List<VisaApplicationEntity> _visaApplications;
  final List<PackageInquiryEntity> _packageInquiries;
  final String? _message;
  final String? _description;

  const OrderSectionEntity({
    required OrderType type,
    required String title,
    required List<HotelBookingEntity> hotelBookings,
    required List<FlightBookingEntity> flightBookings,
    required List<CarRentalEntity> carRentals,
    required List<VisaApplicationEntity> visaApplications,
    required List<PackageInquiryEntity> packageInquiries,
    String? message,
    String? description,
  })  : _type = type,
        _title = title,
        _hotelBookings = hotelBookings,
        _flightBookings = flightBookings,
        _carRentals = carRentals,
        _visaApplications = visaApplications,
        _packageInquiries = packageInquiries,
        _message = message,
        _description = description;

  @override
  List<Object?> get props => [
        _type,
        _title,
        _hotelBookings,
        _flightBookings,
        _carRentals,
        _visaApplications,
        _packageInquiries,
        _message,
        _description,
      ];

  OrderType get type => _type;
  String get title => _title;
  List<HotelBookingEntity> get hotelBookings => _hotelBookings;
  List<FlightBookingEntity> get flightBookings => _flightBookings;
  List<CarRentalEntity> get carRentals => _carRentals;
  List<VisaApplicationEntity> get visaApplications => _visaApplications;
  List<PackageInquiryEntity> get packageInquiries => _packageInquiries;
  String? get message => _message;
  String? get description => _description;

  bool get isEmpty => _hotelBookings.isEmpty &&
      _flightBookings.isEmpty &&
      _carRentals.isEmpty &&
      _visaApplications.isEmpty &&
      _packageInquiries.isEmpty;
}

// Orders Entity
class OrdersEntity extends Equatable {
  final List<OrderSectionEntity> _sections;

  const OrdersEntity({
    required List<OrderSectionEntity> sections,
  }) : _sections = sections;

  @override
  List<Object> get props => [_sections];

  List<OrderSectionEntity> get sections => _sections;
}
