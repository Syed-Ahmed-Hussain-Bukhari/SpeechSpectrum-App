// // lib/view/expert/expert_chat_conversation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_chat_controller.dart';

// class ExpertChatConversationScreen extends StatefulWidget {
//   const ExpertChatConversationScreen({super.key});

//   @override
//   State<ExpertChatConversationScreen> createState() =>
//       _ExpertChatConversationScreenState();
// }

// class _ExpertChatConversationScreenState
//     extends State<ExpertChatConversationScreen> {
//   late final ExpertChatController controller;
//   final ScrollController _scrollController = ScrollController();
//   String? conversationId;
//   String? childName;

//   @override
//   void initState() {
//     super.initState();

//     if (Get.isRegistered<ExpertChatController>()) {
//       controller = Get.find<ExpertChatController>();
//     } else {
//       controller = Get.put(ExpertChatController());
//     }

//     final args = Get.arguments;
//     if (args != null && args is Map<String, dynamic>) {
//       conversationId = args['conversationId'] as String?;
//       childName = args['childName'] as String?;
//     }

//     if (conversationId != null && conversationId!.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.fetchConversationDetails(
//           conversationId: conversationId!,
//         );
//         controller.fetchMessages(conversationId: conversationId!);
//       });
//     }
//   }

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     if (conversationId == null || conversationId!.isEmpty) {
//       return Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.whiteColor,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//             onPressed: () => Get.back(),
//           ),
//           title: Text(
//             'Chat',
//             style: GoogleFonts.poppins(
//               color: AppColors.textPrimaryColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: Center(
//           child: Text(
//             'No conversation selected',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Obx(() {
//           final details = controller.conversationDetails.value;
//           final displayName = details != null
//               ? details.data.expertChildLinks.children.childName
//               : (childName ?? 'Chat');

//           return Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.accentColor.withOpacity(0.8),
//                       AppColors.accentColor,
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     displayName.isNotEmpty
//                         ? displayName[0].toUpperCase()
//                         : 'C',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: size.customWidth(context) * 0.025),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     displayName,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.042,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 8,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: AppColors.successColor,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.015),
//                       Text(
//                         'Online',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.successColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           );
//         }),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () {
//               controller.fetchMessages(conversationId: conversationId!);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Messages List
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value &&
//                   controller.messages.isEmpty) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryColor,
//                     strokeWidth: 3,
//                   ),
//                 );
//               }

//               if (controller.messages.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.chat_bubble_outline,
//                         size: 60,
//                         color: AppColors.greyColor.withOpacity(0.3),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.02),
//                       Text(
//                         'No messages yet',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.045,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.01),
//                       Text(
//                         'Start the conversation!',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.035,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.greyColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               // Group messages by date
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 _scrollToBottom();
//               });

//               return ListView.builder(
//                 controller: _scrollController,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.04,
//                   vertical: size.customHeight(context) * 0.02,
//                 ),
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = controller.messages[index];
//                   final isMyMessage = controller.isMyMessage(message.senderId);

//                   // Show date divider if this is the first message or date changed
//                   bool showDateDivider = false;
//                   if (index == 0) {
//                     showDateDivider = true;
//                   } else {
//                     final prevMessage = controller.messages[index - 1];
//                     if (message.getFormattedDate() !=
//                         prevMessage.getFormattedDate()) {
//                       showDateDivider = true;
//                     }
//                   }

//                   return Column(
//                     children: [
//                       if (showDateDivider)
//                         _buildDateDivider(context, message.getFormattedDate()),
//                       SizedBox(height: size.customHeight(context) * 0.015),
//                       isMyMessage
//                           ? _buildSentMessage(context, message)
//                           : _buildReceivedMessage(context, message),
//                     ],
//                   );
//                 },
//               );
//             }),
//           ),

//           // Message Input
//           Container(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: Offset(0, -5),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: size.customWidth(context) * 0.04,
//                       vertical: size.customHeight(context) * 0.01,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGreyColor,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: TextField(
//                       controller: controller.messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           color: AppColors.greyColor,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.038,
//                         color: AppColors.textPrimaryColor,
//                       ),
//                       maxLines: null,
//                       textInputAction: TextInputAction.newline,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.025),
//                 Obx(() => GestureDetector(
//                       onTap: controller.isSendingMessage.value
//                           ? null
//                           : () {
//                               controller.sendMessage(
//                                 conversationId: conversationId!,
//                               );
//                               Future.delayed(
//                                   Duration(milliseconds: 100), _scrollToBottom);
//                             },
//                       child: Container(
//                         padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.primaryColor,
//                               AppColors.accentColor,
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: controller.isSendingMessage.value
//                             ? SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: AppColors.whiteColor,
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : Icon(
//                                 Icons.send,
//                                 color: AppColors.whiteColor,
//                                 size: size.customWidth(context) * 0.05,
//                               ),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateDivider(BuildContext context, String date) {
//     final size = CustomSize();

//     return Center(
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           vertical: size.customHeight(context) * 0.015,
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: size.customWidth(context) * 0.04,
//           vertical: size.customHeight(context) * 0.008,
//         ),
//         decoration: BoxDecoration(
//           color: AppColors.greyColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           date,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.03,
//             color: AppColors.greyColor,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildReceivedMessage(BuildContext context, message) {
//     final size = CustomSize();

//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: size.customWidth(context) * 0.75,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               decoration: BoxDecoration(
//                 color: AppColors.lightGreyColor,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Text(
//                 message.messageText,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.005),
//             Padding(
//               padding: EdgeInsets.only(left: size.customWidth(context) * 0.02),
//               child: Text(
//                 message.getFormattedTime(),
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.028,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.greyColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSentMessage(BuildContext context, message) {
//     final size = CustomSize();

//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: size.customWidth(context) * 0.75,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor,
//                     AppColors.accentColor,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Text(
//                 message.messageText,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.005),
//             Padding(
//               padding: EdgeInsets.only(right: size.customWidth(context) * 0.02),
//               child: Text(
//                 message.getFormattedTime(),
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.028,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.greyColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }


// // lib/view/expert/expert_chat_conversation_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_chat_controller.dart';

// class ExpertChatConversationScreen extends StatefulWidget {
//   const ExpertChatConversationScreen({super.key});

//   @override
//   State<ExpertChatConversationScreen> createState() =>
//       _ExpertChatConversationScreenState();
// }

// class _ExpertChatConversationScreenState
//     extends State<ExpertChatConversationScreen> {
//   late final ExpertChatController controller;
//   final ScrollController _scrollController = ScrollController();
//   String? conversationId;
//   String? childName;

//   @override
//   void initState() {
//     super.initState();

//     if (Get.isRegistered<ExpertChatController>()) {
//       controller = Get.find<ExpertChatController>();
//     } else {
//       controller = Get.put(ExpertChatController());
//     }

//     final args = Get.arguments;
//     if (args != null && args is Map<String, dynamic>) {
//       conversationId = args['conversationId'] as String?;
//       childName = args['childName'] as String?;
//     }

//     if (conversationId != null && conversationId!.isNotEmpty) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         controller.fetchConversationDetails(
//           conversationId: conversationId!,
//         );
//         controller.fetchMessages(conversationId: conversationId!).then((_) {
//           // Scroll to bottom after messages are loaded
//           _scrollToBottomInstantly();
//         });
//       });
//     }

//     // Listen to messages changes and auto-scroll
//     ever(controller.messages, (_) {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollToBottomInstantly();
//       });
//     });
//   }

//   void _scrollToBottomInstantly() {
//     if (_scrollController.hasClients) {
//       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//     }
//   }

//   void _scrollToBottomAnimated() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     if (conversationId == null || conversationId!.isEmpty) {
//       return Scaffold(
//         backgroundColor: AppColors.whiteColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.whiteColor,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//             onPressed: () => Get.back(),
//           ),
//           title: Text(
//             'Chat',
//             style: GoogleFonts.poppins(
//               color: AppColors.textPrimaryColor,
//               fontSize: 18,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//         body: Center(
//           child: Text(
//             'No conversation selected',
//             style: GoogleFonts.poppins(
//               color: AppColors.textSecondaryColor,
//             ),
//           ),
//         ),
//       );
//     }

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Obx(() {
//           final details = controller.conversationDetails.value;
//           final displayName = details != null
//               ? details.data.expertChildLinks.children.childName
//               : (childName ?? 'Chat');

//           return Row(
//             children: [
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.accentColor.withOpacity(0.8),
//                       AppColors.accentColor,
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     displayName.isNotEmpty
//                         ? displayName[0].toUpperCase()
//                         : 'C',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: size.customWidth(context) * 0.025),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     displayName,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.042,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.textPrimaryColor,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Container(
//                         width: 8,
//                         height: 8,
//                         decoration: BoxDecoration(
//                           color: AppColors.successColor,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       SizedBox(width: size.customWidth(context) * 0.015),
//                       Text(
//                         'Online',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.successColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           );
//         }),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () {
//               controller.fetchMessages(conversationId: conversationId!);
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // Messages List
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value &&
//                   controller.messages.isEmpty) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: AppColors.primaryColor,
//                     strokeWidth: 3,
//                   ),
//                 );
//               }

//               if (controller.messages.isEmpty) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.chat_bubble_outline,
//                         size: 60,
//                         color: AppColors.greyColor.withOpacity(0.3),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.02),
//                       Text(
//                         'No messages yet',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.045,
//                           fontWeight: FontWeight.w500,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.01),
//                       Text(
//                         'Start the conversation!',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.035,
//                           fontWeight: FontWeight.w400,
//                           color: AppColors.greyColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return ListView.builder(
//                 controller: _scrollController,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.customWidth(context) * 0.04,
//                   vertical: size.customHeight(context) * 0.02,
//                 ),
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = controller.messages[index];
//                   final isMyMessage = controller.isMyMessage(message.senderId);

//                   // Show date divider if this is the first message or date changed
//                   bool showDateDivider = false;
//                   if (index == 0) {
//                     showDateDivider = true;
//                   } else {
//                     final prevMessage = controller.messages[index - 1];
//                     if (message.getFormattedDate() !=
//                         prevMessage.getFormattedDate()) {
//                       showDateDivider = true;
//                     }
//                   }

//                   return Column(
//                     children: [
//                       if (showDateDivider)
//                         _buildDateDivider(context, message.getFormattedDate()),
//                       SizedBox(height: size.customHeight(context) * 0.015),
//                       isMyMessage
//                           ? _buildSentMessage(context, message)
//                           : _buildReceivedMessage(context, message),
//                     ],
//                   );
//                 },
//               );
//             }),
//           ),

//           // Message Input
//           Container(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             decoration: BoxDecoration(
//               color: AppColors.whiteColor,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.05),
//                   blurRadius: 10,
//                   offset: Offset(0, -5),
//                 ),
//               ],
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: size.customWidth(context) * 0.04,
//                       vertical: size.customHeight(context) * 0.01,
//                     ),
//                     decoration: BoxDecoration(
//                       color: AppColors.lightGreyColor,
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: TextField(
//                       controller: controller.messageController,
//                       decoration: InputDecoration(
//                         hintText: 'Type a message',
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           color: AppColors.greyColor,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.038,
//                         color: AppColors.textPrimaryColor,
//                       ),
//                       maxLines: null,
//                       textInputAction: TextInputAction.newline,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.025),
//                 Obx(() => GestureDetector(
//                       onTap: controller.isSendingMessage.value
//                           ? null
//                           : () async {
//                               await controller.sendMessage(
//                                 conversationId: conversationId!,
//                               );
//                               // Scroll to bottom after sending
//                               Future.delayed(
//                                 Duration(milliseconds: 100),
//                                 _scrollToBottomAnimated,
//                               );
//                             },
//                       child: Container(
//                         padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [
//                               AppColors.primaryColor,
//                               AppColors.accentColor,
//                             ],
//                           ),
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: controller.isSendingMessage.value
//                             ? SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(
//                                   color: AppColors.whiteColor,
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                             : Icon(
//                                 Icons.send,
//                                 color: AppColors.whiteColor,
//                                 size: size.customWidth(context) * 0.05,
//                               ),
//                       ),
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDateDivider(BuildContext context, String date) {
//     final size = CustomSize();

//     return Center(
//       child: Container(
//         margin: EdgeInsets.symmetric(
//           vertical: size.customHeight(context) * 0.015,
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: size.customWidth(context) * 0.04,
//           vertical: size.customHeight(context) * 0.008,
//         ),
//         decoration: BoxDecoration(
//           color: AppColors.greyColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Text(
//           date,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.03,
//             color: AppColors.greyColor,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildReceivedMessage(BuildContext context, message) {
//     final size = CustomSize();

//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: size.customWidth(context) * 0.75,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               decoration: BoxDecoration(
//                 color: AppColors.lightGreyColor,
//                 borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Text(
//                 message.messageText,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.005),
//             Padding(
//               padding: EdgeInsets.only(left: size.customWidth(context) * 0.02),
//               child: Text(
//                 message.getFormattedTime(),
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.028,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.greyColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSentMessage(BuildContext context, message) {
//     final size = CustomSize();

//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         constraints: BoxConstraints(
//           maxWidth: size.customWidth(context) * 0.75,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor,
//                     AppColors.accentColor,
//                   ],
//                 ),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   bottomLeft: Radius.circular(16),
//                   bottomRight: Radius.circular(16),
//                 ),
//               ),
//               child: Text(
//                 message.messageText,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.005),
//             Padding(
//               padding: EdgeInsets.only(right: size.customWidth(context) * 0.02),
//               child: Text(
//                 message.getFormattedTime(),
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.028,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.greyColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }


// lib/view/expert/expert_chat_conversation_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_chat_controller.dart';

class ExpertChatConversationScreen extends StatefulWidget {
  const ExpertChatConversationScreen({super.key});

  @override
  State<ExpertChatConversationScreen> createState() =>
      _ExpertChatConversationScreenState();
}

class _ExpertChatConversationScreenState
    extends State<ExpertChatConversationScreen> {
  late final ExpertChatController controller;
  final ScrollController _scrollController = ScrollController();
  String? conversationId;
  String? childName;
  Worker? _messagesWorker; // ✅ Store the worker to dispose it properly

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<ExpertChatController>()) {
      controller = Get.find<ExpertChatController>();
    } else {
      controller = Get.put(ExpertChatController());
    }

    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      conversationId = args['conversationId'] as String?;
      childName = args['childName'] as String?;
    }

    if (conversationId != null && conversationId!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchConversationDetails(
          conversationId: conversationId!,
        );
        controller.fetchMessages(conversationId: conversationId!).then((_) {
          _scrollToBottomInstantly();
        });
      });
    }

    // ✅ FIX: Store worker and only run when widget is mounted
    _messagesWorker = ever(controller.messages, (_) {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _scrollToBottomInstantly();
          }
        });
      }
    });
  }

  void _scrollToBottomInstantly() {
    if (_scrollController.hasClients && mounted) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
  }

  void _scrollToBottomAnimated() {
    if (_scrollController.hasClients && mounted) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    if (conversationId == null || conversationId!.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Chat',
            style: GoogleFonts.poppins(
              color: AppColors.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Center(
          child: Text(
            'No conversation selected',
            style: GoogleFonts.poppins(
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Obx(() {
          final details = controller.conversationDetails.value;
          final displayName = details != null
              ? details.data.expertChildLinks.children.childName
              : (childName ?? 'Chat');

          return Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentColor.withOpacity(0.8),
                      AppColors.accentColor,
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    displayName.isNotEmpty
                        ? displayName[0].toUpperCase()
                        : 'C',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: size.customWidth(context) * 0.025),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.042,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: AppColors.successColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: size.customWidth(context) * 0.015),
                      Text(
                        'Online',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.03,
                          fontWeight: FontWeight.w400,
                          color: AppColors.successColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () {
              controller.fetchMessages(conversationId: conversationId!);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.messages.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 3,
                  ),
                );
              }

              if (controller.messages.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 60,
                        color: AppColors.greyColor.withOpacity(0.3),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.02),
                      Text(
                        'No messages yet',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.045,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.01),
                      Text(
                        'Start the conversation!',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.035,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.04,
                  vertical: size.customHeight(context) * 0.02,
                ),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];
                  final isMyMessage = controller.isMyMessage(message.senderId);

                  // Show date divider if this is the first message or date changed
                  bool showDateDivider = false;
                  if (index == 0) {
                    showDateDivider = true;
                  } else {
                    final prevMessage = controller.messages[index - 1];
                    if (message.getFormattedDate() !=
                        prevMessage.getFormattedDate()) {
                      showDateDivider = true;
                    }
                  }

                  return Column(
                    children: [
                      if (showDateDivider)
                        _buildDateDivider(context, message.getFormattedDate()),
                      SizedBox(height: size.customHeight(context) * 0.015),
                      isMyMessage
                          ? _buildSentMessage(context, message)
                          : _buildReceivedMessage(context, message),
                    ],
                  );
                },
              );
            }),
          ),

          // Message Input
          Container(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.customWidth(context) * 0.04,
                      vertical: size.customHeight(context) * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreyColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: controller.messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message',
                        hintStyle: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.038,
                          color: AppColors.greyColor,
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.038,
                        color: AppColors.textPrimaryColor,
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.025),
                Obx(() => GestureDetector(
                      onTap: controller.isSendingMessage.value
                          ? null
                          : () async {
                              await controller.sendMessage(
                                conversationId: conversationId!,
                              );
                              Future.delayed(
                                Duration(milliseconds: 100),
                                _scrollToBottomAnimated,
                              );
                            },
                      child: Container(
                        padding: EdgeInsets.all(size.customWidth(context) * 0.035),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primaryColor,
                              AppColors.accentColor,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: controller.isSendingMessage.value
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: AppColors.whiteColor,
                                  strokeWidth: 2,
                                ),
                              )
                            : Icon(
                                Icons.send,
                                color: AppColors.whiteColor,
                                size: size.customWidth(context) * 0.05,
                              ),
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateDivider(BuildContext context, String date) {
    final size = CustomSize();

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: size.customHeight(context) * 0.015,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: size.customWidth(context) * 0.04,
          vertical: size.customHeight(context) * 0.008,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.03,
            color: AppColors.greyColor,
          ),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, message) {
    final size = CustomSize();

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.customWidth(context) * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                message.messageText,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.005),
            Padding(
              padding: EdgeInsets.only(left: size.customWidth(context) * 0.02),
              child: Text(
                message.getFormattedTime(),
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.028,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, message) {
    final size = CustomSize();

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: size.customWidth(context) * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor,
                    AppColors.accentColor,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                message.messageText,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  fontWeight: FontWeight.w400,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.005),
            Padding(
              padding: EdgeInsets.only(right: size.customWidth(context) * 0.02),
              child: Text(
                message.getFormattedTime(),
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.028,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // ✅ FIX: Properly dispose the worker to prevent memory leaks
    _messagesWorker?.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}