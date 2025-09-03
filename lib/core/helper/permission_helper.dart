import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkLocationPermission() async {
    final Permission locationPermission = Permission.location;

    if (await locationPermission.isDenied) {
      return await locationPermission.request().isGranted;
    } else {
      return true;
    }
  }
}
