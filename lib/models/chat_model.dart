// lib/models/chat_model.dart
import 'package:intl/intl.dart';

// ============================================================================
// CREATE CONVERSATION MODEL
// ============================================================================

class CreateConversationModel {
  final String message;
  final ConversationData data;
  final bool status;

  CreateConversationModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory CreateConversationModel.fromJson(Map<String, dynamic> json) {
    return CreateConversationModel(
      message: json['message'] ?? '',
      data: ConversationData.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class ConversationData {
  final String conversationId;
  final String linkId;
  final String createdAt;

  ConversationData({
    required this.conversationId,
    required this.linkId,
    required this.createdAt,
  });

  factory ConversationData.fromJson(Map<String, dynamic> json) {
    return ConversationData(
      conversationId: json['conversation_id'] ?? '',
      linkId: json['link_id'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

// ============================================================================
// EXPERT CONVERSATIONS LIST MODEL
// ============================================================================

class ExpertConversationsModel {
  final String message;
  final List<ExpertConversationItem> data;
  final bool status;

  ExpertConversationsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ExpertConversationsModel.fromJson(Map<String, dynamic> json) {
    return ExpertConversationsModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ExpertConversationItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class ExpertConversationItem {
  final String conversationId;
  final String linkId;
  final String createdAt;
  final ExpertChatLinks expertChildLinks;

  ExpertConversationItem({
    required this.conversationId,
    required this.linkId,
    required this.createdAt,
    required this.expertChildLinks,
  });

  factory ExpertConversationItem.fromJson(Map<String, dynamic> json) {
    return ExpertConversationItem(
      conversationId: json['conversation_id'] ?? '',
      linkId: json['link_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      expertChildLinks: ExpertChatLinks.fromJson(json['expert_child_links']),
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(createdAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return createdAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(createdAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }
}

class ExpertChatLinks {
  final String childId;
  final ChatChildInfo children;
  final String expertId;
  final String parentUserId;

  ExpertChatLinks({
    required this.childId,
    required this.children,
    required this.expertId,
    required this.parentUserId,
  });

  factory ExpertChatLinks.fromJson(Map<String, dynamic> json) {
    return ExpertChatLinks(
      childId: json['child_id'] ?? '',
      children: ChatChildInfo.fromJson(json['children']),
      expertId: json['expert_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
    );
  }
}

// ============================================================================
// PARENT CONVERSATIONS LIST MODEL
// ============================================================================

class ParentConversationsModel {
  final String message;
  final List<ParentConversationItem> data;
  final bool status;

  ParentConversationsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ParentConversationsModel.fromJson(Map<String, dynamic> json) {
    return ParentConversationsModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => ParentConversationItem.fromJson(item))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class ParentConversationItem {
  final String conversationId;
  final String linkId;
  final String createdAt;
  final ParentChatLinks expertChildLinks;

  ParentConversationItem({
    required this.conversationId,
    required this.linkId,
    required this.createdAt,
    required this.expertChildLinks,
  });

  factory ParentConversationItem.fromJson(Map<String, dynamic> json) {
    return ParentConversationItem(
      conversationId: json['conversation_id'] ?? '',
      linkId: json['link_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      expertChildLinks: ParentChatLinks.fromJson(json['expert_child_links']),
    );
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(createdAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return createdAt;
    }
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(createdAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }
}

class ParentChatLinks {
  final String childId;
  final ChatChildInfo children;
  final String expertId;
  final ChatExpertInfo expertUsers;
  final String parentUserId;

  ParentChatLinks({
    required this.childId,
    required this.children,
    required this.expertId,
    required this.expertUsers,
    required this.parentUserId,
  });

  factory ParentChatLinks.fromJson(Map<String, dynamic> json) {
    return ParentChatLinks(
      childId: json['child_id'] ?? '',
      children: ChatChildInfo.fromJson(json['children']),
      expertId: json['expert_id'] ?? '',
      expertUsers: ChatExpertInfo.fromJson(json['expert_users']),
      parentUserId: json['parent_user_id'] ?? '',
    );
  }
}

// ============================================================================
// SHARED MODELS
// ============================================================================

class ChatChildInfo {
  final String childId;
  final String childName;

  ChatChildInfo({
    required this.childId,
    required this.childName,
  });

  factory ChatChildInfo.fromJson(Map<String, dynamic> json) {
    return ChatChildInfo(
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

class ChatExpertInfo {
  final String expertId;
  final String fullName;
  final String specialization;

  ChatExpertInfo({
    required this.expertId,
    required this.fullName,
    required this.specialization,
  });

  factory ChatExpertInfo.fromJson(Map<String, dynamic> json) {
    return ChatExpertInfo(
      expertId: json['expert_id'] ?? '',
      fullName: json['full_name'] ?? '',
      specialization: json['specialization'] ?? '',
    );
  }

  String getInitials() {
    final names = fullName.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return 'E';
  }
}

// ============================================================================
// CONVERSATION DETAILS MODEL
// ============================================================================

class ConversationDetailsModel {
  final String message;
  final ConversationDetails data;
  final bool status;

  ConversationDetailsModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ConversationDetailsModel.fromJson(Map<String, dynamic> json) {
    return ConversationDetailsModel(
      message: json['message'] ?? '',
      data: ConversationDetails.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class ConversationDetails {
  final String conversationId;
  final String linkId;
  final String createdAt;
  final ConversationLinks expertChildLinks;

  ConversationDetails({
    required this.conversationId,
    required this.linkId,
    required this.createdAt,
    required this.expertChildLinks,
  });

  factory ConversationDetails.fromJson(Map<String, dynamic> json) {
    return ConversationDetails(
      conversationId: json['conversation_id'] ?? '',
      linkId: json['link_id'] ?? '',
      createdAt: json['created_at'] ?? '',
      expertChildLinks: ConversationLinks.fromJson(json['expert_child_links']),
    );
  }
}

class ConversationLinks {
  final String childId;
  final ChatChildInfo children;
  final String expertId;
  final ChatExpertInfo expertUsers;
  final String parentUserId;

  ConversationLinks({
    required this.childId,
    required this.children,
    required this.expertId,
    required this.expertUsers,
    required this.parentUserId,
  });

  factory ConversationLinks.fromJson(Map<String, dynamic> json) {
    return ConversationLinks(
      childId: json['child_id'] ?? '',
      children: ChatChildInfo.fromJson(json['children']),
      expertId: json['expert_id'] ?? '',
      expertUsers: ChatExpertInfo.fromJson(json['expert_users']),
      parentUserId: json['parent_user_id'] ?? '',
    );
  }
}

// ============================================================================
// MESSAGE MODELS
// ============================================================================

class SendMessageModel {
  final String message;
  final MessageData data;
  final bool status;

  SendMessageModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory SendMessageModel.fromJson(Map<String, dynamic> json) {
    return SendMessageModel(
      message: json['message'] ?? '',
      data: MessageData.fromJson(json['data']),
      status: json['status'] ?? false,
    );
  }
}

class MessageData {
  final String messageId;
  final String conversationId;
  final String senderId;
  final String messageText;
  final String messageType;
  final String createdAt;

  MessageData({
    required this.messageId,
    required this.conversationId,
    required this.senderId,
    required this.messageText,
    required this.messageType,
    required this.createdAt,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) {
    return MessageData(
      messageId: json['message_id'] ?? '',
      conversationId: json['conversation_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      messageText: json['message_text'] ?? '',
      messageType: json['message_type'] ?? 'text',
      createdAt: json['created_at'] ?? '',
    );
  }

  String getFormattedTime() {
    try {
      final date = DateTime.parse(createdAt);
      return DateFormat('hh:mm a').format(date);
    } catch (e) {
      return '';
    }
  }

  String getFormattedDate() {
    try {
      final date = DateTime.parse(createdAt);
      final now = DateTime.now();
      final yesterday = DateTime.now().subtract(const Duration(days: 1));

      if (date.year == now.year &&
          date.month == now.month &&
          date.day == now.day) {
        return 'Today';
      } else if (date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day) {
        return 'Yesterday';
      } else {
        return DateFormat('MMM dd, yyyy').format(date);
      }
    } catch (e) {
      return '';
    }
  }
}

// ============================================================================
// MESSAGES LIST MODEL
// ============================================================================

class MessagesListModel {
  final String message;
  final List<MessageData> data;
  final PaginationData pagination;
  final bool status;

  MessagesListModel({
    required this.message,
    required this.data,
    required this.pagination,
    required this.status,
  });

  factory MessagesListModel.fromJson(Map<String, dynamic> json) {
    return MessagesListModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => MessageData.fromJson(item))
              .toList() ??
          [],
      pagination: PaginationData.fromJson(json['pagination'] ?? {}),
      status: json['status'] ?? false,
    );
  }
}

class PaginationData {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  PaginationData({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) {
    return PaginationData(
      page: json['page'] ?? 1,
      limit: json['limit'] ?? 50,
      total: json['total'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}