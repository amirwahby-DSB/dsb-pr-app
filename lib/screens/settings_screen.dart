import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
import '../services/locale_service.dart';
import '../services/app_strings.dart';
import 'about_footer_widget.dart';
import 'executive_dashboard_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String _dashboardTitle(AppLanguage lang) => switch (lang) {
        AppLanguage.ar => 'لوحة التقارير التنفيذية',
        AppLanguage.en => 'Executive Dashboard',
        AppLanguage.de => 'Führungs-Dashboard',
      };

  String _dashboardSubtitle(AppLanguage lang) => switch (lang) {
        AppLanguage.ar => 'Module C — للإدارة ومسؤول العلاقات العامة فقط',
        AppLanguage.en => 'Module C — Leadership & PR Officer only',
        AppLanguage.de => 'Modul C — Nur Schulleitung & PR-Beauftragter',
      };

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.instance.currentUser;
    final lang = LocaleService.instance.language;
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user.role.canViewDashboard)
            Card(
              child: ListTile(
                leading: const Icon(Icons.bar_chart_outlined),
                title: Text(_dashboardTitle(lang)),
                subtitle: Text(_dashboardSubtitle(lang)),
                trailing: const Icon(Icons.chevron_left),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ExecutiveDashboardScreen()),
                ),
              ),
            ),
           Card(
            child: ListTile(
              leading: Icon(Icons.notifications_active_outlined),
              title: Text(AppStrings.notifications),
            ),
          ),
          const SizedBox(height: 24),
          const AboutFooter(),
        ],
      ),
    );
  }
}
