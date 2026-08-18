import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../services/locale_service.dart';
import '../widgets/pillar_card.dart';
import 'request_form_screen.dart';
import '../services/app_strings.dart';

class ServicesCatalogScreen extends StatelessWidget {
  const ServicesCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.serviceGuideTitle)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: AppStrings.searchServiceHint,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  // Fixed height instead of aspect ratio, so the card stays
                  // a sensible size regardless of how wide the screen is
                  // (mobile vs. web/desktop).
                  mainAxisExtent: 190,
                ),
                itemCount: Pillar.values.length,
                itemBuilder: (context, i) {
                  final p = Pillar.values[i];
                  return PillarCard(
                    pillar: p,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => PillarDetailScreen(pillar: p)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Detail screen for a single pillar, listing sub-services with an
/// SLA chip and a CTA that pre-fills the request form.
class PillarDetailScreen extends StatelessWidget {
  final Pillar pillar;
  const PillarDetailScreen({super.key, required this.pillar});

  String _localizedPillarTitle(Pillar p) {
    switch (LocaleService.instance.language) {
      case AppLanguage.ar:
        return p.titleAr;
      case AppLanguage.en:
        return p.titleEn;
      case AppLanguage.de:
        return p.titleDe;
    }
  }

  /// Sub-service title + SLA, localized to the current app language.
  /// Each entry: {'title': ..., 'sla': ...}
  List<Map<String, String>> _subServices(Pillar p) {
    final lang = LocaleService.instance.language;
    switch (p) {
      case Pillar.publicRelationsPartnerships:
        return switch (lang) {
          AppLanguage.ar => [
              {'title': 'إدارة الشراكات والتشبيك', 'sla': '5 أيام عمل'},
              {'title': 'بروتوكولات الاستقبال والضيافة', 'sla': '48 ساعة'},
              {'title': 'تواصل مع أولياء الأمور والإعلام', 'sla': 'يومي'},
            ],
          AppLanguage.en => [
              {'title': 'Partnership & Networking Management', 'sla': '5 business days'},
              {'title': 'Reception & Hospitality Protocols', 'sla': '48 hours'},
              {'title': 'Parent & Media Communication', 'sla': 'Daily'},
            ],
          AppLanguage.de => [
              {'title': 'Partnerschafts- und Netzwerkmanagement', 'sla': '5 Werktage'},
              {'title': 'Empfangs- und Bewirtungsprotokolle', 'sla': '48 Stunden'},
              {'title': 'Kommunikation mit Eltern und Medien', 'sla': 'Täglich'},
            ],
        };
      case Pillar.consularVisas:
        return switch (lang) {
          AppLanguage.ar => [
              {'title': 'حجز مواعيد VFS Global', 'sla': '3 أيام عمل'},
              {'title': 'تصاريح السفر للقاصرين', 'sla': '7 أيام عمل'},
              {'title': 'حجز تذاكر الطيران الجماعية', 'sla': '5 أيام عمل'},
            ],
          AppLanguage.en => [
              {'title': 'VFS Global Appointment Booking', 'sla': '3 business days'},
              {'title': 'Minor Travel Permits', 'sla': '7 business days'},
              {'title': 'Group Flight Ticket Booking', 'sla': '5 business days'},
            ],
          AppLanguage.de => [
              {'title': 'VFS Global Terminbuchung', 'sla': '3 Werktage'},
              {'title': 'Reisegenehmigungen für Minderjährige', 'sla': '7 Werktage'},
              {'title': 'Gruppenflugbuchung', 'sla': '5 Werktage'},
            ],
        };
      case Pillar.logisticsFieldTrips:
        return switch (lang) {
          AppLanguage.ar => [
              {'title': 'ترتيبات الرحلات الخارجية', 'sla': '10 أيام عمل'},
              {'title': 'الرحلات الداخلية والمعسكرات', 'sla': '5 أيام عمل'},
            ],
          AppLanguage.en => [
              {'title': 'International Trip Arrangements', 'sla': '10 business days'},
              {'title': 'Domestic Trips & Camps', 'sla': '5 business days'},
            ],
          AppLanguage.de => [
              {'title': 'Organisation von Auslandsreisen', 'sla': '10 Werktage'},
              {'title': 'Inlandsreisen & Camps', 'sla': '5 Werktage'},
            ],
        };
      case Pillar.digitalMediaIdentity:
        return switch (lang) {
          AppLanguage.ar => [
              {'title': 'طلب تغطية مصورة لفعالية', 'sla': '48 ساعة'},
              {'title': 'نشر على منصات التواصل', 'sla': '24 ساعة'},
              {'title': 'مراجعة الهوية البصرية لمطبوعة', 'sla': '2 أيام عمل'},
            ],
          AppLanguage.en => [
              {'title': 'Photo/Video Coverage Request', 'sla': '48 hours'},
              {'title': 'Social Media Posting', 'sla': '24 hours'},
              {'title': 'Print Material Brand Review', 'sla': '2 business days'},
            ],
          AppLanguage.de => [
              {'title': 'Foto-/Videobericht anfordern', 'sla': '48 Stunden'},
              {'title': 'Social-Media-Veröffentlichung', 'sla': '24 Stunden'},
              {'title': 'Markenprüfung für Druckmaterial', 'sla': '2 Werktage'},
            ],
        };
      case Pillar.eventManagement:
        return switch (lang) {
          AppLanguage.ar => [
              {'title': 'حجز مكان حفل التخرج', 'sla': 'حسب الخطة السنوية'},
              {'title': 'تنظيم يوم ثقافي / معرض', 'sla': '10 أيام عمل'},
            ],
          AppLanguage.en => [
              {'title': 'Graduation Venue Booking', 'sla': 'Per annual plan'},
              {'title': 'Cultural Day / Fair Organization', 'sla': '10 business days'},
            ],
          AppLanguage.de => [
              {'title': 'Veranstaltungsort für Abschlussfeier buchen', 'sla': 'Gemäß Jahresplan'},
              {'title': 'Organisation von Kulturtag / Messe', 'sla': '10 Werktage'},
            ],
        };
      case Pillar.printingOperations:
        return switch (lang) {
          AppLanguage.ar => [
              {'title': 'طلب طباعة امتحانات/أوراق عمل', 'sla': '24 ساعة'},
              {'title': 'الإبلاغ عن نقص مخزون', 'sla': '48 ساعة'},
              {'title': 'طلب صيانة ماكينة تصوير', 'sla': '48 ساعة'},
            ],
          AppLanguage.en => [
              {'title': 'Exam/Worksheet Printing Request', 'sla': '24 hours'},
              {'title': 'Report Stock Shortage', 'sla': '48 hours'},
              {'title': 'Photocopier Maintenance Request', 'sla': '48 hours'},
            ],
          AppLanguage.de => [
              {'title': 'Druckanfrage für Prüfungen/Arbeitsblätter', 'sla': '24 Stunden'},
              {'title': 'Bestandsmangel melden', 'sla': '48 Stunden'},
              {'title': 'Wartungsanfrage für Kopierer', 'sla': '48 Stunden'},
            ],
        };
    }
  }

  String _slaLabel() {
    switch (LocaleService.instance.language) {
      case AppLanguage.ar:
        return 'مدة التنفيذ المعتادة';
      case AppLanguage.en:
        return 'Typical turnaround';
      case AppLanguage.de:
        return 'Übliche Bearbeitungszeit';
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = _subServices(pillar);
    return Scaffold(
      appBar: AppBar(title: Text(_localizedPillarTitle(pillar))),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final s = services[i];
          return Card(
            child: ListTile(
              title: Text(s['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('${_slaLabel()}: ${s['sla']}'),
              trailing: FilledButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RequestFormScreen(
                      preselectedPillar: pillar,
                      preselectedService: s['title'],
                    ),
                  ),
                ),
                child: Text(AppStrings.requestButton),
              ),
            ),
          );
        },
      ),
    );
  }
}
