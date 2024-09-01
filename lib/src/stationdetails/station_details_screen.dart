import 'package:ev_charging_finder/core/core.dart';
import 'package:ev_charging_finder/src/map/map.dart';
import 'package:flutter/material.dart';

class StationDetailsScreen extends StatelessWidget {
  final EvChargingModel station;
  const StationDetailsScreen({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              station.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            AppSizes.small.yGap,

            // Display the address
            Text(
              'Address: ${station.address}',
              style: const TextStyle(fontSize: 16),
            ),

            AppSizes.small.yGap,

            // Display the description
            const Text(
              'Description:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            Text(
              station.description,
              style: const TextStyle(fontSize: 16),
            ),

            AppSizes.medium.yGap,

            // Display operating hours
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Operating Hours: ${station.openingHours} - ${station.closingHours}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),

            AppSizes.small.yGap,
          ],
        ),
      ),
    );
  }
}
