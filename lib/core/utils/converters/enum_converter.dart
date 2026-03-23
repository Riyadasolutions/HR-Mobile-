
T enumFromString<T extends Enum>(String value, List<T> values, {T? fallback}) {
  return values.firstWhere(
        (e) => e.name == value,
    orElse: () {
      if (fallback != null) return fallback;
      throw ArgumentError('No matching enum value for "$value"');
    },
  );
}
extension EnumFromStringExtension<T extends Enum> on List<T> {
  T fromString(String value, {T? fallback}) {
    return firstWhere(
          (e) => e.name == value,
      orElse: () {
        if (fallback != null) return fallback;
        throw ArgumentError('No matching enum value for "$value"');
      },
    );
  }
  T fromValue(String value, {T? fallback}) {
    return firstWhere(  (e) => (e as dynamic).value == value,
      orElse: () {
        if (fallback != null) return fallback;
        throw ArgumentError('No matching enum value for "$value"');
      },
    );
  }
}

