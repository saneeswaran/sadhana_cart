import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkLocationPermission() async {
    final Permission locationPermission = Permission.location;
    var status = await locationPermission.status;

    if (status.isDenied || status.isRestricted) {
      status = await locationPermission.request();
      if (!status.isGranted) {
        return false;
      }
    }
    return true;
  }
}
