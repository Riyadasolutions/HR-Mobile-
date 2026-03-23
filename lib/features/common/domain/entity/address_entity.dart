import 'dart:ui';

import 'package:base_app/core/notification/data/notification_data_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:math' as math;

// ignore: must_be_immutable

final AddressEntity demoAddress = AddressEntity(
  id: 1,
  city: "Riyadh",
  address: "Al Olaya St, Building 5, Apt 12",
  patientId: 101,
  areaId: 10,
  isDefault: true,
  createdAt: "2025-01-10T12:00:00Z",
  updatedAt: "2025-01-10T12:00:00Z",
  lat: 24.7136,
  lng: 46.6753,
  mapAddress: "Al Olaya, Riyadh 12211, Saudi Arabia",
);

class AddressEntity extends Equatable {
  final int _id;
  final String _city;
  final String _address;
  final int _patientId;
  final int _areaId;
  final bool _isDefault;
  final String _createdAt;
  final String _updatedAt;
  final double? _lat;
  final double? _lng;
  final String _mapAddress;

  @override
  List<Object> get props => [
        _id,
    _mapAddress,

      ];

  const AddressEntity({
    required int id,
    required String city,
    required String address,
    required int patientId,
    required int areaId,
    required bool isDefault,
    required String createdAt,
    required String updatedAt,
    required double? lat,
    required double? lng,
    required String mapAddress,
  })  : _id = id,
        _city = city,
        _address = address,
        _patientId = patientId,
        _areaId = areaId,
        _isDefault = isDefault,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _lat = lat,
        _lng = lng,
        _mapAddress = mapAddress;

  String get mapAddress => _mapAddress;

  double? get lng => _lng;

  double? get lat => _lat;

  String get updatedAt => _updatedAt;

  String get createdAt => _createdAt;

  bool get isDefault => _isDefault;

  int get areaId => _areaId;

  int get patientId => _patientId;

  String get address => _address;

  String get city => _city;

  int get id => _id;
}
