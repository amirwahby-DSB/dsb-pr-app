import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'services/locale_service.dart';
import 'services/app_strings.dart';
import 'screens/dashboard_screen.dart';
import 'screens/services_catalog_screen.dart';
import 'screens/requests_list_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/settings_screen.dart';
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
      home: const RootShell(),
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

  // NOT const: these screens read AppStrings/locale-dependent text at
  // build time. A const list is built once and never rebuilt, so it
  // would keep showing the language that was active on first launch
  // even after the user switches languages. Using a getter rebuilds
  // the tab widgets fresh every time RootShell rebuilds (e.g. on
  // locale change), so translated text updates correctly.
  List<Widget> get _tabs => [
        const DashboardScreen(),
        const ServicesCatalogScreen(),
        const RequestsListScreen(),
        const ChatScreen(threadId: 'general_pr_office'),
        const SettingsScreen(),
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
