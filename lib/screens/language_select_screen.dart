import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

/// First screen the app shows. Deliberately neutral (no single
/// language dominates the layout) so anyone opening the app for the
/// first time — regardless of language — can pick their language.
class LanguageSelectScreen extends StatelessWidget {
  const LanguageSelectScreen({super.key});

  void _choose(BuildContext context, AppLanguage lang) {
    LocaleService.instance.setLanguage(lang);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white,
                  backgroundImage: const AssetImage('assets/branding/dsba_logo.jpg'),
                  onBackgroundImageError: (_, __) {},
                ),
                const SizedBox(height: 32),
                const Text(
                  'Please select your language',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
                const SizedBox(height: 24),
                _LanguageButton(
                  label: 'العربية',
                  onTap: () => _choose(context, AppLanguage.ar),
                ),
                const SizedBox(height: 12),
                _LanguageButton(
                  label: 'English',
                  onTap: () => _choose(context, AppLanguage.en),
                ),
                const SizedBox(height: 12),
                _LanguageButton(
                  label: 'Deutsch',
                  onTap: () => _choose(context, AppLanguage.de),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _LanguageButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: DSBAColors.primaryCrimson),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: DSBAColors.primaryCrimson,
          ),
        ),
      ),
    );
  }
}
