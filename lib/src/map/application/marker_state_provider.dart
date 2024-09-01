import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final markerProvider =
    StateNotifierProvider<MarkerNotifier, Map<MarkerId, Marker>>(
  (ref) => MarkerNotifier(),
);

class MarkerNotifier extends StateNotifier<Map<MarkerId, Marker>> {
  MarkerNotifier() : super({});

  void addMarker({
    required String id,
    double lat = 0.0,
    double lng = 0.0,
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker,
    void Function()? onTap,
    void Function(LatLng)? onDrag,
    void Function(LatLng)? onDragStart,
    void Function(LatLng)? onDragEnd,
    String? infoTitle,
    String? snippet,
    Offset anchor = const Offset(0.5, 0.0),
    void Function()? infoOnTap,
  }) {
    final marker = Marker(
      markerId: MarkerId(id),
      position: LatLng(lat, lng),
      icon: icon,
      onTap: onTap,
      onDrag: onDrag,
      onDragStart: onDragStart,
      onDragEnd: onDragEnd,
      infoWindow: InfoWindow(
        title: infoTitle,
        snippet: snippet,
        anchor: anchor,
        onTap: infoOnTap,
      ),
    );

    state = {...state, marker.markerId: marker};
  }

  ///
  void removeMarker(String id) {
    state = {...state..remove(MarkerId(id))};
  }

  // Update an existing marker if needed
  void updateMarker(Marker updatedMarker) {
    if (state.containsKey(updatedMarker.markerId)) {
      state = {...state, updatedMarker.markerId: updatedMarker};
    }
  }

  /// Clears all markers
  void clearMarkers() {
    state = {};
  }
}
