import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/my_app.dart';

const googleMapAPIKey = "AIzaSyDaZZ7G-zcm3Rx2-DomnrkPwvq_VamTTGg";
// String googleMapAPIKey = "AIzaSyDZF_oNL8olqMqAbgcjl6HU1vj2eEjx1Hw";

void main() {
  runApp(const ProviderScope(child: MainApp()));
}
