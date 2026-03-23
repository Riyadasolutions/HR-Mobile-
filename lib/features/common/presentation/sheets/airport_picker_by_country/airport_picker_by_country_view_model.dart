import 'package:base_app/base/domain/entities/drop_down_entity.dart';
import 'package:base_app/features/common/data/services/airports_data_service.dart';
import 'package:base_app/core/utils/logger.dart';
import 'package:flutter/material.dart';

class AirportPickerByCountryViewModel with ChangeNotifier {
  final tag = 'AirportPickerByCountryViewModel';

  ///variables
  List<DropDownEntity> _airports = [];
  DropDownEntity? _selected;
  List<DropDownEntity> _selectedList = [];
  bool _isLoading = false;
  String? _error;
  DropDownEntity? _country;

  ///getters
  List<DropDownEntity> get airports => _airports;
  DropDownEntity? get selected => _selected;
  List<DropDownEntity> get selectedList => _selectedList;
  bool get isLoading => _isLoading;
  String? get error => _error;

  init({
    DropDownEntity? defaultValue,
    List<DropDownEntity>? defaultList,
    DropDownEntity? country,
  }) {
    _selected = defaultValue;
    _selectedList = defaultList ?? [];
    _country = country;
    _isLoading = false;
    _error = null;
    
    if (country != null) {
      loadAirports();
    }
  }

  Future<void> loadAirports({ bool reload = false}) async {
    if (_country == null) {
      _error = 'Country is required';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _error = null;
    if(reload)notifyListeners();

    try {
      final airports = await AirportsDataService.getAirportsByCountry(
        _country!.title,
      );
      
      _airports = airports;
      _error = null;
    } catch (e) {
      log(tag, 'Error loading airports: $e');
      _error = 'Failed to load airports. Please try again.';
      _airports = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onItemChecked({
    required bool isChecked,
    required DropDownEntity selectedItem,
  }) {
    log(tag, 'onItemChecked: isChecked= $isChecked id= $selectedItem');
    if (isChecked) {
      log(tag, 'onItemChecked: add');
      _selectedList.add(selectedItem);
    } else {
      log(tag, 'onItemChecked: remove');
      _selectedList.removeWhere((item) => item.id == selectedItem.id);
    }
    _selectedList = [..._selectedList];
    notifyListeners();
  }

  void onSelected(DropDownEntity value) {
    log(tag, 'onSelected: $value');
    _selected = value;
    notifyListeners();
  }
}
