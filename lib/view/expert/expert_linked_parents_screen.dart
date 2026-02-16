// // lib/view/expert/expert_linked_parents_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';

// class ExpertLinkedParentsScreen extends StatefulWidget {
//   const ExpertLinkedParentsScreen({super.key});

//   @override
//   State<ExpertLinkedParentsScreen> createState() => _ExpertLinkedParentsScreenState();
// }

// class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
//   late final ExpertConsultationController controller;

//   @override
//   void initState() {
//     super.initState();

//     // Get or create controller
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     // Fetch linked parents after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchLinkedParents();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Linked Families',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchLinkedParents(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading linked families...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.linkedParents.isEmpty) {
//           return _buildEmptyState(context);
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           itemCount: controller.linkedParents.length,
//           itemBuilder: (context, index) {
//             final linkedItem = controller.linkedParents[index];
//             return _buildLinkedParentCard(context, linkedItem);
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLinkedParentCard(BuildContext context, linkedItem) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Avatar/Icon
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.accentColor.withOpacity(0.8),
//                         AppColors.accentColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: const Icon(
//                     Icons.family_restroom_outlined,
//                     color: AppColors.whiteColor,
//                     size: 32,
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),

//                 // Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Parent ID',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                       Text(
//                         linkedItem.parentUserId.substring(0, 12) + '...',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.child_care_outlined,
//                             size: 14,
//                             color: AppColors.primaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Text(
//                             'Child: ${linkedItem.childId.substring(0, 8)}...',
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.032,
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Linked Badge
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     Icons.link,
//                     color: AppColors.successColor,
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Linked Date
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   'Linked since: ',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   linkedItem.getFormattedDate(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Link ID
//             Row(
//               children: [
//                 Icon(
//                   Icons.tag_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: Text(
//                     'Link ID: ${linkedItem.linkId.substring(0, 12)}...',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.032,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Info Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.03),
//               decoration: BoxDecoration(
//                 color: AppColors.accentColor.withOpacity(0.05),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: AppColors.accentColor.withOpacity(0.2),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.info_outline,
//                     size: 18,
//                     color: AppColors.accentColor,
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.02),
//                   Expanded(
//                     child: Text(
//                       'You can now access this family\'s records and provide consultation',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.link_off_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Linked Families',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'You don\'t have any linked families yet.\nApproved consultations will appear here.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // lib/view/expert/expert_linked_parents_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';

// class ExpertLinkedParentsScreen extends StatefulWidget {
//   const ExpertLinkedParentsScreen({super.key});

//   @override
//   State<ExpertLinkedParentsScreen> createState() =>
//       _ExpertLinkedParentsScreenState();
// }

// class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
//   late final ExpertConsultationController controller;

//   @override
//   void initState() {
//     super.initState();

//     // Get or create controller
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     // Fetch linked parents after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchExpertLinkedParents();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Linked Families',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchExpertLinkedParents(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading linked families...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.linkedParents.isEmpty) {
//           return _buildEmptyState(context);
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           itemCount: controller.linkedParents.length,
//           itemBuilder: (context, index) {
//             final linkedParent = controller.linkedParents[index];
//             return _buildLinkedParentCard(context, linkedParent);
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLinkedParentCard(BuildContext context, linkedParent) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Child Avatar
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.accentColor.withOpacity(0.8),
//                         AppColors.accentColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       linkedParent.children.getInitials(),
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),

//                 // Child Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         linkedParent.children.childName,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.042,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.family_restroom_outlined,
//                             size: 14,
//                             color: AppColors.primaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Expanded(
//                             child: Text(
//                               'Linked Family',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.034,
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Linked Badge
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.link,
//                     color: AppColors.successColor,
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Linked Date
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   'Linked since: ',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   linkedParent.getFormattedDate(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textPrimaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   linkedParent.getFormattedTime(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),

//             // SizedBox(height: size.customHeight(context) * 0.01),

//             // // IDs Info (for reference)
//             // Container(
//             //   padding: EdgeInsets.all(size.customWidth(context) * 0.03),
//             //   decoration: BoxDecoration(
//             //     color: AppColors.lightGreyColor,
//             //     borderRadius: BorderRadius.circular(12),
//             //   ),
//             //   child: Column(
//             //     children: [
//             //       _buildInfoRow(
//             //         context,
//             //         'Link ID',
//             //         linkedParent.linkId,
//             //         Icons.link_outlined,
//             //       ),
//             //       SizedBox(height: size.customHeight(context) * 0.008),
//             //       _buildInfoRow(
//             //         context,
//             //         'Child ID',
//             //         linkedParent.childId,
//             //         Icons.child_care_outlined,
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//       BuildContext context, String label, String value, IconData icon) {
//     final size = CustomSize();

//     return Row(
//       children: [
//         Icon(
//           icon,
//           size: 14,
//           color: AppColors.textSecondaryColor,
//         ),
//         SizedBox(width: size.customWidth(context) * 0.02),
//         Text(
//           '$label: ',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.032,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: GoogleFonts.poppins(
//               fontSize: size.customWidth(context) * 0.03,
//               color: AppColors.textPrimaryColor,
//               fontWeight: FontWeight.w500,
//             ),
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.link_off_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Linked Families',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'You don\'t have any linked families yet.\nApproved consultations will appear here.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// // lib/view/expert/expert_linked_parents_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/appointment_controller.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertLinkedParentsScreen extends StatefulWidget {
//   const ExpertLinkedParentsScreen({super.key});

//   @override
//   State<ExpertLinkedParentsScreen> createState() =>
//       _ExpertLinkedParentsScreenState();
// }

// class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
//   late final ExpertConsultationController controller;
//   late final AppointmentController appointmentController;

//   @override
//   void initState() {
//     super.initState();

//     // Get or create controllers
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     if (Get.isRegistered<AppointmentController>()) {
//       appointmentController = Get.find<AppointmentController>();
//     } else {
//       appointmentController = Get.put(AppointmentController());
//     }

//     // Fetch linked parents after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchExpertLinkedParents();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Linked Families',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
//             tooltip: 'View Appointments',
//             onPressed: () => Get.toNamed(AppRoutes.expertAppointments),
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchExpertLinkedParents(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading linked families...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.linkedParents.isEmpty) {
//           return _buildEmptyState(context);
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           itemCount: controller.linkedParents.length,
//           itemBuilder: (context, index) {
//             final linkedParent = controller.linkedParents[index];
//             return _buildLinkedParentCard(context, linkedParent);
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLinkedParentCard(BuildContext context, linkedParent) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Child Avatar
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.accentColor.withOpacity(0.8),
//                         AppColors.accentColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       linkedParent.children.getInitials(),
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),

//                 // Child Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         linkedParent.children.childName,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.042,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.family_restroom_outlined,
//                             size: 14,
//                             color: AppColors.primaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Expanded(
//                             child: Text(
//                               'Linked Family',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.034,
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Linked Badge
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.link,
//                     color: AppColors.successColor,
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Linked Date
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   'Linked since: ',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   linkedParent.getFormattedDate(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textPrimaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   linkedParent.getFormattedTime(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Create Appointment Options
//             Text(
//               'Create Appointment:',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.036,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Appointment Type Options (2x2 Grid)
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.video_call,
//                     label: 'Meet',
//                     color: AppColors.primaryColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'google_meet',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.phone,
//                     label: 'Call',
//                     color: AppColors.accentColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'call',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.chat_bubble_outline,
//                     label: 'Chat',
//                     color: AppColors.successColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'chat',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.location_on,
//                     label: 'Physical',
//                     color: AppColors.warningColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'physical',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentOption(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     final size = CustomSize();

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             vertical: size.customHeight(context) * 0.012,
//           ),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: color.withOpacity(0.3)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, color: color, size: 18),
//               SizedBox(width: size.customWidth(context) * 0.015),
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   fontWeight: FontWeight.w600,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCreateAppointmentDialog(
//     BuildContext context,
//     linkedParent,
//     String appointmentType,
//   ) {
//     Get.bottomSheet(
//       CreateAppointmentBottomSheet(
//         linkedParent: linkedParent,
//         appointmentType: appointmentType,
//         appointmentController: appointmentController,
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

// // lib/view/expert/expert_linked_parents_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/appointment_controller.dart';
// import 'package:speechspectrum/controllers/expert_chat_controller.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertLinkedParentsScreen extends StatefulWidget {
//   const ExpertLinkedParentsScreen({super.key});

//   @override
//   State<ExpertLinkedParentsScreen> createState() =>
//       _ExpertLinkedParentsScreenState();
// }

// class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
//   late final ExpertConsultationController controller;
//   late final AppointmentController appointmentController;
//   late final ExpertChatController chatController;

//   @override
//   void initState() {
//     super.initState();

//     // Get or create controllers
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     if (Get.isRegistered<AppointmentController>()) {
//       appointmentController = Get.find<AppointmentController>();
//     } else {
//       appointmentController = Get.put(AppointmentController());
//     }

//     if (Get.isRegistered<ExpertChatController>()) {
//       chatController = Get.find<ExpertChatController>();
//     } else {
//       chatController = Get.put(ExpertChatController());
//     }

//     // Fetch linked parents after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchExpertLinkedParents();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Linked Families',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.chat_bubble_outline, color: AppColors.successColor),
//             tooltip: 'Messages',
//             onPressed: () => Get.toNamed(AppRoutes.expertChats),
//           ),
//           IconButton(
//             icon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
//             tooltip: 'View Appointments',
//             onPressed: () => Get.toNamed(AppRoutes.expertAppointments),
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchExpertLinkedParents(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading linked families...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.linkedParents.isEmpty) {
//           return _buildEmptyState(context);
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           itemCount: controller.linkedParents.length,
//           itemBuilder: (context, index) {
//             final linkedParent = controller.linkedParents[index];
//             return _buildLinkedParentCard(context, linkedParent);
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLinkedParentCard(BuildContext context, linkedParent) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Child Avatar
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.accentColor.withOpacity(0.8),
//                         AppColors.accentColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       linkedParent.children.getInitials(),
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),

//                 // Child Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         linkedParent.children.childName,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.042,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.family_restroom_outlined,
//                             size: 14,
//                             color: AppColors.primaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Expanded(
//                             child: Text(
//                               'Linked Family',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.034,
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Linked Badge
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.link,
//                     color: AppColors.successColor,
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Linked Date
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   'Linked since: ',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   linkedParent.getFormattedDate(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textPrimaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   linkedParent.getFormattedTime(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Create Appointment Options
//             Text(
//               'Create Appointment:',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.036,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Appointment Type Options (2x2 Grid)
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.video_call,
//                     label: 'Meet',
//                     color: AppColors.primaryColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'google_meet',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.phone,
//                     label: 'Call',
//                     color: AppColors.accentColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'call',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.chat_bubble_outline,
//                     label: 'Chat',
//                     color: AppColors.successColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'chat',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.location_on,
//                     label: 'Physical',
//                     color: AppColors.warningColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'physical',
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Chat Button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton.icon(
//                 onPressed: () => _createOrOpenChat(linkedParent),
//                 icon: Icon(
//                   Icons.chat_bubble_outline,
//                   size: 18,
//                   color: AppColors.whiteColor,
//                 ),
//                 label: Text(
//                   'Open Chat',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.038,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.whiteColor,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.successColor,
//                   padding: EdgeInsets.symmetric(
//                     vertical: size.customHeight(context) * 0.015,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Create or Open Chat
//   Future<void> _createOrOpenChat(linkedParent) async {
//     // Show loading
//     Get.dialog(
//       Center(
//         child: Container(
//           padding: EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: AppColors.whiteColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(color: AppColors.primaryColor),
//               SizedBox(height: 16),
//               Text(
//                 'Opening chat...',
//                 style: GoogleFonts.poppins(
//                   fontSize: 14,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       barrierDismissible: false,
//     );

//     // Create conversation
//     final conversationId = await chatController.createConversation(
//       linkId: linkedParent.linkId,
//     );

//     // Close loading dialog
//     Get.back();

//     if (conversationId != null) {
//       // Navigate to chat
//       Get.toNamed(
//         AppRoutes.expertChatConversation,
//         arguments: {
//           'conversationId': conversationId,
//           'childName': linkedParent.children.childName,
//         },
//       );
//     }
//   }

//   Widget _buildAppointmentOption(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     final size = CustomSize();

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             vertical: size.customHeight(context) * 0.012,
//           ),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: color.withOpacity(0.3)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, color: color, size: 18),
//               SizedBox(width: size.customWidth(context) * 0.015),
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   fontWeight: FontWeight.w600,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCreateAppointmentDialog(
//     BuildContext context,
//     linkedParent,
//     String appointmentType,
//   ) {
//     Get.bottomSheet(
//       CreateAppointmentBottomSheet(
//         linkedParent: linkedParent,
//         appointmentType: appointmentType,
//         appointmentController: appointmentController,
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.link_off_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Linked Families',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'You don\'t have any linked families yet.\nApproved consultations will appear here.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Keep the existing CreateAppointmentBottomSheet class exactly as is
// // ... (same code as before)


//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.link_off_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Linked Families',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'You don\'t have any linked families yet.\nApproved consultations will appear here.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }


// // Create Appointment Bottom Sheet
// class CreateAppointmentBottomSheet extends StatefulWidget {
//   final dynamic linkedParent;
//   final String appointmentType;
//   final AppointmentController appointmentController;

//   const CreateAppointmentBottomSheet({
//     Key? key,
//     required this.linkedParent,
//     required this.appointmentType,
//     required this.appointmentController,
//   }) : super(key: key);

//   @override
//   State<CreateAppointmentBottomSheet> createState() =>
//       _CreateAppointmentBottomSheetState();
// }

// class _CreateAppointmentBottomSheetState
//     extends State<CreateAppointmentBottomSheet> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();

//   @override
//   void initState() {
//     super.initState();
//     widget.appointmentController.clearFormData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Handle
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: AppColors.greyColor.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Title
//               Text(
//                 'Create ${_getAppointmentTypeLabel()} Appointment',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.05,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.005),
//               Text(
//                 'For: ${widget.linkedParent.children.childName}',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Date & Time Selection
//               _buildDateTimePicker(context),
//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Type-specific fields
//               if (widget.appointmentType == 'google_meet')
//                 _buildMeetFields(context),
//               if (widget.appointmentType == 'call') _buildCallFields(context),
//               if (widget.appointmentType == 'physical')
//                 _buildPhysicalFields(context),
//               if (widget.appointmentType == 'chat') _buildChatFields(context),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Create Button
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     height: size.customHeight(context) * 0.06,
//                     child: ElevatedButton(
//                       onPressed: widget.appointmentController.isCreating.value
//                           ? null
//                           : () => _createAppointment(),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child:
//                           widget.appointmentController.isCreating.value
//                               ? const SizedBox(
//                                   width: 24,
//                                   height: 24,
//                                   child: CircularProgressIndicator(
//                                     color: AppColors.whiteColor,
//                                     strokeWidth: 2,
//                                   ),
//                                 )
//                               : Text(
//                                   'Create Appointment',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: size.customWidth(context) * 0.042,
//                                     fontWeight: FontWeight.w600,
//                                     color: AppColors.whiteColor,
//                                   ),
//                                 ),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateTimePicker(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Schedule Date & Time',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         Row(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () async {
//                   final picked = await showDatePicker(
//                     context: context,
//                     initialDate: selectedDate,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 365)),
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       selectedDate = picked;
//                     });
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                   decoration: BoxDecoration(
//                     color: AppColors.lightGreyColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.calendar_today,
//                           color: AppColors.primaryColor, size: 20),
//                       SizedBox(width: size.customWidth(context) * 0.02),
//                       Text(
//                         '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.036,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.03),
//             Expanded(
//               child: InkWell(
//                 onTap: () async {
//                   final picked = await showTimePicker(
//                     context: context,
//                     initialTime: selectedTime,
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       selectedTime = picked;
//                     });
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                   decoration: BoxDecoration(
//                     color: AppColors.lightGreyColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.access_time,
//                           color: AppColors.primaryColor, size: 20),
//                       SizedBox(width: size.customWidth(context) * 0.02),
//                       Text(
//                         selectedTime.format(context),
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.036,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMeetFields(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Meeting Duration (minutes)',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         TextField(
//           controller: widget.appointmentController.durationController,
//           keyboardType: TextInputType.number,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter duration (e.g., 30)',
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCallFields(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Contact Number',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         TextField(
//           controller: widget.appointmentController.contactController,
//           keyboardType: TextInputType.phone,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter contact number',
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPhysicalFields(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Location/Address',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         TextField(
//           controller: widget.appointmentController.locationController,
//           maxLines: 2,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter clinic/office address',
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildChatFields(BuildContext context) {
//     final size = CustomSize();

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: AppColors.successColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.successColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.info_outline,
//             color: AppColors.successColor,
//             size: 20,
//           ),
//           SizedBox(width: size.customWidth(context) * 0.03),
//           Expanded(
//             child: Text(
//               'Chat feature will be available soon',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.034,
//                 color: AppColors.successColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getAppointmentTypeLabel() {
//     switch (widget.appointmentType) {
//       case 'google_meet':
//         return 'Google Meet';
//       case 'call':
//         return 'Call';
//       case 'physical':
//         return 'Physical';
//       case 'chat':
//         return 'Chat';
//       default:
//         return '';
//     }
//   }

//   void _createAppointment() async {
//     final scheduledDateTime = DateTime(
//       selectedDate.year,
//       selectedDate.month,
//       selectedDate.day,
//       selectedTime.hour,
//       selectedTime.minute,
//     );

//     bool success = false;

//     switch (widget.appointmentType) {
//       case 'google_meet':
//         success = await widget.appointmentController.createAppointmentWithMeet(
//           linkId: widget.linkedParent.linkId,
//           childName: widget.linkedParent.children.childName,
//           scheduledDateTime: scheduledDateTime,
//         );
//         break;
//       case 'call':
//         if (widget.appointmentController.contactController.text
//             .trim()
//             .isEmpty) {
//           Get.snackbar(
//             'Error',
//             'Please enter a contact number',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: AppColors.errorColor,
//             colorText: AppColors.whiteColor,
//           );
//           return;
//         }
//         success = await widget.appointmentController.createAppointmentWithCall(
//           linkId: widget.linkedParent.linkId,
//           scheduledDateTime: scheduledDateTime,
//           contact: widget.appointmentController.contactController.text.trim(),
//         );
//         break;
//       case 'physical':
//         if (widget.appointmentController.locationController.text
//             .trim()
//             .isEmpty) {
//           Get.snackbar(
//             'Error',
//             'Please enter a location',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: AppColors.errorColor,
//             colorText: AppColors.whiteColor,
//           );
//           return;
//         }
//         success =
//             await widget.appointmentController.createAppointmentWithPhysical(
//           linkId: widget.linkedParent.linkId,
//           scheduledDateTime: scheduledDateTime,
//           location:
//               widget.appointmentController.locationController.text.trim(),
//         );
//         break;
//       case 'chat':
//         success = await widget.appointmentController.createAppointmentWithChat(
//           linkId: widget.linkedParent.linkId,
//           scheduledDateTime: scheduledDateTime,
//         );
//         break;
//     }

//     if (success) {
//       Get.back(); // Close bottom sheet
//     }
//   }
// }


// // lib/view/expert/expert_linked_parents_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/appointment_controller.dart';
// import 'package:speechspectrum/controllers/expert_chat_controller.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ExpertLinkedParentsScreen extends StatefulWidget {
//   const ExpertLinkedParentsScreen({super.key});

//   @override
//   State<ExpertLinkedParentsScreen> createState() =>
//       _ExpertLinkedParentsScreenState();
// }

// class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
//   late final ExpertConsultationController controller;
//   late final AppointmentController appointmentController;
//   late final ExpertChatController chatController;

//   @override
//   void initState() {
//     super.initState();

//     // Get or create controllers
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     if (Get.isRegistered<AppointmentController>()) {
//       appointmentController = Get.find<AppointmentController>();
//     } else {
//       appointmentController = Get.put(AppointmentController());
//     }

//     if (Get.isRegistered<ExpertChatController>()) {
//       chatController = Get.find<ExpertChatController>();
//     } else {
//       chatController = Get.put(ExpertChatController());
//     }

//     // Fetch linked parents after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchExpertLinkedParents();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Linked Families',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.chat_bubble_outline, color: AppColors.successColor),
//             tooltip: 'Messages',
//             onPressed: () => Get.toNamed(AppRoutes.expertChats),
//           ),
//           IconButton(
//             icon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
//             tooltip: 'View Appointments',
//             onPressed: () => Get.toNamed(AppRoutes.expertAppointments),
//           ),
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchExpertLinkedParents(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading linked families...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.linkedParents.isEmpty) {
//           return _buildEmptyState(context);
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           itemCount: controller.linkedParents.length,
//           itemBuilder: (context, index) {
//             final linkedParent = controller.linkedParents[index];
//             return _buildLinkedParentCard(context, linkedParent);
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLinkedParentCard(BuildContext context, linkedParent) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Child Avatar
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.accentColor.withOpacity(0.8),
//                         AppColors.accentColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: Text(
//                       linkedParent.children.getInitials(),
//                       style: GoogleFonts.poppins(
//                         color: AppColors.whiteColor,
//                         fontSize: 26,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),

//                 // Child Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         linkedParent.children.childName,
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.042,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.family_restroom_outlined,
//                             size: 14,
//                             color: AppColors.primaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Expanded(
//                             child: Text(
//                               'Linked Family',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.034,
//                                 color: AppColors.primaryColor,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Linked Badge
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: const Icon(
//                     Icons.link,
//                     color: AppColors.successColor,
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Linked Date
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   'Linked since: ',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   linkedParent.getFormattedDate(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.034,
//                     color: AppColors.textPrimaryColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   linkedParent.getFormattedTime(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Create Appointment Options
//             Text(
//               'Create Appointment:',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.036,
//                 fontWeight: FontWeight.w600,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Appointment Type Options (2x2 Grid)
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.video_call,
//                     label: 'Meet',
//                     color: AppColors.primaryColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'google_meet',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.phone,
//                     label: 'Call',
//                     color: AppColors.accentColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'call',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: size.customHeight(context) * 0.01),
//             Row(
//               children: [
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.chat_bubble_outline,
//                     label: 'Chat',
//                     color: AppColors.successColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'chat',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: _buildAppointmentOption(
//                     context,
//                     icon: Icons.location_on,
//                     label: 'Physical',
//                     color: AppColors.warningColor,
//                     onTap: () => _showCreateAppointmentDialog(
//                       context,
//                       linkedParent,
//                       'physical',
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAppointmentOption(
//     BuildContext context, {
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     final size = CustomSize();

//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(12),
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             vertical: size.customHeight(context) * 0.012,
//           ),
//           decoration: BoxDecoration(
//             color: color.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: color.withOpacity(0.3)),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, color: color, size: 18),
//               SizedBox(width: size.customWidth(context) * 0.015),
//               Text(
//                 label,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.034,
//                   fontWeight: FontWeight.w600,
//                   color: color,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showCreateAppointmentDialog(
//     BuildContext context,
//     linkedParent,
//     String appointmentType,
//   ) {
//     Get.bottomSheet(
//       CreateAppointmentBottomSheet(
//         linkedParent: linkedParent,
//         appointmentType: appointmentType,
//         appointmentController: appointmentController,
//         chatController: chatController,
//       ),
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.link_off_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Linked Families',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'You don\'t have any linked families yet.\nApproved consultations will appear here.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Create Appointment Bottom Sheet - UPDATED with Chat Integration
// class CreateAppointmentBottomSheet extends StatefulWidget {
//   final dynamic linkedParent;
//   final String appointmentType;
//   final AppointmentController appointmentController;
//   final ExpertChatController chatController;

//   const CreateAppointmentBottomSheet({
//     Key? key,
//     required this.linkedParent,
//     required this.appointmentType,
//     required this.appointmentController,
//     required this.chatController,
//   }) : super(key: key);

//   @override
//   State<CreateAppointmentBottomSheet> createState() =>
//       _CreateAppointmentBottomSheetState();
// }

// class _CreateAppointmentBottomSheetState
//     extends State<CreateAppointmentBottomSheet> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();

//   @override
//   void initState() {
//     super.initState();
//     widget.appointmentController.clearFormData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Container(
//       decoration: const BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25),
//           topRight: Radius.circular(25),
//         ),
//       ),
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//       ),
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Handle
//               Center(
//                 child: Container(
//                   width: 40,
//                   height: 4,
//                   decoration: BoxDecoration(
//                     color: AppColors.greyColor.withOpacity(0.3),
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Title
//               Text(
//                 'Create ${_getAppointmentTypeLabel()} Appointment',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.05,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.005),
//               Text(
//                 'For: ${widget.linkedParent.children.childName}',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textSecondaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Date & Time Selection
//               _buildDateTimePicker(context),
//               SizedBox(height: size.customHeight(context) * 0.02),

//               // Type-specific fields
//               if (widget.appointmentType == 'google_meet')
//                 _buildMeetFields(context),
//               if (widget.appointmentType == 'call') _buildCallFields(context),
//               if (widget.appointmentType == 'physical')
//                 _buildPhysicalFields(context),
//               if (widget.appointmentType == 'chat') _buildChatFields(context),

//               SizedBox(height: size.customHeight(context) * 0.025),

//               // Create Button
//               Obx(() => SizedBox(
//                     width: double.infinity,
//                     height: size.customHeight(context) * 0.06,
//                     child: ElevatedButton(
//                       onPressed: widget.appointmentController.isCreating.value ||
//                               widget.chatController.isCreatingConversation.value
//                           ? null
//                           : () => _createAppointment(),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15),
//                         ),
//                       ),
//                       child: widget.appointmentController.isCreating.value ||
//                               widget.chatController.isCreatingConversation.value
//                           ? const SizedBox(
//                               width: 24,
//                               height: 24,
//                               child: CircularProgressIndicator(
//                                 color: AppColors.whiteColor,
//                                 strokeWidth: 2,
//                               ),
//                             )
//                           : Text(
//                               'Create Appointment',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.042,
//                                 fontWeight: FontWeight.w600,
//                                 color: AppColors.whiteColor,
//                               ),
//                             ),
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildDateTimePicker(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Schedule Date & Time',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         Row(
//           children: [
//             Expanded(
//               child: InkWell(
//                 onTap: () async {
//                   final picked = await showDatePicker(
//                     context: context,
//                     initialDate: selectedDate,
//                     firstDate: DateTime.now(),
//                     lastDate: DateTime.now().add(const Duration(days: 365)),
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       selectedDate = picked;
//                     });
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                   decoration: BoxDecoration(
//                     color: AppColors.lightGreyColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.calendar_today,
//                           color: AppColors.primaryColor, size: 20),
//                       SizedBox(width: size.customWidth(context) * 0.02),
//                       Text(
//                         '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.036,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: size.customWidth(context) * 0.03),
//             Expanded(
//               child: InkWell(
//                 onTap: () async {
//                   final picked = await showTimePicker(
//                     context: context,
//                     initialTime: selectedTime,
//                   );
//                   if (picked != null) {
//                     setState(() {
//                       selectedTime = picked;
//                     });
//                   }
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                   decoration: BoxDecoration(
//                     color: AppColors.lightGreyColor,
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.access_time,
//                           color: AppColors.primaryColor, size: 20),
//                       SizedBox(width: size.customWidth(context) * 0.02),
//                       Text(
//                         selectedTime.format(context),
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.036,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildMeetFields(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Meeting Duration (minutes)',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         TextField(
//           controller: widget.appointmentController.durationController,
//           keyboardType: TextInputType.number,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter duration (e.g., 30)',
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildCallFields(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Contact Number',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         TextField(
//           controller: widget.appointmentController.contactController,
//           keyboardType: TextInputType.phone,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter contact number',
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPhysicalFields(BuildContext context) {
//     final size = CustomSize();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Location/Address',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             fontWeight: FontWeight.w600,
//             color: AppColors.textPrimaryColor,
//           ),
//         ),
//         SizedBox(height: size.customHeight(context) * 0.01),
//         TextField(
//           controller: widget.appointmentController.locationController,
//           maxLines: 2,
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//           ),
//           decoration: InputDecoration(
//             hintText: 'Enter clinic/office address',
//             filled: true,
//             fillColor: AppColors.lightGreyColor,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding: const EdgeInsets.all(16),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildChatFields(BuildContext context) {
//     final size = CustomSize();

//     return Container(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       decoration: BoxDecoration(
//         color: AppColors.successColor.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: AppColors.successColor.withOpacity(0.3)),
//       ),
//       child: Row(
//         children: [
//           Icon(
//             Icons.info_outline,
//             color: AppColors.successColor,
//             size: 20,
//           ),
//           SizedBox(width: size.customWidth(context) * 0.03),
//           Expanded(
//             child: Text(
//               'Chat conversation will be created automatically',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.034,
//                 color: AppColors.successColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getAppointmentTypeLabel() {
//     switch (widget.appointmentType) {
//       case 'google_meet':
//         return 'Google Meet';
//       case 'call':
//         return 'Call';
//       case 'physical':
//         return 'Physical';
//       case 'chat':
//         return 'Chat';
//       default:
//         return '';
//     }
//   }

//   void _createAppointment() async {
//     final scheduledDateTime = DateTime(
//       selectedDate.year,
//       selectedDate.month,
//       selectedDate.day,
//       selectedTime.hour,
//       selectedTime.minute,
//     );

//     bool success = false;

//     switch (widget.appointmentType) {
//       case 'google_meet':
//         success = await widget.appointmentController.createAppointmentWithMeet(
//           linkId: widget.linkedParent.linkId,
//           childName: widget.linkedParent.children.childName,
//           scheduledDateTime: scheduledDateTime,
//         );
//         break;
        
//       case 'call':
//         if (widget.appointmentController.contactController.text
//             .trim()
//             .isEmpty) {
//           Get.snackbar(
//             'Error',
//             'Please enter a contact number',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: AppColors.errorColor,
//             colorText: AppColors.whiteColor,
//           );
//           return;
//         }
//         success = await widget.appointmentController.createAppointmentWithCall(
//           linkId: widget.linkedParent.linkId,
//           scheduledDateTime: scheduledDateTime,
//           contact: widget.appointmentController.contactController.text.trim(),
//         );
//         break;
        
//       case 'physical':
//         if (widget.appointmentController.locationController.text
//             .trim()
//             .isEmpty) {
//           Get.snackbar(
//             'Error',
//             'Please enter a location',
//             snackPosition: SnackPosition.BOTTOM,
//             backgroundColor: AppColors.errorColor,
//             colorText: AppColors.whiteColor,
//           );
//           return;
//         }
//         success =
//             await widget.appointmentController.createAppointmentWithPhysical(
//           linkId: widget.linkedParent.linkId,
//           scheduledDateTime: scheduledDateTime,
//           location:
//               widget.appointmentController.locationController.text.trim(),
//         );
//         break;
        
//       case 'chat':
//         // ✅ CHAT: Create appointment AND conversation, then navigate to chat
//         success = await widget.appointmentController.createAppointmentWithChat(
//           linkId: widget.linkedParent.linkId,
//           scheduledDateTime: scheduledDateTime,
//         );
        
//         if (success) {
//           // Create conversation
//           final conversationId = await widget.chatController.createConversation(
//             linkId: widget.linkedParent.linkId,
//           );
          
//           if (conversationId != null) {
//             Get.back(); // Close bottom sheet
            
//             // Navigate to chat conversation screen
//             Get.toNamed(
//               AppRoutes.expertChatConversation,
//               arguments: {
//                 'conversationId': conversationId,
//                 'childName': widget.linkedParent.children.childName,
//               },
//             );
//             return; // Don't execute the code below
//           }
//         }
//         break;
//     }

//     if (success) {
//       Get.back(); // Close bottom sheet for non-chat appointments
//     }
//   }
// }

// lib/view/expert/expert_linked_parents_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/appointment_controller.dart';
import 'package:speechspectrum/controllers/expert_chat_controller.dart';
import 'package:speechspectrum/controllers/expert_consultation_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertLinkedParentsScreen extends StatefulWidget {
  const ExpertLinkedParentsScreen({super.key});

  @override
  State<ExpertLinkedParentsScreen> createState() =>
      _ExpertLinkedParentsScreenState();
}

class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
  late final ExpertConsultationController controller;
  late final AppointmentController appointmentController;
  late final ExpertChatController chatController;

  @override
  void initState() {
    super.initState();

    // Get or create controllers
    if (Get.isRegistered<ExpertConsultationController>()) {
      controller = Get.find<ExpertConsultationController>();
    } else {
      controller = Get.put(ExpertConsultationController());
    }

    if (Get.isRegistered<AppointmentController>()) {
      appointmentController = Get.find<AppointmentController>();
    } else {
      appointmentController = Get.put(AppointmentController());
    }

    if (Get.isRegistered<ExpertChatController>()) {
      chatController = Get.find<ExpertChatController>();
    } else {
      chatController = Get.put(ExpertChatController());
    }

    // Fetch linked parents after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExpertLinkedParents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Linked Families',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat_bubble_outline, color: AppColors.successColor),
            tooltip: 'Messages',
            onPressed: () => Get.toNamed(AppRoutes.expertChats),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today, color: AppColors.primaryColor),
            tooltip: 'View Appointments',
            onPressed: () => Get.toNamed(AppRoutes.expertAppointments),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchExpertLinkedParents(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 3,
                ),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text(
                  'Loading linked families...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.linkedParents.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: EdgeInsets.all(size.customWidth(context) * 0.04),
          itemCount: controller.linkedParents.length,
          itemBuilder: (context, index) {
            final linkedParent = controller.linkedParents[index];
            return _buildLinkedParentCard(context, linkedParent);
          },
        );
      }),
    );
  }

  Widget _buildLinkedParentCard(BuildContext context, linkedParent) {
    final size = CustomSize();

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Child Avatar
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accentColor.withOpacity(0.8),
                        AppColors.accentColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      linkedParent.children.getInitials(),
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.04),

                // Child Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        linkedParent.children.childName,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.customHeight(context) * 0.004),
                      Row(
                        children: [
                          Icon(
                            Icons.family_restroom_outlined,
                            size: 14,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: size.customWidth(context) * 0.015),
                          Expanded(
                            child: Text(
                              'Linked Family',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.034,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Linked Badge
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.link,
                    color: AppColors.successColor,
                    size: 20,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.015),
            Divider(color: AppColors.greyColor.withOpacity(0.2)),
            SizedBox(height: size.customHeight(context) * 0.01),

            // Linked Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Text(
                  'Linked since: ',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  linkedParent.getFormattedDate(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  linkedParent.getFormattedTime(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.032,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.015),

            // Create Appointment Options
            Text(
              'Create Appointment:',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.036,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.01),

            // Appointment Type Options (2x2 Grid)
            Row(
              children: [
                Expanded(
                  child: _buildAppointmentOption(
                    context,
                    icon: Icons.video_call,
                    label: 'Meet',
                    color: AppColors.primaryColor,
                    onTap: () => _showCreateAppointmentDialog(
                      context,
                      linkedParent,
                      'google_meet',
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Expanded(
                  child: _buildAppointmentOption(
                    context,
                    icon: Icons.phone,
                    label: 'Call',
                    color: AppColors.accentColor,
                    onTap: () => _showCreateAppointmentDialog(
                      context,
                      linkedParent,
                      'call',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.customHeight(context) * 0.01),
            Row(
              children: [
                Expanded(
                  child: _buildAppointmentOption(
                    context,
                    icon: Icons.chat_bubble_outline,
                    label: 'Chat',
                    color: AppColors.successColor,
                    onTap: () => _showCreateAppointmentDialog(
                      context,
                      linkedParent,
                      'chat',
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Expanded(
                  child: _buildAppointmentOption(
                    context,
                    icon: Icons.location_on,
                    label: 'Physical',
                    color: AppColors.warningColor,
                    onTap: () => _showCreateAppointmentDialog(
                      context,
                      linkedParent,
                      'physical',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppointmentOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final size = CustomSize();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: size.customHeight(context) * 0.012,
          ),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              SizedBox(width: size.customWidth(context) * 0.015),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.034,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCreateAppointmentDialog(
    BuildContext context,
    linkedParent,
    String appointmentType,
  ) {
    Get.bottomSheet(
      CreateAppointmentBottomSheet(
        linkedParent: linkedParent,
        appointmentType: appointmentType,
        appointmentController: appointmentController,
        chatController: chatController,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.1),
                    AppColors.secondaryColor.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.link_off_outlined,
                size: 70,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              'No Linked Families',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'You don\'t have any linked families yet.\nApproved consultations will appear here.',
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

// Create Appointment Bottom Sheet - UPDATED with Chat Integration
class CreateAppointmentBottomSheet extends StatefulWidget {
  final dynamic linkedParent;
  final String appointmentType;
  final AppointmentController appointmentController;
  final ExpertChatController chatController;

  const CreateAppointmentBottomSheet({
    Key? key,
    required this.linkedParent,
    required this.appointmentType,
    required this.appointmentController,
    required this.chatController,
  }) : super(key: key);

  @override
  State<CreateAppointmentBottomSheet> createState() =>
      _CreateAppointmentBottomSheetState();
}

class _CreateAppointmentBottomSheetState
    extends State<CreateAppointmentBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    widget.appointmentController.clearFormData();
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.greyColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.02),

              // Title
              Text(
                'Create ${_getAppointmentTypeLabel()} Appointment',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.05,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.005),
              Text(
                'For: ${widget.linkedParent.children.childName}',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.025),

              // Date & Time Selection
              _buildDateTimePicker(context),
              SizedBox(height: size.customHeight(context) * 0.02),

              // Type-specific fields
              if (widget.appointmentType == 'google_meet')
                _buildMeetFields(context),
              if (widget.appointmentType == 'call') _buildCallFields(context),
              if (widget.appointmentType == 'physical')
                _buildPhysicalFields(context),
              if (widget.appointmentType == 'chat') _buildChatFields(context),

              SizedBox(height: size.customHeight(context) * 0.025),

              // Create Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: size.customHeight(context) * 0.06,
                    child: ElevatedButton(
                      onPressed: widget.appointmentController.isCreating.value ||
                              widget.chatController.isCreatingConversation.value
                          ? null
                          : () => _createAppointment(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: widget.appointmentController.isCreating.value ||
                              widget.chatController.isCreatingConversation.value
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: AppColors.whiteColor,
                                strokeWidth: 2,
                              ),
                            )
                          : Text(
                              'Create Appointment',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.042,
                                fontWeight: FontWeight.w600,
                                color: AppColors.whiteColor,
                              ),
                            ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    final size = CustomSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Schedule Date & Time',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        SizedBox(height: size.customHeight(context) * 0.01),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          color: AppColors.primaryColor, size: 20),
                      SizedBox(width: size.customWidth(context) * 0.02),
                      Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.036,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: size.customWidth(context) * 0.03),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final picked = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (picked != null) {
                    setState(() {
                      selectedTime = picked;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time,
                          color: AppColors.primaryColor, size: 20),
                      SizedBox(width: size.customWidth(context) * 0.02),
                      Text(
                        selectedTime.format(context),
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.036,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMeetFields(BuildContext context) {
    final size = CustomSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Meeting Duration (minutes)',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        SizedBox(height: size.customHeight(context) * 0.01),
        TextField(
          controller: widget.appointmentController.durationController,
          keyboardType: TextInputType.number,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
          ),
          decoration: InputDecoration(
            hintText: 'Enter duration (e.g., 30)',
            filled: true,
            fillColor: AppColors.lightGreyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildCallFields(BuildContext context) {
    final size = CustomSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Number',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        SizedBox(height: size.customHeight(context) * 0.01),
        TextField(
          controller: widget.appointmentController.contactController,
          keyboardType: TextInputType.phone,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
          ),
          decoration: InputDecoration(
            hintText: 'Enter contact number',
            filled: true,
            fillColor: AppColors.lightGreyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildPhysicalFields(BuildContext context) {
    final size = CustomSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location/Address',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryColor,
          ),
        ),
        SizedBox(height: size.customHeight(context) * 0.01),
        TextField(
          controller: widget.appointmentController.locationController,
          maxLines: 2,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.038,
          ),
          decoration: InputDecoration(
            hintText: 'Enter clinic/office address',
            filled: true,
            fillColor: AppColors.lightGreyColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }

  Widget _buildChatFields(BuildContext context) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.successColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.successColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: AppColors.successColor,
            size: 20,
          ),
          SizedBox(width: size.customWidth(context) * 0.03),
          Expanded(
            child: Text(
              'Chat conversation will be created automatically',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.034,
                color: AppColors.successColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getAppointmentTypeLabel() {
    switch (widget.appointmentType) {
      case 'google_meet':
        return 'Google Meet';
      case 'call':
        return 'Call';
      case 'physical':
        return 'Physical';
      case 'chat':
        return 'Chat';
      default:
        return '';
    }
  }

  void _createAppointment() async {
    final scheduledDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    bool success = false;

    switch (widget.appointmentType) {
      case 'google_meet':
        success = await widget.appointmentController.createAppointmentWithMeet(
          linkId: widget.linkedParent.linkId,
          childName: widget.linkedParent.children.childName,
          scheduledDateTime: scheduledDateTime,
        );
        break;
        
      case 'call':
        if (widget.appointmentController.contactController.text
            .trim()
            .isEmpty) {
          Get.snackbar(
            'Error',
            'Please enter a contact number',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.errorColor,
            colorText: AppColors.whiteColor,
          );
          return;
        }
        success = await widget.appointmentController.createAppointmentWithCall(
          linkId: widget.linkedParent.linkId,
          scheduledDateTime: scheduledDateTime,
          contact: widget.appointmentController.contactController.text.trim(),
        );
        break;
        
      case 'physical':
        if (widget.appointmentController.locationController.text
            .trim()
            .isEmpty) {
          Get.snackbar(
            'Error',
            'Please enter a location',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppColors.errorColor,
            colorText: AppColors.whiteColor,
          );
          return;
        }
        success =
            await widget.appointmentController.createAppointmentWithPhysical(
          linkId: widget.linkedParent.linkId,
          scheduledDateTime: scheduledDateTime,
          location:
              widget.appointmentController.locationController.text.trim(),
        );
        break;
        
      case 'chat':
        // ✅ CHAT: Create appointment AND conversation, then navigate to chat
        success = await widget.appointmentController.createAppointmentWithChat(
          linkId: widget.linkedParent.linkId,
          scheduledDateTime: scheduledDateTime,
        );
        
        if (success) {
          // Create conversation
          final conversationId = await widget.chatController.createConversation(
            linkId: widget.linkedParent.linkId,
          );
          
          if (conversationId != null) {
            Get.back(); // Close bottom sheet
            
            // Navigate to chat conversation screen
            Get.toNamed(
              AppRoutes.expertChatConversation,
              arguments: {
                'conversationId': conversationId,
                'childName': widget.linkedParent.children.childName,
              },
            );
            return; // Don't execute the code below
          }
        }
        break;
    }

    if (success) {
      Get.back(); // Close bottom sheet for non-chat appointments
    }
  }
}