// lib/view/expert/patients/patients_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/patients_controller.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({super.key});

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  late final PatientsController _c;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _c = Get.isRegistered<PatientsController>()
        ? Get.find<PatientsController>()
        : Get.put(PatientsController());
    WidgetsBinding.instance.addPostFrameCallback((_) => _c.fetchPatients());
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          _buildSearchBar(context, size),
          Expanded(child: _buildBody(context, size)),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: AppColors.textPrimaryColor, size: 20),
        onPressed: () => Get.back(),
      ),
      title: Text(
        'My Patients',
        style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600),
      ),
      actions: [
        Obx(() => _c.isLoading.value
            ? const Padding(
                padding: EdgeInsets.all(14),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                      color: AppColors.primaryColor, strokeWidth: 2),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.refresh_rounded,
                    color: AppColors.primaryColor),
                onPressed: _c.fetchPatients,
              )),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, CustomSize size) {
    return Container(
      color: AppColors.whiteColor,
      padding: EdgeInsets.fromLTRB(
        size.customWidth(context) * 0.045,
        0,
        size.customWidth(context) * 0.045,
        14,
      ),
      child: TextField(
        controller: _searchCtrl,
        onChanged: (v) => _c.searchQuery.value = v,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search patient by name…',
          hintStyle: GoogleFonts.poppins(
              fontSize: 13.5, color: AppColors.textSecondaryColor),
          prefixIcon: const Icon(Icons.search_rounded,
              color: AppColors.textSecondaryColor, size: 20),
          suffixIcon: Obx(() => _c.searchQuery.value.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close_rounded,
                      color: AppColors.textSecondaryColor, size: 18),
                  onPressed: () {
                    _searchCtrl.clear();
                    _c.searchQuery.value = '';
                  },
                )
              : const SizedBox.shrink()),
          filled: true,
          fillColor: AppColors.lightGreyColor,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
                color: AppColors.primaryColor, width: 1.5),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, CustomSize size) {
    return Obx(() {
      if (_c.isLoading.value && _c.allPatients.isEmpty) {
        return _buildLoader();
      }

      if (_c.filteredPatients.isEmpty) {
        return _buildEmpty(context, size);
      }

      return RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: _c.fetchPatients,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(
            size.customWidth(context) * 0.045,
            size.customHeight(context) * 0.018,
            size.customWidth(context) * 0.045,
            size.customHeight(context) * 0.04,
          ),
          itemCount: _c.filteredPatients.length + 1,
          itemBuilder: (_, i) {
            if (i == 0) return _buildHeader(context, size);
            final patient = _c.filteredPatients[i - 1];
            return _patientCard(context, size, patient);
          },
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context, CustomSize size) {
    return Obx(() => Padding(
          padding: EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
          child: Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.people_alt_outlined,
                        size: 14, color: AppColors.primaryColor),
                    const SizedBox(width: 6),
                    Text(
                      '${_c.filteredPatients.length} patient${_c.filteredPatients.length == 1 ? '' : 's'}',
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _patientCard(
      BuildContext context, CustomSize size, PatientSummary patient) {
    final statusColor = _statusColor(patient.latestStatus);

    return GestureDetector(
      // onTap: () => Get.toNamed(
      //   AppRoutes.patientDetail,
      //   arguments: {
      //     'childId': patient.childId,
      //     'childName': patient.childName,
      //   },
      // ),
      child: Container(
        margin:
            EdgeInsets.only(bottom: size.customHeight(context) * 0.014),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.055),
                blurRadius: 12,
                offset: const Offset(0, 3))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              // Avatar
              _avatar(patient.initials, 54),
              const SizedBox(width: 14),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.childName,
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimaryColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        _chip(
                          '${patient.totalAppointments} appt${patient.totalAppointments == 1 ? '' : 's'}',
                          Icons.calendar_month_outlined,
                          AppColors.primaryColor,
                        ),
                        const SizedBox(width: 8),
                        _chip(
                          _statusLabel(patient.latestStatus),
                          _statusIcon(patient.latestStatus),
                          statusColor,
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined,
                            size: 11,
                            color: AppColors.textSecondaryColor),
                        const SizedBox(width: 4),
                        Text(
                          'Latest: ${patient.formattedLatestDate}',
                          style: GoogleFonts.poppins(
                              fontSize: 11,
                              color: AppColors.textSecondaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppColors.textSecondaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar(String initials, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(initials,
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: size * 0.3,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _chip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color)),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(
          color: AppColors.primaryColor, strokeWidth: 3),
    );
  }

  Widget _buildEmpty(BuildContext context, CustomSize size) {
    final hasSearch = _c.searchQuery.value.isNotEmpty;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.07),
                shape: BoxShape.circle),
            child: Icon(
              hasSearch ? Icons.search_off_rounded : Icons.people_outline,
              size: 46,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: size.customHeight(context) * 0.02),
          Text(
            hasSearch ? 'No patients found' : 'No Patients Yet',
            style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            hasSearch
                ? 'Try a different name'
                : 'Patients appear once appointments are made',
            style: GoogleFonts.poppins(
                fontSize: 13, color: AppColors.textSecondaryColor),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ── Helpers ──────────────────────────────────────────────────
  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return AppColors.primaryColor;
      case 'completed':
        return AppColors.successColor;
      case 'cancelled':
        return AppColors.errorColor;
      case 'no_show':
        return AppColors.greyColor;
      default:
        return AppColors.warningColor;
    }
  }

  String _statusLabel(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return 'Confirmed';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'no_show':
        return 'No Show';
      default:
        return 'Requested';
    }
  }

  IconData _statusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle_outline_rounded;
      case 'completed':
        return Icons.task_alt_rounded;
      case 'cancelled':
        return Icons.cancel_outlined;
      case 'no_show':
        return Icons.person_off_outlined;
      default:
        return Icons.schedule_rounded;
    }
  }
}