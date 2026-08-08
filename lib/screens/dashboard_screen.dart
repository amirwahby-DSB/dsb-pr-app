import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
import '../services/app_strings.dart';
import '../services/locale_service.dart';
import '../theme/app_theme.dart';
import '../widgets/status_pill.dart';
import 'request_form_screen.dart';
import 'request_tracker_screen.dart';
import 'requests_list_screen.dart';
import 'services_catalog_screen.dart';
import 'chat_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = MockDataService.instance;
    final user = data.currentUser;
    final requests = data.getMyRequests();
    final lang = LocaleService.instance.language;

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: const AssetImage('assets/branding/dsba_logo.jpg'),
            onBackgroundImageError: (_, __) {}, // graceful fallback if asset missing at build time
          ),
        ),
        title: Text(lang == AppLanguage.ar
            ? 'DSBA – بوابة العلاقات العامة'
            : lang == AppLanguage.en
                ? 'DSBA – PR & Operations Portal'
                : 'DSBA – PR- & Betriebsportal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Greeting header
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundColor: DSBAColors.accentGold,
                      child: Icon(Icons.person, color: DSBAColors.neutralDark),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${AppStrings.welcome} ${lang == AppLanguage.ar ? user.fullNameAr : user.fullName}',
                              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                          Text(user.role.id,
                              style: const TextStyle(color: DSBAColors.textMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Quick actions grid
            Text(AppStrings.quickActions,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.4,
              children: [
                _QuickAction(
                  icon: Icons.add_circle_outline,
                  label: AppStrings.newRequest,
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RequestFormScreen())),
                ),
                _QuickAction(
                  icon: Icons.track_changes_outlined,
                  label: AppStrings.trackRequests,
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RequestsListScreen())),
                ),
                _QuickAction(
                  icon: Icons.menu_book_outlined,
                  label: AppStrings.serviceGuide,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ServicesCatalogScreen())),
                ),
                _QuickAction(
                  icon: Icons.chat_bubble_outline,
                  label: AppStrings.officeChat,
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ChatScreen(threadId: 'general_pr_office'))),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Open requests carousel
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppStrings.currentRequests,
                    style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RequestsListScreen())),
                  child: Text(AppStrings.viewAll,
                      style: const TextStyle(color: DSBAColors.primaryCrimson, fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 130,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: requests.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, i) => _RequestMiniCard(request: requests[i]),
              ),
            ),
            const SizedBox(height: 20),

            // Announcements feed
            Text(AppStrings.latestAnnouncements, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                leading: Icon(Icons.campaign_outlined, color: DSBAColors.primaryCrimson),
                title: Text('حفل التخرج السنوي – مكتبة الإسكندرية'),
                subtitle: Text('التخطيط جارٍ الموعد المبدئي يونيو 2027'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Icon(icon, color: DSBAColors.primaryCrimson),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RequestMiniCard extends StatelessWidget {
  final PRRequest request;
  const _RequestMiniCard({required this.request});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RequestTrackerScreen(request: request)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(request.pillar.titleAr,
                    style: const TextStyle(fontSize: 11, color: DSBAColors.textMuted)),
                const SizedBox(height: 6),
                Text(
                  request.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                ),
                const Spacer(),
                StatusPill(status: request.status),
              ],
            ),
          ),
        ),
      ),
    );
  }
 class _Strings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get serviceGuideTitle => switch (_lang) {
        AppLanguage.ar => 'دليل الخدمات - الأقسام الستة',
        AppLanguage.en => 'Service Guide - Six Pillars',
        AppLanguage.de => 'Leistungsverzeichnis - Sechs Säulen',
      };

  static String get searchServiceHint => switch (_lang) {
        AppLanguage.ar => 'ابحث عن خدمة (تأشيرة، طباعة، رحلة...)',
        AppLanguage.en => 'Search a service (visa, printing, trip...)',
        AppLanguage.de => 'Dienst suchen (Visum, Druck, Reise...)',
      };

  static String get requestButton => switch (_lang) {
        AppLanguage.ar => 'طلب',
        AppLanguage.en => 'Request',
        AppLanguage.de => 'Antrag',
      };
}
