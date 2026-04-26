// // lib/controllers/child_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/services/child_service.dart';

// class ChildController extends GetxController {
//   final ChildService _childService = ChildService();

//   var isLoading = false.obs;
//   var isCreating = false.obs;
//   var isUpdating = false.obs;
//   var isDeleting = false.obs;

//   var children = <ChildData>[].obs;
//   var filteredChildren = <ChildData>[].obs;
//   var selectedChild = Rxn<ChildData>();

//   final searchController = TextEditingController();
//   final searchText = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChildren();
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // Fetch all children
//   Future<void> fetchChildren() async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getAllChildren();

//       if (response.status) {
//         children.value = response.data;
//         filteredChildren.value = response.data;
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // Fetch single child
//   Future<void> fetchChild(String childId) async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getChild(childId);

//       if (response.status && response.data != null) {
//         selectedChild.value = response.data;
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isLoading.value = false;
//     }
//   }


//   // Create child
//   Future<void> createChild({
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isCreating.value = true;

//       final response = await _childService.createChild(
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );

//       if (response.status) {
//         Get.back(); // Close the form
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         await fetchChildren(); // Refresh the list
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isCreating.value = false;
//     }
//   }

//   // Update child
//   Future<void> updateChild({
//     required String childId,
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isUpdating.value = true;

//       final response = await _childService.updateChild(
//         childId: childId,
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );

//       if (response.status) {
//         Get.back(); // Close the form
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         await fetchChildren(); // Refresh the list
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isUpdating.value = false;
//     }
//   }

//   // Delete child
//   Future<void> deleteChild(String childId) async {
//     try {
//       isDeleting.value = true;

//       final response = await _childService.deleteChild(childId);

//       if (response.status) {
//         Get.back(); // Close any open dialog
//         Get.snackbar(
//           'Success',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.green,
//           colorText: Colors.white,
//         );
//         await fetchChildren(); // Refresh the list
//       } else {
//         Get.snackbar(
//           'Error',
//           response.message,
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//       }
//     } catch (e) {
//       Get.snackbar(
//         'Error',
//         e.toString(),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         colorText: Colors.white,
//       );
//     } finally {
//       isDeleting.value = false;
//     }
//   }

//   // Search children
// void searchChildren(String query) {
//   searchText.value = query;

//   if (query.isEmpty) {
//     filteredChildren.value = children;
//   } else {
//     filteredChildren.value = children
//         .where((child) =>
//             child.childName.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//   }
// }

// void clearSearch() {
//   searchController.clear();
//   searchText.value = '';
//   filteredChildren.value = children;
// }

// }


// // lib/controllers/child_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/child_service.dart';

// class ChildController extends GetxController {
//   final ChildService _childService = ChildService();

//   var isLoading = false.obs;
//   var isCreating = false.obs;
//   var isUpdating = false.obs;
//   var isDeleting = false.obs;

//   var children = <ChildData>[].obs;
//   var filteredChildren = <ChildData>[].obs;
//   var selectedChild = Rxn<ChildData>();

//   final searchController = TextEditingController();
//   final searchText = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChildren();
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // ─── Fetch all children ───────────────────────────────────────────────────
//   Future<void> fetchChildren() async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getAllChildren();
//       if (response.status) {
//         children.value = response.data;
//         filteredChildren.value = response.data;
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── Fetch single child ───────────────────────────────────────────────────
//   Future<void> fetchChild(String childId) async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getChild(childId);
//       if (response.status && response.data != null) {
//         selectedChild.value = response.data;
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── Create child (standard — returns to list) ────────────────────────────
//   Future<void> createChild({
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isCreating.value = true;
//       final response = await _childService.createChild(
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status) {
//         Get.back();
//         _snack('Success', response.message, isError: false);
//         await fetchChildren();
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isCreating.value = false;
//     }
//   }

//   // ─── Create child then navigate to health profile ─────────────────────────
//   Future<void> createChildAndNavigateToHealth({
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isCreating.value = true;
//       final response = await _childService.createChild(
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status && response.data != null) {
//         final newChild = response.data!;
//         // Add to local list
//         children.insert(0, newChild);
//         filteredChildren.insert(0, newChild);

//         _snack('Success', 'Child profile created! Now add health information.', isError: false);

//         // Navigate to health profile screen (replacing current so back goes to list)
//         Get.off(
//           () => const _HealthProfilePlaceholder(),
//           arguments: {
//             'child': newChild,
//             'healthData': null,
//           },
//           routeName: AppRoutes.childHealthProfile,
//         );
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isCreating.value = false;
//     }
//   }

//   // ─── Update child ─────────────────────────────────────────────────────────
//   Future<void> updateChild({
//     required String childId,
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isUpdating.value = true;
//       final response = await _childService.updateChild(
//         childId: childId,
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status) {
//         Get.back();
//         _snack('Success', response.message, isError: false);
//         await fetchChildren();
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isUpdating.value = false;
//     }
//   }

//   // ─── Delete child ─────────────────────────────────────────────────────────
//   Future<void> deleteChild(String childId) async {
//     try {
//       isDeleting.value = true;
//       final response = await _childService.deleteChild(childId);
//       if (response.status) {
//         Get.back();
//         _snack('Success', response.message, isError: false);
//         await fetchChildren();
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isDeleting.value = false;
//     }
//   }

//   // ─── Search ───────────────────────────────────────────────────────────────
//   void searchChildren(String query) {
//     searchText.value = query;
//     filteredChildren.value = query.isEmpty
//         ? children
//         : children.where((c) => c.childName.toLowerCase().contains(query.toLowerCase())).toList();
//   }

//   void clearSearch() {
//     searchController.clear();
//     searchText.value = '';
//     filteredChildren.value = children;
//   }

//   void _snack(String title, String message, {bool isError = true}) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: isError ? Colors.red : Colors.green,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//     );
//   }
// }

// // Placeholder used for the off() call — actual widget is resolved by GetX router
// class _HealthProfilePlaceholder extends StatelessWidget {
//   const _HealthProfilePlaceholder();
//   @override
//   Widget build(BuildContext context) => const SizedBox.shrink();
// }



// // lib/controllers/child_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/child_service.dart';

// class ChildController extends GetxController {
//   final ChildService _childService = ChildService();

//   var isLoading = false.obs;
//   var isCreating = false.obs;
//   var isUpdating = false.obs;
//   var isDeleting = false.obs;

//   var children = <ChildData>[].obs;
//   var filteredChildren = <ChildData>[].obs;
//   var selectedChild = Rxn<ChildData>();

//   final searchController = TextEditingController();
//   final searchText = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChildren();
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // ─── Fetch all children ───────────────────────────────────────────────────
//   Future<void> fetchChildren() async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getAllChildren();
//       if (response.status) {
//         children.value = response.data;
//         filteredChildren.value = response.data;
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── Fetch single child ───────────────────────────────────────────────────
//   Future<void> fetchChild(String childId) async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getChild(childId);
//       if (response.status && response.data != null) {
//         selectedChild.value = response.data;
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── STEP 1: Create child → navigate to Step 2 (Health Profile) ──────────
//   /// Creates child via API, then navigates to health profile screen.
//   /// Does NOT add to local list yet — list is refreshed only after all steps
//   /// are complete or when returning to the list screen.
//   Future<void> createChildAndNavigateToHealth({
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isCreating.value = true;
//       final response = await _childService.createChild(
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status && response.data != null) {
//         final newChild = response.data!;

//         _snack(
//           'Step 1 Complete ✓',
//           'Child profile created! Now add health information.',
//           isError: false,
//         );

//         // Navigate to health profile screen (Step 2).
//         // Use Get.toNamed so the back-stack is preserved, but the list
//         // screen won't show a duplicate because we haven't mutated the
//         // observable list yet.
//         Get.toNamed(
//           AppRoutes.childHealthProfile,
//           arguments: {
//             'child': newChild,
//             'healthData': null,
//             'isCreationFlow': true, // flag so screen knows it's step 2/3
//           },
//         );
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isCreating.value = false;
//     }
//   }

//   // ─── Called after all 3 steps are done ───────────────────────────────────
//   /// Refreshes the children list from the server (single source of truth)
//   /// and pops back to the list screen.
//   Future<void> finishCreationFlow() async {
//     // Refresh from server — this guarantees no duplicate entries
//     await fetchChildren();
//     // Pop all intermediate screens back to the list screen
//     Get.until((route) => route.settings.name == AppRoutes.childrenList);
//   }

//   // ─── Update child ─────────────────────────────────────────────────────────
//   Future<void> updateChild({
//     required String childId,
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isUpdating.value = true;
//       final response = await _childService.updateChild(
//         childId: childId,
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status) {
//         _snack('Success', response.message, isError: false);
//         await fetchChildren();
//         Get.back();
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isUpdating.value = false;
//     }
//   }

//   // ─── Delete child ─────────────────────────────────────────────────────────
//   Future<void> deleteChild(String childId) async {
//     try {
//       isDeleting.value = true;
//       final response = await _childService.deleteChild(childId);
//       if (response.status) {
//         _snack('Success', response.message, isError: false);
//         await fetchChildren();
//         // Close dialog + detail screen if open
//         Get.close(2);
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isDeleting.value = false;
//     }
//   }

//   // ─── Search ───────────────────────────────────────────────────────────────
//   void searchChildren(String query) {
//     searchText.value = query;
//     filteredChildren.value = query.isEmpty
//         ? children
//         : children
//             .where((c) =>
//                 c.childName.toLowerCase().contains(query.toLowerCase()))
//             .toList();
//   }

//   void clearSearch() {
//     searchController.clear();
//     searchText.value = '';
//     filteredChildren.value = children;
//   }

//   void _snack(String title, String message, {bool isError = true}) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: isError ? Colors.red : Colors.green,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//     );
//   }
// }

// // lib/controllers/child_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/models/child_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/child_service.dart';

// class ChildController extends GetxController {
//   final ChildService _childService = ChildService();

//   var isLoading = false.obs;
//   var isCreating = false.obs;
//   var isUpdating = false.obs;
//   var isDeleting = false.obs;

//   var children = <ChildData>[].obs;
//   var filteredChildren = <ChildData>[].obs;

//   /// Reactive — ChildDetailsScreen observes this so it re-renders the
//   /// moment updateChild() writes a fresh value here.
//   var selectedChild = Rxn<ChildData>();

//   final searchController = TextEditingController();
//   final searchText = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchChildren();
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     super.onClose();
//   }

//   // ─── Fetch all children ───────────────────────────────────────────────────
//   Future<void> fetchChildren() async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getAllChildren();
//       if (response.status) {
//         children.value = response.data;
//         _applySearch();
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── Fetch single child ───────────────────────────────────────────────────
//   Future<void> fetchChild(String childId) async {
//     try {
//       isLoading.value = true;
//       final response = await _childService.getChild(childId);
//       if (response.status && response.data != null) {
//         selectedChild.value = response.data;
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // ─── STEP 1: Create child → navigate to Step 2 (Health Profile) ──────────
//   Future<void> createChildAndNavigateToHealth({
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isCreating.value = true;
//       final response = await _childService.createChild(
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status && response.data != null) {
//         final newChild = response.data!;

//         _snack(
//           'Step 1 Complete ✓',
//           'Child profile created! Now add health information.',
//           isError: false,
//         );

//         Get.toNamed(
//           AppRoutes.childHealthProfile,
//           arguments: {
//             'child': newChild,
//             'healthData': null,
//             'isCreationFlow': true,
//           },
//         );
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isCreating.value = false;
//     }
//   }

//   // ─── Called after all 3 steps are done ───────────────────────────────────
//   Future<void> finishCreationFlow() async {
//     await fetchChildren();
//     Get.until((route) => route.settings.name == AppRoutes.childrenList);
//   }

//   // ─── Update child ─────────────────────────────────────────────────────────
//   /// After a successful update:
//   ///  • Writes fresh data into [selectedChild] → ChildDetailsScreen
//   ///    (which observes this value) instantly shows the new name/dob/gender
//   ///    without a full re-fetch.
//   ///  • Patches the list in-place so ChildrenListScreen also shows the
//   ///    updated name without a full reload.
//   ///  • Calls Get.back(result: updatedChild) so the edit screen pops and
//   ///    the details screen (which awaits the result) can also rebuild if
//   ///    needed.
//   Future<ChildData?> updateChild({
//     required String childId,
//     required String childName,
//     required String dateOfBirth,
//     required String gender,
//   }) async {
//     try {
//       isUpdating.value = true;
//       final response = await _childService.updateChild(
//         childId: childId,
//         childName: childName,
//         dateOfBirth: dateOfBirth,
//         gender: gender,
//       );
//       if (response.status && response.data != null) {
//         final updated = response.data!;

//         // 1. Push new data into the reactive observable
//         selectedChild.value = updated;

//         // 2. Patch the list in-place (no flicker / no duplicate)
//         final idx = children.indexWhere((c) => c.childId == childId);
//         if (idx != -1) {
//           children[idx] = updated;
//           _applySearch();
//         }

//         _snack('Updated ✓', response.message, isError: false);

//         // 3. Pop edit screen and pass the fresh child back to the caller
//         Get.back(result: updated);
//         return updated;
//       } else {
//         _snack('Error', response.message);
//         return null;
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//       return null;
//     } finally {
//       isUpdating.value = false;
//     }
//   }

//   // ─── Delete child ─────────────────────────────────────────────────────────
//   Future<void> deleteChild(String childId) async {
//     try {
//       isDeleting.value = true;
//       final response = await _childService.deleteChild(childId);
//       if (response.status) {
//         // Remove locally — instant, no full reload needed
//         children.removeWhere((c) => c.childId == childId);
//         _applySearch();
//         selectedChild.value = null;

//         _snack('Deleted', response.message, isError: false);

//         // Close dialog + detail screen → lands back on list
//         Get.close(2);
//       } else {
//         _snack('Error', response.message);
//       }
//     } catch (e) {
//       _snack('Error', e.toString());
//     } finally {
//       isDeleting.value = false;
//     }
//   }

//   // ─── Search ───────────────────────────────────────────────────────────────
//   void searchChildren(String query) {
//     searchText.value = query;
//     _applySearch();
//   }

//   void clearSearch() {
//     searchController.clear();
//     searchText.value = '';
//     filteredChildren.value = List.from(children);
//   }

//   void _applySearch() {
//     final q = searchText.value.toLowerCase();
//     filteredChildren.value = q.isEmpty
//         ? List.from(children)
//         : children
//             .where((c) => c.childName.toLowerCase().contains(q))
//             .toList();
//   }

//   void _snack(String title, String message, {bool isError = true}) {
//     Get.snackbar(
//       title,
//       message,
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: isError ? Colors.red : Colors.green,
//       colorText: Colors.white,
//       margin: const EdgeInsets.all(16),
//       borderRadius: 12,
//       duration: const Duration(seconds: 3),
//     );
//   }
// }


// lib/controllers/child_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/services/child_service.dart';

class ChildController extends GetxController {
  final ChildService _childService = ChildService();

  var isLoading = false.obs;
  var isCreating = false.obs;
  var isUpdating = false.obs;
  var isDeleting = false.obs;

  var children = <ChildData>[].obs;
  var filteredChildren = <ChildData>[].obs;

  /// Reactive — ChildDetailsScreen observes this so it re-renders the
  /// moment updateChild() writes a fresh value here.
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

  // ─── Fetch all children ───────────────────────────────────────────────────
  Future<void> fetchChildren() async {
    try {
      isLoading.value = true;
      final response = await _childService.getAllChildren();
      if (response.status) {
        children.value = response.data;
        _applySearch();
      } else {
        _snack('Error', response.message);
      }
    } catch (e) {
      _snack('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ─── Fetch single child ───────────────────────────────────────────────────
  Future<void> fetchChild(String childId) async {
    try {
      isLoading.value = true;
      final response = await _childService.getChild(childId);
      if (response.status && response.data != null) {
        selectedChild.value = response.data;
      } else {
        _snack('Error', response.message);
      }
    } catch (e) {
      _snack('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ─── STEP 1: Create child → navigate to Step 2 (Health Profile) ──────────
  Future<void> createChildAndNavigateToHealth({
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
      if (response.status && response.data != null) {
        final newChild = response.data!;

        _snack(
          'Step 1 Complete ✓',
          'Child profile created! Now add health information.',
          isError: false,
        );

        Get.toNamed(
          AppRoutes.childHealthProfile,
          arguments: {
            'child': newChild,
            'healthData': null,
            'isCreationFlow': true,
          },
        );
      } else {
        _snack('Error', response.message);
      }
    } catch (e) {
      _snack('Error', e.toString());
    } finally {
      isCreating.value = false;
    }
  }

  // ─── Called after all 3 steps are done ───────────────────────────────────
  Future<void> finishCreationFlow() async {
    await fetchChildren();
    Get.until((route) => route.settings.name == AppRoutes.childrenList);
  }

  // ─── Update child ─────────────────────────────────────────────────────────
  /// After a successful update:
  ///  • Writes fresh data into [selectedChild] so ChildDetailsScreen
  ///    (which observes this via Obx) instantly re-renders.
  ///  • Patches the list in-place so ChildrenListScreen also reflects
  ///    the new name without a full reload.
  ///  • Pops the edit screen back to wherever called it — does NOT
  ///    pass a result; the details screen rebuilds via the observable.
  Future<ChildData?> updateChild({
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
      if (response.status && response.data != null) {
        final updated = response.data!;

        // 1. Push new data into the reactive observable so every
        //    Obx(...) watching selectedChild re-renders automatically.
        selectedChild.value = updated;

        // 2. Patch the list in-place (no flicker / no duplicate).
        final idx = children.indexWhere((c) => c.childId == childId);
        if (idx != -1) {
          children[idx] = updated;
          _applySearch();
        }

        _snack('Updated ✓', response.message, isError: false);

        // 3. Pop ONLY the edit screen — lands back on details screen.
        //    The details screen will see the new data via selectedChild.
        Get.back();
        return updated;
      } else {
        _snack('Error', response.message);
        return null;
      }
    } catch (e) {
      _snack('Error', e.toString());
      return null;
    } finally {
      isUpdating.value = false;
    }
  }

  // ─── Delete child ─────────────────────────────────────────────────────────
  Future<void> deleteChild(String childId) async {
    try {
      isDeleting.value = true;
      final response = await _childService.deleteChild(childId);
      if (response.status) {
        // Remove locally — instant, no full reload needed
        children.removeWhere((c) => c.childId == childId);
        _applySearch();
        selectedChild.value = null;

        _snack('Deleted', response.message, isError: false);

        // Close delete-confirmation dialog + detail/list screen.
        // Using Get.until to pop back to the children list reliably.
        Get.until((route) => route.settings.name == AppRoutes.childrenList);
      } else {
        _snack('Error', response.message);
      }
    } catch (e) {
      _snack('Error', e.toString());
    } finally {
      isDeleting.value = false;
    }
  }

  // ─── Search ───────────────────────────────────────────────────────────────
  void searchChildren(String query) {
    searchText.value = query;
    _applySearch();
  }

  void clearSearch() {
    searchController.clear();
    searchText.value = '';
    filteredChildren.value = List.from(children);
  }

  void _applySearch() {
    final q = searchText.value.toLowerCase();
    filteredChildren.value = q.isEmpty
        ? List.from(children)
        : children
            .where((c) => c.childName.toLowerCase().contains(q))
            .toList();
  }

  void _snack(String title, String message, {bool isError = true}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red : Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}