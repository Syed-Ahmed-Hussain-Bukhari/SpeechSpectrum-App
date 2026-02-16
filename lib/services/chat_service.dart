// // lib/services/chat_service.dart
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:speechspectrum/models/chat_model.dart';
// import 'package:speechspectrum/routes/app_urls.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class ChatService {
//   final Dio _dio = Dio();

//   // Create Conversation (Expert only)
//   Future<CreateConversationModel> createConversation({
//     required String linkId,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Creating conversation for link: $linkId');

//       final response = await _dio.post(
//         '${APIEndPoints.baseUrl}/chat/create',
//         data: {'link_id': linkId},
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Conversation created successfully');
//       return CreateConversationModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Create conversation error: ${e.message}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to create conversation',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get Expert Conversations
//   Future<ExpertConversationsModel> getExpertConversations() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching expert conversations');

//       final response = await _dio.get(
//         '${APIEndPoints.baseUrl}/chat/expert',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Expert conversations fetched successfully');
//       return ExpertConversationsModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch expert conversations error: ${e.message}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch conversations',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get Parent Conversations
//   Future<ParentConversationsModel> getParentConversations() async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching parent conversations');

//       final response = await _dio.get(
//         '${APIEndPoints.baseUrl}/chat/parent',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Parent conversations fetched successfully');
//       return ParentConversationsModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch parent conversations error: ${e.message}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch conversations',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get Conversation Details
//   Future<ConversationDetailsModel> getConversationDetails({
//     required String conversationId,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching conversation details: $conversationId');

//       final response = await _dio.get(
//         '${APIEndPoints.baseUrl}/chat/$conversationId',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Conversation details fetched successfully');
//       return ConversationDetailsModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch conversation details error: ${e.message}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch conversation details',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Send Message
//   Future<SendMessageModel> sendMessage({
//     required String conversationId,
//     required String messageText,
//     String messageType = 'text',
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Sending message to conversation: $conversationId');

//       final response = await _dio.post(
//         '${APIEndPoints.baseUrl}/chat/$conversationId/message',
//         data: {
//           'message_text': messageText,
//           'message_type': messageType,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Message sent successfully');
//       return SendMessageModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Send message error: ${e.message}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to send message',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }

//   // Get Messages
//   Future<MessagesListModel> getMessages({
//     required String conversationId,
//     int page = 1,
//     int limit = 50,
//   }) async {
//     try {
//       final token = await SharedPreferencesService.getAccessToken();

//       if (token == null || token.isEmpty) {
//         throw Exception('No authentication token found');
//       }

//       debugPrint('🔐 Fetching messages for conversation: $conversationId');

//       final response = await _dio.get(
//         '${APIEndPoints.baseUrl}/chat/$conversationId/messages',
//         queryParameters: {
//           'page': page,
//           'limit': limit,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         ),
//       );

//       debugPrint('✅ Messages fetched successfully');
//       return MessagesListModel.fromJson(response.data);
//     } on DioException catch (e) {
//       debugPrint('❌ Fetch messages error: ${e.message}');
//       if (e.response?.statusCode == 401) {
//         throw Exception('Unauthorized - Please login again');
//       }
//       if (e.response?.statusCode == 403) {
//         throw Exception('Access denied to this conversation');
//       }
//       throw Exception(
//         e.response?.data['message'] ?? 'Failed to fetch messages',
//       );
//     } catch (e) {
//       debugPrint('❌ Unexpected error: $e');
//       throw Exception('An unexpected error occurred');
//     }
//   }
// }

// lib/services/chat_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/chat_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class ChatService {
  final Dio _dio = Dio();

  // Create Conversation (Expert only)
  Future<CreateConversationModel> createConversation({
    required String linkId,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Creating conversation for link: $linkId');

      final response = await _dio.post(
        APIEndPoints.createChat,
        data: {'link_id': linkId},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Conversation created successfully');
      return CreateConversationModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create conversation error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Failed to create conversation',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Expert Conversations
  Future<ExpertConversationsModel> getExpertConversations() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching expert conversations');

      final response = await _dio.get(
        APIEndPoints.expertChats,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Expert conversations fetched successfully');
      return ExpertConversationsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch expert conversations error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch conversations',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Parent Conversations
  Future<ParentConversationsModel> getParentConversations() async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching parent conversations');

      final response = await _dio.get(
        APIEndPoints.parentChats,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Parent conversations fetched successfully');
      return ParentConversationsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch parent conversations error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch conversations',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Conversation Details
  Future<ConversationDetailsModel> getConversationDetails({
    required String conversationId,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching conversation details: $conversationId');

      final response = await _dio.get(
        '${APIEndPoints.chatBase}/$conversationId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Conversation details fetched successfully');
      return ConversationDetailsModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch conversation details error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch conversation details',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Send Message
  Future<SendMessageModel> sendMessage({
    required String conversationId,
    required String messageText,
    String messageType = 'text',
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Sending message to conversation: $conversationId');

      final response = await _dio.post(
        '${APIEndPoints.chatBase}/$conversationId/message',
        data: {
          'message_text': messageText,
          'message_type': messageType,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Message sent successfully');
      return SendMessageModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Send message error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Failed to send message',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  // Get Messages
  Future<MessagesListModel> getMessages({
    required String conversationId,
    int page = 1,
    int limit = 50,
  }) async {
    try {
      final token = await SharedPreferencesService.getAccessToken();

      if (token == null || token.isEmpty) {
        throw Exception('No authentication token found');
      }

      debugPrint('🔐 Fetching messages for conversation: $conversationId');

      final response = await _dio.get(
        '${APIEndPoints.chatBase}/$conversationId/messages',
        queryParameters: {
          'page': page,
          'limit': limit,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      debugPrint('✅ Messages fetched successfully');
      return MessagesListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Fetch messages error: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Unauthorized - Please login again');
      }
      if (e.response?.statusCode == 403) {
        throw Exception('Access denied to this conversation');
      }
      throw Exception(
        e.response?.data['message'] ?? 'Failed to fetch messages',
      );
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw Exception('An unexpected error occurred');
    }
  }
}