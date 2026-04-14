// // // lib/view/expert/expert_home_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/constants/custom_size.dart';
// // import 'package:speechspectrum/controllers/logout_controller.dart';
// // import 'package:speechspectrum/routes/app_routes.dart';

// // class ExpertHomeScreen extends StatelessWidget {
// //   const ExpertHomeScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final size = CustomSize();

// //     return Scaffold(
// //       backgroundColor: AppColors.lightGreyColor,
// //       appBar: AppBar(
// //         backgroundColor: AppColors.whiteColor,
// //         elevation: 0,
// //         title: Text(
// //           'Expert Dashboard',
// //           style: GoogleFonts.poppins(
// //             color: AppColors.textPrimaryColor,
// //             fontSize: 20,
// //             fontWeight: FontWeight.w600,
// //           ),
// //         ),
// //         actions: [
// //           // Consultations Icon
// //           IconButton(
// //             icon: const Icon(
// //               Icons.logout,
// //               color: AppColors.errorColor,
// //             ),
// //             // tooltip: 'View Consultations',
// //             onPressed: () {
// //               LogoutController controller=LogoutController();
// //               controller.logout();
             
// //             },
// //           ),
// //           // Linked Families Icon
// //           // IconButton(
// //           //   icon: const Icon(
// //           //     Icons.link_outlined,
// //           //     color: AppColors.primaryColor,
// //           //   ),
// //           //   tooltip: 'Linked Families',
// //           //   onPressed: () {
// //           //     Get.toNamed(AppRoutes.expertLinkedParents);
// //           //   },
// //           // ),
// //           SizedBox(width: size.customWidth(context) * 0.02),
// //         ],
// //       ),
// //       body: Center(
// //         child: Padding(
// //           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.center,
// //             children: [
// //               // Welcome Icon
// //               Container(
// //                 width: size.customWidth(context) * 0.4,
// //                 height: size.customWidth(context) * 0.4,
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [
// //                       AppColors.primaryColor.withOpacity(0.1),
// //                       AppColors.secondaryColor.withOpacity(0.1),
// //                     ],
// //                   ),
// //                   shape: BoxShape.circle,
// //                 ),
// //                 child: Icon(
// //                   Icons.medical_information_outlined,
// //                   size: size.customWidth(context) * 0.2,
// //                   color: AppColors.primaryColor,
// //                 ),
// //               ),

// //               SizedBox(height: size.customHeight(context) * 0.04),

// //               // Welcome Text
// //               Text(
// //                 'Welcome, Expert!',
// //                 style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.06,
// //                   fontWeight: FontWeight.bold,
// //                   color: AppColors.textPrimaryColor,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),

// //               SizedBox(height: size.customHeight(context) * 0.015),

// //               Text(
// //                 'Your dashboard is under construction',
// //                 style: GoogleFonts.poppins(
// //                   fontSize: size.customWidth(context) * 0.04,
// //                   color: AppColors.textSecondaryColor,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),

// //               SizedBox(height: size.customHeight(context) * 0.05),

// //               // Quick Action Cards
// //               _buildQuickActionCard(
// //                 context: context,
// //                 icon: Icons.medical_services_outlined,
// //                 title: 'View Consultations',
// //                 subtitle: 'Manage consultation requests',
// //                 color: AppColors.primaryColor,
// //                 onTap: () => Get.toNamed(AppRoutes.expertConsultations),
// //                 size: size,
// //               ),

// //               SizedBox(height: size.customHeight(context) * 0.02),

// //               _buildQuickActionCard(
// //                 context: context,
// //                 icon: Icons.link_outlined,
// //                 title: 'Linked Families',
// //                 subtitle: 'View your linked families',
// //                 color: AppColors.accentColor,
// //                 onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
// //                 size: size,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildQuickActionCard({
// //     required BuildContext context,
// //     required IconData icon,
// //     required String title,
// //     required String subtitle,
// //     required Color color,
// //     required VoidCallback onTap,
// //     required CustomSize size,
// //   }) {
// //     return Container(
// //       width: double.infinity,
// //       decoration: BoxDecoration(
// //         color: AppColors.whiteColor,
// //         borderRadius: BorderRadius.circular(20),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.06),
// //             blurRadius: 15,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Material(
// //         color: Colors.transparent,
// //         child: InkWell(
// //           onTap: onTap,
// //           borderRadius: BorderRadius.circular(20),
// //           child: Padding(
// //             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
// //             child: Row(
// //               children: [
// //                 Container(
// //                   width: 60,
// //                   height: 60,
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         color.withOpacity(0.8),
// //                         color,
// //                       ],
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                     ),
// //                     borderRadius: BorderRadius.circular(15),
// //                   ),
// //                   child: Icon(
// //                     icon,
// //                     color: AppColors.whiteColor,
// //                     size: 28,
// //                   ),
// //                 ),
// //                 SizedBox(width: size.customWidth(context) * 0.04),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         title,
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.042,
// //                           fontWeight: FontWeight.w600,
// //                           color: AppColors.textPrimaryColor,
// //                         ),
// //                       ),
// //                       SizedBox(height: size.customHeight(context) * 0.004),
// //                       Text(
// //                         subtitle,
// //                         style: GoogleFonts.poppins(
// //                           fontSize: size.customWidth(context) * 0.034,
// //                           color: AppColors.textSecondaryColor,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 Icon(
// //                   Icons.arrow_forward_ios_rounded,
// //                   size: 18,
// //                   color: AppColors.greyColor,
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// // lib/view/expert/expert_home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/logout_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertHomeScreen extends StatelessWidget {
//   const ExpertHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         title: Text(
//           'Expert Dashboard',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           // Logout Icon
//           IconButton(
//             icon: const Icon(
//               Icons.logout,
//               color: AppColors.errorColor,
//             ),
//             tooltip: 'Logout',
//             onPressed: () {
//               LogoutController controller = LogoutController();
//               controller.logout();
//             },
//           ),
//           SizedBox(width: size.customWidth(context) * 0.02),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Section
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryColor,
//                       AppColors.secondaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.3),
//                       blurRadius: 15,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.medical_information_outlined,
//                       size: size.customWidth(context) * 0.15,
//                       color: AppColors.whiteColor,
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     Text(
//                       'Welcome, Expert!',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.055,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.whiteColor,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.008),
//                     Text(
//                       'Manage your consultations and appointments',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.036,
//                         color: AppColors.whiteColor.withOpacity(0.9),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Consultation Management Section
//               _buildSectionTitle(context, 'Consultation Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.medical_services_outlined,
//                 title: 'View Consultations',
//                 subtitle: 'Manage consultation requests',
//                 color: AppColors.primaryColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertConsultations),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.link_outlined,
//                 title: 'Linked Families',
//                 subtitle: 'View and manage linked families',
//                 color: AppColors.accentColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Appointment Management Section
//               _buildSectionTitle(context, 'Appointment Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.calendar_today_outlined,
//                 title: 'My Appointments',
//                 subtitle: 'View all scheduled appointments',
//                 color: AppColors.successColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                 size: size,
//               ),

             
//              SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.calendar_today_outlined,
//                 title: 'My Appointments Notes',
//                 subtitle: 'View all appointments Notes',
//                 color: AppColors.successColor,
//                 onTap: () => Get.toNamed(AppRoutes.appointmentDetails),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.015),

//               // Quick Stats Row
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildStatCard(
//                       context: context,
//                       icon: Icons.event_available,
//                       title: 'Scheduled',
//                       subtitle: 'View scheduled',
//                       color: AppColors.primaryColor,
//                       onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                       size: size,
//                     ),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: _buildStatCard(
//                       context: context,
//                       icon: Icons.check_circle_outline,
//                       title: 'Completed',
//                       subtitle: 'View history',
//                       color: AppColors.successColor,
//                       onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                       size: size,
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Quick Actions Section
//               _buildSectionTitle(context, 'Quick Actions', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               // Grid of Quick Actions
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 mainAxisSpacing: size.customHeight(context) * 0.015,
//                 crossAxisSpacing: size.customWidth(context) * 0.03,
//                 childAspectRatio: 1.3,
//                 children: [
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.video_call,
//                     title: 'Google Meet',
//                     color: AppColors.primaryColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.phone,
//                     title: 'Phone Call',
//                     color: AppColors.accentColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.location_on,
//                     title: 'Physical',
//                     color: AppColors.warningColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.chat_bubble_outline,
//                     title: 'Chat',
//                     color: AppColors.successColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(BuildContext context, String title, CustomSize size) {
//     return Row(
//       children: [
//         Container(
//           width: 4,
//           height: 20,
//           decoration: BoxDecoration(
//             color: AppColors.primaryColor,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.02),
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

//   Widget _buildQuickActionCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.withOpacity(0.8),
//                         color,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: AppColors.whiteColor,
//                     size: 28,
//                   ),
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
//                           fontSize: size.customWidth(context) * 0.034,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: AppColors.greyColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: color,
//                     size: 28,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.004),
//                 Text(
//                   subtitle,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.028,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActionTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.03),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.withOpacity(0.8),
//                         color,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: AppColors.whiteColor,
//                     size: 24,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.012),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.004),
//                 Text(
//                   'Create',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.028,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // lib/view/expert/expert_home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/logout_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertHomeScreen extends StatelessWidget {
//   const ExpertHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         title: Text(
//           'Expert Dashboard',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           // Logout Icon
//           IconButton(
//             icon: const Icon(
//               Icons.logout,
//               color: AppColors.errorColor,
//             ),
//             tooltip: 'Logout',
//             onPressed: () {
//               LogoutController controller = LogoutController();
//               controller.logout();
//             },
//           ),
//           SizedBox(width: size.customWidth(context) * 0.02),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Section
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryColor,
//                       AppColors.secondaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.3),
//                       blurRadius: 15,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.medical_information_outlined,
//                       size: size.customWidth(context) * 0.15,
//                       color: AppColors.whiteColor,
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     Text(
//                       'Welcome, Expert!',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.055,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.whiteColor,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.008),
//                     Text(
//                       'Manage your consultations and appointments',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.036,
//                         color: AppColors.whiteColor.withOpacity(0.9),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Consultation Management Section
//               _buildSectionTitle(context, 'Consultation Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.medical_services_outlined,
//                 title: 'View Consultations',
//                 subtitle: 'Manage consultation requests',
//                 color: AppColors.primaryColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertConsultations),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.link_outlined,
//                 title: 'Linked Families',
//                 subtitle: 'View and manage linked families',
//                 color: AppColors.accentColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Appointment Management Section
//               _buildSectionTitle(context, 'Appointment Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.calendar_today_outlined,
//                 title: 'My Appointments',
//                 subtitle: 'View and manage all appointments',
//                 color: AppColors.successColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.015),

//               // Quick Stats Row
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildStatCard(
//                       context: context,
//                       icon: Icons.event_available,
//                       title: 'Scheduled',
//                       subtitle: 'View scheduled',
//                       color: AppColors.primaryColor,
//                       onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                       size: size,
//                     ),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: _buildStatCard(
//                       context: context,
//                       icon: Icons.check_circle_outline,
//                       title: 'Completed',
//                       subtitle: 'View history',
//                       color: AppColors.successColor,
//                       onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                       size: size,
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Quick Actions Section
//               _buildSectionTitle(context, 'Quick Actions', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               // Grid of Quick Actions
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 mainAxisSpacing: size.customHeight(context) * 0.015,
//                 crossAxisSpacing: size.customWidth(context) * 0.03,
//                 childAspectRatio: 1.3,
//                 children: [
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.video_call,
//                     title: 'Google Meet',
//                     color: AppColors.primaryColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.phone,
//                     title: 'Phone Call',
//                     color: AppColors.accentColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.location_on,
//                     title: 'Physical',
//                     color: AppColors.warningColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.chat_bubble_outline,
//                     title: 'Chat',
//                     color: AppColors.successColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),
//             ],
//           ),
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
//             color: AppColors.primaryColor,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.02),
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

//   Widget _buildQuickActionCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.withOpacity(0.8),
//                         color,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: AppColors.whiteColor,
//                     size: 28,
//                   ),
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
//                           fontSize: size.customWidth(context) * 0.034,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: AppColors.greyColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: color,
//                     size: 28,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.004),
//                 Text(
//                   subtitle,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.028,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActionTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.03),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.withOpacity(0.8),
//                         color,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: AppColors.whiteColor,
//                     size: 24,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.012),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.004),
//                 Text(
//                   'Create',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.028,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// // lib/view/expert/expert_home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/logout_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertHomeScreen extends StatelessWidget {
//   const ExpertHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         title: Text(
//           'Expert Dashboard',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           // Chat/Messages Icon
//           IconButton(
//             icon: const Icon(
//               Icons.chat_bubble_outline,
//               color: AppColors.successColor,
//             ),
//             tooltip: 'Messages',
//             onPressed: () => Get.toNamed(AppRoutes.expertChats),
//           ),
//           // Logout Icon
//           IconButton(
//             icon: const Icon(
//               Icons.logout,
//               color: AppColors.errorColor,
//             ),
//             tooltip: 'Logout',
//             onPressed: () {
//               LogoutController controller = LogoutController();
//               controller.logout();
//             },
//           ),
//           SizedBox(width: size.customWidth(context) * 0.02),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Section
//               Container(
//                 width: double.infinity,
//                 padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryColor,
//                       AppColors.secondaryColor,
//                     ],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(25),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.primaryColor.withOpacity(0.3),
//                       blurRadius: 15,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(
//                       Icons.medical_information_outlined,
//                       size: size.customWidth(context) * 0.15,
//                       color: AppColors.whiteColor,
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.02),
//                     Text(
//                       'Welcome, Expert!',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.055,
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.whiteColor,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     SizedBox(height: size.customHeight(context) * 0.008),
//                     Text(
//                       'Manage your consultations and appointments',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.036,
//                         color: AppColors.whiteColor.withOpacity(0.9),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                   ],
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Consultation Management Section
//               _buildSectionTitle(context, 'Consultation Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.medical_services_outlined,
//                 title: 'View Consultations',
//                 subtitle: 'Manage consultation requests',
//                 color: AppColors.primaryColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertConsultations),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.link_outlined,
//                 title: 'Linked Families',
//                 subtitle: 'View and manage linked families',
//                 color: AppColors.accentColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Communication Section
//               _buildSectionTitle(context, 'Communication', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.chat_bubble_outline,
//                 title: 'Messages',
//                 subtitle: 'Chat with your linked families',
//                 color: AppColors.successColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertChats),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Appointment Management Section
//               _buildSectionTitle(context, 'Appointment Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               _buildQuickActionCard(
//                 context: context,
//                 icon: Icons.calendar_today_outlined,
//                 title: 'My Appointments',
//                 subtitle: 'View and manage all appointments',
//                 color: AppColors.warningColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.015),

//               // Quick Stats Row
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildStatCard(
//                       context: context,
//                       icon: Icons.event_available,
//                       title: 'Scheduled',
//                       subtitle: 'View scheduled',
//                       color: AppColors.primaryColor,
//                       onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                       size: size,
//                     ),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: _buildStatCard(
//                       context: context,
//                       icon: Icons.check_circle_outline,
//                       title: 'Completed',
//                       subtitle: 'View history',
//                       color: AppColors.successColor,
//                       onTap: () => Get.toNamed(AppRoutes.expertAppointments),
//                       size: size,
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Quick Actions Section
//               _buildSectionTitle(context, 'Quick Actions', size),
//               SizedBox(height: size.customHeight(context) * 0.015),

//               // Grid of Quick Actions
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 mainAxisSpacing: size.customHeight(context) * 0.015,
//                 crossAxisSpacing: size.customWidth(context) * 0.03,
//                 childAspectRatio: 1.3,
//                 children: [
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.chat,
//                     title: 'Messages',
//                     color: AppColors.successColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertChats),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.video_call,
//                     title: 'Meet',
//                     color: AppColors.primaryColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.phone,
//                     title: 'Call',
//                     color: AppColors.accentColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                   _buildQuickActionTile(
//                     context: context,
//                     icon: Icons.location_on,
//                     title: 'Physical',
//                     color: AppColors.warningColor,
//                     onTap: () => Get.toNamed(AppRoutes.expertLinkedParents),
//                     size: size,
//                   ),
//                 ],
//               ),

//               SizedBox(height: size.customHeight(context) * 0.02),
//             ],
//           ),
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
//             color: AppColors.primaryColor,
//             borderRadius: BorderRadius.circular(2),
//           ),
//         ),
//         SizedBox(width: size.customWidth(context) * 0.02),
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

//   Widget _buildQuickActionCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Row(
//               children: [
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.withOpacity(0.8),
//                         color,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: AppColors.whiteColor,
//                     size: 28,
//                   ),
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
//                           fontSize: size.customWidth(context) * 0.034,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(
//                   Icons.arrow_forward_ios_rounded,
//                   size: 18,
//                   color: AppColors.greyColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildStatCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: color.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(
//                     icon,
//                     color: color,
//                     size: 28,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.015),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.004),
//                 Text(
//                   subtitle,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.028,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickActionTile({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(15),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 10,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(15),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.03),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         color.withOpacity(0.8),
//                         color,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Icon(
//                     icon,
//                     color: AppColors.whiteColor,
//                     size: 24,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.012),
//                 Text(
//                   title,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.004),
//                 Text(
//                   'Open',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.028,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



////


// // lib/view/expert/home/expert_home_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/logout_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertHomeScreen extends StatelessWidget {
//   const ExpertHomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         surfaceTintColor: Colors.transparent,
//         title: Text(
//           'Expert Dashboard',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 20,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.chat_bubble_outline,
//                 color: AppColors.successColor),
//             tooltip: 'Messages',
//             onPressed: () => Get.toNamed(AppRoutes.expertChats),
//           ),
//           IconButton(
//             icon: const Icon(Icons.logout, color: AppColors.errorColor),
//             tooltip: 'Logout',
//             onPressed: () {
//               LogoutController controller = LogoutController();
//               controller.logout();
//             },
//           ),
//           SizedBox(width: size.customWidth(context) * 0.02),
//         ],
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Welcome Banner
//               _buildWelcomeBanner(context, size),
//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Messages Card
//               _buildSectionTitle(context, 'Communication', size),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               _buildActionCard(
//                 context: context,
//                 icon: Icons.chat_bubble_outline_rounded,
//                 title: 'Messages',
//                 subtitle: 'Chat with your linked families',
//                 color: AppColors.successColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertChats),
//                 size: size,
//               ),

//               SizedBox(height: size.customHeight(context) * 0.03),

//               // Locations Card
//               _buildSectionTitle(context, 'Location Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               _buildActionCard(
//                 context: context,
//                 icon: Icons.location_on_outlined,
//                 title: 'My Locations',
//                 subtitle: 'Manage your clinic & office locations',
//                 color: AppColors.primaryColor,
//                 onTap: () => Get.toNamed(AppRoutes.expertLocations),
//                 size: size,
//               ),

//                SizedBox(height: size.customHeight(context) * 0.03),

//               // Locations Card
//               _buildSectionTitle(context, 'Slot Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               _buildActionCard(
//                   context: context,
//                   icon: Icons.calendar_month_rounded,
//                   title: 'My Slots',
//                   subtitle: 'Manage your availability slots',
//                   color: AppColors.secondaryColor,
//                   onTap: () => Get.toNamed(AppRoutes.expertSlots),
//                   size: size,
//                 ),

//                  SizedBox(height: size.customHeight(context) * 0.03),

//               // Locations Card
//               _buildSectionTitle(context, 'Appointment Management', size),
//               SizedBox(height: size.customHeight(context) * 0.015),
//                 _buildActionCard(
//                   context: context,
//                   icon: Icons.event_note_rounded,
//                   title: 'My Appointments',
//                   subtitle: 'View and manage all appointments',
//                   color: AppColors.accentColor,
//                   onTap: () => Get.toNamed(AppRoutes.myAppointments),
//                   size: size,
//                 ),

//               SizedBox(height: size.customHeight(context) * 0.04),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildWelcomeBanner(BuildContext context, CustomSize size) {
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
//             color: AppColors.primaryColor.withOpacity(0.3),
//             blurRadius: 20,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(14),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(16),
//             ),
//             child: Icon(
//               Icons.medical_information_outlined,
//               size: size.customWidth(context) * 0.08,
//               color: Colors.white,
//             ),
//           ),
//           SizedBox(width: size.customWidth(context) * 0.04),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Welcome, Expert!',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.048,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.006),
//                 Text(
//                   'Speech Spectrum Platform',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.033,
//                     color: Colors.white.withOpacity(0.85),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
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
//             color: AppColors.primaryColor,
//             borderRadius: BorderRadius.circular(2),
//           ),
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

//   Widget _buildActionCard({
//     required BuildContext context,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required Color color,
//     required VoidCallback onTap,
//     required CustomSize size,
//   }) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 16,
//             offset: const Offset(0, 4),
//           ),
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
//                   width: 58,
//                   height: 58,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [color.withOpacity(0.7), color],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
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
//                           fontSize: size.customWidth(context) * 0.033,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Icon(Icons.arrow_forward_ios_rounded,
//                     size: 16, color: AppColors.greyColor),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }