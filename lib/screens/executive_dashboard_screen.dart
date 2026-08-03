import 'package:flutter/material.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/kpi_card.dart';

class ExecutiveDashboardScreen extends StatelessWidget {
  const ExecutiveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kpis = MockDataService.instance.getKpiSnapshot();

    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التقارير التنفيذية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            tooltip: 'تصدير تقرير PDF',
            onPressed: () => _showExportSheet(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1.9,
            children: [
              KpiCard(
                  label: 'إجمالي الطلبات',
                  value: '${kpis['totalRequests']}',
                  icon: Icons.list_alt_outlined),
              KpiCard(
                  label: 'الطلبات المكتملة',
                  value: '${kpis['completedRequests']}',
                  icon: Icons.check_circle_outline,
                  accent: DSBAColors.success),
              KpiCard(
                  label: 'أعمال طباعة منجزة',
                  value: '${kpis['printingJobsCompleted']}',
                  icon: Icons.print_outlined,
                  accent: DSBAColors.accentGold),
              KpiCard(
                  label: 'رحلات منظمة',
                  value: '${kpis['tripsOrganized']}',
                  icon: Icons.directions_bus_filled_outlined),
              KpiCard(
                  label: 'فعاليات مُدارة',
                  value: '${kpis['eventsManaged']}',
                  icon: Icons.celebration_outlined),
              KpiCard(
                  label: 'طلبات إعلامية',
                  value: '${kpis['mediaRequestsHandled']}',
                  icon: Icons.camera_alt_outlined),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('متوسط زمن الإنجاز',
                      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 6),
                  Text('${kpis['avgResolutionHours']} ساعة',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800, color: DSBAColors.primaryCrimson)),
                  const SizedBox(height: 4),
                  const Text('عبر جميع الأقسام الستة خلال الفترة الحالية',
                      style: TextStyle(fontSize: 11, color: DSBAColors.textMuted)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showExportSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('تصدير تقرير PDF',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.calendar_view_week),
                title: const Text('تقرير أسبوعي'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_view_month),
                title: const Text('تقرير شهري'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: const Text('تقرير سنوي'),
                onTap: () => Navigator.pop(context),
              ),
              // TODO: call backend endpoint POST /reports/export
              // with { period } → returns AnalyticsReport.exportUrl (PDF)
            ],
          ),
        ),
      ),
    );
  }
}
