extension MapKeyValueExtension on Map {
  /// Returns the value assigned to the [key] if `key` exists in the map, otherwise returns `null`.
  dynamic get(String key) {
    if (containsKey(key)) {
      return this[key];
    }
    return null;
  }
}
