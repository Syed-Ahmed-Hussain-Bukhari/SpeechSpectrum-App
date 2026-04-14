// lib/models/parent_booking_model.dart
import 'package:speechspectrum/models/my_appointment_model.dart';

// ── Expert Slot Model (reuses SlotItem fields) ─────────────────
class ExpertSlotListModel {
  final bool success;
  final List<ExpertSlotItem> data;

  ExpertSlotListModel({required this.success, required this.data});

  factory ExpertSlotListModel.fromJson(Map<String, dynamic> json) {
    return ExpertSlotListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ExpertSlotItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class ExpertSlotItem {
  final String slotId;
  final String expertId;
  final String slotDate;
  final String startTime;
  final String endTime;
  final String mode;
  final double? feeOnline;
  final double? feePhysical;
  final String currency;
  final String? locationId;
  final String status;
  final bool isRecurring;
  final String? recurrenceRule;
  final String createdAt;
  final String updatedAt;
  final ExpertSlotLocation? expertLocations;

  ExpertSlotItem({
    required this.slotId,
    required this.expertId,
    required this.slotDate,
    required this.startTime,
    required this.endTime,
    required this.mode,
    this.feeOnline,
    this.feePhysical,
    required this.currency,
    this.locationId,
    required this.status,
    required this.isRecurring,
    this.recurrenceRule,
    required this.createdAt,
    required this.updatedAt,
    this.expertLocations,
  });

  factory ExpertSlotItem.fromJson(Map<String, dynamic> json) {
    return ExpertSlotItem(
      slotId: json['slot_id'] ?? '',
      expertId: json['expert_id'] ?? '',
      slotDate: json['slot_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      mode: json['mode'] ?? 'both',
      feeOnline: (json['fee_online'] as num?)?.toDouble(),
      feePhysical: (json['fee_physical'] as num?)?.toDouble(),
      currency: json['currency'] ?? 'PKR',
      locationId: json['location_id'],
      status: json['status'] ?? 'available',
      isRecurring: json['is_recurring'] ?? false,
      recurrenceRule: json['recurrence_rule'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      expertLocations: json['expert_locations'] != null
          ? ExpertSlotLocation.fromJson(json['expert_locations'])
          : null,
    );
  }

  bool get isAvailable => status.toLowerCase() == 'available';

  String get formattedDate {
    try {
      final parts = slotDate.split('-');
      if (parts.length == 3) {
        const months = [
          '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
          'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        ];
        final m = int.tryParse(parts[1]) ?? 0;
        return '${parts[2]} ${months[m]} ${parts[0]}';
      }
    } catch (_) {}
    return slotDate;
  }

  String get dayOfWeek {
    try {
      final d = DateTime.parse(slotDate);
      const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      return days[d.weekday - 1];
    } catch (_) {
      return '';
    }
  }

  String get fullDayName {
    try {
      final d = DateTime.parse(slotDate);
      const days = [
        'Monday', 'Tuesday', 'Wednesday', 'Thursday',
        'Friday', 'Saturday', 'Sunday'
      ];
      return days[d.weekday - 1];
    } catch (_) {
      return '';
    }
  }

  String get formattedStartTime => _formatTime(startTime);
  String get formattedEndTime => _formatTime(endTime);

  String _formatTime(String t) {
    try {
      final parts = t.split(':');
      int h = int.parse(parts[0]);
      final m = parts[1];
      final ampm = h >= 12 ? 'PM' : 'AM';
      if (h > 12) h -= 12;
      if (h == 0) h = 12;
      return '$h:$m $ampm';
    } catch (_) {
      return t;
    }
  }

  /// Fee for a given booked mode
  double? feeFor(String bookedMode) {
    switch (bookedMode.toLowerCase()) {
      case 'online':
        return feeOnline;
      case 'physical':
        return feePhysical;
      default:
        return feeOnline ?? feePhysical;
    }
  }
}

class ExpertSlotLocation {
  final String locationId;
  final String label;
  final String address;
  final String city;
  final String mapsUrl;

  ExpertSlotLocation({
    required this.locationId,
    required this.label,
    required this.address,
    required this.city,
    required this.mapsUrl,
  });

  factory ExpertSlotLocation.fromJson(Map<String, dynamic> json) {
    return ExpertSlotLocation(
      locationId: json['location_id'] ?? '',
      label: json['label'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      mapsUrl: json['maps_url'] ?? '',
    );
  }
}

// ── Book Appointment Response ───────────────────────────────────
class BookAppointmentModel {
  final bool success;
  final BookedAppointmentData? data;
  final String? message;

  BookAppointmentModel({
    required this.success,
    this.data,
    this.message,
  });

  factory BookAppointmentModel.fromJson(Map<String, dynamic> json) {
    return BookAppointmentModel(
      success: json['success'] ?? false,
      data: json['data'] != null
          ? BookedAppointmentData.fromJson(json['data'])
          : null,
      message: json['message'],
    );
  }
}

class BookedAppointmentData {
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
  final String? meetLink;
  final String createdAt;

  BookedAppointmentData({
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
    this.meetLink,
    required this.createdAt,
  });

  factory BookedAppointmentData.fromJson(Map<String, dynamic> json) {
    return BookedAppointmentData(
      appointmentId: json['appointment_id'] ?? '',
      slotId: json['slot_id'] ?? '',
      expertId: json['expert_id'] ?? '',
      parentId: json['parent_id'] ?? '',
      childId: json['child_id'] ?? '',
      bookedMode: json['booked_mode'] ?? 'online',
      feeCharged: (json['fee_charged'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] ?? 'PKR',
      scheduledAt: json['scheduled_at'] ?? '',
      durationMinutes: json['duration_minutes'] ?? 30,
      status: json['status'] ?? 'scheduled',
      meetLink: json['meet_link'],
      createdAt: json['created_at'] ?? '',
    );
  }
}