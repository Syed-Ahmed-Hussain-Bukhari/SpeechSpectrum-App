// // lib/controllers/location_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/location_model.dart';
// import 'package:speechspectrum/services/location_service.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';

// class LocationController extends GetxController {
//   final LocationService _locationService = LocationService();

//   // Observables
//   var isLoading = false.obs;
//   var isSaving = false.obs;
//   var isDeleting = false.obs;

//   var myLocations = <LocationItem>[].obs;
//   var allLocations = <LocationItem>[].obs;
//   var selectedLocation = Rx<LocationItem?>(null);

//   // Form controllers
//   final labelController = TextEditingController();
//   final addressController = TextEditingController();
//   final cityController = TextEditingController();
//   final mapsUrlController = TextEditingController();

//   @override
//   void onClose() {
//     labelController.dispose();
//     addressController.dispose();
//     cityController.dispose();
//     mapsUrlController.dispose();
//     super.onClose();
//   }

//   void clearForm() {
//     labelController.clear();
//     addressController.clear();
//     cityController.clear();
//     mapsUrlController.clear();
//   }

//   void populateForm(LocationItem location) {
//     labelController.text = location.label;
//     addressController.text = location.address;
//     cityController.text = location.city;
//     mapsUrlController.text = location.mapsUrl;
//   }

//   /// Auto-generate Google Maps URL from address + city
//   void generateMapsUrl() {
//     final address = addressController.text.trim();
//     final city = cityController.text.trim();
//     if (address.isEmpty && city.isEmpty) return;
//     final query = Uri.encodeComponent('$address $city'.trim());
//     mapsUrlController.text = 'https://maps.google.com/?q=$query';
//   }

//   // Fetch my locations
//   Future<void> fetchMyLocations() async {
//     try {
//       isLoading.value = true;
//       final expertId = await SharedPreferencesService.getUserId();
//       if (expertId == null || expertId.isEmpty) {
//         _showError('Could not retrieve expert ID');
//         return;
//       }
//       final response = await _locationService.getExpertLocations(expertId);
//       if (response.success) {
//         myLocations.value = response.data;
//       } else {
//         _showError('Failed to load locations');
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch all global locations (for selection dropdown)
//   Future<void> fetchAllLocations() async {
//     try {
//       final response = await _locationService.getAllLocations();
//       if (response.success) {
//         allLocations.value = response.data;
//       }
//     } catch (e) {
//       debugPrint('❌ Fetch all locations: $e');
//     }
//   }

//   // Create location
//   Future<bool> createLocation() async {
//     if (!_validateForm()) return false;
//     try {
//       isSaving.value = true;
//       final response = await _locationService.createLocation(
//         label: labelController.text.trim(),
//         address: addressController.text.trim(),
//         city: cityController.text.trim(),
//         mapsUrl: mapsUrlController.text.trim(),
//       );
//       if (response.success) {
//         myLocations.insert(0, response.data);
//         _showSuccess('Location "${response.data.label}" created successfully');
//         clearForm();
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isSaving.value = false;
//     }
//   }

//   // Update location
//   Future<bool> updateLocation(String locationId) async {
//     if (!_validateForm()) return false;
//     try {
//       isSaving.value = true;
//       final response = await _locationService.updateLocation(
//         locationId: locationId,
//         label: labelController.text.trim(),
//         address: addressController.text.trim(),
//         city: cityController.text.trim(),
//         mapsUrl: mapsUrlController.text.trim(),
//       );
//       if (response.success) {
//         final index = myLocations.indexWhere((l) => l.locationId == locationId);
//         if (index != -1) myLocations[index] = response.data;
//         _showSuccess('Location updated successfully');
//         clearForm();
//         return true;
//       }
//       return false;
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isSaving.value = false;
//     }
//   }

//   // Delete location
//   Future<bool> deleteLocation(String locationId) async {
//     try {
//       isDeleting.value = true;
//       await _locationService.deleteLocation(locationId);
//       myLocations.removeWhere((l) => l.locationId == locationId);
//       if (selectedLocation.value?.locationId == locationId) {
//         selectedLocation.value = null;
//       }
//       _showSuccess('Location deleted');
//       return true;
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//       return false;
//     } finally {
//       isDeleting.value = false;
//     }
//   }

//   // Select a location
//   void selectLocation(LocationItem? location) {
//     selectedLocation.value = location;
//   }

//   bool _validateForm() {
//     if (labelController.text.trim().isEmpty) {
//       _showError('Please enter a label (e.g. Main Clinic)');
//       return false;
//     }
//     if (addressController.text.trim().isEmpty) {
//       _showError('Please enter an address');
//       return false;
//     }
//     if (cityController.text.trim().isEmpty) {
//       _showError('Please enter a city');
//       return false;
//     }
//     return true;
//   }

//   void _showSuccess(String message) {
//     Get.snackbar(
//       'Success',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.successColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 3),
//     );
//   }

//   void _showError(String message) {
//     Get.snackbar(
//       'Error',
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.errorColor,
//       colorText: AppColors.whiteColor,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 4),
//     );
//   }
// }


// lib/controllers/location_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/location_model.dart';
import 'package:speechspectrum/services/location_service.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class LocationController extends GetxController {
  final LocationService _locationService = LocationService();

  var isLoading = false.obs;
  var isLoadingAll = false.obs;
  var isSaving = false.obs;
  var isDeleting = false.obs;

  var myLocations = <LocationItem>[].obs;
  var allLocations = <LocationItem>[].obs;
  var filteredAllLocations = <LocationItem>[].obs;

  final labelController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final mapsUrlController = TextEditingController();
  final searchController = TextEditingController();

  @override
  void onClose() {
    labelController.dispose();
    addressController.dispose();
    cityController.dispose();
    mapsUrlController.dispose();
    searchController.dispose();
    super.onClose();
  }

  void clearForm() {
    labelController.clear();
    addressController.clear();
    cityController.clear();
    mapsUrlController.clear();
  }

  void populateForm(LocationItem location) {
    labelController.text = location.label;
    addressController.text = location.address;
    cityController.text = location.city;
    mapsUrlController.text = location.mapsUrl;
  }

  /// Populate form fields from a picked map location
  void populateFromMapPick({
    required String address,
    required String city,
    required String mapsUrl,
  }) {
    addressController.text = address;
    cityController.text = city;
    mapsUrlController.text = mapsUrl;
  }

  /// Populate form from an existing location (from picker screen)
  void populateFromExisting(LocationItem location) {
    labelController.text = location.label;
    addressController.text = location.address;
    cityController.text = location.city;
    mapsUrlController.text = location.mapsUrl;
  }

  void generateMapsUrl() {
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    if (address.isEmpty && city.isEmpty) return;
    final query = Uri.encodeComponent('$address $city'.trim());
    mapsUrlController.text = 'https://maps.google.com/?q=$query';
  }

  static String buildMapsUrlFromLatLng(double lat, double lng) =>
      'https://maps.google.com/?q=$lat,$lng';

  static String buildMapsUrlFromAddress(String address) {
    final encoded = Uri.encodeComponent(address);
    return 'https://maps.google.com/?q=$encoded';
  }

  void filterLocations(String query) {
    if (query.trim().isEmpty) {
      filteredAllLocations.value = allLocations;
      return;
    }
    final q = query.toLowerCase();
    filteredAllLocations.value = allLocations
        .where((l) =>
            l.label.toLowerCase().contains(q) ||
            l.address.toLowerCase().contains(q) ||
            l.city.toLowerCase().contains(q))
        .toList();
  }

  Future<void> fetchMyLocations() async {
    try {
      isLoading.value = true;
      final expertId = await SharedPreferencesService.getUserId();
      if (expertId == null || expertId.isEmpty) {
        _showError('Could not retrieve expert ID');
        return;
      }
      final response = await _locationService.getExpertLocations(expertId);
      if (response.success) {
        myLocations.value = response.data;
      } else {
        _showError('Failed to load your locations');
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAllLocations() async {
    try {
      isLoadingAll.value = true;
      searchController.clear();
      final response = await _locationService.getAllLocations();
      if (response.success) {
        allLocations.value = response.data;
        filteredAllLocations.value = response.data;
      }
    } catch (e) {
      debugPrint('❌ fetchAllLocations: $e');
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoadingAll.value = false;
    }
  }

  Future<bool> createLocation() async {
    if (!_validateForm()) return false;
    try {
      isSaving.value = true;
      final response = await _locationService.createLocation(
        label: labelController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        mapsUrl: mapsUrlController.text.trim(),
      );
      if (response.success) {
        myLocations.insert(0, response.data);
        _showSuccess('"${response.data.label}" added successfully');
        clearForm();
        return true;
      }
      return false;
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> updateLocation(String locationId) async {
    if (!_validateForm()) return false;
    try {
      isSaving.value = true;
      final response = await _locationService.updateLocation(
        locationId: locationId,
        label: labelController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        mapsUrl: mapsUrlController.text.trim(),
      );
      if (response.success) {
        final idx = myLocations.indexWhere((l) => l.locationId == locationId);
        if (idx != -1) myLocations[idx] = response.data;
        _showSuccess('Location updated successfully');
        clearForm();
        return true;
      }
      return false;
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isSaving.value = false;
    }
  }

  Future<bool> deleteLocation(String locationId) async {
    try {
      isDeleting.value = true;
      await _locationService.deleteLocation(locationId);
      myLocations.removeWhere((l) => l.locationId == locationId);
      _showSuccess('Location removed');
      return true;
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      isDeleting.value = false;
    }
  }

  bool _validateForm() {
    if (labelController.text.trim().isEmpty) {
      _showError('Please enter a location label');
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      _showError('Please enter a street address');
      return false;
    }
    if (cityController.text.trim().isEmpty) {
      _showError('Please enter a city');
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