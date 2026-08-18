import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'services/locale_service.dart';
import 'services/app_strings.dart';
import 'screens/dashboard_screen.dart';
import 'screens/services_catalog_screen.dart';
import 'screens/requests_list_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/language_select_screen.dart';
void main() => runApp(const DSBAApp());
class DSBAApp extends StatefulWidget {
  const DSBAApp({super.key});
  @override
  State<DSBAApp> createState() => _DSBAAppState();
}
class _DSBAAppState extends State<DSBAApp> {
  @override
  void initState() {
    super.initState();
    LocaleService.instance.addListener(_onLocaleChanged);
  }
  @override
  void dispose() {
    LocaleService.instance.removeListener(_onLocaleChanged);
    super.dispose();
  }
  void _onLocaleChanged() {
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    final lang = LocaleService.instance.language;
    final localeCode = switch (lang) {
      AppLanguage.ar => 'ar',
      AppLanguage.en => 'en',
      AppLanguage.de => 'de',
    };
    return MaterialApp(
      title: 'DSBA PR & Operations Portal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      locale: Locale(localeCode),
      home: const LanguageSelectScreen(),
    );
  }
}
class RootShell extends StatefulWidget {
  const RootShell({super.key});
  @override
  State<RootShell> createState() => _RootShellState();
}
class _RootShellState extends State<RootShell> {
  int _index = 0;
  // IMPORTANT: none of these are `const`. Each screen reads
  // AppStrings/locale-dependent text at build time. A const widget
  // is a single canonical instance reused forever — Flutter skips
  // calling build() again on an unchanged const instance even if
  // the surrounding list is rebuilt. Creating a genuinely new
  // instance every time (no const) forces Flutter to rebuild each
  // tab whenever RootShell rebuilds (e.g. on locale change), so
  // translated text updates correctly across every tab.
  List<Widget> get _tabs => [
        DashboardScreen(),
        ServicesCatalogScreen(),
        RequestsListScreen(),
        ChatScreen(threadId: 'general_pr_office'),
        SettingsScreen(),
      ];
  @override
  Widget build(BuildContext context) {
    final isRtl = LocaleService.instance.language == AppLanguage.ar;
    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: IndexedStack(index: _index, children: _tabs),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: [
            BottomNavigationBarItem(icon: const Icon(Icons.home_outlined), label: AppStrings.home),
            BottomNavigationBarItem(icon: const Icon(Icons.menu_book_outlined), label: AppStrings.services),
            BottomNavigationBarItem(icon: const Icon(Icons.assignment_outlined), label: AppStrings.requests),
            BottomNavigationBarItem(icon: const Icon(Icons.chat_bubble_outline), label: AppStrings.chat),
            BottomNavigationBarItem(icon: const Icon(Icons.more_horiz), label: AppStrings.more),
          ],
        ),
      ),
    );
  }
}
