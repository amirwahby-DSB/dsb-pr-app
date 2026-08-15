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
}
