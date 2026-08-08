import '../services/locale_service.dart';

class DashboardStrings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get serviceGuideTitle => switch (_lang) {
    AppLanguage.ar => 'دليل الخدمات - الأقسام الستة',
    AppLanguage.en => 'Service Guide - Six Pillars',
    AppLanguage.de => 'Leistungsverzeichnis - Sechs Säulen',
  };

  static String get searchServiceHint => switch (_lang) {
    AppLanguage.ar => 'ابحث عن خدمة (تأشيرة، طباعة، رحلة...)',
    AppLanguage.en => 'Search a service (visa, printing, trip...)',
    AppLanguage.de => 'Dienst suchen (Visum, Druck, Reise...)',
  };

  static String get requestButton => switch (_lang) {
    AppLanguage.ar => 'طلب',
    AppLanguage.en => 'Request',
    AppLanguage.de => 'Antrag',
  };
}
