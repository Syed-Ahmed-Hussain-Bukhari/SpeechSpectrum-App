// // lib/view/history/child_history_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/history_controller.dart';
// import 'package:speechspectrum/models/questionnaire_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';

// class ChildHistoryScreen extends StatefulWidget {
//   const ChildHistoryScreen({super.key});

//   @override
//   State<ChildHistoryScreen> createState() => _ChildHistoryScreenState();
// }

// class _ChildHistoryScreenState extends State<ChildHistoryScreen> {
//   final controller = Get.find<HistoryController>();
//   final searchController = TextEditingController();
//   final RxList<SubmissionItem> submissions = <SubmissionItem>[].obs;
//   final RxList<SubmissionItem> filteredSubmissions = <SubmissionItem>[].obs;
//   final RxString searchText = ''.obs;

//   late String childId;
//   late String childName;

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>;
//     childId = args['childId'];
//     childName = args['childName'];
//     _fetchSubmissions();
//   }

//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }

//   Future<void> _fetchSubmissions() async {
//     final data = await controller.fetchSubmissionsByChildId(childId);
//     submissions.value = data;
//     filteredSubmissions.value = data;
//   }

//   void _searchSubmissions(String query) {
//     searchText.value = query;

//     if (query.isEmpty) {
//       filteredSubmissions.value = submissions;
//     } else {
//       filteredSubmissions.value = submissions.where((submission) {
//         if (submission.questionnaireResults.isEmpty) return false;
//         final probability =
//             submission.questionnaireResults.first.result.probability;
//         return probability.toLowerCase().contains(query.toLowerCase());
//       }).toList();
//     }
//   }

//   void _clearSearch() {
//     searchController.clear();
//     searchText.value = '';
//     filteredSubmissions.value = submissions;
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
//                   controller: searchController,
//                   onChanged: _searchSubmissions,
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.04,
//                     color: AppColors.textPrimaryColor,
//                   ),
//                   decoration: InputDecoration(
//                     hintText: 'Search by probability...',
//                     hintStyle: GoogleFonts.poppins(
//                       color: AppColors.greyColor,
//                       fontSize: size.customWidth(context) * 0.038,
//                     ),
//                     prefixIcon:
//                         const Icon(Icons.search, color: AppColors.primaryColor),
//                     suffixIcon: Obx(() {
//                       return searchText.value.isNotEmpty
//                           ? IconButton(
//                               icon: const Icon(Icons.clear,
//                                   color: AppColors.greyColor),
//                               onPressed: _clearSearch,
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

//             if (filteredSubmissions.isEmpty) {
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
//                     final submission = filteredSubmissions[index];
//                     return _buildSubmissionCard(context, submission);
//                   },
//                   childCount: filteredSubmissions.length,
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
//                   Icons.person_rounded,
//                   size: 40,
//                   color: AppColors.whiteColor,
//                 ),
//               ),
//               SizedBox(height: size.customHeight(context) * 0.015),
//               Text(
//                 childName,
//                 style: GoogleFonts.poppins(
//                   color: AppColors.whiteColor,
//                   fontSize: size.customWidth(context) * 0.06,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: size.customHeight(context) * 0.005),
//               Obx(() => Text(
//                     '${filteredSubmissions.length} submission${filteredSubmissions.length != 1 ? 's' : ''}',
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

//   Widget _buildSubmissionCard(BuildContext context, SubmissionItem submission) {
//     final size = CustomSize();
//     final result = submission.questionnaireResults.isNotEmpty
//         ? submission.questionnaireResults.first
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
//               AppRoutes.submissionDetails,
//               arguments: submission.submissionId,
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
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: result != null
//                               ? [
//                                   result.result.getRiskColor().withOpacity(0.8),
//                                   result.result.getRiskColor(),
//                                 ]
//                               : [
//                                   AppColors.greyColor.withOpacity(0.3),
//                                   AppColors.greyColor
//                                 ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: const Icon(
//                         Icons.assignment_outlined,
//                         size: 26,
//                         color: AppColors.whiteColor,
//                       ),
//                     ),
//                     SizedBox(width: size.customWidth(context) * 0.03),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             submission.getFormattedDate(),
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.04,
//                               fontWeight: FontWeight.w600,
//                               color: AppColors.textPrimaryColor,
//                             ),
//                           ),
//                           SizedBox(height: size.customHeight(context) * 0.003),
//                           Text(
//                             submission.getFormattedTime(),
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.032,
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
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Result',
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.032,
//                                 color: AppColors.textSecondaryColor,
//                               ),
//                             ),
//                             SizedBox(height: size.customHeight(context) * 0.004),
//                             Text(
//                               result.result.prediction,
//                               style: GoogleFonts.poppins(
//                                 fontSize: size.customWidth(context) * 0.036,
//                                 fontWeight: FontWeight.w600,
//                                 color: result.result.getRiskColor(),
//                               ),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis,
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
//                             fontSize: size.customWidth(context) * 0.038,
//                             fontWeight: FontWeight.bold,
//                             color: result.result.getRiskColor(),
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
//                 Icons.assignment_outlined,
//                 size: 85,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               searchText.value.isNotEmpty
//                   ? 'No submissions found'
//                   : 'No Submissions Yet',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               searchText.value.isNotEmpty
//                   ? 'Try searching with different probability'
//                   : 'No assessment submissions found\nfor this child',
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


// lib/view/history/child_history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/history_controller.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ChildHistoryScreen extends StatefulWidget {
  const ChildHistoryScreen({super.key});

  @override
  State<ChildHistoryScreen> createState() => _ChildHistoryScreenState();
}

class _ChildHistoryScreenState extends State<ChildHistoryScreen> {
  late final HistoryController controller;
  final searchController = TextEditingController();
  final RxList<SubmissionItem> submissions = <SubmissionItem>[].obs;
  final RxList<SubmissionItem> filteredSubmissions = <SubmissionItem>[].obs;
  final RxString searchText = ''.obs;
  final RxBool isLoading = false.obs;

  late String childId;
  late String childName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    childId = args['childId'];
    childName = args['childName'];
    
    // Get or create controller
    if (Get.isRegistered<HistoryController>()) {
      controller = Get.find<HistoryController>();
    } else {
      controller = Get.put(HistoryController());
    }
    
    // Fetch submissions after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSubmissions();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchSubmissions() async {
    isLoading.value = true;
    final data = await controller.fetchSubmissionsByChildId(childId);
    submissions.value = data;
    filteredSubmissions.value = data;
    isLoading.value = false;
  }

  void _searchSubmissions(String query) {
    searchText.value = query;

    if (query.isEmpty) {
      filteredSubmissions.value = submissions;
    } else {
      filteredSubmissions.value = submissions.where((submission) {
        if (submission.questionnaireResults.isEmpty) return false;
        final probability = submission.questionnaireResults.first.result.probability;
        return probability.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  void _clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredSubmissions.value = submissions;
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
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
                  controller: searchController,
                  onChanged: _searchSubmissions,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.04,
                    color: AppColors.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by probability...',
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.greyColor,
                      fontSize: size.customWidth(context) * 0.038,
                    ),
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                    suffixIcon: Obx(() {
                      return searchText.value.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.greyColor),
                              onPressed: _clearSearch,
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

          Obx(() {
            if (isLoading.value) {
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

            if (filteredSubmissions.isEmpty) {
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
                    final submission = filteredSubmissions[index];
                    return _buildSubmissionCard(context, submission);
                  },
                  childCount: filteredSubmissions.length,
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
                  Icons.person_rounded,
                  size: 40,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                childName,
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: size.customWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.customHeight(context) * 0.005),
              Obx(() => Text(
                    '${filteredSubmissions.length} submission${filteredSubmissions.length != 1 ? 's' : ''}',
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

  Widget _buildSubmissionCard(BuildContext context, SubmissionItem submission) {
    final size = CustomSize();
    final result = submission.questionnaireResults.isNotEmpty
        ? submission.questionnaireResults.first
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
              AppRoutes.submissionDetails,
              arguments: submission.submissionId,
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
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: result != null
                              ? [
                                  result.result.getRiskColor().withOpacity(0.8),
                                  result.result.getRiskColor(),
                                ]
                              : [
                                  AppColors.greyColor.withOpacity(0.3),
                                  AppColors.greyColor
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
                        size: 26,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    SizedBox(width: size.customWidth(context) * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            submission.getFormattedDate(),
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.04,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                          SizedBox(height: size.customHeight(context) * 0.003),
                          Text(
                            submission.getFormattedTime(),
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.032,
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
                              'Result',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.032,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            SizedBox(height: size.customHeight(context) * 0.004),
                            Text(
                              result.result.prediction,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.036,
                                fontWeight: FontWeight.w600,
                                color: result.result.getRiskColor(),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                            fontSize: size.customWidth(context) * 0.038,
                            fontWeight: FontWeight.bold,
                            color: result.result.getRiskColor(),
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
                  Icons.assignment_outlined,
                  size: 85,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Text(
                searchText.value.isNotEmpty
                    ? 'No submissions found'
                    : 'No Submissions Yet',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.052,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                searchText.value.isNotEmpty
                    ? 'Try searching with different probability'
                    : 'No assessment submissions found\nfor this child',
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