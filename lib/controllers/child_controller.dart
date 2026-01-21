// lib/controllers/child_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/services/child_service.dart';

class ChildController extends GetxController {
  final ChildService _childService = ChildService();

  var isLoading = false.obs;
  var isCreating = false.obs;
  var isUpdating = false.obs;
  var isDeleting = false.obs;

  var children = <ChildData>[].obs;
  var filteredChildren = <ChildData>[].obs;
  var selectedChild = Rxn<ChildData>();

  final searchController = TextEditingController();
  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchChildren();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // Fetch all children
  Future<void> fetchChildren() async {
    try {
      isLoading.value = true;
      final response = await _childService.getAllChildren();

      if (response.status) {
        children.value = response.data;
        filteredChildren.value = response.data;
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch single child
  Future<void> fetchChild(String childId) async {
    try {
      isLoading.value = true;
      final response = await _childService.getChild(childId);

      if (response.status && response.data != null) {
        selectedChild.value = response.data;
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }


  // Create child
  Future<void> createChild({
    required String childName,
    required String dateOfBirth,
    required String gender,
  }) async {
    try {
      isCreating.value = true;

      final response = await _childService.createChild(
        childName: childName,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      if (response.status) {
        Get.back(); // Close the form
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchChildren(); // Refresh the list
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isCreating.value = false;
    }
  }

  // Update child
  Future<void> updateChild({
    required String childId,
    required String childName,
    required String dateOfBirth,
    required String gender,
  }) async {
    try {
      isUpdating.value = true;

      final response = await _childService.updateChild(
        childId: childId,
        childName: childName,
        dateOfBirth: dateOfBirth,
        gender: gender,
      );

      if (response.status) {
        Get.back(); // Close the form
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchChildren(); // Refresh the list
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isUpdating.value = false;
    }
  }

  // Delete child
  Future<void> deleteChild(String childId) async {
    try {
      isDeleting.value = true;

      final response = await _childService.deleteChild(childId);

      if (response.status) {
        Get.back(); // Close any open dialog
        Get.snackbar(
          'Success',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        await fetchChildren(); // Refresh the list
      } else {
        Get.snackbar(
          'Error',
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isDeleting.value = false;
    }
  }

  // Search children
void searchChildren(String query) {
  searchText.value = query;

  if (query.isEmpty) {
    filteredChildren.value = children;
  } else {
    filteredChildren.value = children
        .where((child) =>
            child.childName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}

void clearSearch() {
  searchController.clear();
  searchText.value = '';
  filteredChildren.value = children;
}

}