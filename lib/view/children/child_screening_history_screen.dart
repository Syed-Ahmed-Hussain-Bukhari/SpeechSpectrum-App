// lib/view/children/child_screening_history_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/child_screening_history_controller.dart';
import 'package:speechspectrum/models/questionnaire_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ChildScreeningHistoryScreen extends StatefulWidget {
  const ChildScreeningHistoryScreen({super.key});

  @override
  State<ChildScreeningHistoryScreen> createState() =>
      _ChildScreeningHistoryScreenState();
}

class _ChildScreeningHistoryScreenState
    extends State<ChildScreeningHistoryScreen> {
  late final ChildScreeningHistoryController controller;
  late String childId;
  late String childName;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    childId = args['childId'] as String;
    childName = args['childName'] as String;

    controller = Get.put(
      ChildScreeningHistoryController(),
      tag: childId,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSubmissions(childId);
    });
  }

  @override
  void dispose() {
    Get.delete<ChildScreeningHistoryController>(tag: childId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // ── App Bar ────────────────────────────────────────────────────────
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace:
                FlexibleSpaceBar(background: _buildHeader(context)),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back,
                  color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
          ),

          // ── Search Bar ─────────────────────────────────────────────────────
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
                    hintText: 'Search by result...',
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

          // ── List ───────────────────────────────────────────────────────────
          Obx(() {
            if (controller.isLoading.value) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                          color: AppColors.primaryColor, strokeWidth: 3),
                      SizedBox(height: size.customHeight(context) * 0.02),
                      Text(
                        'Loading screenings...',
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
                  child: _buildEmptyState(context));
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.customWidth(context) * 0.05),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildSubmissionCard(
                    context,
                    controller.filteredSubmissions[index],
                  ),
                  childCount: controller.filteredSubmissions.length,
                ),
              ),
            );
          }),

          SliverToBoxAdapter(
            child:
                SizedBox(height: size.customHeight(context) * 0.1),
          ),
        ],
      ),
    );
  }

  // ── Header ─────────────────────────────────────────────────────────────────
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
                child: const Icon(Icons.assignment_rounded,
                    size: 40, color: AppColors.whiteColor),
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
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: size.customHeight(context) * 0.005),
              Obx(() => Text(
                    '${controller.filteredSubmissions.length} screening'
                    '${controller.filteredSubmissions.length != 1 ? 's' : ''}',
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

  // ── Submission Card ────────────────────────────────────────────────────────
  Widget _buildSubmissionCard(
      BuildContext context, SubmissionItem submission) {
    final size = CustomSize();
    final result = submission.questionnaireResults.isNotEmpty
        ? submission.questionnaireResults.first
        : null;

    return Container(
      margin:
          EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
          onTap: () => Get.toNamed(
            AppRoutes.submissionDetails,
            arguments: submission.submissionId,
          ),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding:
                EdgeInsets.all(size.customWidth(context) * 0.04),
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
                          colors: result != null
                              ? [
                                  result.result
                                      .getRiskColor()
                                      .withOpacity(0.7),
                                  result.result.getRiskColor(),
                                ]
                              : [
                                  AppColors.greyColor.withOpacity(0.3),
                                  AppColors.greyColor,
                                ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.assignment_outlined,
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
                            submission.getFormattedDate(),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  size.customWidth(context) * 0.042,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryColor,
                            ),
                          ),
                          SizedBox(
                              height:
                                  size.customHeight(context) * 0.004),
                          Text(
                            submission.getFormattedTime(),
                            style: GoogleFonts.poppins(
                              fontSize:
                                  size.customWidth(context) * 0.032,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios_rounded,
                        size: 18, color: AppColors.greyColor),
                  ],
                ),
                if (result != null) ...[
                  SizedBox(height: size.customHeight(context) * 0.015),
                  Divider(
                      color: AppColors.greyColor.withOpacity(0.2)),
                  SizedBox(height: size.customHeight(context) * 0.012),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Result',
                              style: GoogleFonts.poppins(
                                fontSize:
                                    size.customWidth(context) * 0.032,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                            SizedBox(
                                height:
                                    size.customHeight(context) * 0.004),
                            Text(
                              result.result.prediction,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    size.customWidth(context) * 0.036,
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
                          horizontal:
                              size.customWidth(context) * 0.04,
                          vertical:
                              size.customHeight(context) * 0.008,
                        ),
                        decoration: BoxDecoration(
                          color: result.result
                              .getRiskColor()
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: result.result
                                .getRiskColor()
                                .withOpacity(0.4),
                          ),
                        ),
                        child: Text(
                          result.result.probability,
                          style: GoogleFonts.poppins(
                            fontSize:
                                size.customWidth(context) * 0.036,
                            fontWeight: FontWeight.bold,
                            color: result.result.getRiskColor(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  SizedBox(height: size.customHeight(context) * 0.012),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.customWidth(context) * 0.03,
                      vertical: size.customHeight(context) * 0.007,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warningColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Pending Analysis',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.warningColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Empty State ────────────────────────────────────────────────────────────
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
                child: const Icon(Icons.assignment_outlined,
                    size: 85, color: AppColors.primaryColor),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'No screenings found'
                    : 'No Screenings Yet',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.052,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'Try searching with different keywords'
                    : 'No questionnaire screenings found\nfor $childName',
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