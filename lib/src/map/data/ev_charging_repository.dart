import 'dart:convert';

import 'package:flutter/services.dart';

import '../map.dart';
import '../model/ev_charging_model.dart';

class EVChargingRepository {
  static Future<List<EvChargingModel>> getChargingStations() async {
    String data = await rootBundle.loadString('assets/coordinates.json');
    var jsonResult = json.decode(data);

    List<dynamic> dataList = jsonResult["dataAsModel"];

    List<EvChargingModel> chargingStations = dataList.map((json) {
      return EvChargingModel.fromJson(json);
    }).toList();

    return chargingStations;
  }
}
