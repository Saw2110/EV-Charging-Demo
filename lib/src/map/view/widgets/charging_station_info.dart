import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../map.dart';

class ChargingStationInfo extends StatelessWidget {
  final EvChargingModel info;

  const ChargingStationInfo({required this.info, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            info.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            info.description,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class EVStationCard extends StatelessWidget {
  final EvChargingModel stationInfo;
  const EVStationCard({super.key, required this.stationInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.medium),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _EVStationInfo(stationInfo: stationInfo),
            StationMenuActions(stationInfo: stationInfo),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying the EV station information
class _EVStationInfo extends StatelessWidget {
  final EvChargingModel stationInfo;

  const _EVStationInfo({required this.stationInfo});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _StationImage(stationInfo.coverImageUrl ?? "")),
        AppSizes.small.xGap,
        Expanded(
          flex: 2,
          child: _StationDetails(
            stationInfo: stationInfo,
          ),
        ),
      ],
    );
  }
}

// Widget for displaying the EV station image
class _StationImage extends StatelessWidget {
  final String imageUrl;
  const _StationImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomRight: Radius.circular(AppSizes.small),
        topLeft: Radius.circular(AppSizes.small),
      ),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: 120.0,
        errorBuilder: (_, __, ___) => Container(
          color: Colors.grey.shade300,
          height: 120.0,
        ),
      ),
    );
  }
}

// Widget for displaying the EV station details
class _StationDetails extends StatelessWidget {
  final EvChargingModel stationInfo;

  const _StationDetails({required this.stationInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSizes.small.yGap,
        Text(
          stationInfo.name,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        _iconWithText(
          icon: Icons.dashboard_outlined,
          label: stationInfo.category!.name,
        ),
        _iconWithText(
          icon: Icons.call_outlined,
          label: "${stationInfo.contact}",
        ),
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final value = ref.watch(getDistanceProvider((
              stationInfo.latitude,
              stationInfo.longitude,
            )));
            return Row(
              children: [
                Expanded(
                  child: value.when(
                    data: (value) {
                      return _iconWithText(
                        icon: Icons.directions_outlined,
                        label: value,
                      );
                    },
                    error: (_, __) => const SizedBox.shrink(),
                    loading: () => const SizedBox(
                      height: 15.0,
                      width: 15.0,
                      child: LoadingIndicator(),
                    ),
                  ),
                ),
                Expanded(
                  child: _iconWithText(
                    icon: Icons.timelapse_outlined,
                    label: "1hr 05 min",
                  ),
                ),
              ],
            );
          },
        ),
        _iconWithText(
          icon: Icons.schedule,
          label: "${stationInfo.openingHours} - ${stationInfo.closingHours}",
        ),
      ],
    );
  }
}

// Widget for displaying an icon with text
Widget _iconWithText({required IconData icon, required String label}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Icon(icon, size: 16.0),
        const SizedBox(width: 8.0),
        Text(label),
      ],
    ),
  );
}
