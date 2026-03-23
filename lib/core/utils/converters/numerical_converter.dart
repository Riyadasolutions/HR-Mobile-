
extension NumericalConverter on Object? {
  int toSafeInt({int defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (this is int) return this as int;
    if (this is double || this is num) {return (this as num).toInt();}
    if (this is String) {
      final trimmed = (this as String).trim();
      return int.tryParse(trimmed) ?? double.tryParse(trimmed)?.toInt() ?? defaultValue;
    }

    return defaultValue;
  }

  double toSafeDouble({double defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (this is int) return this as double;
    if (this is double || this is num) {return (this as num).toDouble();}
    if (this is String) {
      final trimmed = (this as String).trim();
      return double.tryParse(trimmed) ?? double.tryParse(trimmed)?.toDouble() ?? defaultValue;
    }

    return defaultValue;
  }
  num toSafeNum({num defaultValue = 0}) {
    if (this == null) return defaultValue;

    if (this is int) return this as double;
    if (this is double || this is num) {return (this as num);}
    if (this is String) {
      final trimmed = (this as String).trim();
      return num.tryParse(trimmed) ?? num.tryParse(trimmed) ?? defaultValue;
    }

    return defaultValue;
  }

}
