import 'package:get/get.dart';
import '../routes/app_routes.dart';

class RegistrationController extends GetxController {
  // User data
  RxString role = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString fullName = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  void setRole(String userRole) {
    role.value = userRole;
  }

  void setNames(String first, String last) {
    firstName.value = first;
    lastName.value = last;
    fullName.value = '$first $last';
  }

  void setPhoneNumber(String phone) {
    phoneNumber.value = phone;
  }

  void setEmailAndPassword(String userEmail, String userPassword) {
    email.value = userEmail;
    password.value = userPassword;
  }

  void registerUser() {
    // Print data in required format
    print('''
{
    "email": "${email.value}",
    "password": "${password.value}",
    "full_name": "${fullName.value}",
    "phone": "${phoneNumber.value}",
    "role": "${role.value}"
}
    ''');
    
    // Navigate to home or next screen
    Get.offAllNamed(AppRoutes.home);
  }
}
