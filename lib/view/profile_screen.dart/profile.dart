// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../routes/app_routes.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
    
//     return SingleChildScrollView(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//       child: Column(
//         children: [
//           // Profile Header
//           Container(
//             width: double.infinity,
//             padding: EdgeInsets.only(top:size.customWidth(context) * 0.05,bottom:size.customWidth(context) * 0.05),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [AppColors.primaryColor, AppColors.secondaryColor],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   width: 100,
//                   height: 100,
//                   decoration: BoxDecoration(
//                     color: AppColors.whiteColor,
//                     shape: BoxShape.circle,
//                     border: Border.all(color: AppColors.whiteColor, width: 4),
//                   ),
//                   child: Icon(
//                     Icons.person,
//                     size: 50,
//                     color: AppColors.primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   'Syed Ahmed',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   'ahmed@email.com',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor.withOpacity(0.9),
//                     fontSize: 14,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: () => Get.toNamed(AppRoutes.editProfile),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.whiteColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                   child: Text(
//                     'Edit Profile',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.primaryColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          
//           SizedBox(height: size.customHeight(context) * 0.03),
          
//           // Profile Options
//           _buildProfileOption(
//             context: context,
//             icon: Icons.child_care,
//             title: 'My Children',
//             subtitle: '2 children profiles',
//             onTap: () {},
//           ),
//           _buildProfileOption(
//             context: context,
//             icon: Icons.history,
//             title: 'Screening History',
//             subtitle: 'View past screenings',
//             onTap: () => Get.toNamed(AppRoutes.results),
//           ),
//           _buildProfileOption(
//             context: context,
//             icon: Icons.notifications_outlined,
//             title: 'Notifications',
//             subtitle: 'Manage notifications',
//             onTap: () {
//               // Get.toNamed(AppRoutes.notification);
//             },
//           ),
//           _buildProfileOption(
//             context: context,
//             icon: Icons.settings_outlined,
//             title: 'Settings',
//             subtitle: 'App preferences',
//             onTap: () => Get.toNamed(AppRoutes.settings),
//           ),
//           _buildProfileOption(
//             context: context,
//             icon: Icons.help_outline,
//             title: 'Help & Support',
//             subtitle: 'Get help',
//             onTap: () {
//               Get.toNamed(AppRoutes.help);
//             },
//           ),
//           _buildProfileOption(
//             context: context,
//             icon: Icons.logout,
//             title: 'Logout',
//             subtitle: 'Sign out of your account',
//             onTap: () => Get.offAllNamed(AppRoutes.login),
//             isDestructive: true,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileOption({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//     bool isDestructive = false,
//   }) {
//     final size = CustomSize();
    
//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: ListTile(
//         onTap: onTap,
//         leading: Container(
//           width: 45,
//           height: 45,
//           decoration: BoxDecoration(
//             color: (isDestructive ? AppColors.errorColor : AppColors.primaryColor).withOpacity(0.1),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Icon(
//             icon,
//             color: isDestructive ? AppColors.errorColor : AppColors.primaryColor,
//           ),
//         ),
//         title: Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontWeight: FontWeight.w600,
//             color: isDestructive ? AppColors.errorColor : AppColors.textPrimaryColor,
//           ),
//         ),
//         subtitle: Text(
//           subtitle,
//           style: GoogleFonts.poppins(
//             fontSize: 12,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         trailing: Icon(
//           Icons.arrow_forward_ios,
//           size: 16,
//           color: AppColors.greyColor,
//         ),
//       ),
//     );
//   }
// }


// lib/view/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/logout_controller.dart';
import 'package:speechspectrum/controllers/profile_controller.dart';
import 'package:speechspectrum/models/profile_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        }

        if (controller.profileModel.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: AppColors.errorColor,
                ),
                SizedBox(height: 16),
                Text(
                  'Failed to load profile',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchProfile(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                  ),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final profileData = controller.profileModel.value!.data;

        return CustomScrollView(
          slivers: [
            // App Bar with Profile Header
            SliverAppBar(
              expandedHeight: size.customHeight(context) * 0.35,
              pinned: true,
              backgroundColor: AppColors.primaryColor,
              flexibleSpace: FlexibleSpaceBar(
                background: _buildProfileHeader(context, controller, profileData),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.settings_outlined, color: AppColors.whiteColor),
                  onPressed: () => Get.toNamed(AppRoutes.settings),
                ),
              ],
            ),

            // Profile Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(size.customWidth(context) * 0.05),
                child: Column(
                  children: [
                    // Profile Info Card
                    _buildProfileInfoCard(context, controller, profileData),

                    SizedBox(height: size.customHeight(context) * 0.02),

                    // Profile Options
                    if (profileData.isParent()) ...[
                      _buildProfileOption(
                        context: context,
                        icon: Icons.child_care,
                        title: 'My Children',
                        subtitle: 'Manage children profiles',
                        onTap: () {
                          Get.toNamed(AppRoutes.childrenList);
                        },
                      ),
                    ],
                    
                    if (profileData.isExpert()) ...[
                      _buildProfileOption(
                        context: context,
                        icon: Icons.calendar_today,
                        title: 'My Schedule',
                        subtitle: 'View appointments',
                        onTap: () {},
                      ),
                      _buildProfileOption(
                        context: context,
                        icon: Icons.people_outline,
                        title: 'My Clients',
                        subtitle: 'Manage client list',
                        onTap: () {},
                      ),
                    ],

                    _buildProfileOption(
                      context: context,
                      icon: Icons.history,
                      title: 'History',
                      subtitle: profileData.isParent() 
                          ? 'View past screenings'
                          : 'Session history',
                      onTap: () => Get.toNamed(AppRoutes.results),
                    ),

                    _buildProfileOption(
                      context: context,
                      icon: Icons.notifications_outlined,
                      title: 'Notifications',
                      subtitle: 'Manage notifications',
                      onTap: () {},
                    ),

                    _buildProfileOption(
                      context: context,
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      subtitle: 'Get assistance',
                      onTap: () => Get.toNamed(AppRoutes.help),
                    ),

                    _buildProfileOption(
                      context: context,
                      icon: Icons.logout,
                      title: 'Logout',
                      subtitle: 'Sign out of your account',
                      onTap: () => _showLogoutDialog(context, controller),
                      isDestructive: true,
                    ),

                    SizedBox(height: size.customHeight(context) * 0.02),

                    // App Version
                    Text(
                      'App Version 2.3',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
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

  Widget _buildProfileHeader(BuildContext context, ProfileController controller, ProfileData profileData) {
    final size = CustomSize();

    return Container(
      decoration: BoxDecoration(
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
            
            // Profile Avatar
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.whiteColor.withOpacity(0.3),
                  width: 4,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                controller.userInitial,
                style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.015),

            // Name
            Text(
              controller.fullName,
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: size.customWidth(context) * 0.055,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.005),

            // Role Badge
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.04,
                vertical: size.customHeight(context) * 0.006,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.whiteColor.withOpacity(0.3),
                ),
              ),
              child: Text(
                controller.roleDisplay,
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: size.customWidth(context) * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.02),

            // Edit Profile Button
            ElevatedButton.icon(
              onPressed: () => Get.toNamed(AppRoutes.editProfile),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.whiteColor,
                foregroundColor: AppColors.primaryColor,
                padding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.06,
                  vertical: size.customHeight(context) * 0.012,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              icon: Icon(Icons.edit, size: 18),
              label: Text(
                'Edit Profile',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: size.customWidth(context) * 0.038,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoCard(BuildContext context, ProfileController controller, ProfileData profileData) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context: context,
            icon: Icons.phone_outlined,
            label: 'Phone',
            value: controller.phone,
          ),
          
          if (profileData.isExpert()) ...[
            SizedBox(height: size.customHeight(context) * 0.015),
            Divider(color: AppColors.greyColor.withOpacity(0.2)),
            SizedBox(height: size.customHeight(context) * 0.015),
            
            _buildInfoRow(
              context: context,
              icon: Icons.email_outlined,
              label: 'Email',
              value: (profileData.profile as ExpertProfile).contactEmail ?? 'Not provided',
            ),
            
            if ((profileData.profile as ExpertProfile).specialization != null) ...[
              SizedBox(height: size.customHeight(context) * 0.015),
              Divider(color: AppColors.greyColor.withOpacity(0.2)),
              SizedBox(height: size.customHeight(context) * 0.015),
              
              _buildInfoRow(
                context: context,
                icon: Icons.medical_services_outlined,
                label: 'Specialization',
                value: (profileData.profile as ExpertProfile).specialization!,
              ),
            ],
            
            if ((profileData.profile as ExpertProfile).organization != null) ...[
              SizedBox(height: size.customHeight(context) * 0.015),
              Divider(color: AppColors.greyColor.withOpacity(0.2)),
              SizedBox(height: size.customHeight(context) * 0.015),
              
              _buildInfoRow(
                context: context,
                icon: Icons.business_outlined,
                label: 'Organization',
                value: (profileData.profile as ExpertProfile).organization!,
              ),
            ],
          ],
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
    final size = CustomSize();

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primaryColor,
            size: 20,
          ),
        ),
        SizedBox(width: size.customWidth(context) * 0.03),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.032,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
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

  Widget _buildProfileOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final size = CustomSize();

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(
          horizontal: size.customWidth(context) * 0.04,
          vertical: size.customHeight(context) * 0.005,
        ),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: (isDestructive ? AppColors.errorColor : AppColors.primaryColor)
                .withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: isDestructive ? AppColors.errorColor : AppColors.primaryColor,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: size.customWidth(context) * 0.04,
            color: isDestructive ? AppColors.errorColor : AppColors.textPrimaryColor,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.032,
            color: AppColors.textSecondaryColor,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.greyColor,
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileController controller) {
    final size = CustomSize();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
          Obx(() => ElevatedButton(
                onPressed: controller.isLoggingOut.value
                    ? null
                    : () {
                        Get.back();
                        controller.logout();
                         
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.errorColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: controller.isLoggingOut.value
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.whiteColor,
                          strokeWidth: 2,
                        ),
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