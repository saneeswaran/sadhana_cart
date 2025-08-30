class AvoidNullValues {
  static Map<String, dynamic> removeNullValues(Map<String, dynamic> data) {
    final Map<String, dynamic> newMap = {};
    data.forEach((key, value) {
      if (value != null) {
        newMap[key] = value;
      }
    });
    return newMap;
  }
}
