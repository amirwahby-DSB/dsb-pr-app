import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
import '../services/app_strings.dart';
import 'about_footer_widget.dart';
import 'executive_dashboard_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = MockDataService.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (user.role.canViewDashboard)
            Card(
              child: ListTile(
                leading: const Icon(Icons.bar_chart_outlined),
                title: const Text('لوحة التقارير التنفيذية'),
                subtitle: const Text('Module C — للإدارة ومسؤول العلاقات العامة فقط'),
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
