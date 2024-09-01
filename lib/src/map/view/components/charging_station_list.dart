import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../map.dart';

class ChargingStationListWidget extends StatelessWidget {
  final PageController controller;
  final List<EvChargingModel> stationList;
  const ChargingStationListWidget({
    super.key,
    required this.controller,
    required this.stationList,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 190.0,
      child: PageView.builder(
        controller: controller,
        scrollDirection: Axis.horizontal,
        itemCount: stationList.length,
        itemBuilder: (BuildContext context, int index) {
          final stationInfo = stationList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.extraSmall,
            ),
            child: InkWell(
              onTap: () {
                NavigationService().pushNamed(
                  AppRoute.stationDetailScreen,
                  arguments: stationInfo,
                );
              },
              child: EVStationCard(stationInfo: stationInfo),
            ),
          );
        },
      ),
    );
  }
}
