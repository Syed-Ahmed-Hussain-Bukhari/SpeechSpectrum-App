// lib/controllers/expert_drawer_controller.dart
import 'package:get/get.dart';

class ExpertDrawerController extends GetxController {
  final selectedIndex = 0.obs;
  final isManagementExpanded = false.obs;
  final isSettingsExpanded = false.obs;

  void selectItem(int index) => selectedIndex.value = index;

  void toggleManagement() =>
      isManagementExpanded.value = !isManagementExpanded.value;

  void toggleSettings() =>
      isSettingsExpanded.value = !isSettingsExpanded.value;
}