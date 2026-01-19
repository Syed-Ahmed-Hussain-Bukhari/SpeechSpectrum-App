// import 'package:get/get.dart';

// class PasswordController extends GetxController {
//   var isPasswordHidden = true.obs;
//   var isConfirmPasswordHidden = true.obs;

//   void togglePasswordVisibility() {
//     isPasswordHidden.value = !isPasswordHidden.value;
//   }

//   void toggleConfirmPasswordVisibility() {
//     isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
//   }
// }

import 'package:get/get.dart';

class PasswordController extends GetxController {
  RxBool isPasswordHidden = true.obs;
  RxBool isConfirmPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }
}