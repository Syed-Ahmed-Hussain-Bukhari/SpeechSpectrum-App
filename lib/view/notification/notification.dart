import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Mark all read',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.02),
        children: [
          // Today Section
          _buildSectionHeader(context, 'Today'),
          _buildNotificationItem(
            context,
            Icons.article_outlined,
            'New Article Available',
            'Check out our latest guide on "Communication Strategies for Children with Autism"',
            '2 hours ago',
            true,
            AppColors.primaryColor,
            () {},
          ),
          _buildNotificationItem(
            context,
            Icons.assignment_turned_in_outlined,
            'Screening Reminder',
            'It\'s time to complete your child\'s monthly developmental screening assessment.',
            '5 hours ago',
            true,
            AppColors.accentColor,
            () {},
          ),
          
          // Yesterday Section
          _buildSectionHeader(context, 'Yesterday'),
          _buildNotificationItem(
            context,
            Icons.celebration_outlined,
            'Milestone Achievement',
            'Congratulations! Your child has reached a new developmental milestone in social interaction.',
            'Yesterday, 3:45 PM',
            false,
            AppColors.successColor,
            () {},
          ),
          _buildNotificationItem(
            context,
            Icons.event_outlined,
            'Appointment Reminder',
            'You have a scheduled consultation with Dr. Sarah Johnson tomorrow at 10:00 AM.',
            'Yesterday, 2:30 PM',
            false,
            AppColors.warningColor,
            () {},
          ),
          
          // This Week Section
          _buildSectionHeader(context, 'This Week'),
          _buildNotificationItem(
            context,
            Icons.tips_and_updates_outlined,
            'Daily Tip',
            'Try incorporating visual schedules to help your child understand daily routines and transitions.',
            '2 days ago',
            false,
            AppColors.primaryColor,
            () {},
          ),
          _buildNotificationItem(
            context,
            Icons.groups_outlined,
            'Support Group Session',
            'Join our weekly parent support group session this Saturday at 4:00 PM. Share experiences and learn together.',
            '3 days ago',
            false,
            AppColors.successColor,
            () {},
          ),
          _buildNotificationItem(
            context,
            Icons.stars_outlined,
            'App Update Available',
            'New features added: Voice analysis improvements and enhanced reporting. Update now for better experience.',
            '4 days ago',
            false,
            AppColors.accentColor,
            () {},
          ),
          
          // Older Section
          _buildSectionHeader(context, 'Older'),
          _buildNotificationItem(
            context,
            Icons.local_hospital_outlined,
            'Specialist Recommendation',
            'Based on your screening results, we recommend consulting with a pediatric specialist. View recommendations.',
            'Last week',
            false,
            AppColors.errorColor,
            () {},
          ),
          _buildNotificationItem(
            context,
            Icons.school_outlined,
            'Educational Resources',
            'New learning materials added to your resource library. Explore activities for cognitive development.',
            '2 weeks ago',
            false,
            AppColors.primaryColor,
            () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final size = CustomSize();
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.customWidth(context) * 0.05,
        size.customHeight(context) * 0.02,
        size.customWidth(context) * 0.05,
        size.customHeight(context) * 0.01,
      ),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.textSecondaryColor,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    String time,
    bool isUnread,
    Color iconColor,
    VoidCallback onTap,
  ) {
    final size = CustomSize();
    
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: size.customWidth(context) * 0.05,
        vertical: size.customHeight(context) * 0.005,
      ),
      decoration: BoxDecoration(
        color: isUnread 
            ? AppColors.primaryColor.withOpacity(0.05)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: isUnread
            ? Border.all(color: AppColors.primaryColor.withOpacity(0.2), width: 1)
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: isUnread ? FontWeight.w600 : FontWeight.w500,
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textSecondaryColor,
                        height: 1.4,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 12,
                          color: AppColors.greyColor,
                        ),
                        SizedBox(width: 4),
                        Text(
                          time,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: AppColors.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}