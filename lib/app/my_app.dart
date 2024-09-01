import 'package:flutter/material.dart';

import '../core/core.dart';
import 'app.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppGlobal.navigatorKey,
      scaffoldMessengerKey: AppGlobal.scaffoldMessengerKey,

      // home: const MapScreen3D(),
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
