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

  /// Short one-line description shown under the title to fill card spacing
  /// with useful content instead of empty air.
  String _localizedDescription(Pillar p) {
    switch (LocaleService.instance.language) {
      case AppLanguage.ar:
        switch (p) {
          case Pillar.publicRelationsPartnerships:
            return 'التواصل والشراكات الخارجية';
          case Pillar.consularVisas:
            return 'التأشيرات والحجوزات القنصلية';
          case Pillar.logisticsFieldTrips:
            return 'تنظيم الرحلات والنقل';
          case Pillar.digitalMediaIdentity:
            return 'المحتوى والهوية الرقمية';
          case Pillar.eventManagement:
            return 'تخطيط وتنفيذ الفعاليات';
          case Pillar.printingOperations:
            return 'خدمات الطباعة والتشغيل';
        }
      case AppLanguage.en:
        switch (p) {
          case Pillar.publicRelationsPartnerships:
            return 'External outreach & partnerships';
          case Pillar.consularVisas:
            return 'Visas & consular bookings';
          case Pillar.logisticsFieldTrips:
            return 'Trip planning & transport';
          case Pillar.digitalMediaIdentity:
            return 'Content & digital identity';
          case Pillar.eventManagement:
            return 'Planning & running events';
          case Pillar.printingOperations:
            return 'Printing & production services';
        }
      case AppLanguage.de:
        switch (p) {
          case Pillar.publicRelationsPartnerships:
            return 'Außenkontakte & Partnerschaften';
          case Pillar.consularVisas:
            return 'Visa & konsularische Termine';
          case Pillar.logisticsFieldTrips:
            return 'Reiseplanung & Transport';
          case Pillar.digitalMediaIdentity:
            return 'Inhalte & digitale Identität';
          case Pillar.eventManagement:
            return 'Planung & Durchführung von Events';
          case Pillar.printingOperations:
            return 'Druck- & Produktionsservice';
        }
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
              const SizedBox(height: 6),
              Text(
                _localizedDescription(pillar),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade600,
                  height: 1.3,
                ),
                maxLines: 3,
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
