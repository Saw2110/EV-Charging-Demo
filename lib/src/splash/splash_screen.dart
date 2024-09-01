import 'package:ev_charging_finder/core/core.dart';
import 'package:flutter/material.dart';

import '../../app/app.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      if (await MyPermission.checkPermissions()) {
        NavigationService().pushNamed(AppRoute.mapScreen);
      } else {
        NavigationService().pushNamed(AppRoute.permissionCheckScreen);
      }
    });

    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: Center(
        child: Image.asset(
          AppAssets.appIcon,
          height: AppSizes.extraLargePlus + AppSizes.extraLargePlus,
          width: AppSizes.extraLargePlus + AppSizes.extraLargePlus,
        ),
      ),
    );
  }
}
