import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DropDownEntity<T> extends Equatable {
  final int _id;
  final String _title;
  final String? _image;
  final IconData? _icon;
  final String? _key;
  final int _color;
  final T? _value;

  @override
  List<Object> get props => [_id, _title];

  const DropDownEntity({
    required int id,
    required String title,
    IconData? icon,
    int color = 0xffffff,
    String? image,
    String? key,
    T? value,
  })  : _id = id,
        _title = title,
        _icon = icon,
        _color = color,
        _key = key,
        _value = value,
        _image = image;

  int get color => _color;

  String? get image => _image;

  String? get key => _key;

  T? get value => _value;
  String get title => _title;

  int get id => _id;
  IconData? get icon => _icon;
}
