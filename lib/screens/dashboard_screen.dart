import 'package:flutter/material.dart';
import '../models/pr_request.dart';
import '../models/app_user.dart';
import '../services/mock_data_service.dart';
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
        title: const Text('DSBA — بوابة العلاقات العامة'),
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
                          Text('أهلاً، ${user.fullNameAr}',
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
            const Text('إجراءات سريعة',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
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
                  label: 'طلب جديد',
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RequestFormScreen())),
                ),
                _QuickAction(
                  icon: Icons.track_changes_outlined,
                  label: 'تتبع الطلبات',
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RequestsListScreen())),
                ),
                _QuickAction(
                  icon: Icons.menu_book_outlined,
                  label: 'دليل الخدمات',
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ServicesCatalogScreen())),
                ),
                _QuickAction(
                  icon: Icons.chat_bubble_outline,
                  label: 'محادثة المكتب',
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
                const Text('طلباتي الحالية',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (_) => const RequestsListScreen())),
                  child: const Text('عرض الكل',
                      style: TextStyle(color: DSBAColors.primaryCrimson, fontSize: 12)),
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
            const Text('آخر الإعلانات', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                leading: Icon(Icons.campaign_outlined, color: DSBAColors.primaryCrimson),
                title: Text('حفل التخرج السنوي — مكتبة الإسكندرية'),
                subtitle: Text('التخطيط جارٍ، الموعد المبدئي يونيو 2027'),
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
}
