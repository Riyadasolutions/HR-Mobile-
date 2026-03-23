import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'dart:math' as math;

class DropDownModel {

  final int _id;
  final String _title;
  final int _color;
  final String? _image;
  final String? _key;

  DropDownEntity toEntity() => DropDownEntity(
    id: this._id,
    title: this._title,
    color: this._color,
    image: this._image,
    key: this._key,
  );

  const DropDownModel({
    required int id,
    required String title,
    required int color,
    String? image,
    String? key,
  })  : _id = id,
        _title = title,
        _color = color,
        _image = image,
        _key = key;

  factory DropDownModel.fromJson(Map<String, dynamic>? json) => DropDownModel(
        id: json?["id"] ?? 0,
        title: json?["title"] ?? json?["name"] ?? '',
        image: json?["image"] ?? '',
        color: (math.Random().nextDouble() * 0xFFFFFF).toInt(),
      );


}
