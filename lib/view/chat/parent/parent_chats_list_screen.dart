// lib/view/parent/parent_chats_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/parent_chat_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ParentChatsListScreen extends StatefulWidget {
  const ParentChatsListScreen({super.key});

  @override
  State<ParentChatsListScreen> createState() => _ParentChatsListScreenState();
}

class _ParentChatsListScreenState extends State<ParentChatsListScreen> {
  late final ParentChatController controller;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<ParentChatController>()) {
      controller = Get.find<ParentChatController>();
    } else {
      controller = Get.put(ParentChatController());
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchParentConversations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Column(
        children: [
          // Custom App Bar with Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.primaryColor,
                  AppColors.accentColor,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.whiteColor,
                            size: size.customWidth(context) * 0.06,
                          ),
                        ),
                        Text(
                          'Messages',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.05,
                            fontWeight: FontWeight.w600,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () => controller.fetchParentConversations(),
                          icon: Icon(
                            Icons.refresh,
                            color: AppColors.whiteColor,
                            size: size.customWidth(context) * 0.06,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.customHeight(context) * 0.02),

                    // Search Bar
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: size.customWidth(context) * 0.04,
                        vertical: size.customHeight(context) * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: AppColors.greyColor,
                            size: size.customWidth(context) * 0.05,
                          ),
                          SizedBox(width: size.customWidth(context) * 0.025),
                          Expanded(
                            child: TextField(
                              controller: controller.searchController,
                              onChanged: (value) => setState(() {}),
                              decoration: InputDecoration(
                                hintText: 'Search conversations',
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.038,
                                  color: AppColors.greyColor,
                                ),
                                border: InputBorder.none,
                              ),
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.038,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Conversations List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: size.customHeight(context) * 0.02),
                      Text(
                        'Loading conversations...',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontSize: size.customWidth(context) * 0.035,
                        ),
                      ),
                    ],
                  ),
                );
              }

              final conversations = controller.filteredConversations;

              if (conversations.isEmpty) {
                return _buildEmptyState(context);
              }

              return RefreshIndicator(
                onRefresh: () => controller.fetchParentConversations(),
                color: AppColors.primaryColor,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: size.customHeight(context) * 0.01,
                  ),
                  itemCount: conversations.length,
                  itemBuilder: (context, index) {
                    final conversation = conversations[index];
                    return _buildConversationItem(context, conversation);
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildConversationItem(BuildContext context, conversation) {
    final size = CustomSize();

    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.parentChatConversation,
          arguments: {
            'conversationId': conversation.conversationId,
            'expertName': conversation.expertChildLinks.expertUsers.fullName,
            'childName': conversation.expertChildLinks.children.childName,
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: size.customWidth(context) * 0.04,
          vertical: size.customHeight(context) * 0.015,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.greyColor.withOpacity(0.1),
            ),
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: size.customWidth(context) * 0.14,
              height: size.customWidth(context) * 0.14,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.8),
                    AppColors.primaryColor,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  conversation.expertChildLinks.expertUsers.getInitials(),
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: size.customWidth(context) * 0.045,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(width: size.customWidth(context) * 0.03),

            // Conversation Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    conversation.expertChildLinks.expertUsers.fullName,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.042,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: size.customHeight(context) * 0.004),
                  Row(
                    children: [
                      Icon(
                        Icons.child_care,
                        size: 14,
                        color: AppColors.accentColor,
                      ),
                      SizedBox(width: size.customWidth(context) * 0.015),
                      Text(
                        conversation.expertChildLinks.children.childName,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.034,
                          fontWeight: FontWeight.w500,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.customHeight(context) * 0.002),
                  Text(
                    conversation.expertChildLinks.expertUsers.specialization,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.03,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Time & Badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  conversation.getFormattedTime(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.03,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                SizedBox(height: size.customHeight(context) * 0.005),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = CustomSize();

    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline,
                size: 60,
                color: AppColors.primaryColor.withOpacity(0.5),
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              'No Conversations Yet',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.05,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.01),
            Text(
              'Your expert will start a\nconversation with you',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.038,
                color: AppColors.textSecondaryColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}