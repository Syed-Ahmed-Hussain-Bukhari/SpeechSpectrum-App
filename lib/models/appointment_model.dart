// lib/models/appointment_model.dart
import 'package:intl/intl.dart';

// Generate Zoom Link Model
class GenerateZoomLinkModel {
  final String message;
  final ZoomLinkData data;
  final bool status;

  GenerateZoomLinkModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory GenerateZoomLinkModel.fromJson(Map<String, dynamic> json) {
    return GenerateZoomLinkModel(
      message: json['message'] ?? '',
      data: ZoomLinkData.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class ZoomLinkData {
  final String joinUrl;
  final int meetingId;
  final String password;

  ZoomLinkData({
    required this.joinUrl,
    required this.meetingId,
    required this.password,
  });

  factory ZoomLinkData.fromJson(Map<String, dynamic> json) {
    return ZoomLinkData(
      joinUrl: json['join_url'] ?? '',
      meetingId: json['meeting_id'] ?? 0,
      password: json['password'] ?? '',
    );
  }
}

// Create Appointment Model
class CreateAppointmentModel {
  final String message;
  final AppointmentData data;
  final bool status;

  CreateAppointmentModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory CreateAppointmentModel.fromJson(Map<String, dynamic> json) {
    return CreateAppointmentModel(
      message: json['message'] ?? '',
      data: AppointmentData.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class AppointmentData {
  final String appointmentId;
  final String linkId;
  final String appointmentType;
  final String scheduledAt;
  final String status;
  final String createdAt;
  final String? meetLink;
  final String? contact;
  final String? location;

  AppointmentData({
    required this.appointmentId,
    required this.linkId,
    required this.appointmentType,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
    this.meetLink,
    this.contact,
    this.location,
  });

  factory AppointmentData.fromJson(Map<String, dynamic> json) {
    return AppointmentData(
      appointmentId: json['appointment_id'] ?? '',
      linkId: json['link_id'] ?? '',
      appointmentType: json['appointment_type'] ?? '',
      scheduledAt: json['scheduled_at'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      meetLink: json['meet_link'] == 'NULL' ? null : json['meet_link'],
      contact: json['contact'],
      location: json['location'],
    );
  }
}

// Expert Appointments List Model
class ExpertAppointmentsModel {
  final String message;
  final List<ExpertAppointmentItem> data;
  final bool status;

  ExpertAppointmentsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ExpertAppointmentsModel.fromJson(Map<String, dynamic> json) {
    return ExpertAppointmentsModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ExpertAppointmentItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class ExpertAppointmentItem {
  final String appointmentId;
  final String appointmentType;
  final String scheduledAt;
  final String status;
  final String createdAt;
  final ExpertChildLinks expertChildLinks;

  ExpertAppointmentItem({
    required this.appointmentId,
    required this.appointmentType,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
    required this.expertChildLinks,
  });

  factory ExpertAppointmentItem.fromJson(Map<String, dynamic> json) {
    return ExpertAppointmentItem(
      appointmentId: json['appointment_id'] ?? '',
      appointmentType: json['appointment_type'] ?? '',
      scheduledAt: json['scheduled_at'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      expertChildLinks: ExpertChildLinks.fromJson(json['expert_child_links']),
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(scheduledAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return scheduledAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(scheduledAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }

  bool isScheduled() => status.toLowerCase() == 'scheduled';
  bool isCompleted() => status.toLowerCase() == 'completed';
  bool isCancelled() => status.toLowerCase() == 'cancelled';
}

class ExpertChildLinks {
  final String linkId;
  final String childId;
  final AppointmentChildInfo children;
  final String expertId;
  final String parentUserId;

  ExpertChildLinks({
    required this.linkId,
    required this.childId,
    required this.children,
    required this.expertId,
    required this.parentUserId,
  });

  factory ExpertChildLinks.fromJson(Map<String, dynamic> json) {
    return ExpertChildLinks(
      linkId: json['link_id'] ?? '',
      childId: json['child_id'] ?? '',
      children: AppointmentChildInfo.fromJson(json['children']),
      expertId: json['expert_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
    );
  }
}

class AppointmentChildInfo {
  final String childId;
  final String childName;

  AppointmentChildInfo({
    required this.childId,
    required this.childName,
  });

  factory AppointmentChildInfo.fromJson(Map<String, dynamic> json) {
    return AppointmentChildInfo(
      childId: json['child_id'] ?? '',
      childName: json['child_name'] ?? '',
    );
  }

  String getInitials() {
    final names = childName.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return 'C';
  }
}

// Save Notes Model
class SaveNotesModel {
  final String message;
  final AppointmentRecord data;
  final bool status;

  SaveNotesModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory SaveNotesModel.fromJson(Map<String, dynamic> json) {
    return SaveNotesModel(
      message: json['message'] ?? '',
      data: AppointmentRecord.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class AppointmentRecord {
  final String recordId;
  final String appointmentId;
  final String notes;
  final String therapyPlan;
  final Medication? medication;
  final String progressFeedback;
  final String createdAt;

  AppointmentRecord({
    required this.recordId,
    required this.appointmentId,
    required this.notes,
    required this.therapyPlan,
    this.medication,
    required this.progressFeedback,
    required this.createdAt,
  });

  factory AppointmentRecord.fromJson(Map<String, dynamic> json) {
    return AppointmentRecord(
      recordId: json['record_id'] ?? '',
      appointmentId: json['appointment_id'] ?? '',
      notes: json['notes'] ?? '',
      therapyPlan: json['therapy_plan'] ?? '',
      medication: json['medication'] != null
          ? Medication.fromJson(json['medication'])
          : null,
      progressFeedback: json['progress_feedback'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class Medication {
  final List<Prescription> prescriptions;
  final String recommendations;

  Medication({
    required this.prescriptions,
    required this.recommendations,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      prescriptions: (json['prescriptions'] as List<dynamic>?)
              ?.map((item) => Prescription.fromJson(item))
              .toList() ??
          [],
      recommendations: json['recommendations'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prescriptions': prescriptions.map((p) => p.toJson()).toList(),
      'recommendations': recommendations,
    };
  }
}

class Prescription {
  final String name;
  final String dosage;
  final String duration;

  Prescription({
    required this.name,
    required this.dosage,
    required this.duration,
  });

  factory Prescription.fromJson(Map<String, dynamic> json) {
    return Prescription(
      name: json['name'] ?? '',
      dosage: json['dosage'] ?? '',
      duration: json['duration'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'duration': duration,
    };
  }
}

// Appointment Details Model
class AppointmentDetailsModel {
  final String message;
  final AppointmentDetailsData data;
  final bool status;

  AppointmentDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory AppointmentDetailsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailsModel(
      message: json['message'] ?? '',
      data: AppointmentDetailsData.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class AppointmentDetailsData {
  final DetailedAppointment appointment;
  final List<AppointmentRecord> records;

  AppointmentDetailsData({
    required this.appointment,
    required this.records,
  });

  factory AppointmentDetailsData.fromJson(Map<String, dynamic> json) {
    return AppointmentDetailsData(
      appointment: DetailedAppointment.fromJson(json['appointment']),
      records: (json['records'] as List<dynamic>?)
              ?.map((item) => AppointmentRecord.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class DetailedAppointment {
  final String appointmentId;
  final String appointmentType;
  final String scheduledAt;
  final String status;
  final String createdAt;
  final DetailedExpertChildLinks expertChildLinks;

  DetailedAppointment({
    required this.appointmentId,
    required this.appointmentType,
    required this.scheduledAt,
    required this.status,
    required this.createdAt,
    required this.expertChildLinks,
  });

  factory DetailedAppointment.fromJson(Map<String, dynamic> json) {
    return DetailedAppointment(
      appointmentId: json['appointment_id'] ?? '',
      appointmentType: json['appointment_type'] ?? '',
      scheduledAt: json['scheduled_at'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      expertChildLinks:
          DetailedExpertChildLinks.fromJson(json['expert_child_links']),
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(scheduledAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return scheduledAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(scheduledAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }
}

class DetailedExpertChildLinks {
  final String linkId;
  final String childId;
  final AppointmentChildInfo children;
  final String expertId;
  final ExpertUserInfo expertUsers;
  final String parentUserId;

  DetailedExpertChildLinks({
    required this.linkId,
    required this.childId,
    required this.children,
    required this.expertId,
    required this.expertUsers,
    required this.parentUserId,
  });

  factory DetailedExpertChildLinks.fromJson(Map<String, dynamic> json) {
    return DetailedExpertChildLinks(
      linkId: json['link_id'] ?? '',
      childId: json['child_id'] ?? '',
      children: AppointmentChildInfo.fromJson(json['children']),
      expertId: json['expert_id'] ?? '',
      expertUsers: ExpertUserInfo.fromJson(json['expert_users']),
      parentUserId: json['parent_user_id'] ?? '',
    );
  }
}

class ExpertUserInfo {
  final String phone;
  final String expertId;
  final String fullName;
  final String organization;
  final String contactEmail;
  final String specialization;

  ExpertUserInfo({
    required this.phone,
    required this.expertId,
    required this.fullName,
    required this.organization,
    required this.contactEmail,
    required this.specialization,
  });

  factory ExpertUserInfo.fromJson(Map<String, dynamic> json) {
    return ExpertUserInfo(
      phone: json['phone'] ?? '',
      expertId: json['expert_id'] ?? '',
      fullName: json['full_name'] ?? '',
      organization: json['organization'] ?? '',
      contactEmail: json['contact_email'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }
}