// lib/view/expert/home/expert_animated_drawer.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_drawer_controller.dart';
import 'package:speechspectrum/controllers/expert_profile_controller.dart';
import 'package:speechspectrum/controllers/logout_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertAnimatedDrawer extends StatelessWidget {
  final VoidCallback onHomePressed;
  final VoidCallback onMessagesPressed;
  final VoidCallback onProfilePressed;

  ExpertAnimatedDrawer({
    super.key,
    required this.onHomePressed,
    required this.onMessagesPressed,
    required this.onProfilePressed,
  });

  // Controllers registered here — same pattern as parent AnimatedDrawer
  final drawerController = Get.isRegistered<ExpertDrawerController>()
      ? Get.find<ExpertDrawerController>()
      : Get.put(ExpertDrawerController());

  final logoutController = Get.isRegistered<LogoutController>()
      ? Get.find<LogoutController>()
      : Get.put(LogoutController());

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return Drawer(
      child: Container(
        color: AppColors.whiteColor,
        child: Column(
          children: [
            // Header — reads reactive profile fields, owns its Obx internally
            const _ExpertDrawerHeader(),

            // Scrollable menu items
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _buildSectionLabel('MAIN', screenWidth),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.dashboard_outlined,
                    selectedIcon: Icons.dashboard,
                    title: 'Dashboard',
                    index: 0,
                    onTap: () {
                      Navigator.pop(context);
                      onHomePressed();
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  // _buildMenuItem(
                  //   context: context,
                  //   icon: Icons.chat_bubble_outline,
                  //   selectedIcon: Icons.chat_bubble,
                  //   title: 'Messages',
                  //   index: 1,
                  //   onTap: () {
                  //     Navigator.pop(context);
                  //     onMessagesPressed();
                  //   },
                  //   screenWidth: screenWidth,
                  //   screenHeight: screenHeight,
                  // ),

                  
                  SizedBox(height: screenHeight * 0.01),

                  _buildSectionLabel('MANAGEMENT', screenWidth),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.location_on_outlined,
                    selectedIcon: Icons.location_on,
                    title: 'My Locations',
                    index: 2,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.expertLocations);
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.calendar_month_outlined,
                    selectedIcon: Icons.calendar_month,
                    title: 'My Slots',
                    index: 3,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.expertSlots);
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.event_note_outlined,
                    selectedIcon: Icons.event_note,
                    title: 'My Appointments',
                    index: 4,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.myAppointments);
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  _buildSectionLabel('ACCOUNT', screenWidth),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.person_outline,
                    selectedIcon: Icons.person,
                    title: 'My Profile',
                    index: 5,
                    onTap: () {
                      Navigator.pop(context);
                      onProfilePressed();
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildExpandableMenuItem(
                    context: context,
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    index: 6,
                    isExpanded: drawerController.isSettingsExpanded,
                    onTap: drawerController.toggleSettings,
                    children: [
                      _buildSubMenuItem(
                        context,
                        'App Settings',
                        7,
                        screenWidth,
                        screenHeight,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.settings);
                        },
                      ),
                      _buildSubMenuItem(
                        context,
                        'Terms & Conditions',
                        8,
                        screenWidth,
                        screenHeight,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.termsAndConditions);
                        },
                      ),
                      _buildSubMenuItem(
                        context,
                        'Privacy Policy',
                        9,
                        screenWidth,
                        screenHeight,
                        onTap: () {
                          Navigator.pop(context);
                          Get.toNamed(AppRoutes.privacyPolicy);
                        },
                      ),
                    ],
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.info_outline,
                    selectedIcon: Icons.info,
                    title: 'About',
                    index: 10,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.about);
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.help_outline,
                    selectedIcon: Icons.help,
                    title: 'Help',
                    index: 11,
                    onTap: () {
                      Navigator.pop(context);
                      Get.toNamed(AppRoutes.help);
                    },
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                ],
              ),
            ),

            // Logout at bottom
            SafeArea(
              top: false,
              child: _buildLogoutButton(context, screenWidth, screenHeight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenWidth * 0.03,
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required IconData selectedIcon,
    required String title,
    required int index,
    required VoidCallback onTap,
    required double screenWidth,
    required double screenHeight,
  }) {
    // Obx owns a reactive read on selectedIndex — correct pattern
    return Obx(() {
      final isSelected = drawerController.selectedIndex.value == index;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.003,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              drawerController.selectItem(index);
              onTap();
            },
            borderRadius: BorderRadius.circular(screenWidth * 0.025),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.015,
              ),
              child: Row(
                children: [
                  Icon(
                    isSelected ? selectedIcon : icon,
                    color: isSelected
                        ? AppColors.whiteColor
                        : AppColors.textSecondaryColor,
                    size: screenWidth * 0.055,
                  ),
                  SizedBox(width: screenWidth * 0.04),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.textPrimaryColor,
                      fontSize: screenWidth * 0.038,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildExpandableMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required int index,
    required RxBool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Obx(() {
      final expanded = isExpanded.value;

      return Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.003,
            ),
            decoration: BoxDecoration(
              color:
                  expanded ? AppColors.lightGreyColor : Colors.transparent,
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.015,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: AppColors.textPrimaryColor,
                        size: screenWidth * 0.055,
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: Text(
                          title,
                          style: GoogleFonts.poppins(
                            color: AppColors.textPrimaryColor,
                            fontSize: screenWidth * 0.038,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      AnimatedRotation(
                        turns: expanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.expand_more,
                          color: AppColors.textSecondaryColor,
                          size: screenWidth * 0.05,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: expanded
                ? Column(children: children)
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }

  Widget _buildSubMenuItem(
    BuildContext context,
    String title,
    int index,
    double screenWidth,
    double screenHeight, {
    VoidCallback? onTap,
  }) {
    return Obx(() {
      final isSelected = drawerController.selectedIndex.value == index;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.only(
          left: screenWidth * 0.15,
          right: screenWidth * 0.04,
          top: screenHeight * 0.003,
          bottom: screenHeight * 0.003,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              drawerController.selectItem(index);
              if (onTap != null) onTap();
            },
            borderRadius: BorderRadius.circular(screenWidth * 0.02),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.012,
              ),
              child: Row(
                children: [
                  Container(
                    width: screenWidth * 0.015,
                    height: screenWidth * 0.015,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.greyColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.textSecondaryColor,
                      fontSize: screenWidth * 0.035,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLogoutButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.greyColor.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showLogoutDialog(context),
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.015,
            ),
            child: Row(
              children: [
                Icon(Icons.logout,
                    color: AppColors.errorColor, size: screenWidth * 0.055),
                SizedBox(width: screenWidth * 0.04),
                Text(
                  'Logout Account',
                  style: GoogleFonts.poppins(
                    color: AppColors.errorColor,
                    fontSize: screenWidth * 0.038,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final size = CustomSize();
    Get.dialog(
      AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Logout',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: size.customWidth(context) * 0.05,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            color: AppColors.textSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: AppColors.textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Obx wraps ONLY the button — it reads isLoading.value reactively
          Obx(() => ElevatedButton(
                onPressed: logoutController.isLoading.value
                    ? null
                    : () {
                        Get.back();
                        logoutController.logout();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: logoutController.isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2),
                      )
                    : Text(
                        'Logout',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  Expert Drawer Header
//  Owns its own Get.find + Obx — no parameter passing
// ═══════════════════════════════════════════════════════════════
class _ExpertDrawerHeader extends StatelessWidget {
  const _ExpertDrawerHeader();

  @override
  Widget build(BuildContext context) {
    final ExpertProfileController ctrl =
        Get.find<ExpertProfileController>();
    final size = CustomSize();
    final screenWidth = size.customWidth(context);
    final screenHeight = size.customHeight(context);

    return Obx(() {
      final String initial = ctrl.userInitial;
      final String name =
          ctrl.fullName.isNotEmpty ? ctrl.fullName : 'Expert';
      final String specialization =
          ctrl.specialization.isNotEmpty ? ctrl.specialization : 'Speech Therapist';
      final bool approved = ctrl.isApproved;

      return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.025,
            ),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: screenWidth * 0.15,
                  height: screenWidth * 0.15,
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    initial,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.07,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.04),

                // Name + specialization + badge
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.003),
                      Text(
                        specialization,
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor.withOpacity(0.9),
                          fontSize: screenWidth * 0.032,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: screenHeight * 0.006),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: approved
                              ? AppColors.successColor.withOpacity(0.25)
                              : AppColors.warningColor.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: AppColors.whiteColor.withOpacity(0.4)),
                        ),
                        child: Text(
                          approved ? '✓ Approved' : 'Pending',
                          style: GoogleFonts.poppins(
                            color: AppColors.whiteColor,
                            fontSize: screenWidth * 0.027,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Close button
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(screenWidth * 0.02),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: AppColors.whiteColor,
                      size: screenWidth * 0.05,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}