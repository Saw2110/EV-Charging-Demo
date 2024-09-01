import 'package:flutter/material.dart';

import '../core.dart';

class PermissionCheckScreen extends StatefulWidget {
  const PermissionCheckScreen({super.key});

  @override
  State<PermissionCheckScreen> createState() => _PermissionCheckScreenState();
}

class _PermissionCheckScreenState extends State<PermissionCheckScreen> {
  Future<void> _handlePermissionCheck() async {
    bool isPermissionGranted = await MyPermission.askPermissions();

    if (!mounted) return;

    if (isPermissionGranted) {
      NavigationService().pushNamed(AppRoute.splashScreen);
    } else {
      context.showErrorSnackBar(message: "Permission not granted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Permission Check'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: _handlePermissionCheck,
            child: const Text('Check Permission'),
          ),
        ),
      ),
    );
  }
}
