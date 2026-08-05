import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
import '../services/locale_service.dart';
import 'about_footer_widget.dart';
import 'executive_dashboard_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = MockDataService.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات والمزيد')),
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
            leading: const Icon(Icons.language_outlined),
            title: const Text('اللغة / Sprache / Language'),
            subtitle: const Text('العربية، Deutsch، English'),
            trailing: const Icon(Icons.chevron_left),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (ctx) => SafeArea(
                  child: Wrap(
                    children: [
                      ListTile(
                        title: const Text('العربية'),
                        onTap: () {
                          LocaleService.instance.setLanguage(AppLanguage.ar);
                          Navigator.pop(ctx);
                        },
                      ),
                      ListTile(
                        title: const Text('English'),
                        onTap: () {
                          LocaleService.instance.setLanguage(AppLanguage.en);
                          Navigator.pop(ctx);
                        },
                      ),
                      ListTile(
                        title: const Text('Deutsch'),
                        onTap: () {
                          LocaleService.instance.setLanguage(AppLanguage.de);
                          Navigator.pop(ctx);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
          const Card(
            child: ListTile(
              leading: Icon(Icons.notifications_active_outlined),
              title: Text('الإشعارات'),
            ),
          ),
          const SizedBox(height: 24),
          const AboutFooter(),
        ],
      ),
    );
  }
}
