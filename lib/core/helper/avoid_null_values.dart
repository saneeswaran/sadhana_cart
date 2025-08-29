class AvoidNullValues {
  static Map<String, dynamic> removeNullValues() {
    final Map<String, dynamic> data = {};
    data.forEach((key, value) {
      if (value != null) {
        data[key] = value;
      }
    });
    return data;
  }
}
