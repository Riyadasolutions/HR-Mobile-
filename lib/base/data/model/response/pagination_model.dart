


import 'package:base_app/base/domain/entities/pagination_entity.dart';

class PaginationModel {

  final int _currentPage;
  final int _lastPage;
  final int _perPage;
  final int _total;
  final bool _hasMorePages;

  PaginationEntity toEntity() => PaginationEntity(
    currentPage: this._currentPage,
    lastPage: this._lastPage,
    perPage: this._perPage,
    total: this._total,
    hasMorePages: this._hasMorePages,
  );

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      PaginationModel(
          currentPage: json["current_page"] ?? 1,
          lastPage: json["total_pages"] ?? 1,
          perPage: json["per_page"] ?? 1,
          total: json["total_items"] ?? 1,
          hasMorePages: ((json["total_pages"] ?? 1) > (json["current_page"] ?? 1)));

  const PaginationModel({
    required int currentPage,
    required int lastPage,
    required int perPage,
    required int total,
    required bool hasMorePages,
  })  : _currentPage = currentPage,
        _lastPage = lastPage,
        _perPage = perPage,
        _total = total,
        _hasMorePages = hasMorePages;
}
