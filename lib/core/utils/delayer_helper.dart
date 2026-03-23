import 'dart:async';

import 'package:flutter/cupertino.dart';

class DelayerHelper {
  final int _milliseconds;
  Timer? _timer;

  /// The [DelayerHelper] for this current [DelayerHelper] instance.
  DelayerHelper._({
    int? milliseconds,
  }) : _milliseconds = milliseconds ?? 1000;

  static DelayerHelper? _instance;

  static DelayerHelper get instance {
    if (_instance == null) {
      _instance = DelayerHelper._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: _milliseconds), action);
  }
}
