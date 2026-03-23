import 'package:base_app/base/data/model/response/pagination_model.dart';
import 'package:equatable/equatable.dart';

class PaginationListModel<T> extends Equatable {
  final PaginationModel _pagination;
  final List<T> _list;

  @override
  List<Object> get props => [
    _pagination,
    _list,
  ];

  const PaginationListModel({
    required PaginationModel pagination,
    required List<T> list,
  })  : _pagination = pagination,
        _list = list;

  List<T> get list => _list;
  

  PaginationModel get pagination => _pagination;
}
