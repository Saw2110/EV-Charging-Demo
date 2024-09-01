import 'package:geolocator/geolocator.dart';

class MyPermission {
  static Future<bool> askPermissions() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      return false;
    }
    return true;
  }

  static Future<bool> checkPermissions() async {
    return await askPermissions();
  }
}

class MyLocation {
  Future<(double lat, double long)> getLatLong() async {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    return (position.latitude, position.longitude);
  }

  Stream<Position> getPositionStream({LocationSettings? locationSettings}) {
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  Future<String> calculateDistance(double lat, double long) async {
    var (currentLat, currentLong) = await getLatLong();
    double distanceInMeters = Geolocator.distanceBetween(
      currentLat,
      currentLong,
      lat,
      long,
    );

    double distanceInKilometers = distanceInMeters / 1000;
    return "${distanceInKilometers.toStringAsFixed(2)} KM";
  }
}
