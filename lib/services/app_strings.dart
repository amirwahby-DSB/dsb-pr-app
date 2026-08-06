import 'locale_service.dart';

class AppStrings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get home => switch (_lang) {
        AppLanguage.ar => 'الرئيسية',
        AppLanguage.en => 'Home',
        AppLanguage.de => 'Startseite',
      };

  static String get services => switch (_lang) {
        AppLanguage.ar => 'الخدمات',
        AppLanguage.en => 'Services',
        AppLanguage.de => 'Dienste',
      };

  static String get requests => switch (_lang) {
        AppLanguage.ar => 'الطلبات',
        AppLanguage.en => 'Requests',
        AppLanguage.de => 'Anträge',
      };

  static String get chat => switch (_lang) {
        AppLanguage.ar => 'المحادثة',
        AppLanguage.en => 'Chat',
        AppLanguage.de => 'Chat',
      };

  static String get more => switch (_lang) {
        AppLanguage.ar => 'المزيد',
        AppLanguage.en => 'More',
        AppLanguage.de => 'Mehr',
      };

  static String get settingsTitle => switch (_lang) {
        AppLanguage.ar => 'الإعدادات والمزيد',
        AppLanguage.en => 'Settings & More',
        AppLanguage.de => 'Einstellungen & Mehr',
      };

  static String get languageTitle => switch (_lang) {
        AppLanguage.ar => 'اللغة / Sprache / Language',
        AppLanguage.en => 'اللغة / Sprache / Language',
        AppLanguage.de => 'اللغة / Sprache / Language',
      };

  static String get languageSubtitle => switch (_lang) {
        AppLanguage.ar => 'العربية، Deutsch، English',
        AppLanguage.en => 'العربية، Deutsch، English',
        AppLanguage.de => 'العربية، Deutsch، English',
      };

  static String get notifications => switch (_lang) {
        AppLanguage.ar => 'الإشعارات',
        AppLanguage.en => 'Notifications',
        AppLanguage.de => 'Benachrichtigungen',
      };

  static String get welcome => switch (_lang) {
        AppLanguage.ar => 'أهلاً،',
        AppLanguage.en => 'Welcome,',
        AppLanguage.de => 'Willkommen,',
      };

  static String get quickActions => switch (_lang) {
        AppLanguage.ar => 'إجراءات سريعة',
        AppLanguage.en => 'Quick Actions',
        AppLanguage.de => 'Schnellaktionen',
      };

  static String get trackRequests => switch (_lang) {
        AppLanguage.ar => 'تتبع الطلبات',
        AppLanguage.en => 'Track Requests',
        AppLanguage.de => 'Anträge verfolgen',
      };

  static String get newRequest => switch (_lang) {
        AppLanguage.ar => 'طلب جديد',
        AppLanguage.en => 'New Request',
        AppLanguage.de => 'Neuer Antrag',
      };

  static String get officeChat => switch (_lang) {
        AppLanguage.ar => 'محادثة المكتب',
        AppLanguage.en => 'Office Chat',
        AppLanguage.de => 'Büro-Chat',
      };

  static String get serviceGuide => switch (_lang) {
        AppLanguage.ar => 'دليل الخدمات',
        AppLanguage.en => 'Service Guide',
        AppLanguage.de => 'Dienstleitfaden',
      };

  static String get currentRequests => switch (_lang) {
        AppLanguage.ar => 'طلباتي الحالية',
        AppLanguage.en => 'My Current Requests',
        AppLanguage.de => 'Meine aktuellen Anträge',
      };

  static String get viewAll => switch (_lang) {
        AppLanguage.ar => 'عرض الكل',
        AppLanguage.en => 'View All',
        AppLanguage.de => 'Alle anzeigen',
      };

  static String get latestAnnouncements => switch (_lang) {
        AppLanguage.ar => 'آخر الإعلانات',
        AppLanguage.en => 'Latest Announcements',
        AppLanguage.de => 'Neueste Ankündigungen',
      };

  static String get departmentAnnouncements => switch (_lang) {
        AppLanguage.ar => 'إعلانات القسم',
        AppLanguage.en => 'Department Announcements',
        AppLanguage.de => 'Abteilungsankündigungen',
      };
static String get serviceGuideTitle => switch (_lang) {
        AppLanguage.ar => 'دليل الخدمات – الأقسام الستة',
        AppLanguage.en => 'Service Guide – Six Pillars',
        AppLanguage.de => 'Leistungsverzeichnis – Sechs Säulen',
      };

  static String get searchServiceHint => switch (_lang) {
        AppLanguage.ar => 'ابحث عن خدمة (تأشيرة، طباعة، رحلة...)',
        AppLanguage.en => 'Search a service (visa, printing, trip...)',
        AppLanguage.de => 'Dienst suchen (Visum, Druck, Reise...)',
      };

  static String get requestButton => switch (_lang) {
        AppLanguage.ar => 'طلب',
        AppLanguage.en => 'Request',
        AppLanguage.de => 'Anfrage',
      };
}

