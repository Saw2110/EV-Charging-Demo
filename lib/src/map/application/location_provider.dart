import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/core.dart';

final mapControllerProvider = StateProvider<Completer<GoogleMapController>>(
  (ref) => Completer<GoogleMapController>(),
);

///
///
final myLocationPositionStream = StateProvider<Stream<Position>>((ref) {
  return MyLocation().getPositionStream();
});

final getDistanceProvider = FutureProvider.family<String, (double, double)>(
  (ref, latLong) async {
    final (lat, long) = latLong;
    return MyLocation().calculateDistance(lat, long);
  },
);
