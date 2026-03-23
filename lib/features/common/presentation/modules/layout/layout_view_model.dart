import 'package:base_app/core/utils/logger.dart';
import 'package:flutter/material.dart';



class LayoutViewModel extends ChangeNotifier {


  int _currentIndex = 2;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
  void init(int? index) {
    _currentIndex = index??4;
  }

}
