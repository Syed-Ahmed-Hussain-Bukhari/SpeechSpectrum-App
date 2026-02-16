// // lib/controllers/expert_chat_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/chat_model.dart';
// import 'package:speechspectrum/services/chat_service.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class ExpertChatController extends GetxController {
//   final ChatService _chatService = ChatService();

//   var isLoading = false.obs;
//   var isCreatingConversation = false.obs;
//   var isSendingMessage = false.obs;
//   var conversations = <ExpertConversationItem>[].obs;
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

//   // Fetch Expert Conversations
//   Future<void> fetchExpertConversations() async {
//     try {
//       isLoading.value = true;
//       debugPrint('🔐 Fetching expert conversations');

//       final response = await _chatService.getExpertConversations();

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

//   // Create Conversation
//   Future<String?> createConversation({required String linkId}) async {
//     try {
//       isCreatingConversation.value = true;
//       debugPrint('🔐 Creating conversation for link: $linkId');

//       final response = await _chatService.createConversation(linkId: linkId);

//       if (response.status) {
//         debugPrint('✅ Conversation created: ${response.data.conversationId}');
//         _showSuccess('Conversation created successfully');
        
//         // Refresh conversations list
//         await fetchExpertConversations();
        
//         return response.data.conversationId;
//       } else {
//         _showError(response.message);
//         return null;
//       }
//     } catch (e) {
//       debugPrint('❌ Error creating conversation: $e');
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return null;
//     } finally {
//       isCreatingConversation.value = false;
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
//   List<ExpertConversationItem> get filteredConversations {
//     if (searchController.text.isEmpty) {
//       return conversations;
//     }

//     final query = searchController.text.toLowerCase();
//     return conversations.where((conversation) {
//       final childName =
//           conversation.expertChildLinks.children.childName.toLowerCase();
//       return childName.contains(query);
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

// lib/controllers/expert_chat_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/chat_model.dart';
import 'package:speechspectrum/services/chat_service.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ExpertChatController extends GetxController {
  final ChatService _chatService = ChatService();

  var isLoading = false.obs;
  var isCreatingConversation = false.obs;
  var isSendingMessage = false.obs;
  var conversations = <ExpertConversationItem>[].obs;
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

  // Fetch Expert Conversations
  Future<void> fetchExpertConversations() async {
    try {
      isLoading.value = true;
      debugPrint('🔐 Fetching expert conversations');

      final response = await _chatService.getExpertConversations();

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

  // Create Conversation
  Future<String?> createConversation({required String linkId}) async {
    try {
      isCreatingConversation.value = true;
      debugPrint('🔐 Creating conversation for link: $linkId');

      final response = await _chatService.createConversation(linkId: linkId);

      if (response.status) {
        debugPrint('✅ Conversation created: ${response.data.conversationId}');
        _showSuccess('Conversation created successfully');
        
        // Refresh conversations list
        await fetchExpertConversations();
        
        return response.data.conversationId;
      } else {
        _showError(response.message);
        return null;
      }
    } catch (e) {
      debugPrint('❌ Error creating conversation: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
      return null;
    } finally {
      isCreatingConversation.value = false;
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
  List<ExpertConversationItem> get filteredConversations {
    if (searchController.text.isEmpty) {
      return conversations;
    }

    final query = searchController.text.toLowerCase();
    return conversations.where((conversation) {
      final childName =
          conversation.expertChildLinks.children.childName.toLowerCase();
      return childName.contains(query);
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