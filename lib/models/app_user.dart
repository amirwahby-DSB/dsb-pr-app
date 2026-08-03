enum UserRole { faculty, staff, prStaff, prAdmin, leadership }

extension UserRoleX on UserRole {
  String get id {
    switch (this) {
      case UserRole.faculty:
        return 'faculty';
      case UserRole.staff:
        return 'staff';
      case UserRole.prStaff:
        return 'pr_staff';
      case UserRole.prAdmin:
        return 'pr_admin';
      case UserRole.leadership:
        return 'leadership';
    }
  }

  /// Only pr_admin and leadership can see the Executive Dashboard (Module C).
  bool get canViewDashboard => this == UserRole.prAdmin || this == UserRole.leadership;

  /// Only pr_staff and pr_admin can triage/assign tickets.
  bool get canManageRequests => this == UserRole.prStaff || this == UserRole.prAdmin;
}

class AppUser {
  final String userId;
  final String fullName;
  final String fullNameAr;
  final String email;
  final String? phone;
  final UserRole role;
  final String preferredLanguage; // 'ar' | 'de' | 'en'

  const AppUser({
    required this.userId,
    required this.fullName,
    required this.fullNameAr,
    required this.email,
    this.phone,
    required this.role,
    this.preferredLanguage = 'ar',
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        userId: json['userId'] as String,
        fullName: json['fullName'] as String,
        fullNameAr: json['fullNameAr'] as String? ?? json['fullName'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        role: UserRole.values.firstWhere((r) => r.id == json['role']),
        preferredLanguage: json['preferredLanguage'] as String? ?? 'ar',
      );
}
