// lib/view/expert/save_notes_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/appointment_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class SaveNotesScreen extends StatefulWidget {
  const SaveNotesScreen({super.key});

  @override
  State<SaveNotesScreen> createState() => _SaveNotesScreenState();
}

class _SaveNotesScreenState extends State<SaveNotesScreen> {
  late final AppointmentController controller;
  late String appointmentId;
  late String childName;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments as Map<String, dynamic>;
    appointmentId = args['appointmentId'];
    childName = args['childName'];

    // Get or create controller
    if (Get.isRegistered<AppointmentController>()) {
      controller = Get.find<AppointmentController>();
    } else {
      controller = Get.put(AppointmentController());
    }

    controller.clearFormData();
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
          'Add Session Notes',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Child Info Card
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.04),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryColor.withOpacity(0.1),
                    AppColors.secondaryColor.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.child_care,
                      color: AppColors.primaryColor, size: 24),
                  SizedBox(width: size.customWidth(context) * 0.03),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Session for',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.032,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        Text(
                          childName,
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.042,
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

            SizedBox(height: size.customHeight(context) * 0.025),

            // Discussion Summary
            _buildSectionTitle(context, 'Discussion Summary'),
            SizedBox(height: size.customHeight(context) * 0.01),
            _buildTextField(
              context,
              controller: controller.discussionSummaryController,
              hintText: 'Summarize the session discussion...',
              maxLines: 4,
            ),

            SizedBox(height: size.customHeight(context) * 0.02),

            // Session Notes
            _buildSectionTitle(context, 'Session Notes'),
            SizedBox(height: size.customHeight(context) * 0.01),
            _buildTextField(
              context,
              controller: controller.notesController,
              hintText: 'Add detailed notes about the session...',
              maxLines: 5,
            ),

            SizedBox(height: size.customHeight(context) * 0.02),

            // Medication/Therapy Plan Section
            _buildSectionTitle(context, 'Prescriptions/Therapy Plan'),
            SizedBox(height: size.customHeight(context) * 0.01),

            // Add Prescription Button
            OutlinedButton.icon(
              onPressed: () => controller.addPrescription(),
              icon: const Icon(Icons.add, size: 18),
              label: Text(
                'Add Prescription',
                style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.primaryColor.withOpacity(0.5)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            SizedBox(height: size.customHeight(context) * 0.015),

            // Prescription List
            Obx(() => Column(
                  children: List.generate(
                    controller.prescriptions.length,
                    (index) => _buildPrescriptionCard(context, index),
                  ),
                )),

            SizedBox(height: size.customHeight(context) * 0.02),

            // Recommendations
            _buildSectionTitle(context, 'Recommendations'),
            SizedBox(height: size.customHeight(context) * 0.01),
            _buildTextField(
              context,
              controller: controller.recommendationsController,
              hintText: 'Add therapy recommendations...',
              maxLines: 3,
            ),

            SizedBox(height: size.customHeight(context) * 0.03),

            // Save & Continue Button
            Obx(() => SizedBox(
                  width: double.infinity,
                  height: size.customHeight(context) * 0.06,
                  child: ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : () => _saveNotesAndContinue(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: controller.isSaving.value
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: AppColors.whiteColor,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save & Add Feedback',
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.042,
                              fontWeight: FontWeight.w600,
                              color: AppColors.whiteColor,
                            ),
                          ),
                  ),
                )),

            SizedBox(height: size.customHeight(context) * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final size = CustomSize();
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.04,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryColor,
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    final size = CustomSize();

    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: GoogleFonts.poppins(
        fontSize: size.customWidth(context) * 0.038,
        color: AppColors.textPrimaryColor,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(
          color: AppColors.greyColor,
          fontSize: size.customWidth(context) * 0.036,
        ),
        filled: true,
        fillColor: AppColors.whiteColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16),
      ),
    );
  }

  Widget _buildPrescriptionCard(BuildContext context, int index) {
    final size = CustomSize();
    final prescription = controller.prescriptions[index];

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.greyColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Prescription ${index + 1}',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.036,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () => controller.removePrescription(index),
                icon: const Icon(Icons.delete_outline,
                    color: AppColors.errorColor, size: 20),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          TextField(
            controller: prescription.nameController,
            style: GoogleFonts.poppins(fontSize: size.customWidth(context) * 0.036),
            decoration: InputDecoration(
              hintText: 'Medicine/Exercise name',
              filled: true,
              fillColor: AppColors.lightGreyColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.01),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: prescription.dosageController,
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.036),
                  decoration: InputDecoration(
                    hintText: 'Dosage',
                    filled: true,
                    fillColor: AppColors.lightGreyColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
              SizedBox(width: size.customWidth(context) * 0.02),
              Expanded(
                child: TextField(
                  controller: prescription.durationController,
                  style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.036),
                  decoration: InputDecoration(
                    hintText: 'Duration',
                    filled: true,
                    fillColor: AppColors.lightGreyColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _saveNotesAndContinue() async {
    // Validation
    if (controller.discussionSummaryController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter discussion summary',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    if (controller.notesController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter session notes',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
      );
      return;
    }

    final success = await controller.saveAppointmentNotes(
      appointmentId: appointmentId,
    );

    if (success) {
      // Navigate to feedback screen
      Get.offNamed(
        AppRoutes.saveFeedback,
        arguments: {
          'appointmentId': appointmentId,
          'childName': childName,
        },
      );
    }
  }
}