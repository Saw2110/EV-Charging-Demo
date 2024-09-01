import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../map.dart';

class StationMenuActions extends ConsumerWidget {
  final EvChargingModel stationInfo;
  const StationMenuActions({super.key, required this.stationInfo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _IconWithLabel(
          icon: Icons.chat_bubble_outline,
          label: "Message",
          onTap: () {},
        ),
        _IconWithLabel(
          icon: Icons.directions_outlined,
          label: "Go",
          onTap: () async {
            NavigationService().pushNamed(
              AppRoute.directionsPage,
              arguments: stationInfo,
            );
          },
        ),
        _IconWithLabel(
          icon: Icons.call_outlined,
          label: "Call",
          onTap: () {
            stationInfo.contact.makePhoneCall();
          },
        ),
      ],
    );
  }
}

class _IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final void Function()? onTap;

  const _IconWithLabel({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.smallMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.blue),
              AppSizes.extraSmall.yGap,
              Text(
                label,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
