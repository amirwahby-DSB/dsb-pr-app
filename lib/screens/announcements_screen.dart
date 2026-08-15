import 'package:flutter/material.dart';
import '../models/app_user.dart';
import '../models/announcement.dart';
import '../services/mock_data_service.dart';
import '../theme/app_theme.dart';
import 'announcements_strings.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  late List<Announcement> _announcements;

  @override
  void initState() {
    super.initState();
    _announcements = MockDataService.instance.getAnnouncements();
  }

  void _refresh() {
    setState(() {
      _announcements = MockDataService.instance.getAnnouncements();
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = MockDataService.instance.currentUser;
    final canPost = currentUser.role.canPostAnnouncements;

    return Scaffold(
      appBar: AppBar(title: Text(AnnouncementsStrings.title)),
      floatingActionButton: canPost
          ? FloatingActionButton.extended(
              onPressed: () => _openComposeSheet(context),
              icon: const Icon(Icons.campaign_outlined),
              label: Text(AnnouncementsStrings.postButton),
            )
          : null,
      body: _announcements.isEmpty
          ? Center(
              child: Text(
                AnnouncementsStrings.emptyState,
                style: const TextStyle(color: DSBAColors.textMuted),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _announcements.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final a = _announcements[i];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.campaign_outlined, color: DSBAColors.primaryCrimson),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                a.title,
                                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(a.body, style: const TextStyle(fontSize: 13)),
                        const SizedBox(height: 10),
                        Text(
                          AnnouncementsStrings.publishedBy(a.authorName),
                          style: const TextStyle(fontSize: 11, color: DSBAColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void _openComposeSheet(BuildContext context) {
    final titleController = TextEditingController();
    final bodyController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 20,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AnnouncementsStrings.newAnnouncementTitle,
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: AnnouncementsStrings.titleFieldHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bodyController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AnnouncementsStrings.bodyFieldHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: Text(AnnouncementsStrings.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        final title = titleController.text.trim();
                        final body = bodyController.text.trim();
                        if (title.isEmpty || body.isEmpty) return;
                        final currentUser = MockDataService.instance.currentUser;
                        MockDataService.instance.addAnnouncement(
                          Announcement(
                            id: 'ann-${DateTime.now().millisecondsSinceEpoch}',
                            title: title,
                            body: body,
                            authorName: currentUser.fullNameAr,
                            createdAt: DateTime.now(),
                          ),
                        );
                        Navigator.pop(sheetContext);
                        _refresh();
                      },
                      child: Text(AnnouncementsStrings.publish),
                    ),
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
