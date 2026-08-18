import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
import '../services/locale_service.dart';
import '../theme/app_theme.dart';
import 'dashboard_screen.dart';

/// Simple "pick a user" screen — not a real password login yet.
/// Shown first when the app opens; tapping a user takes you to the
/// Home screen acting as that user (wired up fully in the next stage).
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  String _roleLabel(UserRole role, AppLanguage lang) {
    switch (role) {
      case UserRole.faculty:
        return lang == AppLanguage.ar
            ? 'هيئة تدريس'
            : lang == AppLanguage.en
                ? 'Faculty'
                : 'Lehrkraft';
      case UserRole.staff:
        return lang == AppLanguage.ar
            ? 'موظف'
            : lang == AppLanguage.en
                ? 'Staff'
                : 'Mitarbeiter';
      case UserRole.prStaff:
        return lang == AppLanguage.ar
            ? 'موظف علاقات عامة'
            : lang == AppLanguage.en
                ? 'PR Staff'
                : 'PR-Mitarbeiter';
      case UserRole.prAdmin:
        return lang == AppLanguage.ar
            ? 'إدارة العلاقات العامة'
            : lang == AppLanguage.en
                ? 'PR Admin'
                : 'PR-Leitung';
      case UserRole.leadership:
        return lang == AppLanguage.ar
            ? 'قيادة عليا'
            : lang == AppLanguage.en
                ? 'Leadership'
                : 'Schulleitung';
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = LocaleService.instance.language;
    final users = MockDataService.mockUsers;

    return Scaffold(
      appBar: AppBar(
        title: Text(lang == AppLanguage.ar
            ? 'اختر المستخدم'
            : lang == AppLanguage.en
                ? 'Select User'
                : 'Benutzer auswählen'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, i) {
          final u = users[i];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const CircleAvatar(
                radius: 22,
                backgroundColor: DSBAColors.accentGold,
                child: Icon(Icons.person, color: DSBAColors.neutralDark),
              ),
              title: Text(
                lang == AppLanguage.ar ? u.fullNameAr : u.fullName,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              subtitle: Text(
                _roleLabel(u.role, lang),
                style: const TextStyle(color: DSBAColors.textMuted, fontSize: 12),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 14),
              onTap: () {
                MockDataService.instance.setCurrentUser(u);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
