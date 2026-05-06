// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import '../../routes/app_routes.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';

// // // class SettingsScreen extends StatelessWidget {
// // //   const SettingsScreen({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: AppColors.lightGreyColor,
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.whiteColor,
// // //         elevation: 0,
// // //         leading: IconButton(
// // //           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
// // //           onPressed: () => Get.back(),
// // //         ),
// // //         title: Text(
// // //           'Settings',
// // //           style: GoogleFonts.poppins(
// // //             color: AppColors.textPrimaryColor,
// // //             fontWeight: FontWeight.w600,
// // //           ),
// // //         ),
// // //       ),
// // //       body: ListView(
// // //         padding: EdgeInsets.all(16),
// // //         children: [
// // //           _buildSettingsSection(
// // //             'Account',
// // //             [
// // //               _buildSettingsTile(Icons.person_outline, 'Edit Profile', () => Get.toNamed(AppRoutes.editProfile)),
// // //               _buildSettingsTile(Icons.lock_outline, 'Change Password', () {}),
// // //             ],
// // //           ),
// // //           _buildSettingsSection(
// // //             'Preferences',
// // //             [
// // //               _buildSettingsTile(Icons.notifications_outlined, 'Notifications', () {}),
// // //               _buildSettingsTile(Icons.language, 'Language', () {}),
// // //             ],
// // //           ),
// // //           _buildSettingsSection(
// // //             'Legal',
// // //             [
// // //               _buildSettingsTile(Icons.description_outlined, 'Terms & Conditions', () => Get.toNamed(AppRoutes.termsAndConditions)),
// // //               _buildSettingsTile(Icons.privacy_tip_outlined, 'Privacy Policy', () => Get.toNamed(AppRoutes.privacyPolicy)),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildSettingsSection(String title, List<Widget> children) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         Padding(
// // //           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// // //           child: Text(
// // //             title,
// // //             style: GoogleFonts.poppins(
// // //               fontSize: 14,
// // //               fontWeight: FontWeight.w600,
// // //               color: AppColors.textSecondaryColor,
// // //             ),
// // //           ),
// // //         ),
// // //         Container(
// // //           decoration: BoxDecoration(
// // //             color: AppColors.whiteColor,
// // //             borderRadius: BorderRadius.circular(15),
// // //           ),
// // //           child: Column(children: children),
// // //         ),
// // //         SizedBox(height: 16),
// // //       ],
// // //     );
// // //   }

// // //   Widget _buildSettingsTile(IconData icon, String title, VoidCallback onTap) {
// // //     return ListTile(
// // //       leading: Icon(icon, color: AppColors.primaryColor),
// // //       title: Text(title, style: GoogleFonts.poppins()),
// // //       trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.greyColor),
// // //       onTap: onTap,
// // //     );
// // //   }
// // // }



// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import '../../routes/app_routes.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';

// // class SettingsScreen extends StatelessWidget {
// //   const SettingsScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final screenHeight = MediaQuery.of(context).size.height;

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.whiteColor,
// //         elevation: 0,
// //         leading: IconButton(
// //           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
// //           onPressed: () => Get.back(),
// //         ),
// //         title: Text(
// //           'Settings',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //       ),
// //       body: ListView(
// //         padding: EdgeInsets.symmetric(
// //           horizontal: screenWidth * 0.05,
// //           vertical: screenHeight * 0.025,
// //         ),
// //         children: [
// //           // ── Account ──────────────────────────────────────────────
// //           _buildSectionLabel('Account', screenWidth),
// //           _buildCard(
// //             children: [
// //               _buildTile(
// //                 icon: Icons.person_outline,
// //                 title: 'Edit Profile',
// //                 subtitle: 'Update your personal information',
// //                 onTap: () => Get.toNamed(AppRoutes.editProfile),
// //                 screenWidth: screenWidth,
// //                 screenHeight: screenHeight,
// //               ),
// //             ],
// //           ),

// //           SizedBox(height: screenHeight * 0.025),

// //           // ── Children ─────────────────────────────────────────────
// //           _buildSectionLabel('Children', screenWidth),
// //           _buildCard(
// //             children: [
// //               _buildTile(
// //                 icon: Icons.child_care_outlined,
// //                 title: 'My Children',
// //                 subtitle: 'Manage and create child profiles',
// //                 onTap: () => Get.toNamed(AppRoutes.childrenList),
// //                 screenWidth: screenWidth,
// //                 screenHeight: screenHeight,
// //                 isLast: true,
// //               ),
// //             ],
// //           ),

// //           SizedBox(height: screenHeight * 0.025),

// //           // ── Support ──────────────────────────────────────────────
// //           _buildSectionLabel('Support', screenWidth),
// //           _buildCard(
// //             children: [
// //               _buildTile(
// //                 icon: Icons.quiz_outlined,
// //                 title: 'FAQs',
// //                 subtitle: 'Common questions answered',
// //                 onTap: () => Get.toNamed(AppRoutes.faq),
// //                 screenWidth: screenWidth,
// //                 screenHeight: screenHeight,
// //               ),
// //               _buildDivider(),
// //               _buildTile(
// //                 icon: Icons.info_outline,
// //                 title: 'About',
// //                 subtitle: 'Learn more about Speech Spectrum',
// //                 onTap: () => Get.toNamed(AppRoutes.about),
// //                 screenWidth: screenWidth,
// //                 screenHeight: screenHeight,
// //                 isLast: true,
// //               ),
// //             ],
// //           ),

// //           SizedBox(height: screenHeight * 0.025),

// //           // ── Legal ────────────────────────────────────────────────
// //           _buildSectionLabel('Legal', screenWidth),
// //           _buildCard(
// //             children: [
// //               _buildTile(
// //                 icon: Icons.description_outlined,
// //                 title: 'Terms & Conditions',
// //                 subtitle: 'Read our terms of use',
// //                 onTap: () => Get.toNamed(AppRoutes.termsAndConditions),
// //                 screenWidth: screenWidth,
// //                 screenHeight: screenHeight,
// //               ),
// //               _buildDivider(),
// //               _buildTile(
// //                 icon: Icons.privacy_tip_outlined,
// //                 title: 'Privacy Policy',
// //                 subtitle: 'How we handle your data',
// //                 onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
// //                 screenWidth: screenWidth,
// //                 screenHeight: screenHeight,
// //                 isLast: true,
// //               ),
// //             ],
// //           ),

// //           SizedBox(height: screenHeight * 0.03),
// //         ],
// //       ),
// //     );
// //   }

// //   // ── Helpers ──────────────────────────────────────────────────────────

// //   Widget _buildSectionLabel(String label, double screenWidth) {
// //     return Padding(
// //       padding: EdgeInsets.only(left: 4, bottom: screenWidth * 0.025),
// //       child: Text(
// //         label,
// //         style: GoogleFonts.poppins(
// //           fontSize: screenWidth * 0.038,
// //           fontWeight: FontWeight.w600,
// //           color: AppColors.textSecondaryColor,
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildCard({required List<Widget> children}) {
// //     return Container(
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(15),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.04),
// //             blurRadius: 8,
// //             offset: const Offset(0, 2),
// //           ),
// //         ],
// //       ),
// //       child: Column(children: children),
// //     );
// //   }

// //   Widget _buildDivider() {
// //     return Padding(
// //       padding: const EdgeInsets.only(left: 68),
// //       child: Divider(height: 1, color: Colors.grey.shade200),
// //     );
// //   }

// //   Widget _buildTile({
// //     required IconData icon,
// //     required String title,
// //     required String subtitle,
// //     required VoidCallback onTap,
// //     required double screenWidth,
// //     required double screenHeight,
// //     bool isLast = false,
// //   }) {
// //     return ListTile(
// //       onTap: onTap,
// //       contentPadding: EdgeInsets.symmetric(
// //         horizontal: screenWidth * 0.04,
// //         vertical: screenHeight * 0.004,
// //       ),
// //       leading: Container(
// //         width: 44,
// //         height: 44,
// //         decoration: BoxDecoration(
// //           color: AppColors.primaryColor.withOpacity(0.1),
// //           borderRadius: BorderRadius.circular(11),
// //         ),
// //         child: Icon(icon, color: AppColors.primaryColor, size: 22),
// //       ),
// //       title: Text(
// //         title,
// //         style: GoogleFonts.poppins(
// //           fontSize: screenWidth * 0.038,
// //           fontWeight: FontWeight.w600,
// //           color: AppColors.textPrimaryColor,
// //         ),
// //       ),
// //       subtitle: Text(
// //         subtitle,
// //         style: GoogleFonts.poppins(
// //           fontSize: screenWidth * 0.031,
// //           color: AppColors.textSecondaryColor,
// //         ),
// //       ),
// //       trailing: Icon(
// //         Icons.arrow_forward_ios,
// //         size: 15,
// //         color: AppColors.greyColor,
// //       ),
// //       shape: isLast
// //           ? null
// //           : null,
// //     );
// //   }
// // }



// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../../routes/app_routes.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Settings',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: FutureBuilder<String?>(
//         future: SharedPreferencesService.getRole(),
//         builder: (context, snapshot) {
//           final userRole = snapshot.data?.toLowerCase();
//           final isParent = userRole != 'expert';

//           return ListView(
//             padding: EdgeInsets.symmetric(
//               horizontal: screenWidth * 0.05,
//               vertical: screenHeight * 0.025,
//             ),
//             children: [
//               // ── Account ──────────────────────────────────────────────
//               _buildSectionLabel('Account', screenWidth),
//               _buildCard(
//                 children: [
//                   _buildTile(
//                     icon: Icons.person_outline,
//                     title: 'Edit Profile',
//                     subtitle: 'Update your personal information',
//                     onTap: () => Get.toNamed(AppRoutes.editProfile),
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     isLast: true,
//                   ),
//                 ],
//               ),

//               // ── Children (parents only) ───────────────────────────────
//               if (isParent) ...[
//                 SizedBox(height: screenHeight * 0.025),
//                 _buildSectionLabel('Children', screenWidth),
//                 _buildCard(
//                   children: [
//                     _buildTile(
//                       icon: Icons.child_care_outlined,
//                       title: 'My Children',
//                       subtitle: 'Manage and create child profiles',
//                       onTap: () => Get.toNamed(AppRoutes.childrenList),
//                       screenWidth: screenWidth,
//                       screenHeight: screenHeight,
//                       isLast: true,
//                     ),
//                   ],
//                 ),
//               ],

//               SizedBox(height: screenHeight * 0.025),

//               // ── Support ──────────────────────────────────────────────
//               _buildSectionLabel('Support', screenWidth),
//               _buildCard(
//                 children: [
//                   _buildTile(
//                     icon: Icons.quiz_outlined,
//                     title: 'FAQs',
//                     subtitle: 'Common questions answered',
//                     onTap: () => Get.toNamed(AppRoutes.faq),
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                   ),
//                   _buildDivider(),
//                   _buildTile(
//                     icon: Icons.info_outline,
//                     title: 'About',
//                     subtitle: 'Learn more about Speech Spectrum',
//                     onTap: () => Get.toNamed(AppRoutes.about),
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     isLast: true,
//                   ),
//                 ],
//               ),

//               SizedBox(height: screenHeight * 0.025),

//               // ── Legal ────────────────────────────────────────────────
//               _buildSectionLabel('Legal', screenWidth),
//               _buildCard(
//                 children: [
//                   _buildTile(
//                     icon: Icons.description_outlined,
//                     title: 'Terms & Conditions',
//                     subtitle: 'Read our terms of use',
//                     onTap: () => Get.toNamed(AppRoutes.termsAndConditions),
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                   ),
//                   _buildDivider(),
//                   _buildTile(
//                     icon: Icons.privacy_tip_outlined,
//                     title: 'Privacy Policy',
//                     subtitle: 'How we handle your data',
//                     onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
//                     screenWidth: screenWidth,
//                     screenHeight: screenHeight,
//                     isLast: true,
//                   ),
//                 ],
//               ),

//               SizedBox(height: screenHeight * 0.03),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   // ── Helpers ──────────────────────────────────────────────────────────

//   Widget _buildSectionLabel(String label, double screenWidth) {
//     return Padding(
//       padding: EdgeInsets.only(left: 4, bottom: screenWidth * 0.025),
//       child: Text(
//         label,
//         style: GoogleFonts.poppins(
//           fontSize: screenWidth * 0.038,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textSecondaryColor,
//         ),
//       ),
//     );
//   }

//   Widget _buildCard({required List<Widget> children}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(children: children),
//     );
//   }

//   Widget _buildDivider() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 68),
//       child: Divider(height: 1, color: Colors.grey.shade200),
//     );
//   }

//   Widget _buildTile({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//     required double screenWidth,
//     required double screenHeight,
//     bool isLast = false,
//   }) {
//     return ListTile(
//       onTap: onTap,
//       contentPadding: EdgeInsets.symmetric(
//         horizontal: screenWidth * 0.04,
//         vertical: screenHeight * 0.004,
//       ),
//       leading: Container(
//         width: 44,
//         height: 44,
//         decoration: BoxDecoration(
//           color: AppColors.primaryColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(11),
//         ),
//         child: Icon(icon, color: AppColors.primaryColor, size: 22),
//       ),
//       title: Text(
//         title,
//         style: GoogleFonts.poppins(
//           fontSize: screenWidth * 0.038,
//           fontWeight: FontWeight.w600,
//           color: AppColors.textPrimaryColor,
//         ),
//       ),
//       subtitle: Text(
//         subtitle,
//         style: GoogleFonts.poppins(
//           fontSize: screenWidth * 0.031,
//           color: AppColors.textSecondaryColor,
//         ),
//       ),
//       trailing: Icon(
//         Icons.arrow_forward_ios,
//         size: 15,
//         color: AppColors.greyColor,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../routes/app_routes.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: FutureBuilder<String?>(
        future: SharedPreferencesService.getRole(),
        builder: (context, snapshot) {
          final userRole = snapshot.data?.toLowerCase();
          final isParent = userRole != 'expert';

          return ListView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.025,
            ),
            children: [
              // ── Account ──────────────────────────────────────────────
              _buildSectionLabel('Account', screenWidth),
              _buildCard(
                children: [
                  _buildTile(
                    icon: Icons.person_outline,
                    title: 'Edit Profile',
                    subtitle: 'Update your personal information',
                    // ✅ ONLY CHANGE: route depends on role
                    onTap: () => Get.toNamed(
                      userRole == 'expert'
                          ? AppRoutes.expertEditProfile
                          : AppRoutes.editProfile,
                    ),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isLast: true,
                  ),
                ],
              ),

              // ── Children (parents only) ───────────────────────────────
              if (isParent) ...[
                SizedBox(height: screenHeight * 0.025),
                _buildSectionLabel('Children', screenWidth),
                _buildCard(
                  children: [
                    _buildTile(
                      icon: Icons.child_care_outlined,
                      title: 'My Children',
                      subtitle: 'Manage and create child profiles',
                      onTap: () => Get.toNamed(AppRoutes.childrenList),
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      isLast: true,
                    ),
                  ],
                ),
              ],

              SizedBox(height: screenHeight * 0.025),

              // ── Support ──────────────────────────────────────────────
              _buildSectionLabel('Support', screenWidth),
              _buildCard(
                children: [
                  _buildTile(
                    icon: Icons.quiz_outlined,
                    title: 'FAQs',
                    subtitle: 'Common questions answered',
                    onTap: () => Get.toNamed(AppRoutes.faq),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildDivider(),
                  _buildTile(
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'Learn more about Speech Spectrum',
                    onTap: () => Get.toNamed(AppRoutes.about),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isLast: true,
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.025),

              // ── Legal ────────────────────────────────────────────────
              _buildSectionLabel('Legal', screenWidth),
              _buildCard(
                children: [
                  _buildTile(
                    icon: Icons.description_outlined,
                    title: 'Terms & Conditions',
                    subtitle: 'Read our terms of use',
                    onTap: () => Get.toNamed(AppRoutes.termsAndConditions),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),
                  _buildDivider(),
                  _buildTile(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    subtitle: 'How we handle your data',
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    isLast: true,
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionLabel(String label, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(left: 4, bottom: screenWidth * 0.025),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.038,
          fontWeight: FontWeight.w600,
          color: AppColors.textSecondaryColor,
        ),
      ),
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.only(left: 68),
      child: Divider(height: 1, color: Colors.grey.shade200),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    required double screenWidth,
    required double screenHeight,
    bool isLast = false,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.004,
      ),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(11),
        ),
        child: Icon(icon, color: AppColors.primaryColor, size: 22),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.038,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryColor,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFonts.poppins(
          fontSize: screenWidth * 0.031,
          color: AppColors.textSecondaryColor,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 15,
        color: AppColors.greyColor,
      ),
    );
  }
}