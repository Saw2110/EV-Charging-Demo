import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../main.dart';

///
///
final polylineProvider =
    StateNotifierProvider<PolylineNotifier, Map<PolylineId, Polyline>>(
  (ref) => PolylineNotifier(),
);

class PolylineNotifier extends StateNotifier<Map<PolylineId, Polyline>> {
  PolylineNotifier() : super({});

  // Fetch and add polyline
  Future<void> fetchAndAddPolyline({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) async {
    final polylineCoordinates = await fetchPolylineCoordinates(
      originLat: originLat,
      originLng: originLng,
      destLat: destLat,
      destLng: destLng,
    );

    if (polylineCoordinates.isNotEmpty) {
      final polyline = createPolyline(polylineCoordinates);
      state = {...state, polyline.polylineId: polyline};
    }
  }

  ///
  Future<List<LatLng>> fetchPolylineCoordinates({
    required double originLat,
    required double originLng,
    required double destLat,
    required double destLng,
  }) async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      googleApiKey: googleMapAPIKey,
      request: PolylineRequest(
        origin: PointLatLng(originLat, originLng),
        destination: PointLatLng(destLat, destLng),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }

    return polylineCoordinates;
  }

  // Create polyline
  Polyline createPolyline(List<LatLng> coordinates) {
    return Polyline(
      polylineId: const PolylineId("route"),
      color: Colors.blue.shade400,
      width: 4,
      points: coordinates,
      patterns: const [PatternItem.dot],
    );
  }

  /// Clears all markers
  void clearPolylines() {
    state = {};
  }
}
