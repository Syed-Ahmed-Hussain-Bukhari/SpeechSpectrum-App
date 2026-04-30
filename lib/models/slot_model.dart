// // lib/models/slot_model.dart

// class SlotListModel {
//   final bool success;
//   final List<SlotItem> data;

//   SlotListModel({required this.success, required this.data});

//   factory SlotListModel.fromJson(Map<String, dynamic> json) {
//     return SlotListModel(
//       success: json['success'] ?? false,
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) => SlotItem.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }

// class SlotSingleModel {
//   final bool success;
//   final SlotItem data;

//   SlotSingleModel({required this.success, required this.data});

//   factory SlotSingleModel.fromJson(Map<String, dynamic> json) {
//     return SlotSingleModel(
//       success: json['success'] ?? false,
//       data: SlotItem.fromJson(json['data']),
//     );
//   }
// }

// class SlotItem {
//   final String slotId;
//   final String expertId;
//   final String slotDate;
//   final String startTime;
//   final String endTime;
//   final String mode; // 'online' | 'physical' | 'both'
//   final double? feeOnline;
//   final double? feePhysical;
//   final String currency;
//   final String? locationId;
//   final String status; // 'available' | 'booked' | 'cancelled'
//   final bool isRecurring;
//   final String? recurrenceRule;
//   final String createdAt;
//   final String updatedAt;
//   final SlotLocation? expertLocations;

//   SlotItem({
//     required this.slotId,
//     required this.expertId,
//     required this.slotDate,
//     required this.startTime,
//     required this.endTime,
//     required this.mode,
//     this.feeOnline,
//     this.feePhysical,
//     required this.currency,
//     this.locationId,
//     required this.status,
//     required this.isRecurring,
//     this.recurrenceRule,
//     required this.createdAt,
//     required this.updatedAt,
//     this.expertLocations,
//   });

//   factory SlotItem.fromJson(Map<String, dynamic> json) {
//     return SlotItem(
//       slotId: json['slot_id'] ?? '',
//       expertId: json['expert_id'] ?? '',
//       slotDate: json['slot_date'] ?? '',
//       startTime: json['start_time'] ?? '',
//       endTime: json['end_time'] ?? '',
//       mode: json['mode'] ?? 'both',
//       feeOnline: json['fee_online'] != null
//           ? (json['fee_online'] as num).toDouble()
//           : null,
//       feePhysical: json['fee_physical'] != null
//           ? (json['fee_physical'] as num).toDouble()
//           : null,
//       currency: json['currency'] ?? 'PKR',
//       locationId: json['location_id'],
//       status: json['status'] ?? 'available',
//       isRecurring: json['is_recurring'] ?? false,
//       recurrenceRule: json['recurrence_rule'],
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       expertLocations: json['expert_locations'] != null
//           ? SlotLocation.fromJson(json['expert_locations'])
//           : null,
//     );
//   }

//   // Helpers
//   bool get isAvailable => status.toLowerCase() == 'available';
//   bool get isBooked => status.toLowerCase() == 'booked';
//   bool get isCancelled => status.toLowerCase() == 'cancelled';

//   String get formattedDate {
//     try {
//       final parts = slotDate.split('-');
//       if (parts.length == 3) {
//         final months = [
//           '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//         ];
//         final m = int.tryParse(parts[1]) ?? 0;
//         return '${parts[2]} ${months[m]} ${parts[0]}';
//       }
//     } catch (_) {}
//     return slotDate;
//   }

//   String get dayOfWeek {
//     try {
//       final d = DateTime.parse(slotDate);
//       const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//       return days[d.weekday - 1];
//     } catch (_) {
//       return '';
//     }
//   }

//   String get formattedStartTime {
//     try {
//       final parts = startTime.split(':');
//       int h = int.parse(parts[0]);
//       final m = parts[1];
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return startTime;
//     }
//   }

//   String get formattedEndTime {
//     try {
//       final parts = endTime.split(':');
//       int h = int.parse(parts[0]);
//       final m = parts[1];
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return endTime;
//     }
//   }
// }

// class SlotLocation {
//   final String locationId;
//   final String label;
//   final String address;
//   final String city;

//   SlotLocation({
//     required this.locationId,
//     required this.label,
//     required this.address,
//     required this.city,
//   });

//   factory SlotLocation.fromJson(Map<String, dynamic> json) {
//     return SlotLocation(
//       locationId: json['location_id'] ?? '',
//       label: json['label'] ?? '',
//       address: json['address'] ?? '',
//       city: json['city'] ?? '',
//     );
//   }
// }

// // lib/models/slot_model.dart

// class SlotListModel {
//   final bool success;
//   final List<SlotItem> data;

//   SlotListModel({required this.success, required this.data});

//   factory SlotListModel.fromJson(Map<String, dynamic> json) {
//     return SlotListModel(
//       success: json['success'] ?? false,
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) => SlotItem.fromJson(e))
//               .toList() ??
//           [],
//     );
//   }
// }

// class SlotSingleModel {
//   final bool success;
//   final SlotItem data;

//   SlotSingleModel({required this.success, required this.data});

//   factory SlotSingleModel.fromJson(Map<String, dynamic> json) {
//     return SlotSingleModel(
//       success: json['success'] ?? false,
//       data: SlotItem.fromJson(json['data']),
//     );
//   }
// }

// class SlotItem {
//   final String slotId;
//   final String expertId;
//   final String slotDate;
//   final String startTime;
//   final String endTime;
//   final String mode; // 'online' | 'physical' | 'both'
//   final double? feeOnline;
//   final double? feePhysical;
//   final String currency;
//   final String? locationId;
//   final String status; // 'available' | 'booked' | 'cancelled'
//   final bool isRecurring;
//   final String? recurrenceRule;
//   final String createdAt;
//   final String updatedAt;
//   final SlotLocation? expertLocations;

//   SlotItem({
//     required this.slotId,
//     required this.expertId,
//     required this.slotDate,
//     required this.startTime,
//     required this.endTime,
//     required this.mode,
//     this.feeOnline,
//     this.feePhysical,
//     required this.currency,
//     this.locationId,
//     required this.status,
//     required this.isRecurring,
//     this.recurrenceRule,
//     required this.createdAt,
//     required this.updatedAt,
//     this.expertLocations,
//   });

//   factory SlotItem.fromJson(Map<String, dynamic> json) {
//     return SlotItem(
//       slotId: json['slot_id'] ?? '',
//       expertId: json['expert_id'] ?? '',
//       slotDate: json['slot_date'] ?? '',
//       startTime: json['start_time'] ?? '',
//       endTime: json['end_time'] ?? '',
//       mode: json['mode'] ?? 'both',
//       feeOnline: json['fee_online'] != null
//           ? (json['fee_online'] as num).toDouble()
//           : null,
//       feePhysical: json['fee_physical'] != null
//           ? (json['fee_physical'] as num).toDouble()
//           : null,
//       currency: json['currency'] ?? 'PKR',
//       locationId: json['location_id'],
//       status: json['status'] ?? 'available',
//       isRecurring: json['is_recurring'] ?? false,
//       recurrenceRule: json['recurrence_rule'],
//       createdAt: json['created_at'] ?? '',
//       updatedAt: json['updated_at'] ?? '',
//       expertLocations: json['expert_locations'] != null
//           ? SlotLocation.fromJson(json['expert_locations'])
//           : null,
//     );
//   }

//   // Helpers
//   bool get isAvailable => status.toLowerCase() == 'available';
//   bool get isBooked => status.toLowerCase() == 'booked';
//   bool get isCancelled => status.toLowerCase() == 'cancelled';

//   String get formattedDate {
//     try {
//       final parts = slotDate.split('-');
//       if (parts.length == 3) {
//         final months = [
//           '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//           'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//         ];
//         final m = int.tryParse(parts[1]) ?? 0;
//         return '${parts[2]} ${months[m]} ${parts[0]}';
//       }
//     } catch (_) {}
//     return slotDate;
//   }

//   String get dayOfWeek {
//     try {
//       final d = DateTime.parse(slotDate);
//       const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//       return days[d.weekday - 1];
//     } catch (_) {
//       return '';
//     }
//   }

//   String get formattedStartTime {
//     try {
//       final parts = startTime.split(':');
//       int h = int.parse(parts[0]);
//       final m = parts[1];
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return startTime;
//     }
//   }

//   String get formattedEndTime {
//     try {
//       final parts = endTime.split(':');
//       int h = int.parse(parts[0]);
//       final m = parts[1];
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return endTime;
//     }
//   }
// }

// class SlotLocation {
//   final String locationId;
//   final String label;
//   final String address;
//   final String city;

//   SlotLocation({
//     required this.locationId,
//     required this.label,
//     required this.address,
//     required this.city,
//   });

//   factory SlotLocation.fromJson(Map<String, dynamic> json) {
//     return SlotLocation(
//       locationId: json['location_id'] ?? '',
//       label: json['label'] ?? '',
//       address: json['address'] ?? '',
//       city: json['city'] ?? '',
//     );
//   }
// }

// // ── Zoom Link Result ────────────────────────────────────────────
// class ZoomLinkResult {
//   final String joinUrl;
//   final int meetingId;
//   final String password;

//   ZoomLinkResult({
//     required this.joinUrl,
//     required this.meetingId,
//     required this.password,
//   });

//   factory ZoomLinkResult.fromJson(Map<String, dynamic> json) {
//     return ZoomLinkResult(
//       joinUrl: json['join_url'] ?? '',
//       meetingId: json['meeting_id'] ?? 0,
//       password: json['password'] ?? '',
//     );
//   }
// }


// lib/models/slot_model.dart

class SlotListModel {
  final bool success;
  final List<SlotItem> data;

  SlotListModel({required this.success, required this.data});

  factory SlotListModel.fromJson(Map<String, dynamic> json) {
    return SlotListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => SlotItem.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class SlotSingleModel {
  final bool success;
  final SlotItem data;

  SlotSingleModel({required this.success, required this.data});

  factory SlotSingleModel.fromJson(Map<String, dynamic> json) {
    return SlotSingleModel(
      success: json['success'] ?? false,
      data: SlotItem.fromJson(json['data']),
    );
  }
}

class SlotItem {
  final String slotId;
  final String expertId;
  final String slotDate;
  final String startTime;
  final String endTime;
  final String mode; // 'online' | 'physical' | 'both'
  final double? feeOnline;
  final double? feePhysical;
  final String currency;
  final String? locationId;
  final String status; // 'available' | 'booked' | 'cancelled'
  final bool isRecurring;
  final String? recurrenceRule;
  final String createdAt;
  final String updatedAt;
  final SlotLocation? expertLocations;

  SlotItem({
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

  // ── FIXED: safe numeric parsing to avoid 'String is not a subtype of int' ──
  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  factory SlotItem.fromJson(Map<String, dynamic> json) {
    return SlotItem(
      slotId: json['slot_id']?.toString() ?? '',
      expertId: json['expert_id']?.toString() ?? '',
      slotDate: json['slot_date']?.toString() ?? '',
      startTime: json['start_time']?.toString() ?? '',
      endTime: json['end_time']?.toString() ?? '',
      mode: json['mode']?.toString() ?? 'both',
      feeOnline: _parseDouble(json['fee_online']),
      feePhysical: _parseDouble(json['fee_physical']),
      currency: json['currency']?.toString() ?? 'PKR',
      locationId: json['location_id']?.toString(),
      status: json['status']?.toString() ?? 'available',
      isRecurring: json['is_recurring'] == true,
      recurrenceRule: json['recurrence_rule']?.toString(),
      createdAt: json['created_at']?.toString() ?? '',
      updatedAt: json['updated_at']?.toString() ?? '',
      expertLocations: json['expert_locations'] != null
          ? SlotLocation.fromJson(json['expert_locations'])
          : null,
    );
  }

  // Helpers
  bool get isAvailable => status.toLowerCase() == 'available';
  bool get isBooked => status.toLowerCase() == 'booked';
  bool get isCancelled => status.toLowerCase() == 'cancelled';

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

  String get dayOfWeekFull {
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

  String get formattedStartTime {
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

  String get formattedEndTime {
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

  String get durationLabel {
    try {
      final sParts = startTime.split(':');
      final eParts = endTime.split(':');
      final startMins = int.parse(sParts[0]) * 60 + int.parse(sParts[1]);
      final endMins = int.parse(eParts[0]) * 60 + int.parse(eParts[1]);
      final diff = endMins - startMins;
      if (diff <= 0) return '';
      if (diff < 60) return '${diff}m';
      final h = diff ~/ 60;
      final m = diff % 60;
      return m == 0 ? '${h}h' : '${h}h ${m}m';
    } catch (_) {
      return '';
    }
  }
}

class SlotLocation {
  final String locationId;
  final String label;
  final String address;
  final String city;
  final String? mapsUrl;

  SlotLocation({
    required this.locationId,
    required this.label,
    required this.address,
    required this.city,
    this.mapsUrl,
  });

  factory SlotLocation.fromJson(Map<String, dynamic> json) {
    return SlotLocation(
      locationId: json['location_id']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      mapsUrl: json['maps_url']?.toString(),
    );
  }
}

// ── Zoom Link Result ────────────────────────────────────────────
class ZoomLinkResult {
  final String joinUrl;
  final int meetingId;
  final String password;

  ZoomLinkResult({
    required this.joinUrl,
    required this.meetingId,
    required this.password,
  });

  factory ZoomLinkResult.fromJson(Map<String, dynamic> json) {
    return ZoomLinkResult(
      joinUrl: json['join_url']?.toString() ?? '',
      meetingId: json['meeting_id'] is int
          ? json['meeting_id']
          : int.tryParse(json['meeting_id']?.toString() ?? '') ?? 0,
      password: json['password']?.toString() ?? '',
    );
  }
}