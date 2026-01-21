// // lib/view/history/history_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/history_controller.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class HistoryScreen extends StatelessWidget {
//   const HistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();
//     final controller = Get.put(HistoryController());

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       body: CustomScrollView(
//         slivers: [
//           // App Bar with gradient
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
//               onPressed: () => Navigator.pop(context),
//             ),
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
//                     prefixIcon:
//                         const Icon(Icons.search, color: AppColors.primaryColor),
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
//             if (controller.isLoading.value) {
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
//                         'Loading history...',
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
//                 child: _buildEmptyState(context, controller),
//               );
//             }

//             final groupedSubmissions = controller.getGroupedSubmissions();

//             return SliverPadding(
//               padding: EdgeInsets.symmetric(
//                 horizontal: size.customWidth(context) * 0.05,
//               ),
//               sliver: SliverList(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final childName = groupedSubmissions.keys.elementAt(index);
//                     final childSubmissions = groupedSubmissions[childName]!;

//                     return _buildChildSubmissionCard(
//                       context,
//                       controller,
//                       childName,
//                       childSubmissions,
//                     );
//                   },
//                   childCount: groupedSubmissions.length,
//                 ),
//               ),
//             );
//           }),

//           SliverToBoxAdapter(
//             child: SizedBox(height: size.customHeight(context) * 0.1),
//           ),
//         ],
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
//                   Icons.history_rounded,
//                   size: 40,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               Text(
//                 'Assessment History',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: size.customWidth(context) * 0.06,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.005),
//               Text(
//                 'View all questionnaire submissions',
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor.withOpacity(0.9),
//                   fontSize: size.customWidth(context) * 0.035,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildChildSubmissionCard(
//     BuildContext context,
//     HistoryController controller,
//     String childName,
//     List<dynamic> submissions,
//   ) {
//     final size = CustomSize();
//     final latestSubmission = submissions.first;
//     final result = latestSubmission.questionnaireResults.isNotEmpty
//         ? latestSubmission.questionnaireResults.first
//         : null;

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
//               AppRoutes.childHistory,
//               arguments: {
//                 'childId': latestSubmission.childId,
//                 'childName': childName,
//               },
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
//                     // Avatar
//                     Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             AppColors.primaryColor,
//                             AppColors.secondaryColor
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: const Icon(
//                         Icons.person_rounded,
//                         size: 32,
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                     SizedBox(width: size.customWidth(context) * 0.03),

//                     // Child Info
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             childName,
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.045,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.textPrimaryColor,
//                             ),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           SizedBox(height: size.customHeight(context) * 0.004),
//                           Text(
//                             '${submissions.length} submission${submissions.length > 1 ? 's' : ''}',
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.035,
//                               color: AppColors.textSecondaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                     Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       size: 18,
//                       color: AppColors.greyColor,
//                     ),
//                   ],
//                 ),

//                 if (result != null) ...[
//                   SizedBox(height: size.customHeight(context) * 0.02),
//                   Divider(color: AppColors.greyColor.withOpacity(0.2)),
//                   SizedBox(height: size.customHeight(context) * 0.015),

//                   // Latest Result
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Latest Result',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.032,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                             ),
//                             SizedBox(height: size.customHeight(context) * 0.004),
//                             Text(
//                               result.result.prediction,
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.038,
//                                 fontWeight: FontWeight.w600,
//                                 color: result.result.getRiskColor(),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: size.customWidth(context) * 0.03,
//                           vertical: size.customHeight(context) * 0.008,
//                         ),
//                         decoration: BoxDecoration(
//                           color: result.result.getRiskColor().withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           result.result.probability,
//                           style: GoogleFonts.poppins(
//                             fontSize: size.customWidth(context) * 0.035,
//                             fontWeight: FontWeight.w600,
//                             color: result.result.getRiskColor(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],

//                 SizedBox(height: size.customHeight(context) * 0.015),

//                 // Date
//                 Row(
//                   children: [
//                     Icon(
//                       Icons.calendar_today_outlined,
//                       size: 14,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                     SizedBox(width: size.customWidth(context) * 0.015),
//                     Text(
//                       'Last: ${latestSubmission.getFormattedDate()}',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textSecondaryColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context, HistoryController controller) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 160,
//               height: 160,
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
//                 Icons.history_rounded,
//                 size: 85,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               controller.searchController.text.isNotEmpty
//                   ? 'No submissions found'
//                   : 'No History Yet',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               controller.searchController.text.isNotEmpty
//                   ? 'Try searching with a different name'
//                   : 'Complete a questionnaire to see\nyour assessment history here',
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


// lib/view/history/history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/history_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late final HistoryController controller;

  @override
  void initState() {
    super.initState();
    // Initialize controller and fetch data
    controller = Get.put(HistoryController());
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
          // App Bar with gradient
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
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                    suffixIcon: Obx(() {
                      return controller.searchText.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.greyColor),
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
            if (controller.isLoading.value) {
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
                        'Loading history...',
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
                child: _buildEmptyState(context, controller),
              );
            }

            final groupedSubmissions = controller.getGroupedSubmissions();

            return SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.05,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final childName = groupedSubmissions.keys.elementAt(index);
                    final childSubmissions = groupedSubmissions[childName]!;

                    return _buildChildSubmissionCard(
                      context,
                      controller,
                      childName,
                      childSubmissions,
                    );
                  },
                  childCount: groupedSubmissions.length,
                ),
              ),
            );
          }),

          SliverToBoxAdapter(
            child: SizedBox(height: size.customHeight(context) * 0.1),
          ),
        ],
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
                  Icons.history_rounded,
                  size: 40,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                'Assessment History',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: size.customWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.005),
              Text(
                'View all questionnaire submissions',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor.withOpacity(0.9),
                  fontSize: size.customWidth(context) * 0.035,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildSubmissionCard(
    BuildContext context,
    HistoryController controller,
    String childName,
    List<dynamic> submissions,
  ) {
    final size = CustomSize();
    final latestSubmission = submissions.first;
    final result = latestSubmission.questionnaireResults.isNotEmpty
        ? latestSubmission.questionnaireResults.first
        : null;

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
              AppRoutes.childHistory,
              arguments: {
                'childId': latestSubmission.childId,
                'childName': childName,
              },
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
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.primaryColor, AppColors.secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 32,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(width: size.customWidth(context) * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            childName,
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.045,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: size.customHeight(context) * 0.004),
                          Text(
                            '${submissions.length} submission${submissions.length > 1 ? 's' : ''}',
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.035,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 18,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
                if (result != null) ...[
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
                              'Latest Result',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.032,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            SizedBox(height: size.customHeight(context) * 0.004),
                            Text(
                              result.result.prediction,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.038,
                                fontWeight: FontWeight.w600,
                                color: result.result.getRiskColor(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.customWidth(context) * 0.03,
                          vertical: size.customHeight(context) * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: result.result.getRiskColor().withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          result.result.probability,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.035,
                            fontWeight: FontWeight.w600,
                            color: result.result.getRiskColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                SizedBox(height: size.customHeight(context) * 0.015),
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: AppColors.textSecondaryColor,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.015),
                    Text(
                      'Last: ${latestSubmission.getFormattedDate()}',
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
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, HistoryController controller) {
    final size = CustomSize();

    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.08),
        child:SingleChildScrollView(
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
                  Icons.history_rounded,
                  size: 85,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'No submissions found'
                    : 'No History Yet',
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
                    : 'Complete a questionnaire to see\nyour assessment history here',
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
      ),
    );
  }
}