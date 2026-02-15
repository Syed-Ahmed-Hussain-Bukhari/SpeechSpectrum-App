// lib/view/parent/parent_appointment_details_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/parent_appointment_controller.dart';

class ParentAppointmentDetailsScreen extends StatefulWidget {
  const ParentAppointmentDetailsScreen({super.key});

  @override
  State<ParentAppointmentDetailsScreen> createState() =>
      _ParentAppointmentDetailsScreenState();
}

class _ParentAppointmentDetailsScreenState
    extends State<ParentAppointmentDetailsScreen> {
  late final ParentAppointmentController controller;
  String? appointmentId;

  @override
  void initState() {
    super.initState();

    // Get or create controller
    if (Get.isRegistered<ParentAppointmentController>()) {
      controller = Get.find<ParentAppointmentController>();
    } else {
      controller = Get.put(ParentAppointmentController());
    }

    // Safely get appointmentId from arguments
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      appointmentId = args['appointmentId'] as String?;
    }

    // Fetch appointment details if we have an ID
    if (appointmentId != null && appointmentId!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.fetchAppointmentDetails(appointmentId: appointmentId!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    // If no appointment ID, show error immediately
    if (appointmentId == null || appointmentId!.isEmpty) {
      return Scaffold(
        backgroundColor: AppColors.lightGreyColor,
        appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          elevation: 0,
          leading: IconButton(
            icon:
                const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
            onPressed: () => Get.back(),
          ),
          title: Text(
            'Appointment Details',
            style: GoogleFonts.poppins(
              color: AppColors.textPrimaryColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: _buildErrorState(context, 'No appointment selected'),
      );
    }

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
          'Appointment Details',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchAppointmentDetails(
                appointmentId: appointmentId!),
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
                  'Loading details...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
              ],
            ),
          );
        }

        final details = controller.appointmentDetails.value;
        if (details == null) {
          return _buildErrorState(
              context, 'Failed to load appointment details');
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(size.customWidth(context) * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appointment Info Card
              _buildAppointmentInfoCard(context, details.data.appointment),

              SizedBox(height: size.customHeight(context) * 0.02),

              // Expert & Child Info
              _buildExpertChildCard(
                  context, details.data.appointment.expertChildLinks),

              SizedBox(height: size.customHeight(context) * 0.02),

              // Session Records
              if (details.data.records.isNotEmpty) ...[
                Row(
                  children: [
                    Icon(
                      Icons.note_alt_outlined,
                      color: AppColors.successColor,
                      size: 24,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.02),
                    Text(
                      'Session Notes',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.customHeight(context) * 0.015),
                ...details.data.records
                    .map((record) => _buildRecordCard(context, record))
                    .toList(),
              ] else
                _buildNoRecordsCard(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAppointmentInfoCard(BuildContext context, appointment) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accentColor,
            AppColors.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentColor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
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
                  color: AppColors.whiteColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _getAppointmentIcon(appointment.appointmentType),
                  color: AppColors.whiteColor,
                  size: 24,
                ),
              ),
              SizedBox(width: size.customWidth(context) * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getAppointmentTypeLabel(appointment.appointmentType),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.042,
                        fontWeight: FontWeight.w600,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    Text(
                      appointment.status.toUpperCase(),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.03,
                        color: AppColors.whiteColor.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          Divider(color: AppColors.whiteColor.withOpacity(0.3)),
          SizedBox(height: size.customHeight(context) * 0.015),
          Row(
            children: [
              Icon(Icons.calendar_today,
                  color: AppColors.whiteColor, size: 16),
              SizedBox(width: size.customWidth(context) * 0.02),
              Text(
                appointment.getFormattedDate(),
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.036,
                  color: AppColors.whiteColor,
                ),
              ),
              const Spacer(),
              Icon(Icons.access_time, color: AppColors.whiteColor, size: 16),
              SizedBox(width: size.customWidth(context) * 0.02),
              Text(
                appointment.getFormattedTime(),
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.036,
                  color: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpertChildCard(BuildContext context, links) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
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
              Icon(Icons.info_outline, color: AppColors.primaryColor, size: 20),
              SizedBox(width: size.customWidth(context) * 0.02),
              Text(
                'Appointment Information',
                style: GoogleFonts.poppins(
                  fontSize: size.customWidth(context) * 0.04,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: size.customHeight(context) * 0.015),
          _buildInfoRow(
            context,
            'Child',
            links.children.childName,
            Icons.child_care,
          ),
          SizedBox(height: size.customHeight(context) * 0.01),
          _buildInfoRow(
            context,
            'Expert',
            links.expertUsers.fullName,
            Icons.medical_services,
          ),
          SizedBox(height: size.customHeight(context) * 0.01),
          _buildInfoRow(
            context,
            'Specialization',
            links.expertUsers.specialization,
            Icons.school,
          ),
          SizedBox(height: size.customHeight(context) * 0.01),
          _buildInfoRow(
            context,
            'Organization',
            links.expertUsers.organization,
            Icons.business,
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(BuildContext context, record) {
    final size = CustomSize();

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
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
          // Therapy Plan
          _buildRecordSection(
            context,
            'Therapy Plan',
            record.therapyPlan,
            Icons.assignment_outlined,
          ),
          SizedBox(height: size.customHeight(context) * 0.015),

          // Notes
          _buildRecordSection(
            context,
            'Session Notes',
            record.notes,
            Icons.notes,
          ),
          SizedBox(height: size.customHeight(context) * 0.015),

          // Medication/Prescriptions
          if (record.medication != null) ...[
            Row(
              children: [
                Icon(Icons.medication_outlined,
                    size: 16, color: AppColors.primaryColor),
                SizedBox(width: size.customWidth(context) * 0.02),
                Text(
                  'Prescriptions & Recommendations',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.038,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.customHeight(context) * 0.01),
            ...record.medication!.prescriptions.map((p) => Container(
                  margin: EdgeInsets.only(
                      bottom: size.customHeight(context) * 0.008),
                  padding: EdgeInsets.all(size.customWidth(context) * 0.03),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.primaryColor.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle,
                              size: 6, color: AppColors.primaryColor),
                          SizedBox(width: size.customWidth(context) * 0.02),
                          Expanded(
                            child: Text(
                              p.name,
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.036,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textPrimaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.customHeight(context) * 0.005),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.customWidth(context) * 0.04),
                        child: Text(
                          'Dosage: ${p.dosage} • Duration: ${p.duration}',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.032,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
            if (record.medication!.recommendations.isNotEmpty) ...[
              SizedBox(height: size.customHeight(context) * 0.01),
              Container(
                padding: EdgeInsets.all(size.customWidth(context) * 0.03),
                decoration: BoxDecoration(
                  color: AppColors.accentColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.accentColor.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tips_and_updates,
                            size: 16, color: AppColors.accentColor),
                        SizedBox(width: size.customWidth(context) * 0.02),
                        Text(
                          'Recommendations',
                          style: GoogleFonts.poppins(
                            fontSize: size.customWidth(context) * 0.034,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.customHeight(context) * 0.008),
                    Text(
                      record.medication!.recommendations,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            SizedBox(height: size.customHeight(context) * 0.015),
          ],

          // Progress Feedback
          if (record.progressFeedback.isNotEmpty)
            Container(
              padding: EdgeInsets.all(size.customWidth(context) * 0.03),
              decoration: BoxDecoration(
                color: AppColors.successColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.successColor.withOpacity(0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.trending_up,
                          size: 16, color: AppColors.successColor),
                      SizedBox(width: size.customWidth(context) * 0.02),
                      Text(
                        'Progress Feedback',
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.036,
                          fontWeight: FontWeight.w600,
                          color: AppColors.successColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.customHeight(context) * 0.008),
                  Text(
                    record.progressFeedback,
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.034,
                      color: AppColors.textSecondaryColor,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecordSection(
      BuildContext context, String title, String content, IconData icon) {
    final size = CustomSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: AppColors.primaryColor),
            SizedBox(width: size.customWidth(context) * 0.02),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.036,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
            ),
          ],
        ),
        SizedBox(height: size.customHeight(context) * 0.008),
        Text(
          content,
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.034,
            color: AppColors.textSecondaryColor,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    final size = CustomSize();

    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.primaryColor),
        SizedBox(width: size.customWidth(context) * 0.02),
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.034,
            color: AppColors.textSecondaryColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.034,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoRecordsCard(BuildContext context) {
    final size = CustomSize();

    return Container(
      padding: EdgeInsets.all(size.customWidth(context) * 0.06),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(
            Icons.note_add_outlined,
            size: 60,
            color: AppColors.greyColor.withOpacity(0.5),
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text(
            'No session notes yet',
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.042,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.008),
          Text(
            'Session notes will appear here\nafter the expert completes the appointment',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.034,
              color: AppColors.textSecondaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    final size = CustomSize();

    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: AppColors.errorColor.withOpacity(0.5),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              errorMessage,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.05,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'Please go back and try again',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.038,
                color: AppColors.textSecondaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            ElevatedButton.icon(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back),
              label: Text(
                'Go Back',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getAppointmentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'meet':
      case 'google_meet':
        return Icons.video_call;
      case 'call':
        return Icons.phone;
      case 'chat':
        return Icons.chat_bubble_outline;
      case 'physical':
        return Icons.location_on;
      default:
        return Icons.event;
    }
  }

  String _getAppointmentTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'meet':
      case 'google_meet':
        return 'Google Meet Appointment';
      case 'call':
        return 'Phone Call Appointment';
      case 'chat':
        return 'Chat Appointment';
      case 'physical':
        return 'Physical Appointment';
      default:
        return type;
    }
  }
}