extension MapKeyValueExtension on Map {
  dynamic get(String key) {
    if (containsKey(key)) {
      return this[key];
    }
    return null;
  }
}
