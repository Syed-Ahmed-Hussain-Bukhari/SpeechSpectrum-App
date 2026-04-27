// lib/controllers/patients_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/appointment_detail_model.dart';
import 'package:speechspectrum/models/child_profile_model.dart';
import 'package:speechspectrum/models/my_appointment_model.dart';
import 'package:speechspectrum/services/child_profile_service.dart';
import 'package:speechspectrum/services/my_appointment_service.dart';
import 'package:dio/dio.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class PatientsController extends GetxController {
  final MyAppointmentService _apptService = MyAppointmentService();
  final ChildProfileService _childService = ChildProfileService();
  final Dio _dio = Dio();

  // ── State ──────────────────────────────────────────────────
  final isLoading = false.obs;
  final isLoadingChildDetail = false.obs;
  final isLoadingAppointmentDetail = false.obs;

  // All unique patients derived from appointments
  final allPatients = <PatientSummary>[].obs;
  final filteredPatients = <PatientSummary>[].obs;
  final searchQuery = ''.obs;

  // Selected patient detail
  final selectedChild = Rxn<ChildData>();
  final selectedHealth = Rxn<ChildHealthData>();
  final selectedPatientAppointments = <MyAppointmentItem>[].obs;

  // Selected appointment detail
  final selectedAppointmentDetail = Rxn<AppointmentDetailData>();

  // Raw all appointments (to filter per child)
  final _allAppointments = <MyAppointmentItem>[];

  @override
  void onInit() {
    super.onInit();
    ever(searchQuery, (_) => _applySearch());
  }

  // ── Fetch all patients ─────────────────────────────────────
  Future<void> fetchPatients() async {
    try {
      isLoading.value = true;
      final result = await _apptService.getMyAppointments();
      if (result.success) {
        _allAppointments
          ..clear()
          ..addAll(result.data);
        _buildPatientList(result.data);
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void _buildPatientList(List<MyAppointmentItem> appointments) {
    // Deduplicate by childId, keep latest appointment info
    final Map<String, PatientSummary> map = {};
    for (final appt in appointments) {
      if (!map.containsKey(appt.childId)) {
        map[appt.childId] = PatientSummary(
          childId: appt.childId,
          childName: appt.children?.childName ?? 'Unknown',
          initials: appt.childInitials,
          totalAppointments: 1,
          latestStatus: appt.status,
          latestDate: appt.scheduledAt,
        );
      } else {
        final existing = map[appt.childId]!;
        map[appt.childId] = PatientSummary(
          childId: existing.childId,
          childName: existing.childName,
          initials: existing.initials,
          totalAppointments: existing.totalAppointments + 1,
          latestStatus: existing.latestStatus,
          latestDate: existing.latestDate,
        );
      }
    }
    final list = map.values.toList()
      ..sort((a, b) => a.childName.compareTo(b.childName));
    allPatients.assignAll(list);
    filteredPatients.assignAll(list);
  }

  void _applySearch() {
    final q = searchQuery.value.toLowerCase().trim();
    if (q.isEmpty) {
      filteredPatients.assignAll(allPatients);
    } else {
      filteredPatients.assignAll(
        allPatients.where((p) => p.childName.toLowerCase().contains(q)),
      );
    }
  }

  // ── Load child detail + health + their appointments ────────
  Future<void> loadPatientDetail(String childId) async {
    try {
      isLoadingChildDetail.value = true;
      selectedChild.value = null;
      selectedHealth.value = null;
      selectedPatientAppointments.clear();

      // Filter appointments for this child
      final childAppts = _allAppointments
          .where((a) => a.childId == childId)
          .toList()
        ..sort((a, b) =>
            DateTime.parse(b.scheduledAt)
                .compareTo(DateTime.parse(a.scheduledAt)));
      selectedPatientAppointments.assignAll(childAppts);

      // Fetch child profile + health in parallel
      await Future.wait([
        _fetchChildProfile(childId),
        _fetchChildHealth(childId),
      ]);
    } finally {
      isLoadingChildDetail.value = false;
    }
  }

  Future<void> _fetchChildProfile(String childId) async {
    try {
      final result = await _childService.getChildProfile(childId);
      if (result.status) selectedChild.value = result.data;
    } catch (_) {}
  }

  Future<void> _fetchChildHealth(String childId) async {
    try {
      final result = await _childService.getChildHealth(childId);
      if (result.status) selectedHealth.value = result.data;
    } catch (_) {}
  }

  // ── Load single appointment detail ─────────────────────────
  Future<void> loadAppointmentDetail(String appointmentId) async {
    try {
      isLoadingAppointmentDetail.value = true;
      selectedAppointmentDetail.value = null;
      final token = await SharedPreferencesService.getAccessToken();
      final resp = await _dio.get(
        '${APIEndPoints.appointmentsBase}/$appointmentId',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }),
      );
      final model = AppointmentDetailModel.fromJson(
          Map<String, dynamic>.from(resp.data as Map));
      if (model.success) {
        selectedAppointmentDetail.value = model.data;
      }
    } catch (e) {
      _showError('Failed to load appointment detail');
    } finally {
      isLoadingAppointmentDetail.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────
  List<MyAppointmentItem> appointmentsForChild(String childId) =>
      _allAppointments
          .where((a) => a.childId == childId)
          .toList()
        ..sort((a, b) => DateTime.parse(b.scheduledAt)
            .compareTo(DateTime.parse(a.scheduledAt)));

  void _showError(String msg) {
    Get.snackbar('❌ Error', msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        duration: const Duration(seconds: 4));
  }
}

// ── Simple summary model used in the patients list ─────────
class PatientSummary {
  final String childId;
  final String childName;
  final String initials;
  final int totalAppointments;
  final String latestStatus;
  final String latestDate;

  const PatientSummary({
    required this.childId,
    required this.childName,
    required this.initials,
    required this.totalAppointments,
    required this.latestStatus,
    required this.latestDate,
  });

  String get formattedLatestDate {
    try {
      final dt = DateTime.parse(latestDate).toLocal();
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${dt.day} ${months[dt.month]} ${dt.year}';
    } catch (_) {
      return latestDate;
    }
  }
}