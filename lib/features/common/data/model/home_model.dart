import 'package:base_app/core/constants/enums.dart';
import 'package:base_app/core/utils/converters/enum_converter.dart';
import 'package:base_app/features/common/data/model/filters_available_model.dart';
import 'package:base_app/features/common/data/model/home_item_model.dart';
import 'package:base_app/features/common/domain/entity/home_entity.dart';

// ignore: must_be_immutable
class HomeModel {

  final String _title;
  final HomeItemsType _type;
  final List<HomeItemModel> _list;
  final FiltersAvailableModel _filtersAvailable;
  final dynamic _rawData;


  factory HomeModel.fromJson(Map<String, dynamic>? json,Map<String, dynamic>? filtersAvailable) {
    final type = HomeItemsType.values.fromString(json?["type"] ?? '',fallback:HomeItemsType.non );
    
    // Handle special types with different data structures
    if (type == HomeItemsType.hero_slider) {
      // hero_slider has data as a list of strings (image URLs)
      final imageUrls = (json?["data"] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ?? [];
      return HomeModel(
        title: json?["title"] ?? '',
        type: type,
        filtersAvailable: FiltersAvailableModel.fromJson(filtersAvailable),
        list: [],
        rawData: imageUrls,
      );
    } else if (type == HomeItemsType.social_links) {
      // social_links has data as a map
      return HomeModel(
        title: json?["title"] ?? '',
        type: type,
        filtersAvailable: FiltersAvailableModel.fromJson(filtersAvailable),
        list: [],
        rawData: json?["data"] ?? {},
      );
    } else {
      // Other types use HomeItemModel list
      final data = json?["data"];
      List<HomeItemModel> itemList = [];
      
      if (data is List) {
        itemList = List<HomeItemModel>.from(
          data.map((x) => HomeItemModel.fromJson(x is Map<String, dynamic> ? x : null))
        );
      }
      
      return HomeModel(
        title: json?["title"] ?? '',
        type: type,
        filtersAvailable: FiltersAvailableModel.fromJson(filtersAvailable),
        list: itemList,
        rawData: null,
      );
    }
  }

  toEntity()=>HomeEntity(
    list: this._list.map((model) => model.toEntity()).toList(),
    title: this._title,
    type: this._type,
    filtersAvailable: this._filtersAvailable.toEntity(),
    rawData: this._rawData,
  );

  const HomeModel({
    required String title,
    required HomeItemsType type,
    required List<HomeItemModel> list,
    required FiltersAvailableModel filtersAvailable,
    dynamic rawData,
  })
      : _title = title,
        _type = type,
        _list = list,
        _filtersAvailable = filtersAvailable,
        _rawData = rawData;

  dynamic get rawData => _rawData;
}
