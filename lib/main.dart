import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/services_catalog_screen.dart';
import 'screens/requests_list_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/settings_screen.dart';

void main() => runApp(const DSBAApp());

class DSBAApp extends StatelessWidget {
  const DSBAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DSBA PR & Operations Portal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      // App is Arabic-first (RTL); Directionality mirrors automatically
      // once localization delegates for 'ar' are wired in (see l10n/ folder).
      locale: const Locale('ar'),
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

  final _tabs = const [
    DashboardScreen(),
    ServicesCatalogScreen(),
    RequestsListScreen(),
    ChatScreen(threadId: 'general_pr_office'),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: IndexedStack(index: _index, children: _tabs),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _index,
          onTap: (i) => setState(() => _index = i),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'الرئيسية'),
            BottomNavigationBarItem(icon: Icon(Icons.menu_book_outlined), label: 'الخدمات'),
            BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'الطلبات'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'المحادثة'),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'المزيد'),
          ],
        ),
      ),
    );
  }
}
