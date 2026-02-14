// // lib/view/expert/expert_consultations_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';

// class ExpertConsultationsScreen extends StatefulWidget {
//   const ExpertConsultationsScreen({super.key});

//   @override
//   State<ExpertConsultationsScreen> createState() => _ExpertConsultationsScreenState();
// }

// class _ExpertConsultationsScreenState extends State<ExpertConsultationsScreen> with SingleTickerProviderStateMixin {
//   late final ExpertConsultationController controller;
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);

//     // Get or create controller
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     // Fetch consultations after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchConsultations();
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
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
//           'Consultation Requests',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchConsultations(),
//           ),
//         ],
//         bottom: TabBar(
//           controller: _tabController,
//           labelColor: AppColors.primaryColor,
//           unselectedLabelColor: AppColors.textSecondaryColor,
//           indicatorColor: AppColors.primaryColor,
//           indicatorWeight: 3,
//           labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
//           unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
//           tabs: [
//             Tab(text: 'Pending'),
//             Tab(text: 'Approved'),
//             Tab(text: 'All'),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           // Search Bar
//           Container(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             color: AppColors.whiteColor,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.lightGreyColor,
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               child: TextField(
//                 controller: controller.searchController,
//                 onChanged: controller.searchConsultations,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.04,
//                   color: AppColors.textPrimaryColor,
//                 ),
//                 decoration: InputDecoration(
//                   hintText: 'Search consultations...',
//                   hintStyle: GoogleFonts.poppins(
//                     color: AppColors.greyColor,
//                     fontSize: size.customWidth(context) * 0.038,
//                   ),
//                   prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
//                   suffixIcon: Obx(() {
//                     return controller.searchText.value.isNotEmpty
//                         ? IconButton(
//                             icon: const Icon(Icons.clear, color: AppColors.greyColor),
//                             onPressed: controller.clearSearch,
//                           )
//                         : const SizedBox.shrink();
//                   }),
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: size.customWidth(context) * 0.04,
//                     vertical: size.customHeight(context) * 0.018,
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Tab Views
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                         strokeWidth: 3,
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.02),
//                       Text(
//                         'Loading consultations...',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textSecondaryColor,
//                           fontSize: size.customWidth(context) * 0.035,
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }

//               return TabBarView(
//                 controller: _tabController,
//                 children: [
//                   _buildConsultationsList(controller.filteredConsultations.where((c) => c.isPending()).toList()),
//                   _buildConsultationsList(controller.filteredConsultations.where((c) => c.isApproved()).toList()),
//                   _buildConsultationsList(controller.filteredConsultations),
//                 ],
//               );
//             }),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildConsultationsList(List consultations) {
//     final size = CustomSize();

//     if (consultations.isEmpty) {
//       return _buildEmptyState(context);
//     }

//     return ListView.builder(
//       padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//       itemCount: consultations.length,
//       itemBuilder: (context, index) {
//         final consultation = consultations[index];
//         return _buildConsultationCard(context, consultation);
//       },
//     );
//   }

//   Widget _buildConsultationCard(BuildContext context, consultation) {
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
//                 // Icon
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         consultation.isPending()
//                             ? AppColors.warningColor.withOpacity(0.8)
//                             : consultation.isApproved()
//                                 ? AppColors.successColor.withOpacity(0.8)
//                                 : AppColors.errorColor.withOpacity(0.8),
//                         consultation.isPending()
//                             ? AppColors.warningColor
//                             : consultation.isApproved()
//                                 ? AppColors.successColor
//                                 : AppColors.errorColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: const Icon(
//                     Icons.person_outline,
//                     color: AppColors.whiteColor,
//                     size: 28,
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.03),

//                 // Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Request ID',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                       Text(
//                         consultation.requestId.substring(0, 8) + '...',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Status Badge
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: size.customWidth(context) * 0.03,
//                     vertical: size.customHeight(context) * 0.006,
//                   ),
//                   decoration: BoxDecoration(
//                     color: consultation.isPending()
//                         ? AppColors.warningColor.withOpacity(0.1)
//                         : consultation.isApproved()
//                             ? AppColors.successColor.withOpacity(0.1)
//                             : AppColors.errorColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     consultation.status.toUpperCase(),
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.028,
//                       fontWeight: FontWeight.bold,
//                       color: consultation.isPending()
//                           ? AppColors.warningColor
//                           : consultation.isApproved()
//                               ? AppColors.successColor
//                               : AppColors.errorColor,
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Details
//             Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.calendar_today_outlined,
//                             size: 14,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Text(
//                             consultation.getFormattedDate(),
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.032,
//                               color: AppColors.textSecondaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.008),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.access_time_outlined,
//                             size: 14,
//                             color: AppColors.textSecondaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Text(
//                             consultation.getFormattedTime(),
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.032,
//                               color: AppColors.textSecondaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             // Action Button
//             if (consultation.isPending()) ...[
//               SizedBox(height: size.customHeight(context) * 0.015),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => _showResponseDialog(context, consultation),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.primaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.012),
//                   ),
//                   child: Text(
//                     'Respond to Request',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor,
//                       fontSize: size.customWidth(context) * 0.036,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
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
//                 Icons.medical_services_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Consultations',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'No consultation requests found\nfor this category',
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

//   void _showResponseDialog(BuildContext context, consultation) {
//     final size = CustomSize();
//     final messageController = TextEditingController();

//     Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//         child: Container(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 80,
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: AppColors.primaryColor.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(Icons.assignment_outlined, color: AppColors.primaryColor, size: 45),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.025),
//               Text(
//                 'Respond to Consultation',
//                 style: GoogleFonts.poppins(
//                   fontWeight: FontWeight.bold,
//                   fontSize: size.customWidth(context) * 0.05,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               Text(
//                 'Send a message to the parent',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.4,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.025),
              
//               // Message TextField
//               TextField(
//                 controller: messageController,
//                 maxLines: 4,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your response message...',
//                   hintStyle: GoogleFonts.poppins(
//                     color: AppColors.greyColor,
//                     fontSize: size.customWidth(context) * 0.036,
//                   ),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: AppColors.greyColor.withOpacity(0.3)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
//                   ),
//                   contentPadding: EdgeInsets.all(size.customWidth(context) * 0.04),
//                 ),
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),

//               SizedBox(height: size.customHeight(context) * 0.025),
              
//               Row(
//                 children: [
//                   Expanded(
//                     child: OutlinedButton(
//                       onPressed: () {
//                         Get.back();
//                         messageController.dispose();
//                       },
//                       style: OutlinedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.015),
//                         side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                       ),
//                       child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontWeight: FontWeight.w600)),
//                     ),
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.03),
//                   Expanded(
//                     child: Obx(() => ElevatedButton(
//                           onPressed: controller.isResponding.value
//                               ? null
//                               : () async {
//                                   if (messageController.text.trim().isEmpty) {
//                                     Get.snackbar(
//                                       'Error',
//                                       'Please enter a response message',
//                                       snackPosition: SnackPosition.BOTTOM,
//                                       backgroundColor: AppColors.errorColor,
//                                       colorText: AppColors.whiteColor,
//                                     );
//                                     return;
//                                   }

//                                   await controller.respondToConsultation(
//                                     requestId: consultation.requestId,
//                                     status: 'approved',
//                                     responseMessage: messageController.text.trim(),
//                                     parentUserId: consultation.parentUserId,
//                                     childId: consultation.childId,
//                                   );
//                                   messageController.dispose();
//                                 },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.successColor,
//                             padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.015),
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                           ),
//                           child: controller.isResponding.value
//                               ? const SizedBox(
//                                   width: 20,
//                                   height: 20,
//                                   child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2),
//                                 )
//                               : Text('Approve', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600)),
//                         )),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/view/expert/expert_consultations_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_consultation_controller.dart';

class ExpertConsultationsScreen extends StatefulWidget {
  const ExpertConsultationsScreen({super.key});

  @override
  State<ExpertConsultationsScreen> createState() =>
      _ExpertConsultationsScreenState();
}

class _ExpertConsultationsScreenState extends State<ExpertConsultationsScreen>
    with SingleTickerProviderStateMixin {
  late final ExpertConsultationController controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Get or create controller
    if (Get.isRegistered<ExpertConsultationController>()) {
      controller = Get.find<ExpertConsultationController>();
    } else {
      controller = Get.put(ExpertConsultationController());
    }

    // Fetch consultations after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExpertConsultations();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Consultation Requests',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchExpertConsultations(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          isScrollable: true,
          labelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
            Tab(text: 'Rejected'),
          ],
        ),
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
                  'Loading consultations...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
              ],
            ),
          );
        }

        return TabBarView(
          controller: _tabController,
          children: [
            _buildConsultationsList(controller.consultations),
            _buildConsultationsList(
                controller.consultations.where((c) => c.isPending()).toList()),
            _buildConsultationsList(
                controller.consultations.where((c) => c.isApproved()).toList()),
            _buildConsultationsList(
                controller.consultations.where((c) => c.isRejected()).toList()),
          ],
        );
      }),
    );
  }

  Widget _buildConsultationsList(List consultations) {
    final size = CustomSize();

    if (consultations.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      itemCount: consultations.length,
      itemBuilder: (context, index) {
        final consultation = consultations[index];
        return _buildConsultationCard(context, consultation);
      },
    );
  }

  Widget _buildConsultationCard(BuildContext context, consultation) {
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
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accentColor.withOpacity(0.8),
                        AppColors.accentColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      consultation.children.getInitials(),
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.03),

                // Child Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consultation.children.childName,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.04,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.customHeight(context) * 0.003),
                      Text(
                        'Consultation Request',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.032,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.customWidth(context) * 0.03,
                    vertical: size.customHeight(context) * 0.006,
                  ),
                  decoration: BoxDecoration(
                    color: consultation.isPending()
                        ? AppColors.warningColor.withOpacity(0.1)
                        : consultation.isApproved()
                            ? AppColors.successColor.withOpacity(0.1)
                            : AppColors.errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    consultation.status.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.028,
                      fontWeight: FontWeight.bold,
                      color: consultation.isPending()
                          ? AppColors.warningColor
                          : consultation.isApproved()
                              ? AppColors.successColor
                              : AppColors.errorColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.015),
            Divider(color: AppColors.greyColor.withOpacity(0.2)),
            SizedBox(height: size.customHeight(context) * 0.01),

            // Date Info
            Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Text(
                  'Requested: ',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  consultation.getFormattedDate(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  consultation.getFormattedTime(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.032,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),

            // Respond Button (only for pending)
            if (consultation.isPending()) ...[
              SizedBox(height: size.customHeight(context) * 0.015),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _showRespondDialog(
                        context,
                        consultation,
                        'rejected',
                      ),
                      icon: const Icon(Icons.close, size: 18),
                      label: Text(
                        'Reject',
                        style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.034),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.errorColor,
                        side: BorderSide(
                            color: AppColors.errorColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: size.customHeight(context) * 0.012),
                      ),
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _showRespondDialog(
                        context,
                        consultation,
                        'approved',
                      ),
                      icon: const Icon(Icons.check, size: 18),
                      label: Text(
                        'Approve',
                        style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.034),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successColor,
                        foregroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: size.customHeight(context) * 0.012),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showRespondDialog(
      BuildContext context, consultation, String status) {
    final size = CustomSize();
    controller.responseMessageController.clear();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Container(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: status == 'approved'
                      ? AppColors.successColor.withOpacity(0.1)
                      : AppColors.errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  status == 'approved' ? Icons.check_circle : Icons.cancel,
                  color:
                      status == 'approved' ? AppColors.successColor : AppColors.errorColor,
                  size: 45,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.025),
              Text(
                status == 'approved'
                    ? 'Approve Consultation'
                    : 'Reject Consultation',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: size.customWidth(context) * 0.05,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                'Add a message for the parent',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.02),
              TextField(
                controller: controller.responseMessageController,
                maxLines: 3,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textPrimaryColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Enter your response message...',
                  hintStyle: GoogleFonts.poppins(
                    color: AppColors.greyColor,
                    fontSize: size.customWidth(context) * 0.036,
                  ),
                  filled: true,
                  fillColor: AppColors.lightGreyColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: size.customHeight(context) * 0.015),
                        side: BorderSide(
                            color: AppColors.greyColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
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
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isResponding.value
                              ? null
                              : () async {
                                  if (controller.responseMessageController.text
                                      .trim()
                                      .isEmpty) {
                                    Get.snackbar(
                                      'Error',
                                      'Please enter a response message',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppColors.errorColor,
                                      colorText: AppColors.whiteColor,
                                    );
                                    return;
                                  }

                                  await controller.respondToConsultation(
                                    requestId: consultation.requestId,
                                    status: status,
                                    responseMessage: controller
                                        .responseMessageController.text
                                        .trim(),
                                    parentUserId: consultation.parentUserId,
                                    childId: consultation.childId,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: status == 'approved'
                                ? AppColors.successColor
                                : AppColors.errorColor,
                            padding: EdgeInsets.symmetric(
                                vertical: size.customHeight(context) * 0.015),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          child: controller.isResponding.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Respond',
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
                Icons.medical_services_outlined,
                size: 70,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              'No Consultations',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'No consultation requests\navailable at the moment',
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