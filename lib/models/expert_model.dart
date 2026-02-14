// // lib/models/expert_model.dart
// import 'package:intl/intl.dart';

// // Expert List Response Model
// class ExpertListModel {
//   final String message;
//   final ExpertListData data;
//   final bool status;

//   ExpertListModel({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory ExpertListModel.fromJson(Map<String, dynamic> json) {
//     return ExpertListModel(
//       message: json['message'] ?? '',
//       data: ExpertListData.fromJson(json['data']),
//       status: json['status'] ?? false,
//     );
//   }
// }

// class ExpertListData {
//   final List<ExpertData> experts;
//   final PaginationData pagination;

//   ExpertListData({
//     required this.experts,
//     required this.pagination,
//   });

//   factory ExpertListData.fromJson(Map<String, dynamic> json) {
//     return ExpertListData(
//       experts: (json['experts'] as List<dynamic>?)
//               ?.map((expert) => ExpertData.fromJson(expert))
//               .toList() ??
//           [],
//       pagination: PaginationData.fromJson(json['pagination']),
//     );
//   }
// }

// class PaginationData {
//   final int currentPage;
//   final int totalPages;
//   final int totalCount;
//   final int limit;
//   final bool hasNextPage;
//   final bool hasPrevPage;

//   PaginationData({
//     required this.currentPage,
//     required this.totalPages,
//     required this.totalCount,
//     required this.limit,
//     required this.hasNextPage,
//     required this.hasPrevPage,
//   });

//   factory PaginationData.fromJson(Map<String, dynamic> json) {
//     return PaginationData(
//       currentPage: json['currentPage'] ?? 1,
//       totalPages: json['totalPages'] ?? 1,
//       totalCount: json['totalCount'] ?? 0,
//       limit: json['limit'] ?? 10,
//       hasNextPage: json['hasNextPage'] ?? false,
//       hasPrevPage: json['hasPrevPage'] ?? false,
//     );
//   }
// }

// class ExpertData {
//   final String expertId;
//   final String fullName;
//   final String specialization;
//   final String organization;
//   final String contactEmail;
//   final String phone;
//   final String pmdcNumber;
//   final String? profileImagePublicId;
//   final String approvalStatus;
//   final String createdAt;

//   ExpertData({
//     required this.expertId,
//     required this.fullName,
//     required this.specialization,
//     required this.organization,
//     required this.contactEmail,
//     required this.phone,
//     required this.pmdcNumber,
//     this.profileImagePublicId,
//     required this.approvalStatus,
//     required this.createdAt,
//   });

//   factory ExpertData.fromJson(Map<String, dynamic> json) {
//     return ExpertData(
//       expertId: json['expert_id'] ?? '',
//       fullName: json['full_name'] ?? '',
//       specialization: json['specialization'] ?? '',
//       organization: json['organization'] ?? '',
//       contactEmail: json['contact_email'] ?? '',
//       phone: json['phone'] ?? '',
//       pmdcNumber: json['pmdc_number'] ?? '',
//       profileImagePublicId: json['profile_image_public_id'],
//       approvalStatus: json['approval_status'] ?? '',
//       createdAt: json['created_at'] ?? '',
//     );
//   }

//   // Get initials for avatar
//   String getInitials() {
//     final names = fullName.trim().split(' ');
//     if (names.length >= 2) {
//       return '${names[0][0]}${names[1][0]}'.toUpperCase();
//     } else if (names.isNotEmpty) {
//       return names[0][0].toUpperCase();
//     }
//     return 'E';
//   }

//   // Get formatted date
//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(createdAt);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (e) {
//       return createdAt;
//     }
//   }

//   // Check if expert has profile image
//   bool hasProfileImage() {
//     return profileImagePublicId != null && profileImagePublicId!.isNotEmpty;
//   }
// }

// // Consultation Request Model
// class ConsultationRequestModel {
//   final String message;
//   final ConsultationData? data;
//   final bool status;

//   ConsultationRequestModel({
//     required this.message,
//     this.data,
//     required this.status,
//   });

//   factory ConsultationRequestModel.fromJson(Map<String, dynamic> json) {
//     return ConsultationRequestModel(
//       message: json['message'] ?? '',
//       data: json['data'] != null ? ConsultationData.fromJson(json['data']) : null,
//       status: json['status'] ?? false,
//     );
//   }
// }

// class ConsultationData {
//   final String requestId;
//   final String parentUserId;
//   final String expertId;
//   final String childId;
//   final String status;
//   final String requestedAt;

//   ConsultationData({
//     required this.requestId,
//     required this.parentUserId,
//     required this.expertId,
//     required this.childId,
//     required this.status,
//     required this.requestedAt,
//   });

//   factory ConsultationData.fromJson(Map<String, dynamic> json) {
//     return ConsultationData(
//       requestId: json['request_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       expertId: json['expert_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       status: json['status'] ?? '',
//       requestedAt: json['requested_at'] ?? '',
//     );
//   }
// }

// // Consultation List Model
// class ConsultationListModel {
//   final String message;
//   final List<ConsultationItem> data;
//   final bool status;

//   ConsultationListModel({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory ConsultationListModel.fromJson(Map<String, dynamic> json) {
//     return ConsultationListModel(
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((item) => ConsultationItem.fromJson(item))
//               .toList() ??
//           [],
//       status: json['status'] ?? false,
//     );
//   }
// }

// class ConsultationItem {
//   final String requestId;
//   final String expertId;
//   final String childId;
//   final String status;
//   final String requestedAt;
//   final ExpertInfo expertUsers;
//   final ChildInfo children;

//   ConsultationItem({
//     required this.requestId,
//     required this.expertId,
//     required this.childId,
//     required this.status,
//     required this.requestedAt,
//     required this.expertUsers,
//     required this.children,
//   });

//   factory ConsultationItem.fromJson(Map<String, dynamic> json) {
//     return ConsultationItem(
//       requestId: json['request_id'] ?? '',
//       expertId: json['expert_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       status: json['status'] ?? '',
//       requestedAt: json['requested_at'] ?? '',
//       expertUsers: ExpertInfo.fromJson(json['expert_users']),
//       children: ChildInfo.fromJson(json['children']),
//     );
//   }

//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(requestedAt);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (e) {
//       return requestedAt;
//     }
//   }

//   String getFormattedTime() {
//     try {
//       final date = DateTime.parse(requestedAt);
//       return DateFormat('hh:mm a').format(date);
//     } catch (e) {
//       return '';
//     }
//   }

//   bool isPending() => status.toLowerCase() == 'pending';
//   bool isApproved() => status.toLowerCase() == 'approved';
// }

// class ExpertInfo {
//   final String phone;
//   final String expertId;
//   final String fullName;
//   final String organization;
//   final String contactEmail;
//   final String specialization;

//   ExpertInfo({
//     required this.phone,
//     required this.expertId,
//     required this.fullName,
//     required this.organization,
//     required this.contactEmail,
//     required this.specialization,
//   });

//   factory ExpertInfo.fromJson(Map<String, dynamic> json) {
//     return ExpertInfo(
//       phone: json['phone'] ?? '',
//       expertId: json['expert_id'] ?? '',
//       fullName: json['full_name'] ?? '',
//       organization: json['organization'] ?? '',
//       contactEmail: json['contact_email'] ?? '',
//       specialization: json['specialization'] ?? '',
//     );
//   }

//   String getInitials() {
//     final names = fullName.trim().split(' ');
//     if (names.length >= 2) {
//       return '${names[0][0]}${names[1][0]}'.toUpperCase();
//     } else if (names.isNotEmpty) {
//       return names[0][0].toUpperCase();
//     }
//     return 'E';
//   }
// }

// class ChildInfo {
//   final String childId;
//   final String childName;

//   ChildInfo({
//     required this.childId,
//     required this.childName,
//   });

//   factory ChildInfo.fromJson(Map<String, dynamic> json) {
//     return ChildInfo(
//       childId: json['child_id'] ?? '',
//       childName: json['child_name'] ?? '',
//     );
//   }
// }

// // Linked Experts Model
// class LinkedExpertsModel {
//   final String message;
//   final List<LinkedExpertItem> data;
//   final bool status;

//   LinkedExpertsModel({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory LinkedExpertsModel.fromJson(Map<String, dynamic> json) {
//     return LinkedExpertsModel(
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((item) => LinkedExpertItem.fromJson(item))
//               .toList() ??
//           [],
//       status: json['status'] ?? false,
//     );
//   }
// }

// class LinkedExpertItem {
//   final String linkId;
//   final String linkedAt;
//   final String expertId;
//   final String childId;
//   final String parentUserId;
//   final ChildInfo children;
//   final ExpertInfo expertUsers;

//   LinkedExpertItem({
//     required this.linkId,
//     required this.linkedAt,
//     required this.expertId,
//     required this.childId,
//     required this.parentUserId,
//     required this.children,
//     required this.expertUsers,
//   });

//   factory LinkedExpertItem.fromJson(Map<String, dynamic> json) {
//     return LinkedExpertItem(
//       linkId: json['link_id'] ?? '',
//       linkedAt: json['linked_at'] ?? '',
//       expertId: json['expert_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       children: ChildInfo.fromJson(json['children']),
//       expertUsers: ExpertInfo.fromJson(json['expert_users']),
//     );
//   }

//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(linkedAt);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (e) {
//       return linkedAt;
//     }
//   }
// }

// // Expert Consultation Models
// class ExpertConsultationListModel {
//   final String message;
//   final List<ExpertConsultationItem> data;
//   final bool status;

//   ExpertConsultationListModel({
//     required this.message,
//     required this.data,
//     required this.status,
//   });

//   factory ExpertConsultationListModel.fromJson(Map<String, dynamic> json) {
//     return ExpertConsultationListModel(
//       message: json['message'] ?? '',
//       data: (json['data'] as List<dynamic>?)
//               ?.map((item) => ExpertConsultationItem.fromJson(item))
//               .toList() ??
//           [],
//       status: json['status'] ?? false,
//     );
//   }
// }

// class ExpertConsultationItem {
//   final String requestId;
//   final String parentUserId;
//   final String childId;
//   final String status;
//   final String requestedAt;
//   final ChildInfo? children;

//   ExpertConsultationItem({
//     required this.requestId,
//     required this.parentUserId,
//     required this.childId,
//     required this.status,
//     required this.requestedAt,
//     this.children,
//   });

//   factory ExpertConsultationItem.fromJson(Map<String, dynamic> json) {
//     return ExpertConsultationItem(
//       requestId: json['request_id'] ?? '',
//       parentUserId: json['parent_user_id'] ?? '',
//       childId: json['child_id'] ?? '',
//       status: json['status'] ?? '',
//       requestedAt: json['requested_at'] ?? '',
//       children: json['children'] != null ? ChildInfo.fromJson(json['children']) : null,
//     );
//   }

//   String getFormattedDate() {
//     try {
//       final date = DateTime.parse(requestedAt);
//       return DateFormat('MMM dd, yyyy').format(date);
//     } catch (e) {
//       return requestedAt;
//     }
//   }

//   String getFormattedTime() {
//     try {
//       final date = DateTime.parse(requestedAt);
//       return DateFormat('hh:mm a').format(date);
//     } catch (e) {
//       return '';
//     }
//   }

//   bool isPending() => status.toLowerCase() == 'pending';
//   bool isApproved() => status.toLowerCase() == 'approved';
//   bool isRejected() => status.toLowerCase() == 'rejected';
// }

// // Consultation Response Model
// class ConsultationResponseModel {
//   final String message;
//   final bool status;

//   ConsultationResponseModel({
//     required this.message,
//     required this.status,
//   });

//   factory ConsultationResponseModel.fromJson(Map<String, dynamic> json) {
//     return ConsultationResponseModel(
//       message: json['message'] ?? '',
//       status: json['status'] ?? false,
//     );
//   }
// }

// // Create Link Response Model
// class CreateLinkResponseModel {
//   final String message;
//   final bool status;

//   CreateLinkResponseModel({
//     required this.message,
//     required this.status,
//   });

//   factory CreateLinkResponseModel.fromJson(Map<String, dynamic> json) {
//     return CreateLinkResponseModel(
//       message: json['message'] ?? '',
//       status: json['status'] ?? false,
//     );
//   }
// }


// lib/models/expert_model.dart
import 'package:intl/intl.dart';

// Expert Consultations Response Model
class ExpertConsultationsModel {
  final String message;
  final List<ExpertConsultationItem> data;
  final bool status;

  ExpertConsultationsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ExpertConsultationsModel.fromJson(Map<String, dynamic> json) {
    return ExpertConsultationsModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ExpertConsultationItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class ExpertConsultationItem {
  final String requestId;
  final String parentUserId;
  final String childId;
  final String status;
  final String requestedAt;
  final ChildInfo children;

  ExpertConsultationItem({
    required this.requestId,
    required this.parentUserId,
    required this.childId,
    required this.status,
    required this.requestedAt,
    required this.children,
  });

  factory ExpertConsultationItem.fromJson(Map<String, dynamic> json) {
    return ExpertConsultationItem(
      requestId: json['request_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childId: json['child_id'] ?? '',
      status: json['status'] ?? '',
      requestedAt: json['requested_at'] ?? '',
      children: ChildInfo.fromJson(json['children']),
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(requestedAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return requestedAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(requestedAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }

  bool isPending() => status.toLowerCase() == 'pending';
  bool isApproved() => status.toLowerCase() == 'approved';
  bool isRejected() => status.toLowerCase() == 'rejected';
}

class ChildInfo {
  final String childId;
  final String childName;

  ChildInfo({
    required this.childId,
    required this.childName,
  });

  factory ChildInfo.fromJson(Map<String, dynamic> json) {
    return ChildInfo(
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

// Respond to Consultation Model
class RespondConsultationModel {
  final String message;
  final RespondConsultationData? data;
  final bool status;

  RespondConsultationModel({
    required this.message,
    this.data,
    required this.status,
  });

  factory RespondConsultationModel.fromJson(Map<String, dynamic> json) {
    return RespondConsultationModel(
      message: json['message'] ?? '',
      data: json['data'] != null
          ? RespondConsultationData.fromJson(json['data'])
          : null,
      status: json['status'] ?? false,
    );
  }
}

class RespondConsultationData {
  final ConsultationRequest request;
  final ConsultationLink? link;

  RespondConsultationData({
    required this.request,
    this.link,
  });

  factory RespondConsultationData.fromJson(Map<String, dynamic> json) {
    return RespondConsultationData(
      request: ConsultationRequest.fromJson(json['request']),
      link: json['link'] != null
          ? ConsultationLink.fromJson(json['link'])
          : null,
    );
  }
}

class ConsultationRequest {
  final String requestId;
  final String parentUserId;
  final String expertId;
  final String childId;
  final String status;
  final String requestedAt;

  ConsultationRequest({
    required this.requestId,
    required this.parentUserId,
    required this.expertId,
    required this.childId,
    required this.status,
    required this.requestedAt,
  });

  factory ConsultationRequest.fromJson(Map<String, dynamic> json) {
    return ConsultationRequest(
      requestId: json['request_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      expertId: json['expert_id'] ?? '',
      childId: json['child_id'] ?? '',
      status: json['status'] ?? '',
      requestedAt: json['requested_at'] ?? '',
    );
  }
}

class ConsultationLink {
  final String linkId;
  final String expertId;
  final String childId;
  final String parentUserId;
  final String linkedAt;

  ConsultationLink({
    required this.linkId,
    required this.expertId,
    required this.childId,
    required this.parentUserId,
    required this.linkedAt,
  });

  factory ConsultationLink.fromJson(Map<String, dynamic> json) {
    return ConsultationLink(
      linkId: json['link_id'] ?? '',
      expertId: json['expert_id'] ?? '',
      childId: json['child_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      linkedAt: json['linked_at'] ?? '',
    );
  }
}

// Create Link Model
class CreateLinkModel {
  final String message;
  final CreateLinkData data;
  final bool status;

  CreateLinkModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory CreateLinkModel.fromJson(Map<String, dynamic> json) {
    return CreateLinkModel(
      message: json['message'] ?? '',
      data: CreateLinkData.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class CreateLinkData {
  final String linkId;

  CreateLinkData({required this.linkId});

  factory CreateLinkData.fromJson(Map<String, dynamic> json) {
    return CreateLinkData(
      linkId: json['link_id'] ?? '',
    );
  }
}

// Expert Linked Parents Model
class ExpertLinkedParentsModel {
  final String message;
  final List<ExpertLinkedParentItem> data;
  final bool status;

  ExpertLinkedParentsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ExpertLinkedParentsModel.fromJson(Map<String, dynamic> json) {
    return ExpertLinkedParentsModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ExpertLinkedParentItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class ExpertLinkedParentItem {
  final String linkId;
  final String linkedAt;
  final String expertId;
  final String childId;
  final String parentUserId;
  final ChildInfo children;

  ExpertLinkedParentItem({
    required this.linkId,
    required this.linkedAt,
    required this.expertId,
    required this.childId,
    required this.parentUserId,
    required this.children,
  });

  factory ExpertLinkedParentItem.fromJson(Map<String, dynamic> json) {
    return ExpertLinkedParentItem(
      linkId: json['link_id'] ?? '',
      linkedAt: json['linked_at'] ?? '',
      expertId: json['expert_id'] ?? '',
      childId: json['child_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      children: ChildInfo.fromJson(json['children']),
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(linkedAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return linkedAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(linkedAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }
}