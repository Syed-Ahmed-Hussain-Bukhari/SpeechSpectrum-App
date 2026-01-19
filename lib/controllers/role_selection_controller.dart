import 'package:get/get.dart';
import '../routes/app_routes.dart';

class RoleSelectionController extends GetxController {
  RxString selectedRole = ''.obs;

  void selectRole(String role) {
    selectedRole.value = role;
  }

  void continueNext() {
    if (selectedRole.value.isNotEmpty) {
      Get.toNamed(AppRoutes.nameScreen, arguments: selectedRole.value);
    }
  }
}