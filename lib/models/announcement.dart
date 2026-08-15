import 'dart:typed_data';

enum AnnouncementAttachmentType { image, pdf }

class Announcement {
  final String id;
  final String title;
  final String body;
  final String authorName;
  final DateTime createdAt;
  final Uint8List? attachmentBytes;
  final String? attachmentName;
  final AnnouncementAttachmentType? attachmentType;

  const Announcement({
    required this.id,
    required this.title,
    required this.body,
    required this.authorName,
    required this.createdAt,
    this.attachmentBytes,
    this.attachmentName,
    this.attachmentType,
  });
}
