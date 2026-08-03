/// The six operational pillars from the DSBA PR handbook.
enum Pillar {
  publicRelationsPartnerships,
  consularVisas,
  logisticsFieldTrips,
  digitalMediaIdentity,
  eventManagement,
  printingOperations,
}

extension PillarX on Pillar {
  String get id {
    switch (this) {
      case Pillar.publicRelationsPartnerships:
        return 'public_relations_partnerships';
      case Pillar.consularVisas:
        return 'consular_visas';
      case Pillar.logisticsFieldTrips:
        return 'logistics_field_trips';
      case Pillar.digitalMediaIdentity:
        return 'digital_media_identity';
      case Pillar.eventManagement:
        return 'event_management';
      case Pillar.printingOperations:
        return 'printing_operations';
    }
  }

  String get titleAr {
    switch (this) {
      case Pillar.publicRelationsPartnerships:
        return 'العلاقات العامة والشراكات';
      case Pillar.consularVisas:
        return 'المعاملات القنصلية والتأشيرات';
      case Pillar.logisticsFieldTrips:
        return 'التخطيط واللوجستيات للرحلات';
      case Pillar.digitalMediaIdentity:
        return 'الإعلام الرقمي والهوية المؤسسية';
      case Pillar.eventManagement:
        return 'إدارة الاحتفاليات والفعاليات الكبرى';
      case Pillar.printingOperations:
        return 'وحدة تصوير الأوراق والدعم التشغيلي';
    }
  }

  String get titleEn {
    switch (this) {
      case Pillar.publicRelationsPartnerships:
        return 'PR & Partnerships';
      case Pillar.consularVisas:
        return 'Consular Affairs & Visas';
      case Pillar.logisticsFieldTrips:
        return 'Logistics & Field Trips';
      case Pillar.digitalMediaIdentity:
        return 'Digital Media & Identity';
      case Pillar.eventManagement:
        return 'Event Management';
      case Pillar.printingOperations:
        return 'Printing Center';
    }
  }

  String get iconAsset {
    switch (this) {
      case Pillar.publicRelationsPartnerships:
        return 'handshake';
      case Pillar.consularVisas:
        return 'passport';
      case Pillar.logisticsFieldTrips:
        return 'bus';
      case Pillar.digitalMediaIdentity:
        return 'camera';
      case Pillar.eventManagement:
        return 'celebration';
      case Pillar.printingOperations:
        return 'print';
    }
  }
}

enum RequestStatus { pending, inProgress, awaitingInfo, completed, cancelled }

extension RequestStatusX on RequestStatus {
  String get id {
    switch (this) {
      case RequestStatus.pending:
        return 'pending';
      case RequestStatus.inProgress:
        return 'in_progress';
      case RequestStatus.awaitingInfo:
        return 'awaiting_info';
      case RequestStatus.completed:
        return 'completed';
      case RequestStatus.cancelled:
        return 'cancelled';
    }
  }

  String get labelAr {
    switch (this) {
      case RequestStatus.pending:
        return 'قيد الانتظار';
      case RequestStatus.inProgress:
        return 'قيد التنفيذ';
      case RequestStatus.awaitingInfo:
        return 'بانتظار معلومات';
      case RequestStatus.completed:
        return 'مكتمل';
      case RequestStatus.cancelled:
        return 'ملغى';
    }
  }
}

class PRRequest {
  final String requestId;
  final Pillar pillar;
  final String serviceType;
  final String title;
  final String description;
  final String requesterId;
  final String? assignedToId;
  final RequestStatus status;
  final DateTime createdAt;
  final DateTime? dueDate;
  final Map<String, dynamic> dynamicFields;

  const PRRequest({
    required this.requestId,
    required this.pillar,
    required this.serviceType,
    required this.title,
    required this.description,
    required this.requesterId,
    this.assignedToId,
    required this.status,
    required this.createdAt,
    this.dueDate,
    this.dynamicFields = const {},
  });

  factory PRRequest.fromJson(Map<String, dynamic> json) => PRRequest(
        requestId: json['requestId'] as String,
        pillar: Pillar.values.firstWhere((p) => p.id == json['pillar']),
        serviceType: json['serviceType'] as String,
        title: json['title'] as String,
        description: json['description'] as String? ?? '',
        requesterId: json['requesterId'] as String,
        assignedToId: json['assignedToId'] as String?,
        status: RequestStatus.values.firstWhere((s) => s.id == json['status']),
        createdAt: DateTime.parse(json['createdAt'] as String),
        dueDate: json['dueDate'] != null ? DateTime.tryParse(json['dueDate']) : null,
        dynamicFields: (json['dynamicFields'] as Map<String, dynamic>?) ?? {},
      );

  Map<String, dynamic> toJson() => {
        'requestId': requestId,
        'pillar': pillar.id,
        'serviceType': serviceType,
        'title': title,
        'description': description,
        'requesterId': requesterId,
        'assignedToId': assignedToId,
        'status': status.id,
        'createdAt': createdAt.toIso8601String(),
        'dueDate': dueDate?.toIso8601String(),
        'dynamicFields': dynamicFields,
      };
}
