// // lib/view/speech/speech_submissions_screen.dart

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/speech_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class SpeechSubmissionsScreen extends StatefulWidget {
//   const SpeechSubmissionsScreen({super.key});

//   @override
//   State<SpeechSubmissionsScreen> createState() =>
//       _SpeechSubmissionsScreenState();
// }

// class _SpeechSubmissionsScreenState extends State<SpeechSubmissionsScreen> {
//   late final SpeechController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.put(SpeechController());
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchAllSubmissions();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: CustomScrollView(
//         slivers: [
//           // App Bar
//           SliverAppBar(
//             expandedHeight: MediaQuery.of(context).size.height * 0.25,
//             pinned: true,
//             elevation: 0,
//             backgroundColor: AppColors.primaryColor,
//             flexibleSpace: FlexibleSpaceBar(
//               background: _buildHeader(context),
//             ),
//             leading: IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
//               onPressed: () => Get.back(),
//             ),
//             actions: [
//               IconButton(
//                 icon: const Icon(Icons.add_rounded, color: AppColors.whiteColor),
//                 onPressed: () => Get.toNamed(AppRoutes.speechRecording),
//               ),
//             ],
//           ),

//           // Search Bar
//           SliverToBoxAdapter(
//             child: Padding(
//               padding: EdgeInsets.fromLTRB(
//                 size.customWidth(context) * 0.05,
//                 size.customHeight(context) * 0.02,
//                 size.customWidth(context) * 0.05,
//                 size.customHeight(context) * 0.01,
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   borderRadius: BorderRadius.circular(15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 15,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: TextField(
//                   controller: controller.searchController,
//                   onChanged: controller.searchSubmissions,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'Search by child name...',
//                     hintStyle: GoogleFonts.poppins(
//                       color: AppColors.greyColor,
//                       fontSize: size.customWidth(context) * 0.038,
//                     ),
//                     prefixIcon: const Icon(Icons.search,
//                         color: AppColors.primaryColor),
//                     suffixIcon: Obx(() {
//                       return controller.searchText.value.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear,
//                                   color: AppColors.greyColor),
//                               onPressed: controller.clearSearch,
//                             )
//                           : const SizedBox.shrink();
//                     }),
//                     border: InputBorder.none,
//                     contentPadding: EdgeInsets.symmetric(
//                       horizontal: size.customWidth(context) * 0.04,
//                       vertical: size.customHeight(context) * 0.018,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Submissions List
//           Obx(() {
//             if (controller.isLoadingSubmissions.value) {
//               return SliverFillRemaining(
//                 child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const CircularProgressIndicator(
//                         color: AppColors.primaryColor,
//                         strokeWidth: 3,
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.02),
//                       Text(
//                         'Loading submissions...',
//                         style: GoogleFonts.poppins(
//                           color: AppColors.textSecondaryColor,
//                           fontSize: size.customWidth(context) * 0.035,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }

//             if (controller.filteredSubmissions.isEmpty) {
//               return SliverFillRemaining(
//                 child: _buildEmptyState(context),
//               );
//             }

//             return SliverPadding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.05,
//               ),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final submission = controller.filteredSubmissions[index];
//                     return _buildSubmissionCard(context, submission);
//                   },
//                   childCount: controller.filteredSubmissions.length,
//                 ),
//               ),
//             );
//           }),

//           SliverToBoxAdapter(
//             child: SizedBox(height: size.customHeight(context) * 0.1),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () => Get.toNamed(AppRoutes.speechRecording),
//         backgroundColor: AppColors.primaryColor,
//         icon: const Icon(Icons.mic_rounded, color: AppColors.whiteColor),
//         label: Text(
//           'New Recording',
//           style: GoogleFonts.poppins(
//             color: AppColors.whiteColor,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader(BuildContext context) {
//     final size = CustomSize();

//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.primaryColor, AppColors.secondaryColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   color: AppColors.whiteColor.withOpacity(0.2),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.voice_chat_rounded,
//                   size: 40,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               Text(
//                 'Speech Assessments',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: size.customWidth(context) * 0.06,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.005),
//               Obx(() => Text(
//                     '${controller.filteredSubmissions.length} submission${controller.filteredSubmissions.length != 1 ? 's' : ''}',
//                     style: GoogleFonts.poppins(
//                       color: AppColors.whiteColor.withOpacity(0.9),
//                       fontSize: size.customWidth(context) * 0.035,
//                     ),
//                   )),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSubmissionCard(BuildContext context, submission) {
//     final size = CustomSize();
//     final hasResults = submission.hasResults();
//     final result = submission.getLatestResult();

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
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () {
//             Get.toNamed(
//               AppRoutes.speechDetail,
//               arguments: submission.speechSubmissionId,
//             );
//           },
//           borderRadius: BorderRadius.circular(20),
//           child: Padding(
//             padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Container(
//                       width: 55,
//                       height: 55,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: hasResults
//                               ? [
//                                   AppColors.primaryColor.withOpacity(0.8),
//                                   AppColors.secondaryColor,
//                                 ]
//                               : [
//                                   AppColors.greyColor.withOpacity(0.3),
//                                   AppColors.greyColor
//                                 ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: Icon(
//                         hasResults ? Icons.check_circle_rounded : Icons.pending_rounded,
//                         size: 28,
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                     SizedBox(width: size.customWidth(context) * 0.03),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             submission.getChildName(),
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.042,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.textPrimaryColor,
//                             ),
//                           ),
//                           SizedBox(height: size.customHeight(context) * 0.003),
//                           Row(
//                             children: [
//                               Icon(
//                                 Icons.access_time_rounded,
//                                 size: 14,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                               SizedBox(width: size.customWidth(context) * 0.01),
//                               Text(
//                                 '${submission.recordingDurationSeconds}s',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.032,
//                                   color: AppColors.textSecondaryColor,
//                                 ),
//                               ),
//                               SizedBox(width: size.customWidth(context) * 0.03),
//                               Icon(
//                                 Icons.calendar_today_outlined,
//                                 size: 14,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                               SizedBox(width: size.customWidth(context) * 0.01),
//                               Text(
//                                 submission.getFormattedDate(),
//                                 style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.032,
//                                   color: AppColors.textSecondaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     PopupMenuButton(
//                       icon: const Icon(Icons.more_vert_rounded,
//                           color: AppColors.greyColor),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       itemBuilder: (context) => [
//                         PopupMenuItem(
//                           child: Row(
//                             children: [
//                               const Icon(Icons.visibility_rounded,
//                                   color: AppColors.primaryColor, size: 20),
//                               SizedBox(width: size.customWidth(context) * 0.02),
//                               Text(
//                                 'View Details',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.035,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Future.delayed(Duration.zero, () {
//                               Get.toNamed(
//                                 AppRoutes.speechDetail,
//                                 arguments: submission.speechSubmissionId,
//                               );
//                             });
//                           },
//                         ),
//                         PopupMenuItem(
//                           child: Row(
//                             children: [
//                               const Icon(Icons.delete_rounded,
//                                   color: AppColors.errorColor, size: 20),
//                               SizedBox(width: size.customWidth(context) * 0.02),
//                               Text(
//                                 'Delete',
//                                 style: GoogleFonts.poppins(
//                                   fontSize: size.customWidth(context) * 0.035,
//                                   color: AppColors.errorColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           onTap: () {
//                             Future.delayed(Duration.zero, () {
//                               _showDeleteConfirmation(
//                                   context, submission.speechSubmissionId);
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 if (hasResults && result != null) ...[
//                   SizedBox(height: size.customHeight(context) * 0.02),
//                   Divider(color: AppColors.greyColor.withOpacity(0.2)),
//                   SizedBox(height: size.customHeight(context) * 0.015),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Analysis Result',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.032,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                             ),
//                             SizedBox(height: size.customHeight(context) * 0.004),
//                             Text(
//                               result.result.label,
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.04,
//                                 fontWeight: FontWeight.w600,
//                                 color: result.result.isTypical()
//                                     ? AppColors.successColor
//                                     : AppColors.warningColor,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: size.customWidth(context) * 0.04,
//                           vertical: size.customHeight(context) * 0.01,
//                         ),
//                         decoration: BoxDecoration(
//                           color: (result.result.isTypical()
//                                   ? AppColors.successColor
//                                   : AppColors.warningColor)
//                               .withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                           border: Border.all(
//                             color: (result.result.isTypical()
//                                     ? AppColors.successColor
//                                     : AppColors.warningColor)
//                                 .withOpacity(0.3),
//                           ),
//                         ),
//                         child: Text(
//                           'Score: ${result.result.score}',
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.035,
//                             fontWeight: FontWeight.bold,
//                             color: result.result.isTypical()
//                                 ? AppColors.successColor
//                                 : AppColors.warningColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 width: 160,
//                 height: 160,
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       AppColors.primaryColor.withOpacity(0.1),
//                       AppColors.secondaryColor.withOpacity(0.1),
//                     ],
//                   ),
//                   shape: BoxShape.circle,
//                 ),
//                 child: const Icon(
//                   Icons.mic_none_rounded,
//                   size: 85,
//                   color: AppColors.primaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.03),
//               Text(
//                 controller.searchController.text.isNotEmpty
//                     ? 'No submissions found'
//                     : 'No Recordings Yet',
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.052,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.textPrimaryColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               Text(
//                 controller.searchController.text.isNotEmpty
//                     ? 'Try searching with a different name'
//                     : 'Start by recording your child\'s speech\nfor analysis',
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                   fontSize: size.customWidth(context) * 0.038,
//                   color: AppColors.textSecondaryColor,
//                   height: 1.5,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.04),
//               ElevatedButton.icon(
//                 onPressed: () => Get.toNamed(AppRoutes.speechRecording),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primaryColor,
//                   padding: EdgeInsets.symmetric(
//                     horizontal: size.customWidth(context) * 0.08,
//                     vertical: size.customHeight(context) * 0.018,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 icon: const Icon(Icons.mic_rounded, color: AppColors.whiteColor),
//                 label: Text(
//                   'Start Recording',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.whiteColor,
//                     fontWeight: FontWeight.w600,
//                     fontSize: size.customWidth(context) * 0.04,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showDeleteConfirmation(BuildContext context, String submissionId) {
//     final size = CustomSize();

//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.warning_rounded,
//                 color: AppColors.errorColor, size: 28),
//             SizedBox(width: size.customWidth(context) * 0.02),
//             Text(
//               'Delete Submission',
//               style: GoogleFonts.poppins(
//                 fontWeight: FontWeight.bold,
//                 fontSize: size.customWidth(context) * 0.045,
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           'Are you sure you want to delete this speech recording? This action cannot be undone.',
//           style: GoogleFonts.poppins(
//             fontSize: size.customWidth(context) * 0.038,
//             color: AppColors.textSecondaryColor,
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Get.back(),
//             child: Text(
//               'Cancel',
//               style: GoogleFonts.poppins(
//                 color: AppColors.textSecondaryColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () async {
//               Get.back();
//               final success = await controller.deleteSubmission(submissionId);
//               if (success) {
//                 controller.fetchAllSubmissions();
//               }
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: AppColors.errorColor,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: Text(
//               'Delete',
//               style: GoogleFonts.poppins(
//                 color: AppColors.whiteColor,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/view/speech/speech_submissions_screen.dart - FIXED VERSION

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/speech_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class SpeechSubmissionsScreen extends StatefulWidget {
  const SpeechSubmissionsScreen({super.key});

  @override
  State<SpeechSubmissionsScreen> createState() =>
      _SpeechSubmissionsScreenState();
}

class _SpeechSubmissionsScreenState extends State<SpeechSubmissionsScreen> {
  late final SpeechController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SpeechController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchAllSubmissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_rounded, color: AppColors.whiteColor),
                onPressed: () => Get.toNamed(AppRoutes.speechRecording),
              ),
            ],
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                size.customWidth(context) * 0.05,
                size.customHeight(context) * 0.02,
                size.customWidth(context) * 0.05,
                size.customHeight(context) * 0.01,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.searchSubmissions,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    color: AppColors.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by child name...',
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.greyColor,
                      fontSize: size.customWidth(context) * 0.038,
                    ),
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.primaryColor),
                    suffixIcon: Obx(() {
                      return controller.searchText.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear,
                                  color: AppColors.greyColor),
                              onPressed: controller.clearSearch,
                            )
                          : const SizedBox.shrink();
                    }),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.customWidth(context) * 0.04,
                      vertical: size.customHeight(context) * 0.018,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Submissions List
          Obx(() {
            if (controller.isLoadingSubmissions.value) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: size.customHeight(context) * 0.02),
                      Text(
                        'Loading submissions...',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontSize: size.customWidth(context) * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.filteredSubmissions.isEmpty) {
              return SliverFillRemaining(
                child: _buildEmptyState(context),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.05,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final submission = controller.filteredSubmissions[index];
                    return _buildSubmissionCard(context, submission);
                  },
                  childCount: controller.filteredSubmissions.length,
                ),
              ),
            );
          }),

          SliverToBoxAdapter(
            child: SizedBox(height: size.customHeight(context) * 0.1),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.speechRecording),
        backgroundColor: AppColors.primaryColor,
        icon: const Icon(Icons.mic_rounded, color: AppColors.whiteColor),
        label: Text(
          'New Recording',
          style: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final size = CustomSize();

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.customWidth(context) * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.voice_chat_rounded,
                  size: 40,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                'Speech Assessments',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: size.customWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.005),
              Obx(() => Text(
                    '${controller.filteredSubmissions.length} submission${controller.filteredSubmissions.length != 1 ? 's' : ''}',
                    style: GoogleFonts.poppins(
                      color: AppColors.whiteColor.withOpacity(0.9),
                      fontSize: size.customWidth(context) * 0.035,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmissionCard(BuildContext context, submission) {
    final size = CustomSize();
    final hasResults = submission.hasResults();
    final result = submission.getLatestResult();

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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutes.speechDetail,
              arguments: submission.speechSubmissionId,
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: hasResults
                              ? [
                                  AppColors.primaryColor.withOpacity(0.8),
                                  AppColors.secondaryColor,
                                ]
                              : [
                                  AppColors.greyColor.withOpacity(0.3),
                                  AppColors.greyColor
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        hasResults ? Icons.check_circle_rounded : Icons.pending_rounded,
                        size: 28,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(width: size.customWidth(context) * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            submission.getChildName(),
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.042,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                          SizedBox(height: size.customHeight(context) * 0.003),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 14,
                                color: AppColors.textSecondaryColor,
                              ),
                              SizedBox(width: size.customWidth(context) * 0.01),
                              Text(
                                '${submission.recordingDurationSeconds}s',
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.032,
                                  color: AppColors.textSecondaryColor,
                                ),
                              ),
                              SizedBox(width: size.customWidth(context) * 0.03),
                              Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: AppColors.textSecondaryColor,
                              ),
                              SizedBox(width: size.customWidth(context) * 0.01),
                              Text(
                                submission.getFormattedDate(),
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.032,
                                  color: AppColors.textSecondaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert_rounded,
                          color: AppColors.greyColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              const Icon(Icons.visibility_rounded,
                                  color: AppColors.primaryColor, size: 20),
                              SizedBox(width: size.customWidth(context) * 0.02),
                              Text(
                                'View Details',
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.035,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              Get.toNamed(
                                AppRoutes.speechDetail,
                                arguments: submission.speechSubmissionId,
                              );
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              const Icon(Icons.delete_rounded,
                                  color: AppColors.errorColor, size: 20),
                              SizedBox(width: size.customWidth(context) * 0.02),
                              Text(
                                'Delete',
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.035,
                                  color: AppColors.errorColor,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Future.delayed(Duration.zero, () {
                              _showDeleteConfirmation(
                                  context, submission.speechSubmissionId);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                if (hasResults && result != null) ...[
                  SizedBox(height: size.customHeight(context) * 0.02),
                  Divider(color: AppColors.greyColor.withOpacity(0.2)),
                  SizedBox(height: size.customHeight(context) * 0.015),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Analysis Result',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.032,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            SizedBox(height: size.customHeight(context) * 0.004),
                            Text(
                              result.result.result.label,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.04,
                                fontWeight: FontWeight.w600,
                                color: result.result.result.isTypical()
                                    ? AppColors.successColor
                                    : AppColors.warningColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.customWidth(context) * 0.04,
                          vertical: size.customHeight(context) * 0.01,
                        ),
                        decoration: BoxDecoration(
                          color: (result.result.result.isTypical()
                                  ? AppColors.successColor
                                  : AppColors.warningColor)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: (result.result.result.isTypical()
                                    ? AppColors.successColor
                                    : AppColors.warningColor)
                                .withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          'Score: ${result.result.result.score}',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.035,
                            fontWeight: FontWeight.bold,
                            color: result.result.result.isTypical()
                                ? AppColors.successColor
                                : AppColors.warningColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
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
                  Icons.mic_none_rounded,
                  size: 85,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'No submissions found'
                    : 'No Recordings Yet',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.052,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'Try searching with a different name'
                    : 'Start by recording your child\'s speech\nfor analysis',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.5,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.04),
              ElevatedButton.icon(
                onPressed: () => Get.toNamed(AppRoutes.speechRecording),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.customWidth(context) * 0.08,
                    vertical: size.customHeight(context) * 0.018,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                icon: const Icon(Icons.mic_rounded, color: AppColors.whiteColor),
                label: Text(
                  'Start Recording',
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: size.customWidth(context) * 0.04,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, String submissionId) {
    final size = CustomSize();

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_rounded,
                color: AppColors.errorColor, size: 28),
            SizedBox(width: size.customWidth(context) * 0.02),
            Text(
              'Delete Submission',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: size.customWidth(context) * 0.045,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to delete this speech recording? This action cannot be undone.',
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
          ElevatedButton(
            onPressed: () async {
              Get.back();
              final success = await controller.deleteSubmission(submissionId);
              if (success) {
                controller.fetchAllSubmissions();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}