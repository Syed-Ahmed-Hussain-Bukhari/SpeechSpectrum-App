// lib/view/experts/expert_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ExpertDetailScreen extends StatefulWidget {
  const ExpertDetailScreen({super.key});

  @override
  State<ExpertDetailScreen> createState() => _ExpertDetailScreenState();
}

class _ExpertDetailScreenState extends State<ExpertDetailScreen> {
  late final ExpertController controller;
  late final expert;
  String? childId;
  String? childName;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>;
    expert = args['expert'];
    childId = args['childId'];
    childName = args['childName'];

    // Get or create controller
    if (Get.isRegistered<ExpertController>()) {
      controller = Get.find<ExpertController>();
    } else {
      controller = Get.put(ExpertController());
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with Expert Header
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.35,
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

          // Expert Details
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(size.customWidth(context) * 0.05),
              child: Column(
                children: [
                  _buildInfoCard(context),
                  SizedBox(height: size.customHeight(context) * 0.02),
                  _buildContactCard(context),
                  if (childId != null) ...[
                    SizedBox(height: size.customHeight(context) * 0.02),
                    _buildConsultButton(context),
                  ],
                  SizedBox(height: size.customHeight(context) * 0.03),
                ],
              ),
            ),
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
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    expert.getInitials(),
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.02),
              Text(
                expert.fullName,
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: size.customWidth(context) * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: size.customHeight(context) * 0.008),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  expert.specialization,
                  style: GoogleFonts.poppins(
                    color: AppColors.whiteColor,
                    fontSize: size.customWidth(context) * 0.038,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.info_outline, color: AppColors.primaryColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Professional Information',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoRow(context, 'Organization', expert.organization, Icons.business_outlined),
          _buildInfoRow(context, 'PMDC Number', expert.pmdcNumber, Icons.badge_outlined),
          _buildInfoRow(context, 'Status', expert.approvalStatus.toUpperCase(), Icons.verified_outlined),
          _buildInfoRow(context, 'Member Since', expert.getFormattedDate(), Icons.calendar_today_outlined, isLast: true),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.05),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.contact_phone_outlined, color: AppColors.accentColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                'Contact Information',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildContactRow(context, 'Email', expert.contactEmail, Icons.email_outlined, () {
            _launchEmail(expert.contactEmail);
          }),
          _buildContactRow(context, 'Phone', expert.phone, Icons.phone_outlined, () {
            _launchPhone(expert.phone);
          }, isLast: true),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value, IconData icon, {bool isLast = false}) {
    final size = CustomSize();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.01),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: AppColors.primaryColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                    Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.038,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(color: AppColors.greyColor.withOpacity(0.2)),
      ],
    );
  }

  Widget _buildContactRow(BuildContext context, String label, String value, IconData icon, VoidCallback onTap, {bool isLast = false}) {
    final size = CustomSize();

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.01),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.accentColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: AppColors.accentColor),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.032,
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                      Text(
                        value,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.038,
                          fontWeight: FontWeight.w600,
                          color: AppColors.accentColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.launch,
                  size: 18,
                  color: AppColors.accentColor,
                ),
              ],
            ),
          ),
        ),
        if (!isLast) Divider(color: AppColors.greyColor.withOpacity(0.2)),
      ],
    );
  }

  Widget _buildConsultButton(BuildContext context) {
    final size = CustomSize();

    return Obx(() => SizedBox(
          width: double.infinity,
          height: size.customHeight(context) * 0.06,
          child: ElevatedButton(
            onPressed: controller.isRequesting.value
                ? null
                : () => _showConsultDialog(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 0,
            ),
            child: controller.isRequesting.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: AppColors.whiteColor,
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.medical_services_outlined, color: AppColors.whiteColor),
                      const SizedBox(width: 12),
                      Text(
                        'Request Consultation',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: size.customWidth(context) * 0.042,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }

  void _showConsultDialog(BuildContext context) {
    final size = CustomSize();

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
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.medical_services_outlined, color: AppColors.primaryColor, size: 45),
              ),
              SizedBox(height: size.customHeight(context) * 0.025),
              Text(
                'Request Consultation',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: size.customWidth(context) * 0.05,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.015),
              Text(
                'Do you want to request a consultation with ${expert.fullName} for $childName?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.4,
                ),
              ),
              SizedBox(height: size.customHeight(context) * 0.03),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.015),
                        side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Text('Cancel', style: GoogleFonts.poppins(color: AppColors.textSecondaryColor, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isRequesting.value
                              ? null
                              : () async {
                                  final success = await controller.requestConsultation(
                                    expertId: expert.expertId,
                                    childId: childId!,
                                  );
                                  if (success) {
                                    Get.back(); // Close detail screen
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: size.customHeight(context) * 0.015),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: controller.isRequesting.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(color: AppColors.whiteColor, strokeWidth: 2),
                                )
                              : Text('Request', style: GoogleFonts.poppins(color: AppColors.whiteColor, fontWeight: FontWeight.w600)),
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