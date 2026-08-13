import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import '../services/mock_data_service.dart';
import '../services/report_generator.dart';
import '../theme/app_theme.dart';
import '../widgets/kpi_card.dart';
import 'executive_dashboard_strings.dart';

class ExecutiveDashboardScreen extends StatelessWidget {
  const ExecutiveDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = MockDataService.instance.currentUser;

    if (!currentUser.role.canViewDashboard) {
      return Scaffold(
        appBar: AppBar(
          title: Text(ExecutiveDashboardStrings.title),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_outline, size: 56, color: DSBAColors.textMuted),
                const SizedBox(height: 16),
                Text(
                  ExecutiveDashboardStrings.accessDeniedTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 8),
                Text(
                  ExecutiveDashboardStrings.accessDeniedBody,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: DSBAColors.textMuted),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final kpis = MockDataService.instance.getKpiSnapshot();

    return Scaffold(
      appBar: AppBar(
        title: Text(ExecutiveDashboardStrings.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            tooltip: ExecutiveDashboardStrings.exportPdfTooltip,
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
                  label: ExecutiveDashboardStrings.totalRequests,
                  value: '${kpis['totalRequests']}',
                  icon: Icons.list_alt_outlined),
              KpiCard(
                  label: ExecutiveDashboardStrings.completedRequests,
                  value: '${kpis['completedRequests']}',
                  icon: Icons.check_circle_outline,
                  accent: DSBAColors.success),
              KpiCard(
                  label: ExecutiveDashboardStrings.printingJobs,
                  value: '${kpis['printingJobsCompleted']}',
                  icon: Icons.print_outlined,
                  accent: DSBAColors.accentGold),
              KpiCard(
                  label: ExecutiveDashboardStrings.tripsOrganized,
                  value: '${kpis['tripsOrganized']}',
                  icon: Icons.directions_bus_filled_outlined),
              KpiCard(
                  label: ExecutiveDashboardStrings.eventsManaged,
                  value: '${kpis['eventsManaged']}',
                  icon: Icons.celebration_outlined),
              KpiCard(
                  label: ExecutiveDashboardStrings.mediaRequests,
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
                  Text(ExecutiveDashboardStrings.avgResolutionTime,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                  const SizedBox(height: 6),
                  Text(ExecutiveDashboardStrings.hoursValue('${kpis['avgResolutionHours']}'),
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w800, color: DSBAColors.primaryCrimson)),
                  const SizedBox(height: 4),
                  Text(ExecutiveDashboardStrings.acrossPillars,
                      style: const TextStyle(fontSize: 11, color: DSBAColors.textMuted)),
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
              Text(ExecutiveDashboardStrings.exportPdfSheetTitle,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              const SizedBox(height: 12),
              ListTile(
                leading: const Icon(Icons.today_outlined),
                title: Text(ExecutiveDashboardStrings.dailyReport),
                onTap: () => _generateAndShow(context, ReportPeriod.daily),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_view_week),
                title: Text(ExecutiveDashboardStrings.weeklyReport),
                onTap: () => _generateAndShow(context, ReportPeriod.weekly),
              ),
              ListTile(
                leading: const Icon(Icons.calendar_view_month),
                title: Text(ExecutiveDashboardStrings.monthlyReport),
                onTap: () => _generateAndShow(context, ReportPeriod.monthly),
              ),
              ListTile(
                leading: const Icon(Icons.date_range_outlined),
                title: Text(ExecutiveDashboardStrings.halfYearlyReport),
                onTap: () => _generateAndShow(context, ReportPeriod.halfYearly),
              ),
              ListTile(
                leading: const Icon(Icons.event_note),
                title: Text(ExecutiveDashboardStrings.yearlyReport),
                onTap: () => _generateAndShow(context, ReportPeriod.yearly),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _generateAndShow(BuildContext context, ReportPeriod period) async {
    Navigator.pop(context);
    final allRequests = MockDataService.instance.getAllRequests();
    final bytes = await ReportGenerator.buildReport(allRequests: allRequests, period: period);
    await Printing.layoutPdf(onLayout: (_) async => bytes);
  }
}
