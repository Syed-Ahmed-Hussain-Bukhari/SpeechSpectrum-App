import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage(int totalPages) {
    if (currentPage.value == totalPages - 1) {
      Get.offNamed(AppRoutes.login);
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    Get.offNamed(AppRoutes.signup);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
