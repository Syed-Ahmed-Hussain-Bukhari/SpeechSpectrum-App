// // // lib/models/my_appointment_model.dart

// // class MyAppointmentListModel {
// //   final bool success;
// //   final List<MyAppointmentItem> data;

// //   MyAppointmentListModel({required this.success, required this.data});

// //   factory MyAppointmentListModel.fromJson(Map<String, dynamic> json) {
// //     return MyAppointmentListModel(
// //       success: json['success'] ?? false,
// //       data: (json['data'] as List<dynamic>?)
// //               ?.map((e) => MyAppointmentItem.fromJson(e))
// //               .toList() ??
// //           [],
// //     );
// //   }
// // }

// // class MyAppointmentSingleModel {
// //   final bool success;
// //   final MyAppointmentItem data;

// //   MyAppointmentSingleModel({required this.success, required this.data});

// //   factory MyAppointmentSingleModel.fromJson(Map<String, dynamic> json) {
// //     return MyAppointmentSingleModel(
// //       success: json['success'] ?? false,
// //       data: MyAppointmentItem.fromJson(json['data']),
// //     );
// //   }
// // }

// // class MyAppointmentItem {
// //   final String appointmentId;
// //   final String slotId;
// //   final String expertId;
// //   final String parentId;
// //   final String childId;
// //   final String bookedMode;
// //   final double feeCharged;
// //   final String currency;
// //   final String scheduledAt;
// //   final int durationMinutes;
// //   final String status;
// //   final String? meetLink;
// //   final String? cancelledBy;
// //   final String? cancellationReason;
// //   final String? cancelledAt;
// //   final String createdAt;
// //   final String updatedAt;
// //   final AppointmentChild? children;
// //   final AppointmentExpert? expertUsers;
// //   final AppointmentSlot? appointmentSlots;

// //   MyAppointmentItem({
// //     required this.appointmentId,
// //     required this.slotId,
// //     required this.expertId,
// //     required this.parentId,
// //     required this.childId,
// //     required this.bookedMode,
// //     required this.feeCharged,
// //     required this.currency,
// //     required this.scheduledAt,
// //     required this.durationMinutes,
// //     required this.status,
// //     this.meetLink,
// //     this.cancelledBy,
// //     this.cancellationReason,
// //     this.cancelledAt,
// //     required this.createdAt,
// //     required this.updatedAt,
// //     this.children,
// //     this.expertUsers,
// //     this.appointmentSlots,
// //   });

// //   factory MyAppointmentItem.fromJson(Map<String, dynamic> json) {
// //     return MyAppointmentItem(
// //       appointmentId: json['appointment_id'] ?? '',
// //       slotId: json['slot_id'] ?? '',
// //       expertId: json['expert_id'] ?? '',
// //       parentId: json['parent_id'] ?? '',
// //       childId: json['child_id'] ?? '',
// //       bookedMode: json['booked_mode'] ?? 'online',
// //       feeCharged: (json['fee_charged'] as num?)?.toDouble() ?? 0.0,
// //       currency: json['currency'] ?? 'PKR',
// //       scheduledAt: json['scheduled_at'] ?? '',
// //       durationMinutes: json['duration_minutes'] ?? 30,
// //       status: json['status'] ?? 'scheduled',
// //       meetLink: json['meet_link'],
// //       cancelledBy: json['cancelled_by'],
// //       cancellationReason: json['cancellation_reason'],
// //       cancelledAt: json['cancelled_at'],
// //       createdAt: json['created_at'] ?? '',
// //       updatedAt: json['updated_at'] ?? '',
// //       children: json['children'] != null
// //           ? AppointmentChild.fromJson(json['children'])
// //           : null,
// //       expertUsers: json['expert_users'] != null
// //           ? AppointmentExpert.fromJson(json['expert_users'])
// //           : null,
// //       appointmentSlots: json['appointment_slots'] != null
// //           ? AppointmentSlot.fromJson(json['appointment_slots'])
// //           : null,
// //     );
// //   }

// //   // Status helpers
// //   bool get isScheduled => status.toLowerCase() == 'scheduled';
// //   bool get isConfirmed => status.toLowerCase() == 'confirmed';
// //   bool get isCompleted => status.toLowerCase() == 'completed';
// //   bool get isCancelled => status.toLowerCase() == 'cancelled';
// //   bool get isNoShow => status.toLowerCase() == 'no_show';

// //   String get formattedDate {
// //     try {
// //       final dt = DateTime.parse(scheduledAt).toLocal();
// //       const months = [
// //         '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //       ];
// //       const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
// //       return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month]} ${dt.year}';
// //     } catch (_) {
// //       return scheduledAt;
// //     }
// //   }

// //   String get formattedTime {
// //     try {
// //       final dt = DateTime.parse(scheduledAt).toLocal();
// //       int h = dt.hour;
// //       final m = dt.minute.toString().padLeft(2, '0');
// //       final ampm = h >= 12 ? 'PM' : 'AM';
// //       if (h > 12) h -= 12;
// //       if (h == 0) h = 12;
// //       return '$h:$m $ampm';
// //     } catch (_) {
// //       return '';
// //     }
// //   }

// //   String get childInitials {
// //     final name = children?.childName ?? '';
// //     final parts = name.trim().split(' ');
// //     if (parts.length >= 2) {
// //       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
// //     }
// //     return name.isNotEmpty ? name[0].toUpperCase() : 'C';
// //   }
// // }

// // class AppointmentChild {
// //   final String childId;
// //   final String childName;

// //   AppointmentChild({required this.childId, required this.childName});

// //   factory AppointmentChild.fromJson(Map<String, dynamic> json) {
// //     return AppointmentChild(
// //       childId: json['child_id'] ?? '',
// //       childName: json['child_name'] ?? '',
// //     );
// //   }
// // }

// // class AppointmentExpert {
// //   final String expertId;
// //   final String fullName;
// //   final String specialization;
// //   final String? phone;
// //   final String? contactEmail;

// //   AppointmentExpert({
// //     required this.expertId,
// //     required this.fullName,
// //     required this.specialization,
// //     this.phone,
// //     this.contactEmail,
// //   });

// //   factory AppointmentExpert.fromJson(Map<String, dynamic> json) {
// //     return AppointmentExpert(
// //       expertId: json['expert_id'] ?? '',
// //       fullName: json['full_name'] ?? '',
// //       specialization: json['specialization'] ?? '',
// //       phone: json['phone'],
// //       contactEmail: json['contact_email'],
// //     );
// //   }
// // }

// // class AppointmentSlot {
// //   final String slotId;
// //   final String slotDate;
// //   final String startTime;
// //   final String endTime;
// //   final String mode;
// //   final String? locationId;
// //   final String? status;

// //   AppointmentSlot({
// //     required this.slotId,
// //     required this.slotDate,
// //     required this.startTime,
// //     required this.endTime,
// //     required this.mode,
// //     this.locationId,
// //     this.status,
// //   });

// //   factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
// //     return AppointmentSlot(
// //       slotId: json['slot_id'] ?? '',
// //       slotDate: json['slot_date'] ?? '',
// //       startTime: json['start_time'] ?? '',
// //       endTime: json['end_time'] ?? '',
// //       mode: json['mode'] ?? '',
// //       locationId: json['location_id'],
// //       status: json['status'],
// //     );
// //   }

// //   String get formattedStart {
// //     try {
// //       final parts = startTime.split(':');
// //       int h = int.parse(parts[0]);
// //       final m = parts[1];
// //       final ampm = h >= 12 ? 'PM' : 'AM';
// //       if (h > 12) h -= 12;
// //       if (h == 0) h = 12;
// //       return '$h:$m $ampm';
// //     } catch (_) {
// //       return startTime;
// //     }
// //   }

// //   String get formattedEnd {
// //     try {
// //       final parts = endTime.split(':');
// //       int h = int.parse(parts[0]);
// //       final m = parts[1];
// //       final ampm = h >= 12 ? 'PM' : 'AM';
// //       if (h > 12) h -= 12;
// //       if (h == 0) h = 12;
// //       return '$h:$m $ampm';
// //     } catch (_) {
// //       return endTime;
// //     }
// //   }
// // }

// // // ── Appointment Record Model ────────────────────────────────────

// // class AppointmentRecordListModel {
// //   final bool success;
// //   final List<AppointmentRecordItem> data;

// //   AppointmentRecordListModel({required this.success, required this.data});

// //   factory AppointmentRecordListModel.fromJson(Map<String, dynamic> json) {
// //     return AppointmentRecordListModel(
// //       success: json['success'] ?? false,
// //       data: (json['data'] as List<dynamic>?)
// //               ?.map((e) => AppointmentRecordItem.fromJson(e))
// //               .toList() ??
// //           [],
// //     );
// //   }
// // }

// // class AppointmentRecordSingleModel {
// //   final bool success;
// //   final AppointmentRecordItem data;

// //   AppointmentRecordSingleModel({required this.success, required this.data});

// //   factory AppointmentRecordSingleModel.fromJson(Map<String, dynamic> json) {
// //     return AppointmentRecordSingleModel(
// //       success: json['success'] ?? false,
// //       data: AppointmentRecordItem.fromJson(json['data']),
// //     );
// //   }
// // }

// // class AppointmentRecordItem {
// //   final String recordId;
// //   final String appointmentId;
// //   final String notes;
// //   final String therapyPlan;
// //   final Map<String, dynamic>? medication;
// //   final String progressFeedback;
// //   final String createdAt;

// //   AppointmentRecordItem({
// //     required this.recordId,
// //     required this.appointmentId,
// //     required this.notes,
// //     required this.therapyPlan,
// //     this.medication,
// //     required this.progressFeedback,
// //     required this.createdAt,
// //   });

// //   factory AppointmentRecordItem.fromJson(Map<String, dynamic> json) {
// //     return AppointmentRecordItem(
// //       recordId: json['record_id'] ?? '',
// //       appointmentId: json['appointment_id'] ?? '',
// //       notes: json['notes'] ?? '',
// //       therapyPlan: json['therapy_plan'] ?? '',
// //       medication: json['medication'] as Map<String, dynamic>?,
// //       progressFeedback: json['progress_feedback'] ?? '',
// //       createdAt: json['created_at'] ?? '',
// //     );
// //   }

// //   String get formattedDate {
// //     try {
// //       final dt = DateTime.parse(createdAt).toLocal();
// //       const months = [
// //         '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
// //         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
// //       ];
// //       return '${dt.day} ${months[dt.month]} ${dt.year}';
// //     } catch (_) {
// //       return createdAt;
// //     }
// //   }
// // }


// // lib/models/my_appointment_model.dart

// class MyAppointmentListModel {
//   final bool success;
//   final List<MyAppointmentItem> data;

//   MyAppointmentListModel({required this.success, required this.data});

//   factory MyAppointmentListModel.fromJson(Map<String, dynamic> json) {
//     return MyAppointmentListModel(
//       success: json['success'] ?? false,
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) => MyAppointmentItem.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class MyAppointmentSingleModel {
//   final bool success;
//   final MyAppointmentItem data;

//   MyAppointmentSingleModel({required this.success, required this.data});

//   factory MyAppointmentSingleModel.fromJson(Map<String, dynamic> json) {
//     return MyAppointmentSingleModel(
//       success: json['success'] ?? false,
//       data: MyAppointmentItem.fromJson(json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class MyAppointmentItem {
//   final String appointmentId;
//   final String slotId;
//   final String expertId;
//   final String parentId;
//   final String childId;
//   final String bookedMode;
//   final double feeCharged;
//   final String currency;
//   final String scheduledAt;
//   final int durationMinutes;
//   final String status;
//   final String? meetLink;
//   final String? cancelledBy;
//   final String? cancellationReason;
//   final String? cancelledAt;
//   final String createdAt;
//   final String updatedAt;
//   final AppointmentChild? children;
//   final AppointmentExpert? expertUsers;
//   final AppointmentSlot? appointmentSlots;

//   MyAppointmentItem({
//     required this.appointmentId,
//     required this.slotId,
//     required this.expertId,
//     required this.parentId,
//     required this.childId,
//     required this.bookedMode,
//     required this.feeCharged,
//     required this.currency,
//     required this.scheduledAt,
//     required this.durationMinutes,
//     required this.status,
//     this.meetLink,
//     this.cancelledBy,
//     this.cancellationReason,
//     this.cancelledAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.children,
//     this.expertUsers,
//     this.appointmentSlots,
//   });

//   factory MyAppointmentItem.fromJson(Map<String, dynamic> json) {
//     // ── Safe int parsing ──────────────────────────────────────────
//     // duration_minutes may arrive as String "30" or int 30
//     int parseDuration(dynamic val) {
//       if (val == null) return 30;
//       if (val is int) return val;
//       if (val is double) return val.toInt();
//       if (val is String) return int.tryParse(val) ?? 30;
//       return 30;
//     }

//     // fee_charged may arrive as String "2500", int 2500, or double 2500.0
//     double parseFee(dynamic val) {
//       if (val == null) return 0.0;
//       if (val is double) return val;
//       if (val is int) return val.toDouble();
//       if (val is String) return double.tryParse(val) ?? 0.0;
//       return 0.0;
//     }

//     return MyAppointmentItem(
//       appointmentId: (json['appointment_id'] ?? '').toString(),
//       slotId: (json['slot_id'] ?? '').toString(),
//       expertId: (json['expert_id'] ?? '').toString(),
//       parentId: (json['parent_id'] ?? '').toString(),
//       childId: (json['child_id'] ?? '').toString(),
//       bookedMode: (json['booked_mode'] ?? 'online').toString(),
//       feeCharged: parseFee(json['fee_charged']),
//       currency: (json['currency'] ?? 'PKR').toString(),
//       scheduledAt: (json['scheduled_at'] ?? '').toString(),
//       durationMinutes: parseDuration(json['duration_minutes']),
//       status: (json['status'] ?? 'scheduled').toString(),
//       meetLink: json['meet_link']?.toString(),
//       cancelledBy: json['cancelled_by']?.toString(),
//       cancellationReason: json['cancellation_reason']?.toString(),
//       cancelledAt: json['cancelled_at']?.toString(),
//       createdAt: (json['created_at'] ?? '').toString(),
//       updatedAt: (json['updated_at'] ?? '').toString(),
//       // Nested objects — safely handle null (action APIs return without them)
//       children: json['children'] != null
//           ? AppointmentChild.fromJson(json['children'] as Map<String, dynamic>)
//           : null,
//       expertUsers: json['expert_users'] != null
//           ? AppointmentExpert.fromJson(json['expert_users'] as Map<String, dynamic>)
//           : null,
//       appointmentSlots: json['appointment_slots'] != null
//           ? AppointmentSlot.fromJson(json['appointment_slots'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   // ── Status helpers ─────────────────────────────────────────────
//   bool get isScheduled => status.toLowerCase() == 'scheduled';
//   bool get isConfirmed => status.toLowerCase() == 'confirmed';
//   bool get isCompleted => status.toLowerCase() == 'completed';
//   bool get isCancelled => status.toLowerCase() == 'cancelled';
//   bool get isNoShow => status.toLowerCase() == 'no_show';

//   String get formattedDate {
//     try {
//       final dt = DateTime.parse(scheduledAt).toLocal();
//       const months = [
//         '',
//         'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//       ];
//       const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//       return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month]} ${dt.year}';
//     } catch (_) {
//       return scheduledAt;
//     }
//   }

//   String get formattedTime {
//     try {
//       final dt = DateTime.parse(scheduledAt).toLocal();
//       int h = dt.hour;
//       final m = dt.minute.toString().padLeft(2, '0');
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return '';
//     }
//   }

//   /// Safe initials — never crashes even when childName is null/empty
//   String get childInitials {
//     final name = (children?.childName ?? '').trim();
//     if (name.isEmpty) return 'C';
//     final parts = name.split(RegExp(r'\s+'));
//     if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
//       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
//     }
//     return name[0].toUpperCase();
//   }

//   /// Returns a copy of this item merged with [updated].
//   /// Preserves nested relations from the original when the action API
//   /// omits them (confirm / complete / cancel / no-show responses).
//   MyAppointmentItem mergeWith(MyAppointmentItem updated) {
//     return MyAppointmentItem(
//       appointmentId: updated.appointmentId,
//       slotId: updated.slotId,
//       expertId: updated.expertId,
//       parentId: updated.parentId,
//       childId: updated.childId,
//       bookedMode: updated.bookedMode,
//       feeCharged: updated.feeCharged,
//       currency: updated.currency,
//       scheduledAt: updated.scheduledAt,
//       durationMinutes: updated.durationMinutes,
//       status: updated.status,
//       meetLink: updated.meetLink,
//       cancelledBy: updated.cancelledBy,
//       cancellationReason: updated.cancellationReason,
//       cancelledAt: updated.cancelledAt,
//       createdAt: updated.createdAt,
//       updatedAt: updated.updatedAt,
//       // Keep original nested data if the new response didn't include them
//       children: updated.children ?? children,
//       expertUsers: updated.expertUsers ?? expertUsers,
//       appointmentSlots: updated.appointmentSlots ?? appointmentSlots,
//     );
//   }
// }

// // ── Child ──────────────────────────────────────────────────────────

// class AppointmentChild {
//   final String childId;
//   final String childName;

//   AppointmentChild({required this.childId, required this.childName});

//   factory AppointmentChild.fromJson(Map<String, dynamic> json) {
//     return AppointmentChild(
//       childId: (json['child_id'] ?? '').toString(),
//       childName: (json['child_name'] ?? '').toString(),
//     );
//   }
// }

// // ── Expert ─────────────────────────────────────────────────────────

// class AppointmentExpert {
//   final String expertId;
//   final String fullName;
//   final String specialization;
//   final String? phone;
//   final String? contactEmail;

//   AppointmentExpert({
//     required this.expertId,
//     required this.fullName,
//     required this.specialization,
//     this.phone,
//     this.contactEmail,
//   });

//   factory AppointmentExpert.fromJson(Map<String, dynamic> json) {
//     return AppointmentExpert(
//       expertId: (json['expert_id'] ?? '').toString(),
//       fullName: (json['full_name'] ?? '').toString(),
//       specialization: (json['specialization'] ?? '').toString(),
//       phone: json['phone']?.toString(),
//       contactEmail: json['contact_email']?.toString(),
//     );
//   }
// }

// // ── Slot ───────────────────────────────────────────────────────────

// class AppointmentSlot {
//   final String slotId;
//   final String slotDate;
//   final String startTime;
//   final String endTime;
//   final String mode;
//   final String? locationId;
//   final String? status;

//   AppointmentSlot({
//     required this.slotId,
//     required this.slotDate,
//     required this.startTime,
//     required this.endTime,
//     required this.mode,
//     this.locationId,
//     this.status,
//   });

//   factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
//     return AppointmentSlot(
//       slotId: (json['slot_id'] ?? '').toString(),
//       slotDate: (json['slot_date'] ?? '').toString(),
//       startTime: (json['start_time'] ?? '').toString(),
//       endTime: (json['end_time'] ?? '').toString(),
//       mode: (json['mode'] ?? '').toString(),
//       locationId: json['location_id']?.toString(),
//       status: json['status']?.toString(),
//     );
//   }

//   String get formattedStart => _formatTime(startTime);
//   String get formattedEnd => _formatTime(endTime);

//   String _formatTime(String t) {
//     try {
//       final parts = t.split(':');
//       int h = int.parse(parts[0]);
//       final m = parts[1];
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return t;
//     }
//   }
// }

// // ── Record models ──────────────────────────────────────────────────

// class AppointmentRecordListModel {
//   final bool success;
//   final List<AppointmentRecordItem> data;

//   AppointmentRecordListModel({required this.success, required this.data});

//   factory AppointmentRecordListModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentRecordListModel(
//       success: json['success'] ?? false,
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) => AppointmentRecordItem.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class AppointmentRecordSingleModel {
//   final bool success;
//   final AppointmentRecordItem data;

//   AppointmentRecordSingleModel({required this.success, required this.data});

//   factory AppointmentRecordSingleModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentRecordSingleModel(
//       success: json['success'] ?? false,
//       data: AppointmentRecordItem.fromJson(json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class AppointmentRecordItem {
//   final String recordId;
//   final String appointmentId;
//   final String notes;
//   final String therapyPlan;
//   final Map<String, dynamic>? medication;
//   final String progressFeedback;
//   final String createdAt;

//   AppointmentRecordItem({
//     required this.recordId,
//     required this.appointmentId,
//     required this.notes,
//     required this.therapyPlan,
//     this.medication,
//     required this.progressFeedback,
//     required this.createdAt,
//   });

//   factory AppointmentRecordItem.fromJson(Map<String, dynamic> json) {
//     // medication can be a Map or null; guard against unexpected types
//     Map<String, dynamic>? parseMedication(dynamic val) {
//       if (val == null) return null;
//       if (val is Map<String, dynamic>) return val;
//       if (val is Map) return val.cast<String, dynamic>();
//       return null;
//     }

//     return AppointmentRecordItem(
//       recordId: (json['record_id'] ?? '').toString(),
//       appointmentId: (json['appointment_id'] ?? '').toString(),
//       notes: (json['notes'] ?? '').toString(),
//       therapyPlan: (json['therapy_plan'] ?? '').toString(),
//       medication: parseMedication(json['medication']),
//       progressFeedback: (json['progress_feedback'] ?? '').toString(),
//       createdAt: (json['created_at'] ?? '').toString(),
//     );
//   }

//   String get formattedDate {
//     try {
//       final dt = DateTime.parse(createdAt).toLocal();
//       const months = [
//         '',
//         'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//         'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//       ];
//       return '${dt.day} ${months[dt.month]} ${dt.year}';
//     } catch (_) {
//       return createdAt;
//     }
//   }
// }


// // lib/models/my_appointment_model.dart

// class MyAppointmentListModel {
//   final bool success;
//   final List<MyAppointmentItem> data;

//   MyAppointmentListModel({required this.success, required this.data});

//   factory MyAppointmentListModel.fromJson(Map<String, dynamic> json) {
//     return MyAppointmentListModel(
//       success: json['success'] ?? false,
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) => MyAppointmentItem.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class MyAppointmentSingleModel {
//   final bool success;
//   final MyAppointmentItem data;

//   MyAppointmentSingleModel({required this.success, required this.data});

//   factory MyAppointmentSingleModel.fromJson(Map<String, dynamic> json) {
//     return MyAppointmentSingleModel(
//       success: json['success'] ?? false,
//       data: MyAppointmentItem.fromJson(json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class MyAppointmentItem {
//   final String appointmentId;
//   final String slotId;
//   final String expertId;
//   final String parentId;
//   final String childId;
//   final String bookedMode;
//   final double feeCharged;
//   final String currency;
//   final String scheduledAt;
//   final int durationMinutes;
//   final String status;
//    final String? paymentStatus;   // ← NEW FIELD
//   final String? meetLink;
//   final String? cancelledBy;
//   final String? cancellationReason;
//   final String? cancelledAt;
//   final String createdAt;
//   final String updatedAt;
//   final AppointmentChild? children;
//   final AppointmentExpert? expertUsers;
//   final AppointmentSlot? appointmentSlots;

//   MyAppointmentItem({
//     required this.appointmentId,
//     required this.slotId,
//     required this.expertId,
//     required this.parentId,
//     required this.childId,
//     required this.bookedMode,
//     required this.feeCharged,
//     required this.currency,
//     required this.scheduledAt,
//     required this.durationMinutes,
//     required this.status,
//     this.paymentStatus,             // ← NEW
//     this.meetLink,
//     this.cancelledBy,
//     this.cancellationReason,
//     this.cancelledAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.children,
//     this.expertUsers,
//     this.appointmentSlots,
//   });

//   factory MyAppointmentItem.fromJson(Map<String, dynamic> json) {
//     return MyAppointmentItem(
//       appointmentId: (json['appointment_id'] ?? '').toString(),
//       slotId: (json['slot_id'] ?? '').toString(),
//       expertId: (json['expert_id'] ?? '').toString(),
//       parentId: (json['parent_id'] ?? '').toString(),
//       childId: (json['child_id'] ?? '').toString(),
//       bookedMode: (json['booked_mode'] ?? 'online').toString(),
//       feeCharged: (json['fee_charged'] as num?)?.toDouble() ?? 0.0,
//       currency: (json['currency'] ?? 'PKR').toString(),
//       scheduledAt: (json['scheduled_at'] ?? '').toString(),
//       durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 30,
//       status: (json['status'] ?? 'scheduled').toString(),
//       paymentStatus: json['payment_status'],  // ← NEW
//       meetLink: json['meet_link']?.toString(),
//       cancelledBy: json['cancelled_by']?.toString(),
//       cancellationReason: json['cancellation_reason']?.toString(),
//       cancelledAt: json['cancelled_at']?.toString(),
//       createdAt: (json['created_at'] ?? '').toString(),
//       updatedAt: (json['updated_at'] ?? '').toString(),
//       children: json['children'] != null
//           ? AppointmentChild.fromJson(json['children'] as Map<String, dynamic>)
//           : null,
//       expertUsers: json['expert_users'] != null
//           ? AppointmentExpert.fromJson(json['expert_users'] as Map<String, dynamic>)
//           : null,
//       appointmentSlots: json['appointment_slots'] != null
//           ? AppointmentSlot.fromJson(json['appointment_slots'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   // Status helpers
//   bool get isScheduled => status.toLowerCase() == 'scheduled';
//   bool get isConfirmed => status.toLowerCase() == 'confirmed';
//   bool get isCompleted => status.toLowerCase() == 'completed';
//   bool get isCancelled => status.toLowerCase() == 'cancelled';
//   bool get isNoShow => status.toLowerCase() == 'no_show';

//   String get formattedDate {
//     try {
//       final dt = DateTime.parse(scheduledAt).toLocal();
//       const months = [
//         '',
//         'Jan',
//         'Feb',
//         'Mar',
//         'Apr',
//         'May',
//         'Jun',
//         'Jul',
//         'Aug',
//         'Sep',
//         'Oct',
//         'Nov',
//         'Dec'
//       ];
//       const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//       return '${days[dt.weekday - 1]}, ${dt.day} ${months[dt.month]} ${dt.year}';
//     } catch (_) {
//       return scheduledAt;
//     }
//   }

//   String get formattedTime {
//     try {
//       final dt = DateTime.parse(scheduledAt).toLocal();
//       int h = dt.hour;
//       final m = dt.minute.toString().padLeft(2, '0');
//       final ampm = h >= 12 ? 'PM' : 'AM';
//       if (h > 12) h -= 12;
//       if (h == 0) h = 12;
//       return '$h:$m $ampm';
//     } catch (_) {
//       return '';
//     }
//   }

//   String get childInitials {
//     final name = children?.childName ?? '';
//     final parts = name.trim().split(' ');
//     if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
//       return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
//     }
//     return name.isNotEmpty ? name[0].toUpperCase() : 'C';
//   }
// }

// class AppointmentChild {
//   final String childId;
//   final String childName;

//   AppointmentChild({required this.childId, required this.childName});

//   factory AppointmentChild.fromJson(Map<String, dynamic> json) {
//     return AppointmentChild(
//       childId: (json['child_id'] ?? '').toString(),
//       childName: (json['child_name'] ?? '').toString(),
//     );
//   }
// }

// class AppointmentExpert {
//   final String expertId;
//   final String fullName;
//   final String specialization;
//   final String? phone;
//   final String? contactEmail;

//   AppointmentExpert({
//     required this.expertId,
//     required this.fullName,
//     required this.specialization,
//     this.phone,
//     this.contactEmail,
//   });

//   factory AppointmentExpert.fromJson(Map<String, dynamic> json) {
//     return AppointmentExpert(
//       expertId: (json['expert_id'] ?? '').toString(),
//       fullName: (json['full_name'] ?? '').toString(),
//       specialization: (json['specialization'] ?? '').toString(),
//       phone: json['phone']?.toString(),
//       contactEmail: json['contact_email']?.toString(),
//     );
//   }
// }

// class AppointmentSlot {
//   final String slotId;
//   final String slotDate;
//   final String startTime;
//   final String endTime;
//   final String mode;
//   final String? locationId;
//   final String? status;

//   AppointmentSlot({
//     required this.slotId,
//     required this.slotDate,
//     required this.startTime,
//     required this.endTime,
//     required this.mode,
//     this.locationId,
//     this.status,
//   });

//   factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
//     return AppointmentSlot(
//       slotId: (json['slot_id'] ?? '').toString(),
//       slotDate: (json['slot_date'] ?? '').toString(),
//       startTime: (json['start_time'] ?? '').toString(),
//       endTime: (json['end_time'] ?? '').toString(),
//       mode: (json['mode'] ?? '').toString(),
//       locationId: json['location_id']?.toString(),
//       status: json['status']?.toString(),
//     );
//   }

//   String get formattedStart {
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

//   String get formattedEnd {
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

// // ── Appointment Record Models ──────────────────────────────────

// class AppointmentRecordListModel {
//   final bool success;
//   final List<AppointmentRecordItem> data;

//   AppointmentRecordListModel({required this.success, required this.data});

//   factory AppointmentRecordListModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentRecordListModel(
//       success: json['success'] ?? false,
//       data: (json['data'] as List<dynamic>?)
//               ?.map((e) => AppointmentRecordItem.fromJson(e as Map<String, dynamic>))
//               .toList() ??
//           [],
//     );
//   }
// }

// class AppointmentRecordSingleModel {
//   final bool success;
//   final AppointmentRecordItem data;

//   AppointmentRecordSingleModel({required this.success, required this.data});

//   factory AppointmentRecordSingleModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentRecordSingleModel(
//       success: json['success'] ?? false,
//       data: AppointmentRecordItem.fromJson(json['data'] as Map<String, dynamic>),
//     );
//   }
// }

// class AppointmentRecordItem {
//   final String recordId;
//   final String appointmentId;
//   final String notes;
//   final String therapyPlan;
//   final Map<String, dynamic>? medication;
//   final String progressFeedback;
//   final String createdAt;

//   AppointmentRecordItem({
//     required this.recordId,
//     required this.appointmentId,
//     required this.notes,
//     required this.therapyPlan,
//     this.medication,
//     required this.progressFeedback,
//     required this.createdAt,
//   });

//   factory AppointmentRecordItem.fromJson(Map<String, dynamic> json) {
//     return AppointmentRecordItem(
//       recordId: (json['record_id'] ?? '').toString(),
//       appointmentId: (json['appointment_id'] ?? '').toString(),
//       notes: (json['notes'] ?? '').toString(),
//       therapyPlan: (json['therapy_plan'] ?? '').toString(),
//       medication: json['medication'] != null
//           ? Map<String, dynamic>.from(json['medication'] as Map)
//           : null,
//       progressFeedback: (json['progress_feedback'] ?? '').toString(),
//       createdAt: (json['created_at'] ?? '').toString(),
//     );
//   }

//   String get formattedDate {
//     try {
//       final dt = DateTime.parse(createdAt).toLocal();
//       const months = [
//         '',
//         'Jan',
//         'Feb',
//         'Mar',
//         'Apr',
//         'May',
//         'Jun',
//         'Jul',
//         'Aug',
//         'Sep',
//         'Oct',
//         'Nov',
//         'Dec'
//       ];
//       return '${dt.day} ${months[dt.month]} ${dt.year}';
//     } catch (_) {
//       return createdAt;
//     }
//   }
  
// }



// lib/models/my_appointment_model.dart

class MyAppointmentListModel {
  final bool success;
  final List<MyAppointmentItem> data;

  MyAppointmentListModel({required this.success, required this.data});

  factory MyAppointmentListModel.fromJson(Map<String, dynamic> json) {
    return MyAppointmentListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => MyAppointmentItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class MyAppointmentSingleModel {
  final bool success;
  final MyAppointmentItem data;

  MyAppointmentSingleModel({required this.success, required this.data});

  factory MyAppointmentSingleModel.fromJson(Map<String, dynamic> json) {
    return MyAppointmentSingleModel(
      success: json['success'] ?? false,
      data: MyAppointmentItem.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class MyAppointmentItem {
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
  final AppointmentChild? children;
  final AppointmentExpert? expertUsers;
  final AppointmentSlot? appointmentSlots;

  MyAppointmentItem({
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
    this.children,
    this.expertUsers,
    this.appointmentSlots,
  });

  factory MyAppointmentItem.fromJson(Map<String, dynamic> json) {
    return MyAppointmentItem(
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
      children: json['children'] != null
          ? AppointmentChild.fromJson(
              json['children'] as Map<String, dynamic>)
          : null,
      expertUsers: json['expert_users'] != null
          ? AppointmentExpert.fromJson(
              json['expert_users'] as Map<String, dynamic>)
          : null,
      appointmentSlots: json['appointment_slots'] != null
          ? AppointmentSlot.fromJson(
              json['appointment_slots'] as Map<String, dynamic>)
          : null,
    );
  }

  // ── Status helpers ─────────────────────────────────────────
  bool get isScheduled => status.toLowerCase() == 'scheduled';
  bool get isConfirmed => status.toLowerCase() == 'confirmed';
  bool get isCompleted => status.toLowerCase() == 'completed';
  bool get isCancelled => status.toLowerCase() == 'cancelled';
  bool get isNoShow => status.toLowerCase() == 'no_show';

  // ── Payment helpers ────────────────────────────────────────
  /// Returns true when payment_status == 'paid' (case-insensitive)
  bool get isPaid => paymentStatus?.toLowerCase() == 'paid';

  /// Returns true when payment is pending (anything that is NOT 'paid')
  bool get isPaymentPending => !isPaid;

  String get formattedDate {
    try {
      final dt = DateTime.parse(scheduledAt).toLocal();
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
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

  String get childInitials {
    final name = children?.childName ?? '';
    final parts = name.trim().split(' ');
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'C';
  }
}

class AppointmentChild {
  final String childId;
  final String childName;

  AppointmentChild({required this.childId, required this.childName});

  factory AppointmentChild.fromJson(Map<String, dynamic> json) {
    return AppointmentChild(
      childId: (json['child_id'] ?? '').toString(),
      childName: (json['child_name'] ?? '').toString(),
    );
  }
}

class AppointmentExpert {
  final String expertId;
  final String fullName;
  final String specialization;
  final String? phone;
  final String? contactEmail;

  AppointmentExpert({
    required this.expertId,
    required this.fullName,
    required this.specialization,
    this.phone,
    this.contactEmail,
  });

  factory AppointmentExpert.fromJson(Map<String, dynamic> json) {
    return AppointmentExpert(
      expertId: (json['expert_id'] ?? '').toString(),
      fullName: (json['full_name'] ?? '').toString(),
      specialization: (json['specialization'] ?? '').toString(),
      phone: json['phone']?.toString(),
      contactEmail: json['contact_email']?.toString(),
    );
  }
}

class AppointmentSlot {
  final String slotId;
  final String slotDate;
  final String startTime;
  final String endTime;
  final String mode;
  final String? locationId;
  final String? status;

  AppointmentSlot({
    required this.slotId,
    required this.slotDate,
    required this.startTime,
    required this.endTime,
    required this.mode,
    this.locationId,
    this.status,
  });

  factory AppointmentSlot.fromJson(Map<String, dynamic> json) {
    return AppointmentSlot(
      slotId: (json['slot_id'] ?? '').toString(),
      slotDate: (json['slot_date'] ?? '').toString(),
      startTime: (json['start_time'] ?? '').toString(),
      endTime: (json['end_time'] ?? '').toString(),
      mode: (json['mode'] ?? '').toString(),
      locationId: json['location_id']?.toString(),
      status: json['status']?.toString(),
    );
  }

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

// ── Appointment Record Models ──────────────────────────────────

class AppointmentRecordListModel {
  final bool success;
  final List<AppointmentRecordItem> data;

  AppointmentRecordListModel({required this.success, required this.data});

  factory AppointmentRecordListModel.fromJson(Map<String, dynamic> json) {
    return AppointmentRecordListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) =>
                  AppointmentRecordItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

class AppointmentRecordSingleModel {
  final bool success;
  final AppointmentRecordItem data;

  AppointmentRecordSingleModel({required this.success, required this.data});

  factory AppointmentRecordSingleModel.fromJson(Map<String, dynamic> json) {
    return AppointmentRecordSingleModel(
      success: json['success'] ?? false,
      data: AppointmentRecordItem.fromJson(
          json['data'] as Map<String, dynamic>),
    );
  }
}

class AppointmentRecordItem {
  final String recordId;
  final String appointmentId;
  final String notes;
  final String therapyPlan;
  final Map<String, dynamic>? medication;
  final String progressFeedback;
  final String createdAt;

  AppointmentRecordItem({
    required this.recordId,
    required this.appointmentId,
    required this.notes,
    required this.therapyPlan,
    this.medication,
    required this.progressFeedback,
    required this.createdAt,
  });

  factory AppointmentRecordItem.fromJson(Map<String, dynamic> json) {
    return AppointmentRecordItem(
      recordId: (json['record_id'] ?? '').toString(),
      appointmentId: (json['appointment_id'] ?? '').toString(),
      notes: (json['notes'] ?? '').toString(),
      therapyPlan: (json['therapy_plan'] ?? '').toString(),
      medication: json['medication'] != null
          ? Map<String, dynamic>.from(json['medication'] as Map)
          : null,
      progressFeedback: (json['progress_feedback'] ?? '').toString(),
      createdAt: (json['created_at'] ?? '').toString(),
    );
  }

  String get formattedDate {
    try {
      final dt = DateTime.parse(createdAt).toLocal();
      const months = [
        '',
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return createdAt;
    }
  }
}