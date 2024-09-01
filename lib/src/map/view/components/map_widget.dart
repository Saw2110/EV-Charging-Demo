import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  final void Function(GoogleMapController)? onMapCreated;
  final CustomInfoWindowController infoWindowController;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  final LatLng currentLocation;
  final Function(LatLng) onMapTap;
  final Function() onCameraMove;

  const MapWidget({
    super.key,
    required this.onMapCreated,
    required this.infoWindowController,
    required this.markers,
    required this.polylines,
    required this.currentLocation,
    required this.onMapTap,
    required this.onCameraMove,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<int>(
          future: Future.delayed(const Duration(seconds: 2), () => 2),
          builder: (context, snapShot) {
            if (snapShot.hasData) {
              return GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 15.0,
                ),
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: true,
                onTap: onMapTap,
                onCameraMove: (_) => onCameraMove(),
                onMapCreated: onMapCreated,
              );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          },
        ),
        CustomInfoWindow(
          controller: infoWindowController,
          height: 100,
          width: 150,
          offset: 50,
        ),
      ],
    );
  }
}
