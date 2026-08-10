import '../services/locale_service.dart';

class RequestFormStrings {
  static AppLanguage get _lang => LocaleService.instance.language;

  static String get selectPillarFirst => switch (_lang) {
    AppLanguage.ar => 'يرجى اختيار القسم أولاً',
    AppLanguage.en => 'Please select a department first',
    AppLanguage.de => 'Bitte wählen Sie zuerst eine Abteilung',
  };

  static String get enterTitleFirst => switch (_lang) {
    AppLanguage.ar => 'يرجى إدخال عنوان الطلب',
    AppLanguage.en => 'Please enter a request title',
    AppLanguage.de => 'Bitte geben Sie einen Antragstitel ein',
  };

  static String get submittedTitle => switch (_lang) {
    AppLanguage.ar => 'تم إرسال الطلب',
    AppLanguage.en => 'Request Submitted',
    AppLanguage.de => 'Antrag gesendet',
  };

  static String get submittedBody => switch (_lang) {
    AppLanguage.ar => 'سيتواصل معك مكتب العلاقات العامة قريباً لمتابعة طلبك.',
    AppLanguage.en => 'The Public Relations Office will contact you soon regarding your request.',
    AppLanguage.de => 'Das Büro für Öffentlichkeitsarbeit wird sich in Kürze bezüglich Ihres Antrags bei Ihnen melden.',
  };

  static String get ok => switch (_lang) {
    AppLanguage.ar => 'حسناً',
    AppLanguage.en => 'OK',
    AppLanguage.de => 'OK',
  };

  static String get newRequestTitle => switch (_lang) {
    AppLanguage.ar => 'طلب خدمة جديد',
    AppLanguage.en => 'New Service Request',
    AppLanguage.de => 'Neuer Dienstantrag',
  };

  static String get previous => switch (_lang) {
    AppLanguage.ar => 'السابق',
    AppLanguage.en => 'Previous',
    AppLanguage.de => 'Zurück',
  };

  static String get next => switch (_lang) {
    AppLanguage.ar => 'التالي',
    AppLanguage.en => 'Next',
    AppLanguage.de => 'Weiter',
  };

  static String get submitRequest => switch (_lang) {
    AppLanguage.ar => 'إرسال الطلب',
    AppLanguage.en => 'Submit Request',
    AppLanguage.de => 'Antrag senden',
  };

  static String get choosePillarHeader => switch (_lang) {
    AppLanguage.ar => 'اختر القسم المعني بالطلب',
    AppLanguage.en => 'Choose the department for this request',
    AppLanguage.de => 'Wählen Sie die zuständige Abteilung',
  };

  static String get detailsHeader => switch (_lang) {
    AppLanguage.ar => 'تفاصيل الطلب',
    AppLanguage.en => 'Request Details',
    AppLanguage.de => 'Antragsdetails',
  };

  static String get requestTitleLabel => switch (_lang) {
    AppLanguage.ar => 'عنوان الطلب',
    AppLanguage.en => 'Request Title',
    AppLanguage.de => 'Antragstitel',
  };

  static String get descriptionLabel => switch (_lang) {
    AppLanguage.ar => 'وصف تفصيلي / ملاحظات',
    AppLanguage.en => 'Detailed description / notes',
    AppLanguage.de => 'Detaillierte Beschreibung / Notizen',
  };

  static String get priorityLabel => switch (_lang) {
    AppLanguage.ar => 'الأولوية',
    AppLanguage.en => 'Priority',
    AppLanguage.de => 'Priorität',
  };

  static String get priorityLow => switch (_lang) {
    AppLanguage.ar => 'منخفضة',
    AppLanguage.en => 'Low',
    AppLanguage.de => 'Niedrig',
  };

  static String get priorityNormal => switch (_lang) {
    AppLanguage.ar => 'عادية',
    AppLanguage.en => 'Normal',
    AppLanguage.de => 'Normal',
  };

  static String get priorityHigh => switch (_lang) {
    AppLanguage.ar => 'عالية',
    AppLanguage.en => 'High',
    AppLanguage.de => 'Hoch',
  };

  static String get priorityUrgent => switch (_lang) {
    AppLanguage.ar => 'عاجلة',
    AppLanguage.en => 'Urgent',
    AppLanguage.de => 'Dringend',
  };

  static String priorityDisplay(String key) => switch (key) {
    'low' => priorityLow,
    'high' => priorityHigh,
    'urgent' => priorityUrgent,
    _ => priorityNormal,
  };

  static String get attachmentsHeader => switch (_lang) {
    AppLanguage.ar => 'المرفقات (اختياري)',
    AppLanguage.en => 'Attachments (optional)',
    AppLanguage.de => 'Anhänge (optional)',
  };

  static String get attachFile => switch (_lang) {
    AppLanguage.ar => 'إرفاق ملف',
    AppLanguage.en => 'Attach File',
    AppLanguage.de => 'Datei anhängen',
  };

  static String get documentPrefix => switch (_lang) {
    AppLanguage.ar => 'مستند',
    AppLanguage.en => 'Document',
    AppLanguage.de => 'Dokument',
  };

  static String get reviewHeader => switch (_lang) {
    AppLanguage.ar => 'مراجعة الطلب',
    AppLanguage.en => 'Review Request',
    AppLanguage.de => 'Antrag überprüfen',
  };

  static String get reviewPillar => switch (_lang) {
    AppLanguage.ar => 'القسم',
    AppLanguage.en => 'Department',
    AppLanguage.de => 'Abteilung',
  };

  static String get reviewTitle => switch (_lang) {
    AppLanguage.ar => 'العنوان',
    AppLanguage.en => 'Title',
    AppLanguage.de => 'Titel',
  };

  static String get reviewDescription => switch (_lang) {
    AppLanguage.ar => 'الوصف',
    AppLanguage.en => 'Description',
    AppLanguage.de => 'Beschreibung',
  };

  static String get reviewAttachments => switch (_lang) {
    AppLanguage.ar => 'المرفقات',
    AppLanguage.en => 'Attachments',
    AppLanguage.de => 'Anhänge',
  };

  static String get noValue => switch (_lang) {
    AppLanguage.ar => '-',
    AppLanguage.en => '-',
    AppLanguage.de => '-',
  };

  static String filesCount(int count) => switch (_lang) {
    AppLanguage.ar => '$count ملف',
    AppLanguage.en => '$count file(s)',
    AppLanguage.de => '$count Datei(en)',
  };

  static String get stepPillar => switch (_lang) {
    AppLanguage.ar => 'القسم',
    AppLanguage.en => 'Department',
    AppLanguage.de => 'Abteilung',
  };

  static String get stepDetails => switch (_lang) {
    AppLanguage.ar => 'التفاصيل',
    AppLanguage.en => 'Details',
    AppLanguage.de => 'Details',
  };

  static String get stepAttachments => switch (_lang) {
    AppLanguage.ar => 'المرفقات',
    AppLanguage.en => 'Attachments',
    AppLanguage.de => 'Anhänge',
  };

  static String get stepReview => switch (_lang) {
    AppLanguage.ar => 'المراجعة',
    AppLanguage.en => 'Review',
    AppLanguage.de => 'Überprüfung',
  };
}
