import 'package:base_app/base/domain/entities/pagination_entity.dart';
import 'package:equatable/equatable.dart';

class PaginationListEntity<T> extends Equatable {
  final PaginationEntity _pagination;
  final List<T> _list;

  @override
  List<Object> get props => [
    _pagination,
    _list,
  ];

  const PaginationListEntity({
    required PaginationEntity pagination,
    required List<T> list,
  })  : _pagination = pagination,
        _list = list;

  List<T> get list => _list;

  PaginationEntity get pagination => _pagination;
}
