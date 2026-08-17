import '../services/locale_service.dart';

class AnnouncementsStrings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get title => switch (_lang) {
        AppLanguage.ar => 'إعلانات القسم',
        AppLanguage.en => 'Department Announcements',
        AppLanguage.de => 'Abteilungsankündigungen',
      };
  static String get postButton => switch (_lang) {
        AppLanguage.ar => 'نشر إعلان',
        AppLanguage.en => 'Post Announcement',
        AppLanguage.de => 'Ankündigung veröffentlichen',
      };
  static String get newAnnouncementTitle => switch (_lang) {
        AppLanguage.ar => 'إعلان جديد',
        AppLanguage.en => 'New Announcement',
        AppLanguage.de => 'Neue Ankündigung',
      };
  static String get titleFieldHint => switch (_lang) {
        AppLanguage.ar => 'عنوان الإعلان',
        AppLanguage.en => 'Announcement title',
        AppLanguage.de => 'Titel der Ankündigung',
      };
  static String get bodyFieldHint => switch (_lang) {
        AppLanguage.ar => 'تفاصيل الإعلان',
        AppLanguage.en => 'Announcement details',
        AppLanguage.de => 'Details der Ankündigung',
      };
  static String get cancel => switch (_lang) {
        AppLanguage.ar => 'إلغاء',
        AppLanguage.en => 'Cancel',
        AppLanguage.de => 'Abbrechen',
      };
  static String get publish => switch (_lang) {
        AppLanguage.ar => 'نشر',
        AppLanguage.en => 'Publish',
        AppLanguage.de => 'Veröffentlichen',
      };
  static String get emptyState => switch (_lang) {
        AppLanguage.ar => 'لا توجد إعلانات حتى الآن',
        AppLanguage.en => 'No announcements yet',
        AppLanguage.de => 'Noch keine Ankündigungen',
      };
  static String publishedBy(String name) => switch (_lang) {
        AppLanguage.ar => 'بواسطة $name',
        AppLanguage.en => 'By $name',
        AppLanguage.de => 'Von $name',
      };

  /// Button to add one or more attachments (shown even after some are
  /// already added, so the user can keep adding more).
  static String get attachFile => switch (_lang) {
        AppLanguage.ar => 'إرفاق صور أو PDF',
        AppLanguage.en => 'Attach Images or PDFs',
        AppLanguage.de => 'Bilder oder PDFs anhängen',
      };
  static String get removeAttachment => switch (_lang) {
        AppLanguage.ar => 'إزالة المرفق',
        AppLanguage.en => 'Remove attachment',
        AppLanguage.de => 'Anhang entfernen',
      };
  static String get viewAttachment => switch (_lang) {
        AppLanguage.ar => 'عرض المرفق',
        AppLanguage.en => 'View attachment',
        AppLanguage.de => 'Anhang ansehen',
      };
  static String get unsupportedFileType => switch (_lang) {
        AppLanguage.ar => 'أحد الملفات المختارة غير مدعوم. الأنواع المسموحة: JPG, PNG, PDF',
        AppLanguage.en => 'One of the selected files is unsupported. Allowed: JPG, PNG, PDF',
        AppLanguage.de => 'Eine der ausgewählten Dateien wird nicht unterstützt. Erlaubt: JPG, PNG, PDF',
      };

  /// Shown when the user tries to add more than [maxAttachments] files.
  static const int maxAttachments = 5;
  static String get maxAttachmentsReached => switch (_lang) {
        AppLanguage.ar => 'أقصى عدد للمرفقات هو ${AnnouncementsStrings.maxAttachments} ملفات لكل إعلان',
        AppLanguage.en => 'Maximum ${AnnouncementsStrings.maxAttachments} attachments per announcement',
        AppLanguage.de => 'Maximal ${AnnouncementsStrings.maxAttachments} Anhänge pro Ankündigung',
      };

  /// "3 attachments" / label above the attachments list in the compose sheet.
  static String attachmentsCount(int count) => switch (_lang) {
        AppLanguage.ar => 'المرفقات ($count)',
        AppLanguage.en => 'Attachments ($count)',
        AppLanguage.de => 'Anhänge ($count)',
      };
}
