import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../services/locale_service.dart';
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
  /// Returns the pillar's title in the currently selected app language.
  String _localizedTitle(Pillar p) {
    switch (LocaleService.instance.language) {
      case AppLanguage.ar:
        return p.titleAr;
      case AppLanguage.en:
        return p.titleEn;
      case AppLanguage.de:
        return p.titleDe;
    }
  }

  String _viewServicesLabel() {
    switch (LocaleService.instance.language) {
      case AppLanguage.ar:
        return 'عرض الخدمات';
      case AppLanguage.en:
        return 'View services';
      case AppLanguage.de:
        return 'Leistungen ansehen';
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
                _localizedTitle(pillar),
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _viewServicesLabel(),
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: DSBAColors.primaryCrimson,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Icons.arrow_forward, size: 14, color: DSBAColors.primaryCrimson),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
