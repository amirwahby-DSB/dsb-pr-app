import 'package:flutter/material.dart';
import '../services/locale_service.dart';
import '../services/app_strings.dart';
import '../models/pr_request.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import '../widgets/status_pill.dart';
import 'request_form_screen.dart';
import 'request_tracker_screen.dart';

/// Module B — full ticket list with Active | Completed | All tabs,
/// referenced from the bottom nav tab.
class RequestsListScreen extends StatefulWidget {
  const RequestsListScreen({super.key});

  @override
  State<RequestsListScreen> createState() => _RequestsListScreenState();
}

class _RequestsListScreenState extends State<RequestsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<PRRequest> _filtered(List<PRRequest> all, int tabIndex) {
    switch (tabIndex) {
      case 0: // Active
        return all
            .where((r) =>
                r.status == RequestStatus.pending ||
                r.status == RequestStatus.inProgress ||
                r.status == RequestStatus.awaitingInfo)
            .toList();
      case 1: // Completed
        return all.where((r) => r.status == RequestStatus.completed).toList();
      default: // All
        return all;
    }
  }

  @override
  Widget build(BuildContext context) {
    final all = MockDataService.instance.getMyRequests();

    return Scaffold(
      appBar: AppBar(
        title: Text(_Strings.myRequestsTitle),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: _Strings.tabActive),
            Tab(text: _Strings.tabCompleted),
            Tab(text: _Strings.tabAll),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const RequestFormScreen()),
        ),
        backgroundColor: DSBAColors.primaryCrimson,
        icon: const Icon(Icons.add),
        label: Text(_Strings.newRequest),
      ),
      body: TabBarView(
        controller: _tabController,
        children: List.generate(3, (tabIndex) {
          final items = _filtered(all, tabIndex);
          if (items.isEmpty) {
            return Center(
              child: Text(
                _Strings.noRequestsHere,
                style: const TextStyle(color: DSBAColors.textMuted),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, i) => _RequestListTile(request: items[i]),
          );
        }),
      ),
    );
  }
}

class _RequestListTile extends StatelessWidget {
  final PRRequest request;
  const _RequestListTile({required this.request});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => RequestTrackerScreen(request: request)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(request.requestId,
                      style: const TextStyle(fontSize: 11, color: DSBAColors.textMuted)),
                  StatusPill(status: request.status),
                ],
              ),
              const SizedBox(height: 8),
              Text(request.title,
                  style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
              const SizedBox(height: 4),
              // NOTE: request.pillar.titleAr is a model-level field (not a UI string).
              // Fixing it needs a titleEn/titleDe getter on the PillarType model itself —
              // flagging it, not touching it here.
              Text(request.pillar.titleAr,
                  style: const TextStyle(fontSize: 12, color: DSBAColors.textMuted)),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.schedule, size: 13, color: DSBAColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    '${_Strings.createdOn}: ${request.createdAt.toString().split(' ').first}',
                    style: const TextStyle(fontSize: 11, color: DSBAColors.textMuted),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Strings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get myRequestsTitle => switch (_lang) {
        AppLanguage.ar => 'طلباتي',
        AppLanguage.en => 'My Requests',
        AppLanguage.de => 'Meine Anträge',
      };

  static String get tabActive => switch (_lang) {
        AppLanguage.ar => 'مفتوحة',
        AppLanguage.en => 'Active',
        AppLanguage.de => 'Aktiv',
      };

  static String get tabCompleted => switch (_lang) {
        AppLanguage.ar => 'مكتملة',
        AppLanguage.en => 'Completed',
        AppLanguage.de => 'Abgeschlossen',
      };

  static String get tabAll => switch (_lang) {
        AppLanguage.ar => 'الكل',
        AppLanguage.en => 'All',
        AppLanguage.de => 'Alle',
      };

  static String get noRequestsHere => switch (_lang) {
        AppLanguage.ar => 'لا توجد طلبات هنا حالياً',
        AppLanguage.en => 'No requests here yet',
        AppLanguage.de => 'Derzeit keine Anträge',
      };

  static String get createdOn => switch (_lang) {
        AppLanguage.ar => 'أُنشئ',
        AppLanguage.en => 'Created',
        AppLanguage.de => 'Erstellt',
      };

  static String get newRequest => switch (_lang) {
        AppLanguage.ar => 'طلب جديد',
        AppLanguage.en => 'New Request',
        AppLanguage.de => 'Neuer Antrag',
      };
}
