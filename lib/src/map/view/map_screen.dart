import 'dart:async';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/core.dart';
import '../map.dart';

class GoogleMapScreen extends ConsumerStatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  ConsumerState<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends ConsumerState<GoogleMapScreen> {
  final _customInfoWindowController = CustomInfoWindowController();
  final pageController = PageController(viewportFraction: 0.89);

  late Map<MarkerId, int> markerIdToIndex = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chargingStationListAPI);
    });
  }

  @override
  Widget build(BuildContext context) {
    final stationList = ref.watch(chargingStationListProvider);
    final polylines = ref.watch(polylineProvider);
    final markers = ref.watch(markerProvider);

    return PopScope(
      canPop: false,
      child: Scaffold(
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

            final position = snapshot.data!;
            final currentLocation = LatLng(
              position.latitude,
              position.longitude,
            );

            WidgetsBinding.instance.addPostFrameCallback((_) {
              addMarkersAccordingly(stationList);
            });
            return Stack(
              children: [
                MapWidget(
                  infoWindowController: _customInfoWindowController,
                  markers: markers,
                  polylines: polylines,
                  currentLocation: currentLocation,
                  onMapTap: (position) {
                    _customInfoWindowController.hideInfoWindow!();
                  },
                  onCameraMove: () {
                    _customInfoWindowController.onCameraMove!();
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _customInfoWindowController.googleMapController =
                        controller;
                    ref.read(mapControllerProvider).complete(controller);
                  },
                ),

                ///
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: AppSizes.large),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSizes.medium),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: IconButton(
                              onPressed: goToUserCurrentPosition,
                              icon: const Icon(
                                Icons.my_location,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        ChargingStationListWidget(
                          controller: pageController,
                          stationList: stationList,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> goToUserCurrentPosition() async {
    // ref.read(mapControllerProvider).complete(controller);
    final GoogleMapController controller =
        await ref.read(mapControllerProvider).future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(await getUserCurrentLocation()),
    );
  }

  Future<CameraPosition> getUserCurrentLocation() async {
    final (lat, long) = await MyLocation().getLatLong();
    return CameraPosition(
      target: LatLng(lat, long),
      zoom: 15.0,
    );
  }

  Future<void> addMarkersAccordingly(List<EvChargingModel> stations) async {
    for (int i = 0; i < stations.length; i++) {
      var stationInfo = stations[i];
      final markerId = MarkerId(
        "marker_${stationInfo.latitude}_${stationInfo.longitude}",
      );

      if (!ref.read(markerProvider).containsKey(markerId)) {
        ref.read(markerProvider.notifier).addMarker(
              id: markerId.value,
              lat: stationInfo.latitude,
              lng: stationInfo.longitude,
              onTap: () {
                _customInfoWindowController.addInfoWindow!(
                  CustomInfoWindowWidget(
                    controller: _customInfoWindowController,
                    stationInfo: stationInfo,
                  ),
                  LatLng(stationInfo.latitude, stationInfo.longitude),
                );

                pageController.animateToPage(
                  i,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                );

                markerIdToIndex[markerId] = i;

                Future.microtask(
                  () async {
                    var (lat, long) = await MyLocation().getLatLong();

                    ref.read(polylineProvider.notifier).fetchAndAddPolyline(
                          originLat: lat,
                          originLng: long,
                          destLat: stationInfo.latitude,
                          destLng: stationInfo.longitude,
                        );
                  },
                );
              },
            );
      }
    }
  }
}
