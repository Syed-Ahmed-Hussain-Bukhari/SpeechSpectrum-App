// lib/view/experts/linked_experts_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkedExpertsScreen extends StatefulWidget {
  const LinkedExpertsScreen({super.key});

  @override
  State<LinkedExpertsScreen> createState() => _LinkedExpertsScreenState();
}

class _LinkedExpertsScreenState extends State<LinkedExpertsScreen> {
  late final ExpertController controller;

  @override
  void initState() {
    super.initState();

    // Get or create controller
    if (Get.isRegistered<ExpertController>()) {
      controller = Get.find<ExpertController>();
    } else {
      controller = Get.put(ExpertController());
    }

    // Fetch linked experts after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchLinkedExperts();
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
          'Linked Experts',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchLinkedExperts(),
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
                  'Loading linked experts...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.linkedExperts.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: EdgeInsets.all(size.customWidth(context) * 0.04),
          itemCount: controller.linkedExperts.length,
          itemBuilder: (context, index) {
            final linkedExpert = controller.linkedExperts[index];
            return _buildLinkedExpertCard(context, linkedExpert);
          },
        );
      }),
    );
  }

  Widget _buildLinkedExpertCard(BuildContext context, linkedExpert) {
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
                      linkedExpert.expertUsers.getInitials(),
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
                        linkedExpert.expertUsers.fullName,
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
                              linkedExpert.expertUsers.specialization,
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
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
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

            // Child Info
            Row(
              children: [
                Icon(
                  Icons.child_care_outlined,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Text(
                  'Linked for: ',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  linkedExpert.children.childName,
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.01),

            // Organization
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
                    linkedExpert.expertUsers.organization,
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
                    fontSize: size.customWidth(context) * 0.032,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  linkedExpert.getFormattedDate(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.032,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.02),

            // Contact Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _launchEmail(linkedExpert.expertUsers.contactEmail),
                    icon: const Icon(Icons.email_outlined, size: 18),
                    label: Text(
                      'Email',
                      style: GoogleFonts.poppins(fontSize: size.customWidth(context) * 0.034),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accentColor,
                      side: BorderSide(color: AppColors.accentColor.withOpacity(0.5)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.012),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.03),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _launchPhone(linkedExpert.expertUsers.phone),
                    icon: const Icon(Icons.phone_outlined, size: 18),
                    label: Text(
                      'Call',
                      style: GoogleFonts.poppins(fontSize: size.customWidth(context) * 0.034),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.012),
                      elevation: 0,
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
              'No Linked Experts',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'You don\'t have any linked experts yet.\nApproved consultations will appear here.',
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

  void _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  void _launchPhone(String phone) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phone,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }
}