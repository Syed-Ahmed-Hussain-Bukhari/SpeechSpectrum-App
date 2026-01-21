// lib/view/children/child_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/controllers/child_controller.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:intl/intl.dart';

class ChildDetailsScreen extends StatelessWidget {
  const ChildDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get controller safely
    final controller = Get.isRegistered<ChildController>()
        ? Get.find<ChildController>()
        : Get.put(ChildController());
        
    final ChildData child = Get.arguments as ChildData;

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Child Header
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
            pinned: true,
            elevation: 0,
            backgroundColor: child.gender.toLowerCase() == 'male' 
                ? Colors.blue 
                : Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildChildHeader(context, child),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_rounded, color: AppColors.whiteColor),
                onPressed: () => Get.toNamed(
                  AppRoutes.editChild,
                  arguments: child,
                ),
                tooltip: 'Edit Profile',
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: AppColors.whiteColor),
                onPressed: () => _showDeleteDialog(context, controller, child),
                tooltip: 'Delete Profile',
              ),
            ],
          ),

          // Child Information
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info Card
                  _buildInfoCard(context, child),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                  // Quick Actions
                  Text(
                    'Quick Actions',
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                  _buildActionButton(
                    context: context,
                    icon: Icons.assessment_rounded,
                    title: 'Start Screening',
                    subtitle: 'Begin a new speech screening',
                    color: AppColors.primaryColor,
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Speech screening feature will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.primaryColor,
                        colorText: AppColors.whiteColor,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                  ),

                  _buildActionButton(
                    context: context,
                    icon: Icons.history_rounded,
                    title: 'View History',
                    subtitle: 'See past screening results',
                    color: AppColors.secondaryColor,
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'History feature will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.secondaryColor,
                        colorText: AppColors.whiteColor,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                  ),

                  _buildActionButton(
                    context: context,
                    icon: Icons.schedule_rounded,
                    title: 'Schedule Appointment',
                    subtitle: 'Book session with an expert',
                    color: AppColors.accentColor,
                    onTap: () {
                      Get.snackbar(
                        'Coming Soon',
                        'Appointment scheduling will be available soon',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.accentColor,
                        colorText: AppColors.whiteColor,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildHeader(BuildContext context, ChildData child) {
    final color = child.gender.toLowerCase() == 'male' ? Colors.blue : Colors.pink;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.shade400, color.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),

            // Child Avatar
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  width: 5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                child.gender.toLowerCase() == 'male' ? Icons.boy : Icons.girl,
                size: 65,
                color: color,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.02),

            // Name
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Text(
                child.childName,
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.01),

            // Age Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.008,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.25),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Text(
                '${child.getAge()} Years Old',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, ChildData child) {
    return Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.045),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile Information',
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.width * 0.045,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          _buildInfoRow(
            context: context,
            icon: Icons.person_outline_rounded,
            label: 'Full Name',
            value: child.childName,
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Divider(color: AppColors.greyColor.withOpacity(0.2)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildInfoRow(
            context: context,
            icon: Icons.cake_outlined,
            label: 'Date of Birth',
            value: child.getFormattedDate(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Divider(color: AppColors.greyColor.withOpacity(0.2)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildInfoRow(
            context: context,
            icon: Icons.wc_outlined,
            label: 'Gender',
            value: child.getGenderDisplay(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Divider(color: AppColors.greyColor.withOpacity(0.2)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildInfoRow(
            context: context,
            icon: Icons.calendar_today_outlined,
            label: 'Age',
            value: '${child.getAge()} years old',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          Divider(color: AppColors.greyColor.withOpacity(0.2)),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
          _buildInfoRow(
            context: context,
            icon: Icons.access_time_rounded,
            label: 'Profile Created',
            value: _formatCreatedDate(child.createdAt),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor.withOpacity(0.1),
                AppColors.secondaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 24,
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.035),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.032,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.008,
        ),
        leading: Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.8), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: AppColors.whiteColor,
            size: 30,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: MediaQuery.of(context).size.width * 0.042,
            color: AppColors.textPrimaryColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: MediaQuery.of(context).size.width * 0.033,
            color: AppColors.textSecondaryColor,
            height: 1.4,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: AppColors.greyColor,
        ),
      ),
    );
  }

  String _formatCreatedDate(String createdAt) {
    try {
      final date = DateTime.parse(createdAt);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return 'Unknown';
    }
  }

  void _showDeleteDialog(BuildContext context, ChildController controller, ChildData child) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.errorColor,
                  size: 45,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Text(
                'Delete Child Profile',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text(
                'Are you sure you want to delete ${child.childName}\'s profile?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'This action cannot be undone.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.034,
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.015,
                        ),
                        side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isDeleting.value
                              ? null
                              : () {
                                  controller.deleteChild(child.childId).then((_) {
                                    Get.back(); // Close dialog
                                    Get.back(); // Close details screen
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isDeleting.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Delete',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}