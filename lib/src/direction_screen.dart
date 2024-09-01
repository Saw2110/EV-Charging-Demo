import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../core/core.dart';
import 'map/map.dart';

class DirectionsPage extends ConsumerStatefulWidget {
  final EvChargingModel destination;

  const DirectionsPage({super.key, required this.destination});

  @override
  ConsumerState<DirectionsPage> createState() => _DirectionsPageState();
}

class _DirectionsPageState extends ConsumerState<DirectionsPage> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  StreamSubscription<Position>? _positionSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _setupInitialDirections();
    });
  }

  @override
  void dispose() {
    _positionSubscription
        ?.cancel(); // Cancel the subscription to avoid memory leaks
    super.dispose();
  }

  Future<void> _setupInitialDirections() async {
    final (lat, long) = await MyLocation().getLatLong();
    await ref.read(polylineProvider.notifier).fetchAndAddPolyline(
          originLat: lat,
          originLng: long,
          destLat: widget.destination.latitude,
          destLng: widget.destination.longitude,
        );

    _moveCameraToCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    final polylines = ref.watch(polylineProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.destination.name)),
      body: StreamBuilder<Position>(
        stream: ref.watch(myLocationPositionStream),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No location data available"));
          }

          final currentPosition = snapshot.data!;
          final markers = _createMarkers(currentPosition);

          return GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              bearing: currentPosition.heading,
              target: LatLng(
                currentPosition.latitude,
                currentPosition.longitude,
              ),
              zoom: 20,
              tilt: 90,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            polylines: Set<Polyline>.of(polylines.values),
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
              _subscribeToLocationUpdates();
            },
          );
        },
      ),
    );
  }

  Set<Marker> _createMarkers(Position currentPosition) {
    return {
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        infoWindow: const InfoWindow(title: "Your Location"),
      ),
      Marker(
        markerId: const MarkerId("destination"),
        position: LatLng(
          widget.destination.latitude,
          widget.destination.longitude,
        ),
        infoWindow: const InfoWindow(title: "Destination"),
      ),
    };
  }

  void _subscribeToLocationUpdates() {
    _positionSubscription =
        ref.read(myLocationPositionStream).listen((newLocation) async {
      final controller = await _mapController.future;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            bearing: newLocation.heading,
            target: LatLng(
              newLocation.latitude,
              newLocation.longitude,
            ),
            zoom: 20,
            tilt: 90,
          ),
        ),
      );
    });
  }

  Future<void> _moveCameraToCurrentLocation() async {
    final controller = await _mapController.future;
    final (lat, long) = await MyLocation().getLatLong();
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(lat, long), 20),
    );
  }
}
