import 'package:riverpod/riverpod.dart';

import '../map.dart';

final chargingStationListProvider =
    StateNotifierProvider<ChargingStationListNotifier, List<EvChargingModel>>(
        (ref) => ChargingStationListNotifier());

final chargingStationListAPI = FutureProvider.autoDispose<void>((ref) async {
  await ref.read(chargingStationListProvider.notifier).fetchChargingStations();
});

class ChargingStationListNotifier extends StateNotifier<List<EvChargingModel>> {
  ChargingStationListNotifier() : super([]);

  Future<void> fetchChargingStations() async {
    final response = await EVChargingRepository.getChargingStations();
    state = response;
  }
}
