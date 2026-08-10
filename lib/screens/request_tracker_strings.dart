import '../services/locale_service.dart';

class RequestTrackerStrings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get requestStatus => switch (_lang) {
    AppLanguage.ar => 'حالة الطلب',
    AppLanguage.en => 'Request Status',
    AppLanguage.de => 'Antragsstatus',
  };

  static String get timeline => switch (_lang) {
    AppLanguage.ar => 'السجل الزمني',
    AppLanguage.en => 'Timeline',
    AppLanguage.de => 'Zeitverlauf',
  };

  static String get prOfficerName => switch (_lang) {
    AppLanguage.ar => 'أمير وهبي — مسؤول العلاقات العامة',
    AppLanguage.en => 'Amir Wahby — Public Relations Officer',
    AppLanguage.de => 'Amir Wahby — Beauftragter für Öffentlichkeitsarbeit',
  };

  static String lastUpdated(String date) => switch (_lang) {
    AppLanguage.ar => 'آخر تحديث: $date',
    AppLanguage.en => 'Last updated: $date',
    AppLanguage.de => 'Zuletzt aktualisiert: $date',
  };

  static String get openChat => switch (_lang) {
    AppLanguage.ar => 'فتح محادثة حول هذا الطلب',
    AppLanguage.en => 'Open chat about this request',
    AppLanguage.de => 'Chat zu diesem Antrag öffnen',
  };
}
