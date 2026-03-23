import 'package:equatable/equatable.dart';

class FiltersAvailableEntity extends Equatable {
  final List<String> _stars;
  const FiltersAvailableEntity({
    required List<String> stars,
  }) : _stars = stars;
  @override
  List<Object> get props => [_stars];
  List<String> get stars => _stars;
}