import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../theme/app_theme.dart';

class PillarCard extends StatelessWidget {
  final Pillar pillar;
  final VoidCallback onTap;

  const PillarCard({super.key, required this.pillar, required this.onTap});

  IconData _iconFor(Pillar p) {
    switch (p) {
      case Pillar.publicRelationsPartnerships:
        return Icons.handshake_outlined;
      case Pillar.consularVisas:
        return Icons.badge_outlined;
      case Pillar.logisticsFieldTrips:
        return Icons.directions_bus_filled_outlined;
      case Pillar.digitalMediaIdentity:
        return Icons.camera_alt_outlined;
      case Pillar.eventManagement:
        return Icons.celebration_outlined;
      case Pillar.printingOperations:
        return Icons.print_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: DSBAColors.primaryCrimson.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(_iconFor(pillar), color: DSBAColors.primaryCrimson),
              ),
              const SizedBox(height: 12),
              Text(
                pillar.titleAr,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                pillar.titleEn,
                style: const TextStyle(color: DSBAColors.textMuted, fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
