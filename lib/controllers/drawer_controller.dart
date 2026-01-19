import 'package:get/get.dart';

class DrawerMenuController extends GetxController {
  var selectedIndex = 0.obs;
  var isIncomeExpanded = false.obs;
  var isSettingsExpanded = false.obs;

  void selectItem(int index) {
    selectedIndex.value = index;
  }

  void toggleIncome() {
    isIncomeExpanded.value = !isIncomeExpanded.value;
  }

  void toggleSettings() {
    isSettingsExpanded.value = !isSettingsExpanded.value;
  }
}