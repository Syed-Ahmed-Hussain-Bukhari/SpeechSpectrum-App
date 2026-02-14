// lib/view/experts/consultations_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_controller.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> with SingleTickerProviderStateMixin {
  late final ExpertController controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Get or create controller
    if (Get.isRegistered<ExpertController>()) {
      controller = Get.find<ExpertController>();
    } else {
      controller = Get.put(ExpertController());
    }

    // Fetch consultations after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchConsultations();
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
          'My Consultations',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchConsultations(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          tabs: [
            Tab(text: 'All'),
            Tab(text: 'Pending'),
            Tab(text: 'Approved'),
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
            _buildConsultationsList(controller.consultations.where((c) => c.isPending()).toList()),
            _buildConsultationsList(controller.consultations.where((c) => c.isApproved()).toList()),
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
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primaryColor.withOpacity(0.8),
                        AppColors.primaryColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      consultation.expertUsers.getInitials(),
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.03),

                // Expert Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        consultation.expertUsers.fullName,
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
                        consultation.expertUsers.specialization,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.032,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
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
                        : AppColors.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    consultation.status.toUpperCase(),
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.028,
                      fontWeight: FontWeight.bold,
                      color: consultation.isPending()
                          ? AppColors.warningColor
                          : AppColors.successColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.015),
            Divider(color: AppColors.greyColor.withOpacity(0.2)),
            SizedBox(height: size.customHeight(context) * 0.01),

            // Child and Date Info
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.child_care_outlined,
                        size: 16,
                        color: AppColors.textSecondaryColor,
                      ),
                      SizedBox(width: size.customWidth(context) * 0.02),
                      Text(
                        consultation.children.childName,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.034,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: AppColors.textSecondaryColor,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.015),
                    Text(
                      consultation.getFormattedDate(),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Organization
            SizedBox(height: size.customHeight(context) * 0.01),
            Row(
              children: [
                Icon(
                  Icons.business_outlined,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Expanded(
                  child: Text(
                    consultation.expertUsers.organization,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.034,
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
              'You haven\'t requested any\nconsultations yet',
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