// lib/models/appointment_detail_model.dart
// Full appointment detail — used by expert to view a specific appointment

class AppointmentDetailModel {
  final bool success;
  final AppointmentDetailData data;

  AppointmentDetailModel({required this.success, required this.data});

  factory AppointmentDetailModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailModel(
      success: json['success'] ?? false,
      data: AppointmentDetailData.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

class AppointmentDetailData {
  final String appointmentId;
  final String slotId;
  final String expertId;
  final String parentId;
  final String childId;
  final String bookedMode;
  final double feeCharged;
  final String currency;
  final String scheduledAt;
  final int durationMinutes;
  final String status;
  final String? paymentStatus;
  final String? meetLink;
  final String? cancelledBy;
  final String? cancellationReason;
  final String? cancelledAt;
  final String createdAt;
  final String updatedAt;
  final DetailSlot? appointmentSlots;
  final DetailChild? children;
  final DetailExpert? expertUsers;

  AppointmentDetailData({
    required this.appointmentId,
    required this.slotId,
    required this.expertId,
    required this.parentId,
    required this.childId,
    required this.bookedMode,
    required this.feeCharged,
    required this.currency,
    required this.scheduledAt,
    required this.durationMinutes,
    required this.status,
    this.paymentStatus,
    this.meetLink,
    this.cancelledBy,
    this.cancellationReason,
    this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
    this.appointmentSlots,
    this.children,
    this.expertUsers,
  });

  factory AppointmentDetailData.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailData(
      appointmentId: (json['appointment_id'] ?? '').toString(),
      slotId: (json['slot_id'] ?? '').toString(),
      expertId: (json['expert_id'] ?? '').toString(),
      parentId: (json['parent_id'] ?? '').toString(),
      childId: (json['child_id'] ?? '').toString(),
      bookedMode: (json['booked_mode'] ?? 'online').toString(),
      feeCharged: (json['fee_charged'] as num?)?.toDouble() ?? 0.0,
      currency: (json['currency'] ?? 'PKR').toString(),
      scheduledAt: (json['scheduled_at'] ?? '').toString(),
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 30,
      status: (json['status'] ?? 'scheduled').toString(),
      paymentStatus: json['payment_status']?.toString(),
      meetLink: json['meet_link']?.toString(),
      cancelledBy: json['cancelled_by']?.toString(),
      cancellationReason: json['cancellation_reason']?.toString(),
      cancelledAt: json['cancelled_at']?.toString(),
      createdAt: (json['created_at'] ?? '').toString(),
      updatedAt: (json['updated_at'] ?? '').toString(),
      appointmentSlots: json['appointment_slots'] != null
          ? DetailSlot.fromJson(
              json['appointment_slots'] as Map<String, dynamic>)
          : null,
      children: json['children'] != null
          ? DetailChild.fromJson(json['children'] as Map<String, dynamic>)
          : null,
      expertUsers: json['expert_users'] != null
          ? DetailExpert.fromJson(json['expert_users'] as Map<String, dynamic>)
          : null,
    );
  }

  bool get isPaid => paymentStatus?.toLowerCase() == 'paid';
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isCancelled => status.toLowerCase() == 'cancelled';
  bool get isConfirmed => status.toLowerCase() == 'confirmed';
  bool get isScheduled => status.toLowerCase() == 'scheduled';
  bool get isNoShow => status.toLowerCase() == 'no_show';

  String get formattedDate {
    try {
      final dt = DateTime.parse(scheduledAt).toLocal();
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return scheduledAt;
    }
  }

  String get formattedTime {
    try {
      final dt = DateTime.parse(scheduledAt).toLocal();
      int h = dt.hour;
      final m = dt.minute.toString().padLeft(2, '0');
      final ampm = h >= 12 ? 'PM' : 'AM';
      if (h > 12) h -= 12;
      if (h == 0) h = 12;
      return '$h:$m $ampm';
    } catch (_) {
      return '';
    }
  }

  String get formattedCreatedAt {
    try {
      final dt = DateTime.parse(createdAt).toLocal();
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return createdAt;
    }
  }
}

class DetailChild {
  final String childId;
  final String childName;

  DetailChild({required this.childId, required this.childName});

  factory DetailChild.fromJson(Map<String, dynamic> json) => DetailChild(
        childId: (json['child_id'] ?? '').toString(),
        childName: (json['child_name'] ?? '').toString(),
      );

  String get initials {
    final parts = childName.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return childName.isNotEmpty ? childName[0].toUpperCase() : 'C';
  }
}

class DetailExpert {
  final String expertId;
  final String fullName;
  final String specialization;
  final String? phone;
  final String? contactEmail;

  DetailExpert({
    required this.expertId,
    required this.fullName,
    required this.specialization,
    this.phone,
    this.contactEmail,
  });

  factory DetailExpert.fromJson(Map<String, dynamic> json) => DetailExpert(
        expertId: (json['expert_id'] ?? '').toString(),
        fullName: (json['full_name'] ?? '').toString(),
        specialization: (json['specialization'] ?? '').toString(),
        phone: json['phone']?.toString(),
        contactEmail: json['contact_email']?.toString(),
      );
}

class DetailSlot {
  final String slotId;
  final String slotDate;
  final String startTime;
  final String endTime;
  final String mode;
  final String? status;
  final String? locationId;
  final ExpertLocation? expertLocations;

  DetailSlot({
    required this.slotId,
    required this.slotDate,
    required this.startTime,
    required this.endTime,
    required this.mode,
    this.status,
    this.locationId,
    this.expertLocations,
  });

  factory DetailSlot.fromJson(Map<String, dynamic> json) => DetailSlot(
        slotId: (json['slot_id'] ?? '').toString(),
        slotDate: (json['slot_date'] ?? '').toString(),
        startTime: (json['start_time'] ?? '').toString(),
        endTime: (json['end_time'] ?? '').toString(),
        mode: (json['mode'] ?? '').toString(),
        status: json['status']?.toString(),
        locationId: json['location_id']?.toString(),
        expertLocations: json['expert_locations'] != null
            ? ExpertLocation.fromJson(
                json['expert_locations'] as Map<String, dynamic>)
            : null,
      );

  String get formattedStart {
    try {
      final parts = startTime.split(':');
      int h = int.parse(parts[0]);
      final m = parts[1];
      final ampm = h >= 12 ? 'PM' : 'AM';
      if (h > 12) h -= 12;
      if (h == 0) h = 12;
      return '$h:$m $ampm';
    } catch (_) {
      return startTime;
    }
  }

  String get formattedEnd {
    try {
      final parts = endTime.split(':');
      int h = int.parse(parts[0]);
      final m = parts[1];
      final ampm = h >= 12 ? 'PM' : 'AM';
      if (h > 12) h -= 12;
      if (h == 0) h = 12;
      return '$h:$m $ampm';
    } catch (_) {
      return endTime;
    }
  }
}

class ExpertLocation {
  final String locationId;
  final String label;
  final String address;
  final String city;
  final String? mapsUrl;

  ExpertLocation({
    required this.locationId,
    required this.label,
    required this.address,
    required this.city,
    this.mapsUrl,
  });

  factory ExpertLocation.fromJson(Map<String, dynamic> json) => ExpertLocation(
        locationId: (json['location_id'] ?? '').toString(),
        label: (json['label'] ?? '').toString(),
        address: (json['address'] ?? '').toString(),
        city: (json['city'] ?? '').toString(),
        mapsUrl: json['maps_url']?.toString(),
      );
}