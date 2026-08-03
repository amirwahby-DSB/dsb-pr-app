import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../widgets/pillar_card.dart';
import 'request_form_screen.dart';

class ServicesCatalogScreen extends StatelessWidget {
  const ServicesCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('دليل الخدمات — الأقسام الستة')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'ابحث عن خدمة (تأشيرة، طباعة، رحلة...)',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.95,
                children: Pillar.values
                    .map((p) => PillarCard(
                          pillar: p,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => PillarDetailScreen(pillar: p)),
                          ),
                        ))
                    .toList(),
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

  List<Map<String, String>> _subServices(Pillar p) {
    switch (p) {
      case Pillar.publicRelationsPartnerships:
        return [
          {'title': 'إدارة الشراكات والتشبيك', 'sla': '5 أيام عمل'},
          {'title': 'بروتوكولات الاستقبال والضيافة', 'sla': '48 ساعة'},
          {'title': 'تواصل مع أولياء الأمور والإعلام', 'sla': 'يومي'},
        ];
      case Pillar.consularVisas:
        return [
          {'title': 'حجز مواعيد VFS Global', 'sla': '3 أيام عمل'},
          {'title': 'تصاريح السفر للقاصرين', 'sla': '7 أيام عمل'},
          {'title': 'حجز تذاكر الطيران الجماعية', 'sla': '5 أيام عمل'},
        ];
      case Pillar.logisticsFieldTrips:
        return [
          {'title': 'ترتيبات الرحلات الخارجية', 'sla': '10 أيام عمل'},
          {'title': 'الرحلات الداخلية والمعسكرات', 'sla': '5 أيام عمل'},
        ];
      case Pillar.digitalMediaIdentity:
        return [
          {'title': 'طلب تغطية مصورة لفعالية', 'sla': '48 ساعة'},
          {'title': 'نشر على منصات التواصل', 'sla': '24 ساعة'},
          {'title': 'مراجعة الهوية البصرية لمطبوعة', 'sla': '2 أيام عمل'},
        ];
      case Pillar.eventManagement:
        return [
          {'title': 'حجز مكان حفل التخرج', 'sla': 'حسب الخطة السنوية'},
          {'title': 'تنظيم يوم ثقافي / معرض', 'sla': '10 أيام عمل'},
        ];
      case Pillar.printingOperations:
        return [
          {'title': 'طلب طباعة امتحانات/أوراق عمل', 'sla': '24 ساعة'},
          {'title': 'الإبلاغ عن نقص مخزون', 'sla': '48 ساعة'},
          {'title': 'طلب صيانة ماكينة تصوير', 'sla': '48 ساعة'},
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final services = _subServices(pillar);
    return Scaffold(
      appBar: AppBar(title: Text(pillar.titleAr)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final s = services[i];
          return Card(
            child: ListTile(
              title: Text(s['title']!, style: const TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text('مدة التنفيذ المعتادة: ${s['sla']}'),
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
                child: const Text('طلب'),
              ),
            ),
          );
        },
      ),
    );
  }
}
