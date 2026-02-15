// lib/view/parent/parent_appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/parent_appointment_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ParentAppointmentsScreen extends StatefulWidget {
  const ParentAppointmentsScreen({super.key});

  @override
  State<ParentAppointmentsScreen> createState() =>
      _ParentAppointmentsScreenState();
}

class _ParentAppointmentsScreenState extends State<ParentAppointmentsScreen>
    with SingleTickerProviderStateMixin {
  late final ParentAppointmentController controller;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Get or create controller
    if (Get.isRegistered<ParentAppointmentController>()) {
      controller = Get.find<ParentAppointmentController>();
    } else {
      controller = Get.put(ParentAppointmentController());
    }

    // Fetch appointments after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchParentAppointments();
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
          'My Appointments',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchParentAppointments(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: AppColors.textSecondaryColor,
          indicatorColor: AppColors.primaryColor,
          indicatorWeight: 3,
          labelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Scheduled'),
            Tab(text: 'Completed'),
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
                  'Loading appointments...',
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
            _buildAppointmentsList(controller.appointments),
            _buildAppointmentsList(
                controller.appointments.where((a) => a.isScheduled()).toList()),
            _buildAppointmentsList(
                controller.appointments.where((a) => a.isCompleted()).toList()),
          ],
        );
      }),
    );
  }

  Widget _buildAppointmentsList(List appointments) {
    final size = CustomSize();

    if (appointments.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: EdgeInsets.all(size.customWidth(context) * 0.04),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return _buildAppointmentCard(context, appointment);
      },
    );
  }

  Widget _buildAppointmentCard(BuildContext context, appointment) {
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
              AppRoutes.parentAppointmentDetails,
              arguments: {'appointmentId': appointment.appointmentId},
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
                    // Expert Avatar
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
                          _getExpertInitials(appointment.expertChildLinks.expertUsers.fullName),
                          style: GoogleFonts.poppins(
                            color: AppColors.whiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: size.customWidth(context) * 0.03),

                    // Appointment Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.expertChildLinks.expertUsers.fullName,
                            style: GoogleFonts.poppins(
                              fontSize: size.customWidth(context) * 0.04,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: size.customHeight(context) * 0.003),
                          Row(
                            children: [
                              Icon(
                                _getAppointmentIcon(
                                    appointment.appointmentType),
                                size: 14,
                                color: _getAppointmentColor(
                                    appointment.appointmentType),
                              ),
                              SizedBox(width: size.customWidth(context) * 0.015),
                              Text(
                                _getAppointmentTypeLabel(
                                    appointment.appointmentType),
                                style: GoogleFonts.poppins(
                                  fontSize: size.customWidth(context) * 0.032,
                                  color: _getAppointmentColor(
                                      appointment.appointmentType),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
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
                        color: appointment.isScheduled()
                            ? AppColors.primaryColor.withOpacity(0.1)
                            : AppColors.successColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        appointment.status.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.028,
                          fontWeight: FontWeight.bold,
                          color: appointment.isScheduled()
                              ? AppColors.primaryColor
                              : AppColors.successColor,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.customHeight(context) * 0.015),
                Divider(color: AppColors.greyColor.withOpacity(0.2)),
                SizedBox(height: size.customHeight(context) * 0.01),

                // Child & Date Info
                Row(
                  children: [
                    Icon(
                      Icons.child_care_outlined,
                      size: 16,
                      color: AppColors.textSecondaryColor,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.02),
                    Text(
                      appointment.expertChildLinks.children.childName,
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.034,
                        color: AppColors.textPrimaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 16,
                      color: AppColors.textSecondaryColor,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.015),
                    Text(
                      appointment.getFormattedDate(),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: size.customHeight(context) * 0.008),

                // Specialization & Time
                Row(
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      size: 16,
                      color: AppColors.textSecondaryColor,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.02),
                    Expanded(
                      child: Text(
                        appointment.expertChildLinks.expertUsers.specialization,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.032,
                          color: AppColors.textSecondaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: AppColors.textSecondaryColor,
                    ),
                    SizedBox(width: size.customWidth(context) * 0.015),
                    Text(
                      appointment.getFormattedTime(),
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.032,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),

                // Tap to view details hint
                SizedBox(height: size.customHeight(context) * 0.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Tap to view details',
                      style: GoogleFonts.poppins(
                        fontSize: size.customWidth(context) * 0.03,
                        color: AppColors.primaryColor,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(width: size.customWidth(context) * 0.015),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: AppColors.primaryColor,
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

  String _getExpertInitials(String fullName) {
    final names = fullName.trim().split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    } else if (names.isNotEmpty) {
      return names[0][0].toUpperCase();
    }
    return 'E';
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

  Color _getAppointmentColor(String type) {
    switch (type.toLowerCase()) {
      case 'meet':
      case 'google_meet':
        return AppColors.primaryColor;
      case 'call':
        return AppColors.accentColor;
      case 'chat':
        return AppColors.successColor;
      case 'physical':
        return AppColors.warningColor;
      default:
        return AppColors.textSecondaryColor;
    }
  }

  String _getAppointmentTypeLabel(String type) {
    switch (type.toLowerCase()) {
      case 'meet':
      case 'google_meet':
        return 'Google Meet';
      case 'call':
        return 'Call';
      case 'chat':
        return 'Chat';
      case 'physical':
        return 'Physical';
      default:
        return type;
    }
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
                Icons.event_busy_outlined,
                size: 70,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              'No Appointments',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'You don\'t have any\nappointments scheduled',
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