// // lib/controllers/slot_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/location_model.dart';
// import 'package:speechspectrum/models/slot_model.dart';
// import 'package:speechspectrum/services/location_service.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';
// import 'package:speechspectrum/services/slot_service.dart';

// class SlotController extends GetxController {
//   final SlotService _slotService = SlotService();
//   final LocationService _locationService = LocationService();

//   // ── State ──────────────────────────────────────────────────
//   var isLoading = false.obs;
//   var isLoadingLocations = false.obs;

//   var mySlots = <SlotItem>[].obs;
//   var myLocations = <LocationItem>[].obs;

//   // ── Week day tracking ──────────────────────────────────────
//   // Days that already have at least one slot this week
//   var createdDays = <String>{}.obs; // e.g. {'Monday', 'Wednesday'}

//   static const List<String> weekDays = [
//     'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
//   ];

//   // ── Form state ─────────────────────────────────────────────
//   var selectedMode = 'both'.obs;
//   var selectedLocationId = ''.obs;
//   var selectedLocationLabel = ''.obs;
//   var isRecurring = false.obs;
//   var selectedDate = Rxn<DateTime>();
//   var selectedStartTime = Rxn<TimeOfDay>();
//   var selectedEndTime = Rxn<TimeOfDay>();
//   var selectedStatus = 'available'.obs;

//   final feeOnlineCtrl = TextEditingController();
//   final feePhysicalCtrl = TextEditingController();
//   final currencyCtrl = TextEditingController(text: 'PKR');
//   final recurrenceCtrl = TextEditingController();

//   @override
//   void onClose() {
//     feeOnlineCtrl.dispose();
//     feePhysicalCtrl.dispose();
//     currencyCtrl.dispose();
//     recurrenceCtrl.dispose();
//     super.onClose();
//   }

//   // ── Form helpers ───────────────────────────────────────────
//   void resetForm() {
//     selectedMode.value = 'both';
//     selectedLocationId.value = '';
//     selectedLocationLabel.value = '';
//     isRecurring.value = false;
//     selectedDate.value = null;
//     selectedStartTime.value = null;
//     selectedEndTime.value = null;
//     selectedStatus.value = 'available';
//     feeOnlineCtrl.clear();
//     feePhysicalCtrl.clear();
//     currencyCtrl.text = 'PKR';
//     recurrenceCtrl.clear();
//   }

//   void populateFormFromSlot(SlotItem slot) {
//     selectedMode.value = slot.mode;
//     selectedLocationId.value = slot.locationId ?? '';
//     isRecurring.value = slot.isRecurring;
//     selectedStatus.value = slot.status;
//     feeOnlineCtrl.text = slot.feeOnline?.toStringAsFixed(0) ?? '';
//     feePhysicalCtrl.text = slot.feePhysical?.toStringAsFixed(0) ?? '';
//     currencyCtrl.text = slot.currency;
//     recurrenceCtrl.text = slot.recurrenceRule ?? '';

//     // Date
//     try {
//       selectedDate.value = DateTime.parse(slot.slotDate);
//     } catch (_) {}

//     // Start time
//     try {
//       final parts = slot.startTime.split(':');
//       selectedStartTime.value =
//           TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
//     } catch (_) {}

//     // End time
//     try {
//       final parts = slot.endTime.split(':');
//       selectedEndTime.value =
//           TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
//     } catch (_) {}

//     // Location label
//     if (slot.expertLocations != null) {
//       selectedLocationLabel.value = slot.expertLocations!.label;
//     } else if (slot.locationId != null) {
//       final loc = myLocations.firstWhereOrNull(
//           (l) => l.locationId == slot.locationId);
//       selectedLocationLabel.value = loc?.label ?? '';
//     }
//   }

//   String get formattedStartTime {
//     final t = selectedStartTime.value;
//     if (t == null) return 'Select start time';
//     final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
//     final m = t.minute.toString().padLeft(2, '0');
//     final period = t.period == DayPeriod.am ? 'AM' : 'PM';
//     return '$h:$m $period';
//   }

//   String get formattedEndTime {
//     final t = selectedEndTime.value;
//     if (t == null) return 'Select end time';
//     final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
//     final m = t.minute.toString().padLeft(2, '0');
//     final period = t.period == DayPeriod.am ? 'AM' : 'PM';
//     return '$h:$m $period';
//   }

//   String get formattedDate {
//     final d = selectedDate.value;
//     if (d == null) return 'Select date';
//     const months = [
//       '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
//       'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
//     ];
//     const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
//     return '${days[d.weekday - 1]}, ${d.day} ${months[d.month]} ${d.year}';
//   }

//   String get selectedDayName {
//     final d = selectedDate.value;
//     if (d == null) return '';
//     return weekDays[d.weekday - 1];
//   }

//   String _timeOfDayToString(TimeOfDay t) {
//     final h = t.hour.toString().padLeft(2, '0');
//     final m = t.minute.toString().padLeft(2, '0');
//     return '$h:$m:00';
//   }

//   // ── API calls ──────────────────────────────────────────────
//   Future<void> fetchMySlots() async {
//     try {
//       isLoading.value = true;
//       final response = await _slotService.getMySlots();
//       if (response.success) {
//         mySlots.value = response.data;
//         _buildCreatedDays();
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchMyLocations() async {
//     try {
//       isLoadingLocations.value = true;
//       final expertId = await SharedPreferencesService.getUserId();
//       if (expertId == null || expertId.isEmpty) return;
//       final response = await _locationService.getExpertLocations(expertId);
//       if (response.success) myLocations.value = response.data;
//     } catch (e) {
//       debugPrint('❌ Fetch locations for slots: $e');
//     } finally {
//       isLoadingLocations.value = false;
//     }
//   }

//   Future<bool> createSlot() async {
//     if (!_validateForm()) return false;
//     try {
//       isLoading.value = true;
//       final dateStr =
//           '${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}';

//       final response = await _slotService.createSlot(
//         slotDate: dateStr,
//         startTime: _timeOfDayToString(selectedStartTime.value!),
//         endTime: _timeOfDayToString(selectedEndTime.value!),
//         mode: selectedMode.value,
//         feeOnline: selectedMode.value != 'physical'
//             ? double.tryParse(feeOnlineCtrl.text.trim())
//             : null,
//         feePhysical: selectedMode.value != 'online'
//             ? double.tryParse(feePhysicalCtrl.text.trim())
//             : null,
//         currency: currencyCtrl.text.trim().isEmpty ? 'PKR' : currencyCtrl.text.trim(),
//         locationId: selectedLocationId.value.isEmpty ? null : selectedLocationId.value,
//         isRecurring: isRecurring.value,
//         recurrenceRule: isRecurring.value && recurrenceCtrl.text.trim().isNotEmpty
//             ? recurrenceCtrl.text.trim()
//             : (isRecurring.value ? 'Weekly Every $selectedDayName' : null),
//         status: selectedStatus.value,
//       );

//       if (response.success) {
//         mySlots.insert(0, response.data);
//         _buildCreatedDays();
//         _showSuccess('Slot created for $selectedDayName ✓');
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<bool> updateSlot(String slotId) async {
//     try {
//       isLoading.value = true;
//       final dateStr = selectedDate.value != null
//           ? '${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}'
//           : null;

//       final response = await _slotService.updateSlot(
//         slotId: slotId,
//         slotDate: dateStr,
//         startTime: selectedStartTime.value != null
//             ? _timeOfDayToString(selectedStartTime.value!)
//             : null,
//         endTime: selectedEndTime.value != null
//             ? _timeOfDayToString(selectedEndTime.value!)
//             : null,
//         mode: selectedMode.value,
//         feeOnline: selectedMode.value != 'physical'
//             ? double.tryParse(feeOnlineCtrl.text.trim())
//             : null,
//         feePhysical: selectedMode.value != 'online'
//             ? double.tryParse(feePhysicalCtrl.text.trim())
//             : null,
//         currency: currencyCtrl.text.trim().isEmpty ? 'PKR' : currencyCtrl.text.trim(),
//         locationId: selectedLocationId.value.isEmpty ? null : selectedLocationId.value,
//         isRecurring: isRecurring.value,
//         recurrenceRule: recurrenceCtrl.text.trim().isEmpty ? null : recurrenceCtrl.text.trim(),
//         status: selectedStatus.value,
//       );

//       if (response.success) {
//         final idx = mySlots.indexWhere((s) => s.slotId == slotId);
//         if (idx != -1) mySlots[idx] = response.data;
//         _buildCreatedDays();
//         _showSuccess('Slot updated successfully');
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<bool> deleteSlot(String slotId) async {
//     try {
//       isLoading.value = true;
//       await _slotService.deleteSlot(slotId);
//       mySlots.removeWhere((s) => s.slotId == slotId);
//       _buildCreatedDays();
//       _showSuccess('Slot removed');
//       return true;
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ── Helpers ────────────────────────────────────────────────
//   void _buildCreatedDays() {
//     final days = <String>{};
//     for (final slot in mySlots) {
//       try {
//         final d = DateTime.parse(slot.slotDate);
//         days.add(weekDays[d.weekday - 1]);
//       } catch (_) {}
//     }
//     createdDays.value = days;
//   }

//   List<SlotItem> getSlotsForDay(String dayName) {
//     return mySlots.where((s) {
//       try {
//         final d = DateTime.parse(s.slotDate);
//         return weekDays[d.weekday - 1] == dayName;
//       } catch (_) {
//         return false;
//       }
//     }).toList();
//   }

//   bool _validateForm() {
//     if (selectedDate.value == null) {
//       _showError('Please select a date');
//       return false;
//     }
//     if (selectedStartTime.value == null) {
//       _showError('Please select a start time');
//       return false;
//     }
//     if (selectedEndTime.value == null) {
//       _showError('Please select an end time');
//       return false;
//     }
//     final startMinutes = selectedStartTime.value!.hour * 60 + selectedStartTime.value!.minute;
//     final endMinutes = selectedEndTime.value!.hour * 60 + selectedEndTime.value!.minute;
//     if (endMinutes <= startMinutes) {
//       _showError('End time must be after start time');
//       return false;
//     }
//     if (selectedMode.value != 'physical' &&
//         (feeOnlineCtrl.text.trim().isEmpty ||
//             double.tryParse(feeOnlineCtrl.text.trim()) == null)) {
//       _showError('Please enter a valid online fee');
//       return false;
//     }
//     if (selectedMode.value != 'online' &&
//         (feePhysicalCtrl.text.trim().isEmpty ||
//             double.tryParse(feePhysicalCtrl.text.trim()) == null)) {
//       _showError('Please enter a valid physical fee');
//       return false;
//     }
//     return true;
//   }

//   void _showSuccess(String msg) => Get.snackbar('Success', msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 3));

//   void _showError(String msg) => Get.snackbar('Error', msg,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 4));
// }

// lib/controllers/slot_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/location_model.dart';
import 'package:speechspectrum/models/slot_model.dart';
import 'package:speechspectrum/services/location_service.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';
import 'package:speechspectrum/services/slot_service.dart';

class SlotController extends GetxController {
  final SlotService _slotService = SlotService();
  final LocationService _locationService = LocationService();

  // ── State ──────────────────────────────────────────────────
  var isLoading = false.obs;
  var isLoadingLocations = false.obs;

  var mySlots = <SlotItem>[].obs;
  var myLocations = <LocationItem>[].obs;

  // ── Week day tracking ──────────────────────────────────────
  // Days that already have at least one slot this week
  var createdDays = <String>{}.obs; // e.g. {'Monday', 'Wednesday'}

  static const List<String> weekDays = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'
  ];

  // ── Form state ─────────────────────────────────────────────
  var selectedMode = 'both'.obs;
  var selectedLocationId = ''.obs;
  var selectedLocationLabel = ''.obs;
  var isRecurring = false.obs;
  var selectedDate = Rxn<DateTime>();
  var selectedStartTime = Rxn<TimeOfDay>();
  var selectedEndTime = Rxn<TimeOfDay>();
  var selectedStatus = 'available'.obs;

  final feeOnlineCtrl = TextEditingController();
  final feePhysicalCtrl = TextEditingController();
  final currencyCtrl = TextEditingController(text: 'PKR');
  final recurrenceCtrl = TextEditingController();
  final topicCtrl = TextEditingController(text: 'Speech Therapy Session');

  // Last generated Zoom link (stored after generation, attached to slot)
  ZoomLinkResult? lastZoomLink;

  @override
  void onClose() {
    feeOnlineCtrl.dispose();
    feePhysicalCtrl.dispose();
    currencyCtrl.dispose();
    recurrenceCtrl.dispose();
    topicCtrl.dispose();
    super.onClose();
  }

  // ── Form helpers ───────────────────────────────────────────
  void resetForm() {
    selectedMode.value = 'both';
    selectedLocationId.value = '';
    selectedLocationLabel.value = '';
    isRecurring.value = false;
    selectedDate.value = null;
    selectedStartTime.value = null;
    selectedEndTime.value = null;
    selectedStatus.value = 'available';
    feeOnlineCtrl.clear();
    feePhysicalCtrl.clear();
    currencyCtrl.text = 'PKR';
    recurrenceCtrl.clear();
    topicCtrl.text = 'Speech Therapy Session';
    lastZoomLink = null;
  }

  void populateFormFromSlot(SlotItem slot) {
    selectedMode.value = slot.mode;
    selectedLocationId.value = slot.locationId ?? '';
    isRecurring.value = slot.isRecurring;
    selectedStatus.value = slot.status;
    feeOnlineCtrl.text = slot.feeOnline?.toStringAsFixed(0) ?? '';
    feePhysicalCtrl.text = slot.feePhysical?.toStringAsFixed(0) ?? '';
    currencyCtrl.text = slot.currency;
    recurrenceCtrl.text = slot.recurrenceRule ?? '';

    // Date
    try {
      selectedDate.value = DateTime.parse(slot.slotDate);
    } catch (_) {}

    // Start time
    try {
      final parts = slot.startTime.split(':');
      selectedStartTime.value =
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {}

    // End time
    try {
      final parts = slot.endTime.split(':');
      selectedEndTime.value =
          TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
    } catch (_) {}

    // Location label
    if (slot.expertLocations != null) {
      selectedLocationLabel.value = slot.expertLocations!.label;
    } else if (slot.locationId != null) {
      final loc = myLocations.firstWhereOrNull(
          (l) => l.locationId == slot.locationId);
      selectedLocationLabel.value = loc?.label ?? '';
    }
  }

  String get formattedStartTime {
    final t = selectedStartTime.value;
    if (t == null) return 'Select start time';
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $period';
  }

  String get formattedEndTime {
    final t = selectedEndTime.value;
    if (t == null) return 'Select end time';
    final h = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final m = t.minute.toString().padLeft(2, '0');
    final period = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '$h:$m $period';
  }

  String get formattedDate {
    final d = selectedDate.value;
    if (d == null) return 'Select date';
    const months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${days[d.weekday - 1]}, ${d.day} ${months[d.month]} ${d.year}';
  }

  String get selectedDayName {
    final d = selectedDate.value;
    if (d == null) return '';
    return weekDays[d.weekday - 1];
  }

  String _timeOfDayToString(TimeOfDay t) {
    final h = t.hour.toString().padLeft(2, '0');
    final m = t.minute.toString().padLeft(2, '0');
    return '$h:$m:00';
  }

  /// True when mode requires a Zoom link (online or both)
  bool get needsZoom =>
      selectedMode.value == 'online' || selectedMode.value == 'both';

  // ── API calls ──────────────────────────────────────────────
  Future<void> fetchMySlots() async {
    try {
      isLoading.value = true;
      final response = await _slotService.getMySlots();
      if (response.success) {
        mySlots.value = response.data;
        _buildCreatedDays();
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyLocations() async {
    try {
      isLoadingLocations.value = true;
      final expertId = await SharedPreferencesService.getUserId();
      if (expertId == null || expertId.isEmpty) return;
      final response = await _locationService.getExpertLocations(expertId);
      if (response.success) myLocations.value = response.data;
    } catch (e) {
      debugPrint('❌ Fetch locations for slots: $e');
    } finally {
      isLoadingLocations.value = false;
    }
  }

  Future<bool> createSlot() async {
    if (!_validateForm()) return false;
    try {
      isLoading.value = true;
      final dateStr =
          '${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}';

      // Build ISO8601 start_time from date + start time for Zoom
      String? zoomJoinUrl;
      if (needsZoom) {
        final st = selectedStartTime.value!;
        final d = selectedDate.value!;
        // Compose UTC-like ISO string from local date+time
        final startIso =
            '${dateStr}T${st.hour.toString().padLeft(2, '0')}:${st.minute.toString().padLeft(2, '0')}:00Z';
        final zoom = await _slotService.generateZoomLink(
          topic: topicCtrl.text.trim().isEmpty
              ? 'Speech Therapy Session'
              : topicCtrl.text.trim(),
          startTime: startIso,
        );
        zoomJoinUrl = zoom.joinUrl;
        lastZoomLink = zoom;
        debugPrint('🔗 Zoom URL attached to slot: $zoomJoinUrl');
      }

      final response = await _slotService.createSlot(
        slotDate: dateStr,
        startTime: _timeOfDayToString(selectedStartTime.value!),
        endTime: _timeOfDayToString(selectedEndTime.value!),
        mode: selectedMode.value,
        feeOnline: selectedMode.value != 'physical'
            ? double.tryParse(feeOnlineCtrl.text.trim())
            : null,
        feePhysical: selectedMode.value != 'online'
            ? double.tryParse(feePhysicalCtrl.text.trim())
            : null,
        currency: currencyCtrl.text.trim().isEmpty ? 'PKR' : currencyCtrl.text.trim(),
        locationId: selectedLocationId.value.isEmpty ? null : selectedLocationId.value,
        isRecurring: isRecurring.value,
        recurrenceRule: isRecurring.value && recurrenceCtrl.text.trim().isNotEmpty
            ? recurrenceCtrl.text.trim()
            : (isRecurring.value ? 'Weekly Every $selectedDayName' : null),
        status: selectedStatus.value,
        meetLink: zoomJoinUrl,
      );

      if (response.success) {
        mySlots.insert(0, response.data);
        _buildCreatedDays();
        _showSuccess('Slot created for $selectedDayName ✓');
        return true;
      }
      return false;
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> updateSlot(String slotId) async {
    try {
      isLoading.value = true;
      final dateStr = selectedDate.value != null
          ? '${selectedDate.value!.year}-${selectedDate.value!.month.toString().padLeft(2, '0')}-${selectedDate.value!.day.toString().padLeft(2, '0')}'
          : null;

      final response = await _slotService.updateSlot(
        slotId: slotId,
        slotDate: dateStr,
        startTime: selectedStartTime.value != null
            ? _timeOfDayToString(selectedStartTime.value!)
            : null,
        endTime: selectedEndTime.value != null
            ? _timeOfDayToString(selectedEndTime.value!)
            : null,
        mode: selectedMode.value,
        feeOnline: selectedMode.value != 'physical'
            ? double.tryParse(feeOnlineCtrl.text.trim())
            : null,
        feePhysical: selectedMode.value != 'online'
            ? double.tryParse(feePhysicalCtrl.text.trim())
            : null,
        currency: currencyCtrl.text.trim().isEmpty ? 'PKR' : currencyCtrl.text.trim(),
        locationId: selectedLocationId.value.isEmpty ? null : selectedLocationId.value,
        isRecurring: isRecurring.value,
        recurrenceRule: recurrenceCtrl.text.trim().isEmpty ? null : recurrenceCtrl.text.trim(),
        status: selectedStatus.value,
      );

      if (response.success) {
        final idx = mySlots.indexWhere((s) => s.slotId == slotId);
        if (idx != -1) mySlots[idx] = response.data;
        _buildCreatedDays();
        _showSuccess('Slot updated successfully');
        return true;
      }
      return false;
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> deleteSlot(String slotId) async {
    try {
      isLoading.value = true;
      await _slotService.deleteSlot(slotId);
      mySlots.removeWhere((s) => s.slotId == slotId);
      _buildCreatedDays();
      _showSuccess('Slot removed');
      return true;
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────
  void _buildCreatedDays() {
    final days = <String>{};
    for (final slot in mySlots) {
      try {
        final d = DateTime.parse(slot.slotDate);
        days.add(weekDays[d.weekday - 1]);
      } catch (_) {}
    }
    createdDays.value = days;
  }

  List<SlotItem> getSlotsForDay(String dayName) {
    return mySlots.where((s) {
      try {
        final d = DateTime.parse(s.slotDate);
        return weekDays[d.weekday - 1] == dayName;
      } catch (_) {
        return false;
      }
    }).toList();
  }

  bool _validateForm() {
    if (selectedDate.value == null) {
      _showError('Please select a date');
      return false;
    }
    if (selectedStartTime.value == null) {
      _showError('Please select a start time');
      return false;
    }
    if (selectedEndTime.value == null) {
      _showError('Please select an end time');
      return false;
    }
    final startMinutes = selectedStartTime.value!.hour * 60 + selectedStartTime.value!.minute;
    final endMinutes = selectedEndTime.value!.hour * 60 + selectedEndTime.value!.minute;
    if (endMinutes <= startMinutes) {
      _showError('End time must be after start time');
      return false;
    }
    if (selectedMode.value != 'physical' &&
        (feeOnlineCtrl.text.trim().isEmpty ||
            double.tryParse(feeOnlineCtrl.text.trim()) == null)) {
      _showError('Please enter a valid online fee');
      return false;
    }
    if (selectedMode.value != 'online' &&
        (feePhysicalCtrl.text.trim().isEmpty ||
            double.tryParse(feePhysicalCtrl.text.trim()) == null)) {
      _showError('Please enter a valid physical fee');
      return false;
    }
    return true;
  }

  void _showSuccess(String msg) => Get.snackbar('Success', msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.successColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3));

  void _showError(String msg) => Get.snackbar('Error', msg,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.errorColor,
      colorText: AppColors.whiteColor,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 4));
}