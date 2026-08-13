import '../services/locale_service.dart';
class ExecutiveDashboardStrings {
  static AppLanguage get _lang => LocaleService.instance.language;
  static String get title => switch (_lang) {
    AppLanguage.ar => 'لوحة التقارير التنفيذية',
    AppLanguage.en => 'Executive Reports Dashboard',
    AppLanguage.de => 'Führungsberichte-Dashboard',
  };
  static String get exportPdfTooltip => switch (_lang) {
    AppLanguage.ar => 'تصدير تقرير PDF',
    AppLanguage.en => 'Export PDF Report',
    AppLanguage.de => 'PDF-Bericht exportieren',
  };
  static String get totalRequests => switch (_lang) {
    AppLanguage.ar => 'إجمالي الطلبات',
    AppLanguage.en => 'Total Requests',
    AppLanguage.de => 'Gesamtanträge',
  };
  static String get completedRequests => switch (_lang) {
    AppLanguage.ar => 'الطلبات المكتملة',
    AppLanguage.en => 'Completed Requests',
    AppLanguage.de => 'Abgeschlossene Anträge',
  };
  static String get printingJobs => switch (_lang) {
    AppLanguage.ar => 'أعمال طباعة منجزة',
    AppLanguage.en => 'Printing Jobs Completed',
    AppLanguage.de => 'Abgeschlossene Druckaufträge',
  };
  static String get tripsOrganized => switch (_lang) {
    AppLanguage.ar => 'رحلات منظمة',
    AppLanguage.en => 'Trips Organized',
    AppLanguage.de => 'Organisierte Reisen',
  };
  static String get eventsManaged => switch (_lang) {
    AppLanguage.ar => 'فعاليات مُدارة',
    AppLanguage.en => 'Events Managed',
    AppLanguage.de => 'Verwaltete Veranstaltungen',
  };
  static String get mediaRequests => switch (_lang) {
    AppLanguage.ar => 'طلبات إعلامية',
    AppLanguage.en => 'Media Requests',
    AppLanguage.de => 'Medienanfragen',
  };
  static String get avgResolutionTime => switch (_lang) {
    AppLanguage.ar => 'متوسط زمن الإنجاز',
    AppLanguage.en => 'Average Resolution Time',
    AppLanguage.de => 'Durchschnittliche Bearbeitungszeit',
  };
  static String hoursValue(String hours) => switch (_lang) {
    AppLanguage.ar => '$hours ساعة',
    AppLanguage.en => '$hours hours',
    AppLanguage.de => '$hours Stunden',
  };
  static String get acrossPillars => switch (_lang) {
    AppLanguage.ar => 'عبر جميع الأقسام الستة خلال الفترة الحالية',
    AppLanguage.en => 'Across all six departments during the current period',
    AppLanguage.de => 'Über alle sechs Abteilungen im aktuellen Zeitraum',
  };
  static String get exportPdfSheetTitle => switch (_lang) {
    AppLanguage.ar => 'تصدير تقرير PDF',
    AppLanguage.en => 'Export PDF Report',
    AppLanguage.de => 'PDF-Bericht exportieren',
  };
  static String get dailyReport => switch (_lang) {
    AppLanguage.ar => 'تقرير يومي',
    AppLanguage.en => 'Daily Report',
    AppLanguage.de => 'Tagesbericht',
  };

  static String get weeklyReport => switch (_lang) {
    AppLanguage.ar => 'تقرير أسبوعي',
    AppLanguage.en => 'Weekly Report',
    AppLanguage.de => 'Wochenbericht',
  };
  static String get monthlyReport => switch (_lang) {
    AppLanguage.ar => 'تقرير شهري',
    AppLanguage.en => 'Monthly Report',
    AppLanguage.de => 'Monatsbericht',
  };
  static String get yearlyReport => switch (_lang) {
    AppLanguage.ar => 'تقرير سنوي',
    AppLanguage.en => 'Yearly Report',
    AppLanguage.de => 'Jahresbericht',
  };

  static String get accessDeniedTitle => switch (_lang) {
    AppLanguage.ar => 'غير مصرح لك بالدخول',
    AppLanguage.en => 'Access Denied',
    AppLanguage.de => 'Zugriff verweigert',
  };

  static String get accessDeniedBody => switch (_lang) {
    AppLanguage.ar => 'هذه الصفحة متاحة فقط لمسؤولي العلاقات العامة والإدارة العليا.',
    AppLanguage.en => 'This page is available only to PR administrators and leadership.',
    AppLanguage.de => 'Diese Seite ist nur für PR-Administratoren und die Geschäftsleitung verfügbar.',
  };
}
