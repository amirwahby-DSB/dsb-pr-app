import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
import '../services/locale_service.dart';
import '../services/app_strings.dart';
import '../theme/app_theme.dart';
import 'about_footer_widget.dart';
import 'executive_dashboard_screen.dart';
import 'login_screen.dart';

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

  String _logoutLabel(AppLanguage lang) => switch (lang) {
        AppLanguage.ar => 'تسجيل خروج',
        AppLanguage.en => 'Log out',
        AppLanguage.de => 'Abmelden',
      };

  String _logoutConfirmTitle(AppLanguage lang) => switch (lang) {
        AppLanguage.ar => 'تسجيل خروج؟',
        AppLanguage.en => 'Log out?',
        AppLanguage.de => 'Abmelden?',
      };

  String _logoutConfirmBody(AppLanguage lang) => switch (lang) {
        AppLanguage.ar => 'هترجع لشاشة اختيار المستخدم.',
        AppLanguage.en => 'You will return to the user selection screen.',
        AppLanguage.de => 'Sie kehren zur Benutzerauswahl zurück.',
      };

  String _cancel(AppLanguage lang) => switch (lang) {
        AppLanguage.ar => 'إلغاء',
        AppLanguage.en => 'Cancel',
        AppLanguage.de => 'Abbrechen',
      };

  void _confirmLogout(BuildContext context, AppLanguage lang) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(_logoutConfirmTitle(lang)),
        content: Text(_logoutConfirmBody(lang)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(_cancel(lang)),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx); // يقفل الـ dialog
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false, // يمسح كل الشاشات اللي فاتت عشان مايرجعش بزرار الرجوع
              );
            },
            child: Text(_logoutLabel(lang)),
          ),
        ],
      ),
    );
  }

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
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout_outlined, color: DSBAColors.primaryCrimson),
              title: Text(
                _logoutLabel(lang),
                style: const TextStyle(color: DSBAColors.primaryCrimson, fontWeight: FontWeight.w600),
              ),
              onTap: () => _confirmLogout(context, lang),
            ),
          ),
          const SizedBox(height: 24),
          const AboutFooter(),
        ],
      ),
    );
  }
}
