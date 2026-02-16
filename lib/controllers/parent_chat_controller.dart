// // lib/controllers/parent_chat_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/chat_model.dart';
// import 'package:speechspectrum/services/chat_service.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class ParentChatController extends GetxController {
//   final ChatService _chatService = ChatService();

//   var isLoading = false.obs;
//   var isSendingMessage = false.obs;
//   var conversations = <ParentConversationItem>[].obs;
//   var messages = <MessageData>[].obs;
//   var conversationDetails = Rx<ConversationDetailsModel?>(null);

//   final messageController = TextEditingController();
//   final searchController = TextEditingController();

//   String? currentUserId;
//   String? currentConversationId;

//   @override
//   void onInit() {
//     super.onInit();
//     _loadCurrentUserId();
//   }

//   Future<void> _loadCurrentUserId() async {
//     currentUserId = await SharedPreferencesService.getUserId();
//   }

//   // Fetch Parent Conversations
//   Future<void> fetchParentConversations() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching parent conversations');

//       final response = await _chatService.getParentConversations();

//       debugPrint('✅ Conversations fetched: ${response.data.length}');

//       if (response.status) {
//         conversations.value = response.data;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching conversations: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch Conversation Details
//   Future<void> fetchConversationDetails({
//     required String conversationId,
//   }) async {
//     try {
//       currentConversationId = conversationId;
//       debugPrint('🔐 Fetching conversation details: $conversationId');

//       final response = await _chatService.getConversationDetails(
//         conversationId: conversationId,
//       );

//       if (response.status) {
//         conversationDetails.value = response;
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching conversation details: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     }
//   }

//   // Fetch Messages
//   Future<void> fetchMessages({
//     required String conversationId,
//     int page = 1,
//     int limit = 50,
//   }) async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching messages for conversation: $conversationId');

//       final response = await _chatService.getMessages(
//         conversationId: conversationId,
//         page: page,
//         limit: limit,
//       );

//       debugPrint('✅ Messages fetched: ${response.data.length}');

//       if (response.status) {
//         messages.value = response.data.reversed.toList(); // Reverse to show latest at bottom
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error fetching messages: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Send Message
//   Future<void> sendMessage({required String conversationId}) async {
//     final messageText = messageController.text.trim();

//     if (messageText.isEmpty) {
//       _showError('Please enter a message');
//       return;
//     }

//     try {
//       isSendingMessage.value = true;

//       final response = await _chatService.sendMessage(
//         conversationId: conversationId,
//         messageText: messageText,
//       );

//       if (response.status) {
//         // Add message to list immediately for better UX
//         messages.add(response.data);
//         messageController.clear();

//         // Scroll to bottom (handled in UI)
//       } else {
//         _showError(response.message);
//       }
//     } catch (e) {
//       debugPrint('❌ Error sending message: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isSendingMessage.value = false;
//     }
//   }

//   // Search Conversations
//   List<ParentConversationItem> get filteredConversations {
//     if (searchController.text.isEmpty) {
//       return conversations;
//     }

//     final query = searchController.text.toLowerCase();
//     return conversations.where((conversation) {
//       final expertName =
//           conversation.expertChildLinks.expertUsers.fullName.toLowerCase();
//       final childName =
//           conversation.expertChildLinks.children.childName.toLowerCase();
//       return expertName.contains(query) || childName.contains(query);
//     }).toList();
//   }

//   bool isMyMessage(String senderId) {
//     return senderId == currentUserId;
//   }

//   void _showError(String message) {
//     Get.snackbar(
//       'Error',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 3),
//     );
//   }

//   void _showSuccess(String message) {
//     Get.snackbar(
//       'Success',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 2),
//     );
//   }

//   @override
//   void onClose() {
//     messageController.dispose();
//     searchController.dispose();
//     super.onClose();
//   }
// }

// lib/controllers/parent_chat_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/chat_model.dart';
import 'package:speechspectrum/services/chat_service.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ParentChatController extends GetxController {
  final ChatService _chatService = ChatService();

  var isLoading = false.obs;
  var isSendingMessage = false.obs;
  var conversations = <ParentConversationItem>[].obs;
  var messages = <MessageData>[].obs;
  var conversationDetails = Rx<ConversationDetailsModel?>(null);

  final messageController = TextEditingController();
  final searchController = TextEditingController();

  String? currentUserId;
  String? currentConversationId;

  @override
  void onInit() {
    super.onInit();
    _loadCurrentUserId();
  }

  Future<void> _loadCurrentUserId() async {
    currentUserId = await SharedPreferencesService.getUserId();
  }

  // Fetch Parent Conversations
  Future<void> fetchParentConversations() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching parent conversations');

      final response = await _chatService.getParentConversations();

      debugPrint('✅ Conversations fetched: ${response.data.length}');

      if (response.status) {
        conversations.value = response.data;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching conversations: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch Conversation Details
  Future<void> fetchConversationDetails({
    required String conversationId,
  }) async {
    try {
      currentConversationId = conversationId;
      debugPrint('🔐 Fetching conversation details: $conversationId');

      final response = await _chatService.getConversationDetails(
        conversationId: conversationId,
      );

      if (response.status) {
        conversationDetails.value = response;
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching conversation details: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    }
  }

  // Fetch Messages - FIXED: Keep messages in chronological order
  Future<void> fetchMessages({
    required String conversationId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching messages for conversation: $conversationId');

      final response = await _chatService.getMessages(
        conversationId: conversationId,
        page: page,
        limit: limit,
      );

      debugPrint('✅ Messages fetched: ${response.data.length}');

      if (response.status) {
        // ✅ FIX: Keep messages in chronological order (oldest first, latest at bottom)
        messages.value = response.data; // Don't reverse!
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error fetching messages: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  // Send Message - FIXED: Add to end of list
  Future<void> sendMessage({required String conversationId}) async {
    final messageText = messageController.text.trim();

    if (messageText.isEmpty) {
      _showError('Please enter a message');
      return;
    }

    try {
      isSendingMessage.value = true;

      final response = await _chatService.sendMessage(
        conversationId: conversationId,
        messageText: messageText,
      );

      if (response.status) {
        // ✅ FIX: Add new message to the END of the list (bottom)
        messages.add(response.data);
        messageController.clear();

        // Scroll to bottom will be handled in UI
      } else {
        _showError(response.message);
      }
    } catch (e) {
      debugPrint('❌ Error sending message: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isSendingMessage.value = false;
    }
  }

  // Search Conversations
  List<ParentConversationItem> get filteredConversations {
    if (searchController.text.isEmpty) {
      return conversations;
    }

    final query = searchController.text.toLowerCase();
    return conversations.where((conversation) {
      final expertName =
          conversation.expertChildLinks.expertUsers.fullName.toLowerCase();
      final childName =
          conversation.expertChildLinks.children.childName.toLowerCase();
      return expertName.contains(query) || childName.contains(query);
    }).toList();
  }

  bool isMyMessage(String senderId) {
    return senderId == currentUserId;
  }

  void _showError(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  void _showSuccess(String message) {
    Get.snackbar(
      'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    searchController.dispose();
    super.onClose();
  }
}