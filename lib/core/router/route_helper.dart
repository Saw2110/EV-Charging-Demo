import 'package:ev_charging_finder/src/direction_screen.dart';
import 'package:ev_charging_finder/src/map/map.dart';
import 'package:ev_charging_finder/src/stationdetails/station_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../src/splash/splash.dart';
import '../core.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashScreen:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const SplashScreen(),
        );

      case AppRoute.permissionCheckScreen:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const PermissionCheckScreen(),
        );
      case AppRoute.mapScreen:
        return PageTransition(
          type: PageTransitionType.rightToLeft,
          child: const GoogleMapScreen(),
        );
      case AppRoute.stationDetailScreen:
        final value = settings.arguments as EvChargingModel;
        return createRoute(
          StationDetailsScreen(station: value),
        );
      case AppRoute.directionsPage:
        final value = settings.arguments as EvChargingModel;
        return createRoute(
          DirectionsPage(destination: value),
        );

      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return PageTransition(
      type: PageTransitionType.rightToLeft,
      child: Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('ERROR ROUTE')),
      ),
    );
  }
}
