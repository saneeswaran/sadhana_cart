import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  //keys stored
  final String isOnboard = "isOnboard";
  static Future<bool> storeDetails({
    required String key,
    required dynamic value,
  }) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.setBool(key, value);
  }
}
