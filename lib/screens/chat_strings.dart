import '../services/locale_service.dart';

class ChatStrings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get generalOfficeTitle => switch (_lang) {
    AppLanguage.ar => 'مكتب العلاقات العامة',
    AppLanguage.en => 'Public Relations Office',
    AppLanguage.de => 'Öffentlichkeitsarbeit',
  };

  static String threadTitle(String threadId) => switch (_lang) {
    AppLanguage.ar => 'شكوى غرفة $threadId',
    AppLanguage.en => 'Complaint Room $threadId',
    AppLanguage.de => 'Beschwerderaum $threadId',
  };

  static String get messageHint => switch (_lang) {
    AppLanguage.ar => 'اكتب رسالتك...',
    AppLanguage.en => 'Type your message...',
    AppLanguage.de => 'Nachricht eingeben...',
  };
}
