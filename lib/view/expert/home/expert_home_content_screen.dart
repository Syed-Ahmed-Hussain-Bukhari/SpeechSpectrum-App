// // lib/view/expert/home/expert_home_content_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_profile_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertHomeContentScreen extends StatelessWidget {
//   const ExpertHomeContentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final controller = Get.find<ExpertProfileController>();

//     return RefreshIndicator(
//       color: AppColors.primaryColor,
//       onRefresh: controller.fetchProfile,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Welcome Banner
//             Obx(() => _WelcomeBanner(controller: controller)),
//             SizedBox(height: size.customHeight(context) * 0.028),

//             // Quick Stats
//             _buildSectionTitle(context, 'Quick Overview', size),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _QuickStatsRow(size: size),
//             SizedBox(height: size.customHeight(context) * 0.028),

//             // Management
//             _buildSectionTitle(context, 'Management', size),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.calendar_month_rounded,
//               title: 'My Slots',
//               subtitle: 'Manage your availability slots',
//               color: AppColors.secondaryColor,
//               onTap: () => Get.toNamed(AppRoutes.expertSlots),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.event_note_rounded,
//               title: 'My Appointments',
//               subtitle: 'View and manage all appointments',
//               color: AppColors.accentColor,
//               onTap: () => Get.toNamed(AppRoutes.myAppointments),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.location_on_outlined,
//               title: 'My Locations',
//               subtitle: 'Manage your clinic & office locations',
//               color: AppColors.primaryColor,
//               onTap: () => Get.toNamed(AppRoutes.expertLocations),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.028),

//             // Communication
//             _buildSectionTitle(context, 'Communication', size),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.chat_bubble_outline_rounded,
//               title: 'Messages',
//               subtitle: 'Chat with your linked families',
//               color: AppColors.successColor,
//               onTap: () => Get.toNamed(AppRoutes.expertChats),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.04),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(
//       BuildContext context, String title, CustomSize size) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//               color: AppColors.primaryColor,
//               borderRadius: BorderRadius.circular(2)),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.025),
//         Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.045,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Welcome Banner ─────────────────────────────────────────────
// class _WelcomeBanner extends StatelessWidget {
//   final ExpertProfileController controller;
//   const _WelcomeBanner({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(size.customWidth(context) * 0.055),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(24),
//         boxShadow: [
//           BoxShadow(
//               color: AppColors.primaryColor.withOpacity(0.3),
//               blurRadius: 20,
//               offset: const Offset(0, 6))
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: size.customWidth(context) * 0.15,
//             height: size.customWidth(context) * 0.15,
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             alignment: Alignment.center,
//             child: Text(
//               controller.userInitial,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.07,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.04),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome back!',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.033,
//                     color: Colors.white.withOpacity(0.85),
//                   ),
//                 ),
//                 Text(
//                   controller.fullName.isNotEmpty
//                       ? controller.fullName
//                       : 'Expert',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.048,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.006),
//                 Container(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
//                   decoration: BoxDecoration(
//                     color: controller.isApproved
//                         ? AppColors.successColor.withOpacity(0.25)
//                         : AppColors.warningColor.withOpacity(0.25),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(
//                         color: Colors.white.withOpacity(0.4), width: 1),
//                   ),
//                   child: Text(
//                     controller.isApproved ? '✓ Approved Expert' : 'Pending Approval',
//                     style: GoogleFonts.poppins(
//                       color: Colors.white,
//                       fontSize: size.customWidth(context) * 0.028,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Quick Stats Row ────────────────────────────────────────────
// class _QuickStatsRow extends StatelessWidget {
//   final CustomSize size;
//   const _QuickStatsRow({required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: _StatCard(
//             label: 'Slots',
//             icon: Icons.calendar_today_rounded,
//             color: AppColors.secondaryColor,
//             size: size,
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: _StatCard(
//             label: 'Appointments',
//             icon: Icons.event_note_rounded,
//             color: AppColors.accentColor,
//             size: size,
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: _StatCard(
//             label: 'Messages',
//             icon: Icons.chat_bubble_outline_rounded,
//             color: AppColors.successColor,
//             size: size,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final CustomSize size;
//   const _StatCard(
//       {required this.label,
//       required this.icon,
//       required this.color,
//       required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Icon(icon, color: color, size: size.customWidth(context) * 0.055),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.028,
//               color: AppColors.textSecondaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Action Card ────────────────────────────────────────────────
// class _ActionCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color color;
//   final VoidCallback onTap;
//   final CustomSize size;

//   const _ActionCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.color,
//     required this.onTap,
//     required this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 16,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//             child: Row(
//               children: [
//                 Container(
//                   width: 56,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [color.withOpacity(0.7), color],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Icon(icon, color: Colors.white, size: 26),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.042,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Text(
//                         subtitle,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.031,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.arrow_forward_ios_rounded,
//                     size: 16, color: AppColors.greyColor),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// // }// lib/view/expert/home/expert_home_content_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_profile_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertHomeContentScreen extends StatelessWidget {
//   const ExpertHomeContentScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final ExpertProfileController controller =
//         Get.find<ExpertProfileController>();

//     return RefreshIndicator(
//       color: AppColors.primaryColor,
//       onRefresh: controller.fetchProfile,
//       child: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // _WelcomeBanner owns its own Get.find + Obx internally
//             const _WelcomeBanner(),
//             SizedBox(height: size.customHeight(context) * 0.028),

//             _buildSectionTitle(context, 'Quick Overview', size),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _QuickStatsRow(size: size),
//             SizedBox(height: size.customHeight(context) * 0.028),

//             _buildSectionTitle(context, 'Management', size),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.calendar_month_rounded,
//               title: 'My Slots',
//               subtitle: 'Manage your availability slots',
//               color: AppColors.secondaryColor,
//               onTap: () => Get.toNamed(AppRoutes.expertSlots),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.event_note_rounded,
//               title: 'My Appointments',
//               subtitle: 'View and manage all appointments',
//               color: AppColors.accentColor,
//               onTap: () => Get.toNamed(AppRoutes.myAppointments),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.014),
//             _ActionCard(
//               icon: Icons.location_on_outlined,
//               title: 'My Locations',
//               subtitle: 'Manage your clinic & office locations',
//               color: AppColors.primaryColor,
//               onTap: () => Get.toNamed(AppRoutes.expertLocations),
//               size: size,
//             ),
//             SizedBox(height: size.customHeight(context) * 0.028),

//             // _buildSectionTitle(context, 'Communication', size),
//             // SizedBox(height: size.customHeight(context) * 0.014),
//             // _ActionCard(
//             //   icon: Icons.chat_bubble_outline_rounded,
//             //   title: 'Messages',
//             //   subtitle: 'Chat with your linked families',
//             //   color: AppColors.successColor,
//             //   onTap: () => Get.toNamed(AppRoutes.expertChats),
//             //   size: size,
//             // ),
//             SizedBox(height: size.customHeight(context) * 0.04),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(
//       BuildContext context, String title, CustomSize size) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//               color: AppColors.primaryColor,
//               borderRadius: BorderRadius.circular(2)),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.025),
//         Text(
//           title,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.045,
//             fontWeight: FontWeight.bold,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // ── Welcome Banner ─────────────────────────────────────────────
// // KEY FIX: No controller passed as parameter.
// // Get.find + Obx are both INSIDE this widget so GetX correctly
// // owns the subscription and tracks all reactive reads.
// class _WelcomeBanner extends StatelessWidget {
//   const _WelcomeBanner();

//   @override
//   Widget build(BuildContext context) {
//     final ExpertProfileController controller =
//         Get.find<ExpertProfileController>();
//     final size = CustomSize();

//     return Obx(() {
//       // Read all reactive values inside the Obx callback
//       final String initial = controller.userInitial;
//       final String name =
//           controller.fullName.isNotEmpty ? controller.fullName : 'Expert';
//       final bool approved = controller.isApproved;

//       return Container(
//         width: double.infinity,
//         padding: EdgeInsets.all(size.customWidth(context) * 0.055),
//         decoration: BoxDecoration(
//           gradient: const LinearGradient(
//             colors: [AppColors.primaryColor, AppColors.secondaryColor],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(24),
//           boxShadow: [
//             BoxShadow(
//                 color: AppColors.primaryColor.withOpacity(0.3),
//                 blurRadius: 20,
//                 offset: const Offset(0, 6))
//           ],
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: size.customWidth(context) * 0.15,
//               height: size.customWidth(context) * 0.15,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(16),
//               ),
//               alignment: Alignment.center,
//               child: Text(
//                 initial,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.07,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.04),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Welcome back!',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.033,
//                       color: Colors.white.withOpacity(0.85),
//                     ),
//                   ),
//                   Text(
//                     name,
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.048,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: size.customHeight(context) * 0.006),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 10, vertical: 3),
//                     decoration: BoxDecoration(
//                       color: approved
//                           ? AppColors.successColor.withOpacity(0.25)
//                           : AppColors.warningColor.withOpacity(0.25),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                           color: Colors.white.withOpacity(0.4), width: 1),
//                     ),
//                     child: Text(
//                       approved ? '✓ Approved Expert' : 'Pending Approval',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: size.customWidth(context) * 0.028,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
// }

// // ── Quick Stats Row ────────────────────────────────────────────
// class _QuickStatsRow extends StatelessWidget {
//   final CustomSize size;
//   const _QuickStatsRow({required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: _StatCard(
//             label: 'Slots',
//             icon: Icons.calendar_today_rounded,
//             color: AppColors.secondaryColor,
//             size: size,
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: _StatCard(
//             label: 'Appointments',
//             icon: Icons.event_note_rounded,
//             color: AppColors.accentColor,
//             size: size,
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.03),
//         Expanded(
//           child: _StatCard(
//             label: 'Messages',
//             icon: Icons.chat_bubble_outline_rounded,
//             color: AppColors.successColor,
//             size: size,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String label;
//   final IconData icon;
//   final Color color;
//   final CustomSize size;
//   const _StatCard(
//       {required this.label,
//       required this.icon,
//       required this.color,
//       required this.size});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.035),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 3))
//         ],
//       ),
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(10)),
//             child: Icon(icon,
//                 color: color, size: size.customWidth(context) * 0.055),
//           ),
//           SizedBox(height: size.customHeight(context) * 0.008),
//           Text(
//             label,
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.028,
//               color: AppColors.textSecondaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//             textAlign: TextAlign.center,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ── Action Card ────────────────────────────────────────────────
// class _ActionCard extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final Color color;
//   final VoidCallback onTap;
//   final CustomSize size;

//   const _ActionCard({
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     required this.color,
//     required this.onTap,
//     required this.size,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 16,
//               offset: const Offset(0, 4))
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.045),
//             child: Row(
//               children: [
//                 Container(
//                   width: 56,
//                   height: 56,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                         colors: [color.withOpacity(0.7), color],
//                         begin: Alignment.topLeft,
//                         end: Alignment.bottomRight),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Icon(icon, color: Colors.white, size: 26),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         title,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.042,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Text(
//                         subtitle,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.031,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Icon(Icons.arrow_forward_ios_rounded,
//                     size: 16, color: AppColors.greyColor),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// lib/view/expert/home/expert_home_content_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_profile_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertHomeContentScreen extends StatelessWidget {
  const ExpertHomeContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final ExpertProfileController controller =
        Get.find<ExpertProfileController>();

    return RefreshIndicator(
      color: AppColors.primaryColor,
      onRefresh: controller.fetchProfile,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(size.customWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _WelcomeBanner(),
            SizedBox(height: size.customHeight(context) * 0.028),

            _buildSectionTitle(context, 'Quick Overview', size),
            SizedBox(height: size.customHeight(context) * 0.014),
            _QuickStatsRow(size: size),
            SizedBox(height: size.customHeight(context) * 0.028),

            _buildSectionTitle(context, 'Management', size),
            SizedBox(height: size.customHeight(context) * 0.014),
            _ActionCard(
              icon: Icons.calendar_month_rounded,
              title: 'My Slots',
              subtitle: 'Manage your availability slots',
              color: AppColors.secondaryColor,
              onTap: () => Get.toNamed(AppRoutes.expertSlots),
              size: size,
            ),
            SizedBox(height: size.customHeight(context) * 0.014),
            _ActionCard(
              icon: Icons.event_note_rounded,
              title: 'My Appointments',
              subtitle: 'View and manage all appointments',
              color: AppColors.accentColor,
              onTap: () => Get.toNamed(AppRoutes.myAppointments),
              size: size,
            ),
            SizedBox(height: size.customHeight(context) * 0.014),
            _ActionCard(
              icon: Icons.location_on_outlined,
              title: 'My Locations',
              subtitle: 'Manage your clinic & office locations',
              color: AppColors.primaryColor,
              onTap: () => Get.toNamed(AppRoutes.expertLocations),
              size: size,
            ),
            SizedBox(height: size.customHeight(context) * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      BuildContext context, String title, CustomSize size) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(2)),
        ),
        SizedBox(width: size.customWidth(context) * 0.025),
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.045,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimaryColor,
          ),
        ),
      ],
    );
  }
}

// ── Welcome Banner ─────────────────────────────────────────────
class _WelcomeBanner extends StatelessWidget {
  const _WelcomeBanner();

  @override
  Widget build(BuildContext context) {
    final ExpertProfileController controller =
        Get.find<ExpertProfileController>();
    final size = CustomSize();

    return Obx(() {
      final String initial = controller.userInitial;
      final String name =
          controller.fullName.isNotEmpty ? controller.fullName : 'Expert';
      final bool approved = controller.isApproved;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(size.customWidth(context) * 0.055),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryColor, AppColors.secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 6))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: size.customWidth(context) * 0.15,
              height: size.customWidth(context) * 0.15,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Text(
                initial,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: size.customWidth(context) * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.033,
                      color: Colors.white.withOpacity(0.85),
                    ),
                  ),
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.048,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: size.customHeight(context) * 0.006),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: approved
                          ? AppColors.successColor.withOpacity(0.25)
                          : AppColors.warningColor.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.4), width: 1),
                    ),
                    child: Text(
                      approved ? '✓ Approved Expert' : 'Pending Approval',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: size.customWidth(context) * 0.028,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ── Quick Stats Row ────────────────────────────────────────────
class _QuickStatsRow extends StatelessWidget {
  final CustomSize size;
  const _QuickStatsRow({required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Slots',
            icon: Icons.calendar_today_rounded,
            color: AppColors.secondaryColor,
            size: size,
            onTap: () => Get.toNamed(AppRoutes.expertSlots),
          ),
        ),
        SizedBox(width: size.customWidth(context) * 0.03),
        Expanded(
          child: _StatCard(
            label: 'Appointments',
            icon: Icons.event_note_rounded,
            color: AppColors.accentColor,
            size: size,
            onTap: () => Get.toNamed(AppRoutes.myAppointments),
          ),
        ),
        SizedBox(width: size.customWidth(context) * 0.03),
        Expanded(
          child: _StatCard(
            label: 'Locations',
            icon: Icons.location_on_rounded,
            color: AppColors.primaryColor,
            size: size,
            onTap: () => Get.toNamed(AppRoutes.expertLocations),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final CustomSize size;
  final VoidCallback onTap;

  const _StatCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.size,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.035),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3))
            ],
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(icon,
                    color: color, size: size.customWidth(context) * 0.055),
              ),
              SizedBox(height: size.customHeight(context) * 0.008),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.028,
                  color: AppColors.textSecondaryColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Action Card ────────────────────────────────────────────────
class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final CustomSize size;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, 4))
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.045),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [color.withOpacity(0.7), color],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: Colors.white, size: 26),
                ),
                SizedBox(width: size.customWidth(context) * 0.04),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      SizedBox(height: size.customHeight(context) * 0.004),
                      Text(
                        subtitle,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.031,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: AppColors.greyColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}