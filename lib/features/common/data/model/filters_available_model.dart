import 'package:base_app/features/common/domain/entity/filters_available_entity.dart';

class FiltersAvailableModel {
  final List<String> _stars;
  const FiltersAvailableModel({
    required List<String> stars,
  }) : _stars = stars;
  factory FiltersAvailableModel.fromJson(Map<String, dynamic>? json) => FiltersAvailableModel(
    // stars: List<String>.from(json?["stars"] ?? []),
    stars: List<String>.from((json?["stars"]??[]).map((x) => x.toString())),

  );
  List<String> get stars => _stars;
  FiltersAvailableEntity toEntity() => FiltersAvailableEntity(
    stars: _stars,
  );
}