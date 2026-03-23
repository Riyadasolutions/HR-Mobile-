import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/features/common/domain/entity/filters_available_entity.dart';
import 'package:base_app/features/common/domain/entity/home_item_entity.dart';
import 'package:equatable/equatable.dart';

// final List<HomeEntity> dummyHomeSections = [
//   HomeEntity(title: "أفضل العروض الفندقية", type: HomeItemsType.list, list: dummyHotels),
//   HomeEntity(title: "فنادق مقترحة لك", type: HomeItemsType.list, list: dummyHotels.reversed.toList()),
//   HomeEntity(title: "الأعلي تقييم", type: HomeItemsType.list, list: dummyHotels),
// ];



class HomeEntity extends Equatable {
  final String _title;
  final HomeItemsType _type;
  final List<HomeItemEntity> _list;
  final FiltersAvailableEntity _filtersAvailable;
  final dynamic _rawData;

  @override
  List<Object?> get props => [
        _title,
        _type,
    _filtersAvailable,
        _list,
        _rawData,
      ];

  List<HomeItemEntity> get list => _list;

  HomeItemsType get type => _type;

  String get title => _title;

  FiltersAvailableEntity get filtersAvailable => _filtersAvailable;

  dynamic get rawData => _rawData;

  const HomeEntity({
    required String title,
    required HomeItemsType type,
    required List<HomeItemEntity> list,
    required FiltersAvailableEntity filtersAvailable,
    dynamic rawData,
  }) : _title = title,
       _type = type,
       _list = list,
       _filtersAvailable = filtersAvailable,
       _rawData = rawData;
}
