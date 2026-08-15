import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
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
                  clipBehavior: Clip.antiAlias,
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
                        if (a.attachmentBytes != null) ...[
                          const SizedBox(height: 12),
                          _AttachmentPreview(
                            bytes: a.attachmentBytes!,
                            name: a.attachmentName ?? '',
                            type: a.attachmentType!,
                          ),
                        ],
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => _ComposeSheet(
        onPublished: _refresh,
      ),
    );
  }
}

/// Read-only preview of an attachment: inline image, or a tappable
/// row for a PDF that opens it via the `printing` package's viewer.
class _AttachmentPreview extends StatelessWidget {
  final Uint8List bytes;
  final String name;
  final AnnouncementAttachmentType type;
  const _AttachmentPreview({required this.bytes, required this.name, required this.type});

  @override
  Widget build(BuildContext context) {
    if (type == AnnouncementAttachmentType.image) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.memory(bytes, height: 160, width: double.infinity, fit: BoxFit.cover),
      );
    }
    return InkWell(
      onTap: () => Printing.layoutPdf(onLayout: (_) async => bytes),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: DSBAColors.primaryCrimson.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const Icon(Icons.picture_as_pdf_outlined, color: DSBAColors.primaryCrimson),
            const SizedBox(width: 8),
            Expanded(
              child: Text(name.isEmpty ? 'PDF' : name,
                  maxLines: 1, overflow: TextOverflow.ellipsis),
            ),
            Text(AnnouncementsStrings.viewAttachment,
                style: const TextStyle(fontSize: 11, color: DSBAColors.primaryCrimson)),
          ],
        ),
      ),
    );
  }
}

/// The "new announcement" form, kept as its own StatefulWidget so the
/// attachment picker can update the bottom sheet's own state.
class _ComposeSheet extends StatefulWidget {
  final VoidCallback onPublished;
  const _ComposeSheet({required this.onPublished});

  @override
  State<_ComposeSheet> createState() => _ComposeSheetState();
}

class _ComposeSheetState extends State<_ComposeSheet> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  Uint8List? _attachmentBytes;
  String? _attachmentName;
  AnnouncementAttachmentType? _attachmentType;
  String? _error;

  Future<void> _pickAttachment() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
      withData: true,
    );
    if (result == null || result.files.isEmpty) return;
    final file = result.files.single;
    final bytes = file.bytes;
    if (bytes == null) return;

    final ext = (file.extension ?? '').toLowerCase();
    AnnouncementAttachmentType? type;
    if (ext == 'jpg' || ext == 'jpeg' || ext == 'png') {
      type = AnnouncementAttachmentType.image;
    } else if (ext == 'pdf') {
      type = AnnouncementAttachmentType.pdf;
    }

    if (type == null) {
      setState(() => _error = AnnouncementsStrings.unsupportedFileType);
      return;
    }

    setState(() {
      _attachmentBytes = bytes;
      _attachmentName = file.name;
      _attachmentType = type;
      _error = null;
    });
  }

  void _removeAttachment() {
    setState(() {
      _attachmentBytes = null;
      _attachmentName = null;
      _attachmentType = null;
    });
  }

  void _publish() {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();
    if (title.isEmpty || body.isEmpty) return;
    final currentUser = MockDataService.instance.currentUser;
    MockDataService.instance.addAnnouncement(
      Announcement(
        id: 'ann-${DateTime.now().millisecondsSinceEpoch}',
        title: title,
        body: body,
        authorName: currentUser.fullNameAr,
        createdAt: DateTime.now(),
        attachmentBytes: _attachmentBytes,
        attachmentName: _attachmentName,
        attachmentType: _attachmentType,
      ),
    );
    Navigator.pop(context);
    widget.onPublished();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
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
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: AnnouncementsStrings.titleFieldHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _bodyController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: AnnouncementsStrings.bodyFieldHint,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              if (_attachmentBytes == null)
                OutlinedButton.icon(
                  onPressed: _pickAttachment,
                  icon: const Icon(Icons.attach_file_outlined),
                  label: Text(AnnouncementsStrings.attachFile),
                )
              else
                Row(
                  children: [
                    Icon(
                      _attachmentType == AnnouncementAttachmentType.image
                          ? Icons.image_outlined
                          : Icons.picture_as_pdf_outlined,
                      color: DSBAColors.primaryCrimson,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(_attachmentName ?? '',
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 18),
                      tooltip: AnnouncementsStrings.removeAttachment,
                      onPressed: _removeAttachment,
                    ),
                  ],
                ),
              if (_error != null) ...[
                const SizedBox(height: 6),
                Text(_error!, style: const TextStyle(color: Colors.red, fontSize: 12)),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(AnnouncementsStrings.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: _publish,
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
