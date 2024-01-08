import 'package:location/location.dart';

class LocationService {
  static final Location location = Location();
  static bool isLocationEnabled = false;

  static Future<bool> initLocationService() async {
    // we confirm that the permissions have been granted an that the person has
    if (!await checkAvailabilityAndPermissions()) return false;
    location.changeSettings(accuracy: LocationAccuracy.balanced, interval: 10000);
    return location.enableBackgroundMode(enable: true);
  }

  static Future<String?> getCurrentLocation() async {
    if (!await checkAvailabilityAndPermissions()) return null;
    final locationData = await location.getLocation();
    return "${locationData.latitude},${locationData.longitude}";
  }

  static Future<bool> checkAvailabilityAndPermissions() async {
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return false;
      }
    }

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return false;
      }
    }

    return true;
  }
}
