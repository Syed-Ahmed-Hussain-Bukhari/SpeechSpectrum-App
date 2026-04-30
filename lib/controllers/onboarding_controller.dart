// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../routes/app_routes.dart';

// class OnboardingController extends GetxController {
//   final PageController pageController = PageController();
//   final RxInt currentPage = 0.obs;

//   void onPageChanged(int index) {
//     currentPage.value = index;
//   }

//   void nextPage(int totalPages) {
//     if (currentPage.value == totalPages - 1) {
//       Get.offNamed(AppRoutes.login);
//     } else {
//       pageController.nextPage(
//         duration: const Duration(milliseconds: 300),
//         curve: Curves.easeInOut,
//       );
//     }
//   }

//   void skip() {
//     Get.offNamed(AppRoutes.login);
//   }

//   @override
//   void onClose() {
//     pageController.dispose();
//     super.onClose();
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/shared_preferences_service.dart'; // add this import

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  Future<void> nextPage(int totalPages) async {
    if (currentPage.value == totalPages - 1) {
      await _finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> skip() async {
    await _finishOnboarding();
  }

  Future<void> _finishOnboarding() async {
    // Mark onboarding as seen — never show again
    await SharedPreferencesService.setOnboardingSeen();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}