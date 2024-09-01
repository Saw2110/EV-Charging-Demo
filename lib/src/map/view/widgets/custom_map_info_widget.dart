import 'package:clippy_flutter/triangle.dart';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../map.dart';

class CustomInfoWindowWidget extends StatelessWidget {
  final CustomInfoWindowController controller;
  final EvChargingModel stationInfo;

  const CustomInfoWindowWidget({
    super.key,
    required this.controller,
    required this.stationInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppSizes.medium),
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.small),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    stationInfo.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    stationInfo.mapAddress?.country ?? '',
                    style: const TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                  Text(
                    stationInfo.mapAddress?.street ?? '',
                    style: const TextStyle(
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Triangle.isosceles(
          edge: Edge.BOTTOM,
          child: Container(
            color: Colors.white,
            width: 20.0,
            height: 10.0,
          ),
        ),
      ],
    );
  }
}
