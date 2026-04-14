// lib/view/expert/profile/expert_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_profile_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertProfileScreen extends StatelessWidget {
  const ExpertProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final controller = Get.find<ExpertProfileController>();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor));
        }

        if (controller.profile == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline,
                    size: 64, color: AppColors.errorColor),
                const SizedBox(height: 16),
                Text('Failed to load profile',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.textSecondaryColor)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.fetchProfile,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor),
                  child: Text('Retry',
                      style: GoogleFonts.poppins(
                          color: AppColors.whiteColor)),
                ),
              ],
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            // Header
            SliverAppBar(
              expandedHeight: size.customHeight(context) * 0.38,
              pinned: true,
              backgroundColor: AppColors.primaryColor,
              surfaceTintColor: Colors.transparent,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background:
                    _buildHeader(context, size, controller),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined,
                      color: Colors.white),
                  onPressed: () =>
                      Get.toNamed(AppRoutes.expertEditProfile),
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
              ],
            ),

            // Body
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    EdgeInsets.all(size.customWidth(context) * 0.05),
                child: Column(
                  children: [
                    // Info card
                    _buildInfoCard(context, size, controller),
                    SizedBox(height: size.customHeight(context) * 0.02),

                    // PMDC badge if available
                    if (controller.pmdcNumber.isNotEmpty) ...[
                      _buildPmdcCard(context, size, controller),
                      SizedBox(
                          height: size.customHeight(context) * 0.02),
                    ],

                    // Options
                    _buildOption(
                      context: context,
                      icon: Icons.calendar_month_rounded,
                      title: 'My Slots',
                      subtitle: 'Manage availability slots',
                      color: AppColors.secondaryColor,
                      onTap: () => Get.toNamed(AppRoutes.expertSlots),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    _buildOption(
                      context: context,
                      icon: Icons.event_note_rounded,
                      title: 'My Appointments',
                      subtitle: 'View all appointments',
                      color: AppColors.accentColor,
                      onTap: () => Get.toNamed(AppRoutes.myAppointments),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    _buildOption(
                      context: context,
                      icon: Icons.location_on_outlined,
                      title: 'My Locations',
                      subtitle: 'Manage clinic locations',
                      color: AppColors.primaryColor,
                      onTap: () =>
                          Get.toNamed(AppRoutes.expertLocations),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    _buildOption(
                      context: context,
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Manage notifications',
                      onTap: () {},
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    _buildOption(
                      context: context,
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      subtitle: 'Get assistance',
                      onTap: () => Get.toNamed(AppRoutes.help),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.015),
                    _buildOption(
                      context: context,
                      icon: Icons.logout,
                      title: 'Logout',
                      subtitle: 'Sign out of your account',
                      isDestructive: true,
                      onTap: () => _showLogoutDialog(context, controller),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.02),
                    Text(
                      'App Version 2.3',
                      style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.032,
                          color: AppColors.textSecondaryColor),
                    ),
                    SizedBox(height: size.customHeight(context) * 0.03),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context, CustomSize size,
      ExpertProfileController ctrl) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.customHeight(context) * 0.04),
            // Avatar
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.whiteColor.withOpacity(0.3), width: 4),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10))
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                ctrl.userInitial,
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              ctrl.fullName,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: size.customWidth(context) * 0.055,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.customHeight(context) * 0.005),
            if (ctrl.specialization.isNotEmpty)
              Text(
                ctrl.specialization,
                style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: size.customWidth(context) * 0.034),
              ),
            SizedBox(height: size.customHeight(context) * 0.01),
            // Approval badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                color: ctrl.isApproved
                    ? AppColors.successColor.withOpacity(0.2)
                    : AppColors.warningColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: AppColors.whiteColor.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    ctrl.isApproved
                        ? Icons.verified_rounded
                        : Icons.hourglass_top_rounded,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ctrl.isApproved ? 'Approved Expert' : 'Pending Approval',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.customWidth(context) * 0.032,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.018),
            ElevatedButton.icon(
              onPressed: () => Get.toNamed(AppRoutes.expertEditProfile),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                foregroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(
                    horizontal: size.customWidth(context) * 0.06,
                    vertical: size.customHeight(context) * 0.012),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
              icon: const Icon(Icons.edit, size: 18),
              label: Text('Edit Profile',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: size.customWidth(context) * 0.038)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, CustomSize size,
      ExpertProfileController ctrl) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          _infoRow(context, size, Icons.phone_outlined, 'Phone', ctrl.phone),
          if (ctrl.contactEmail.isNotEmpty) ...[
            _divider(),
            _infoRow(context, size, Icons.email_outlined, 'Email',
                ctrl.contactEmail),
          ],
          if (ctrl.organization.isNotEmpty) ...[
            _divider(),
            _infoRow(context, size, Icons.business_outlined, 'Organization',
                ctrl.organization),
          ],
          if (ctrl.specialization.isNotEmpty) ...[
            _divider(),
            _infoRow(context, size, Icons.medical_services_outlined,
                'Specialization', ctrl.specialization),
          ],
        ],
      ),
    );
  }

  Widget _buildPmdcCard(BuildContext context, CustomSize size,
      ExpertProfileController ctrl) {
    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.badge_outlined,
                color: AppColors.primaryColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PMDC Number',
                    style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.031,
                        color: AppColors.textSecondaryColor)),
                Text(
                  ctrl.pmdcNumber,
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          const Icon(Icons.verified_rounded,
              color: AppColors.primaryColor, size: 20),
        ],
      ),
    );
  }

  Widget _infoRow(BuildContext context, CustomSize size, IconData icon,
      String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Icon(icon, color: AppColors.primaryColor, size: 20),
        ),
        SizedBox(width: size.customWidth(context) * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.031,
                      color: AppColors.textSecondaryColor)),
              Text(value,
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.038,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimaryColor)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _divider() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Divider(
            height: 1, color: AppColors.greyColor.withOpacity(0.2)),
      );

  Widget _buildOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
    Color? color,
  }) {
    final size = CustomSize();
    final optionColor =
        isDestructive ? AppColors.errorColor : (color ?? AppColors.primaryColor);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2))
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
            horizontal: size.customWidth(context) * 0.04,
            vertical: size.customHeight(context) * 0.005),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
              color: optionColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: optionColor, size: 24),
        ),
        title: Text(title,
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: size.customWidth(context) * 0.04,
                color: isDestructive
                    ? AppColors.errorColor
                    : AppColors.textPrimaryColor)),
        subtitle: Text(subtitle,
            style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.031,
                color: AppColors.textSecondaryColor)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16,
            color: AppColors.greyColor),
      ),
    );
  }

  void _showLogoutDialog(
      BuildContext context, ExpertProfileController ctrl) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Logout',
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
        content: Text('Are you sure you want to logout?',
            style: GoogleFonts.poppins(color: AppColors.textSecondaryColor)),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('Cancel',
                style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontWeight: FontWeight.w600)),
          ),
          Obx(() => ElevatedButton(
                onPressed: ctrl.isLoggingOut.value
                    ? null
                    : () {
                        Get.back();
                        ctrl.logout();
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.errorColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: ctrl.isLoggingOut.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : Text('Logout',
                        style: GoogleFonts.poppins(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600)),
              )),
        ],
      ),
    );
  }
}