// lib/view/experts/experts_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ExpertsListScreen extends StatefulWidget {
  const ExpertsListScreen({super.key});

  @override
  State<ExpertsListScreen> createState() => _ExpertsListScreenState();
}

class _ExpertsListScreenState extends State<ExpertsListScreen> {
  late final ExpertController controller;
  final ScrollController _scrollController = ScrollController();
  String? childId;
  String? childName;

  @override
  void initState() {
    super.initState();
    
    // Get arguments if passed
    final args = Get.arguments as Map<String, dynamic>?;
    childId = args?['childId'];
    childName = args?['childName'];

    // Get or create controller
    if (Get.isRegistered<ExpertController>()) {
      controller = Get.find<ExpertController>();
    } else {
      controller = Get.put(ExpertController());
    }

    // Fetch experts after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExperts();
    });

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      controller.loadMoreExperts();
    }
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
          childName != null ? 'Experts for $childName' : 'Find Experts',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            color: AppColors.whiteColor,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.lightGreyColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: controller.searchController,
                onChanged: controller.searchExperts,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  color: AppColors.textPrimaryColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Search by name, specialization...',
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

          // Experts List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value && controller.experts.isEmpty) {
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
                        'Loading experts...',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontSize: size.customWidth(context) * 0.035,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (controller.filteredExperts.isEmpty) {
                return _buildEmptyState(context);
              }

              return ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(size.customWidth(context) * 0.04),
                itemCount: controller.filteredExperts.length + (controller.hasNextPage.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == controller.filteredExperts.length) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(size.customHeight(context) * 0.02),
                        child: const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                          strokeWidth: 2,
                        ),
                      ),
                    );
                  }

                  final expert = controller.filteredExperts[index];
                  return _buildExpertCard(context, expert);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildExpertCard(BuildContext context, expert) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.toNamed(
              AppRoutes.expertDetail,
              arguments: {
                'expert': expert,
                'childId': childId,
                'childName': childName,
              },
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(size.customWidth(context) * 0.04),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.8),
                        AppColors.primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      expert.getInitials(),
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.04),
                
                // Expert Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expert.fullName,
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
                            Icons.medical_services_outlined,
                            size: 14,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: size.customWidth(context) * 0.015),
                          Expanded(
                            child: Text(
                              expert.specialization,
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
                      SizedBox(height: size.customHeight(context) * 0.006),
                      Row(
                        children: [
                          Icon(
                            Icons.business_outlined,
                            size: 14,
                            color: AppColors.textSecondaryColor,
                          ),
                          SizedBox(width: size.customWidth(context) * 0.015),
                          Expanded(
                            child: Text(
                              expert.organization,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.032,
                                color: AppColors.textSecondaryColor,
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
                
                // Arrow Icon
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: AppColors.greyColor,
                ),
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
                Icons.person_search_outlined,
                size: 70,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              controller.searchText.value.isNotEmpty
                  ? 'No experts found'
                  : 'No Experts Available',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              controller.searchText.value.isNotEmpty
                  ? 'Try searching with different keywords'
                  : 'No approved experts are available\nat the moment',
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