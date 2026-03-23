import 'package:base_app/features/common/domain/entity/address_entity.dart';

// ignore: must_be_immutable
class AddressModel {

  final int _id;
  final String _city;
  final String _address;
  final int _patientId;
  final int _areaId;
  final bool _isDefault;
  final String _createdAt;
  final String _updatedAt;
  final double _lat;
  final double _lng;
  final String _mapAddress;

  AddressEntity toEntity() => AddressEntity(
    id: this._id,
    city: this._city,
    address: this._address,
    patientId: this._patientId,
    areaId: this._areaId,
    isDefault: this._isDefault,
    createdAt: this._createdAt,
    updatedAt: this._updatedAt,
    lat: this._lat,
    lng: this._lng,
    mapAddress: this._mapAddress,
  );

  AddressModel({
    required int id,
    required String city,
    required String address,
    required int patientId,
    required int areaId,
    required bool isDefault,
    required String createdAt,
    required String updatedAt,
    required double lat,
    required double lng,
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

//

  factory AddressModel.fromJson(Map<String, dynamic>? json) => AddressModel(
        id: json?["id"] ?? 0,
        createdAt: json?["created_at"] ?? '',
        updatedAt: json?["updated_at"] ?? '',
        city: json?["city"] ?? '',
        address: json?["address"] ?? '',
        patientId: json?["patient_id"] ?? 0,
        areaId: json?["area_id"] ?? 0,
        isDefault: json?["is_default"] ?? false,
        lat: double.tryParse(json?["lat"]?.toString() ?? '') ?? 0.0,
        lng: double.tryParse(json?["lng"]?.toString() ?? '') ?? 0.0,
        mapAddress: json?["map_address"] ?? '',
      );
}
