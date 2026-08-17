import '../models/pr_request.dart';
import '../models/app_user.dart';
import '../models/chat_message.dart';
import '../models/announcement.dart';

/// Local mock implementation of the data layer.
/// Replace method bodies with REST (Dio/http) or Firestore calls —
/// the method signatures/return types already match the JSON schemas
/// in /schemas, so screens do not need to change.
class MockDataService {
  MockDataService._();
  static final MockDataService instance = MockDataService._();

  final AppUser currentUser = const AppUser(
    userId: 'u-001',
    fullName: 'Amir Wahby',
    fullNameAr: 'أمير وهبي',
    email: 'p.r@dsb-alexandria.de',
    role: UserRole.staff,
  );

  final AppUser prManager = const AppUser(
    userId: 'u-000',
    fullName: 'Amir Wahby',
    fullNameAr: 'أمير وهبي',
    email: 'p.r@dsb-alexandria.de',
    phone: '+20 101 35 35 436',
    role: UserRole.prAdmin,
  );

  List<PRRequest> getMyRequests() => [
        PRRequest(
          requestId: 'PR-2026-00147',
          pillar: Pillar.printingOperations,
          serviceType: 'exam_printing',
          title: 'طباعة امتحانات الفصل الدراسي الثاني - الصف التاسع',
          description: '120 نسخة، مادة الرياضيات، مطلوبة يوم الخميس صباحاً.',
          requesterId: 'u-001',
          assignedToId: 'u-000',
          status: RequestStatus.inProgress,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          dueDate: DateTime.now().add(const Duration(days: 2)),
          dynamicFields: {'copies': 120, 'subject': 'Mathematik'},
        ),
        PRRequest(
          requestId: 'PR-2026-00148',
          pillar: Pillar.consularVisas,
          serviceType: 'vfs_visa_booking',
          title: 'حجز موعد تأشيرة ألمانيا - رحلة برلين',
          description: 'مجموعة من 25 طالبة، رحلة تبادل ثقافي.',
          requesterId: 'u-001',
          status: RequestStatus.pending,
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
          dynamicFields: {'studentCount': 25, 'destination': 'Berlin'},
        ),
        PRRequest(
          requestId: 'PR-2026-00139',
          pillar: Pillar.eventManagement,
          serviceType: 'graduation_venue_booking',
          title: 'حجز مكتبة الإسكندرية لحفل التخرج',
          description: 'التخطيط التنفيذي الكامل لحفل التخرج السنوي.',
          requesterId: 'u-001',
          assignedToId: 'u-000',
          status: RequestStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 14)),
        ),
      ];

  /// All requests across every requester and pillar — used for
  /// management reporting (daily/monthly/yearly/half-yearly PDF export).
  /// Replace with a real backend query (e.g. GET /requests?from=&to=)
  /// once the API is available; the return type stays the same.
  List<PRRequest> getAllRequests() => [
        ...getMyRequests(),
        PRRequest(
          requestId: 'PR-2026-00150',
          pillar: Pillar.digitalMediaIdentity,
          serviceType: 'social_media_post',
          title: 'منشور تهنئة بمناسبة اليوم الوطني',
          description: 'تصميم ونشر على حسابات المدرسة الرسمية.',
          requesterId: 'u-002',
          assignedToId: 'u-000',
          status: RequestStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
        ),
        PRRequest(
          requestId: 'PR-2026-00151',
          pillar: Pillar.logisticsFieldTrips,
          serviceType: 'field_trip_transport',
          title: 'ترتيب مواصلات رحلة المتحف المصري',
          description: 'حافلتان لطلاب الصف السابع.',
          requesterId: 'u-003',
          status: RequestStatus.awaitingInfo,
          createdAt: DateTime.now().subtract(const Duration(days: 20)),
        ),
        PRRequest(
          requestId: 'PR-2026-00152',
          pillar: Pillar.publicRelationsPartnerships,
          serviceType: 'partner_meeting',
          title: 'اجتماع تنسيق مع الجهة الشريكة',
          description: 'مناقشة برنامج التبادل الطلابي للفصل القادم.',
          requesterId: 'u-000',
          status: RequestStatus.inProgress,
          createdAt: DateTime.now().subtract(const Duration(days: 45)),
        ),
        PRRequest(
          requestId: 'PR-2026-00153',
          pillar: Pillar.printingOperations,
          serviceType: 'certificate_printing',
          title: 'طباعة شهادات تقدير لحفل نهاية العام',
          description: '200 شهادة، تصميم ذهبي فاخر.',
          requesterId: 'u-002',
          assignedToId: 'u-000',
          status: RequestStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 95)),
        ),
        PRRequest(
          requestId: 'PR-2026-00154',
          pillar: Pillar.eventManagement,
          serviceType: 'open_day',
          title: 'تنظيم يوم مفتوح لأولياء الأمور الجدد',
          description: 'فعالية تعريفية بالمدرسة ومرافقها.',
          requesterId: 'u-003',
          status: RequestStatus.cancelled,
          createdAt: DateTime.now().subtract(const Duration(days: 200)),
        ),
      ];

  List<ChatMessage> getMessagesForThread(String threadId) => [
        ChatMessage(
          messageId: 'm1',
          threadId: threadId,
          senderId: 'u-001',
          senderName: 'أنتِ',
          text: 'مرحباً، هل تم تأكيد موعد التأشيرة في VFS؟',
          sentAt: DateTime.now().subtract(const Duration(minutes: 40)),
          isMe: true,
        ),
        ChatMessage(
          messageId: 'm2',
          threadId: threadId,
          senderId: 'u-000',
          senderName: 'أمير وهبي — العلاقات العامة',
          text: 'أهلاً منى، تم حجز موعد يوم الأحد الساعة 10 صباحاً لجميع الطالبات الـ25.',
          sentAt: DateTime.now().subtract(const Duration(minutes: 35)),
        ),
        ChatMessage(
          messageId: 'm3',
          threadId: threadId,
          senderId: 'u-000',
          senderName: 'أمير وهبي — العلاقات العامة',
          text: 'برجاء التأكد من استيفاء نماذج الموافقة الأمنية لكل طالبة قبل الموعد.',
          sentAt: DateTime.now().subtract(const Duration(minutes: 34)),
        ),
      ];

  /// KPI snapshot for the Executive Dashboard (Module C).
  Map<String, num> getKpiSnapshot() => {
        'totalRequests': 86,
        'completedRequests': 71,
        'printingJobsCompleted': 34,
        'tripsOrganized': 6,
        'eventsManaged': 3,
        'mediaRequestsHandled': 19,
        'visasProcessed': 25,
        'avgResolutionHours': 18.4,
      };

  // Department Announcements — in-memory mock store. Only PR admins and
  // leadership can post (enforced in the UI via role.canPostAnnouncements),
  // but this layer itself doesn't check permissions — that's the caller's
  // job, same as the rest of this mock service. Replace with a real
  // backend (e.g. GET/POST /announcements) once available.
  final List<Announcement> _announcements = [
    Announcement(
      id: 'ann-001',
      title: 'حفل التخرج السنوي – مكتبة الإسكندرية',
      body: 'التخطيط جارٍ، الموعد المبدئي يونيو 2027. سيتم مشاركة التفاصيل الكاملة قريباً.',
      authorName: 'أمير وهبي — العلاقات العامة',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  /// Most recent announcements first.
  List<Announcement> getAnnouncements() {
    final sorted = [..._announcements];
    sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sorted;
  }

  void addAnnouncement(Announcement announcement) {
    _announcements.add(announcement);
  }
}
