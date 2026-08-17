import 'dart:typed_data';

enum AnnouncementAttachmentType { image, pdf }

/// A single file attached to an announcement (image or PDF).
class AnnouncementAttachment {
  final Uint8List bytes;
  final String name;
  final AnnouncementAttachmentType type;

  const AnnouncementAttachment({
    required this.bytes,
    required this.name,
    required this.type,
  });
}

class Announcement {
  final String id;
  final String title;
  final String body;
  final String authorName;
  final DateTime createdAt;

  /// Zero or more attachments (images/PDFs). Defaults to an empty list
  /// so existing call sites that don't pass attachments keep working.
  final List<AnnouncementAttachment> attachments;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.authorName,
    required this.createdAt,
    this.attachments = const [],
  });
}
