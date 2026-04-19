import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SpeechSpectrum',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppColors.primaryColor,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppRoutes.routes,
    );
  }
}




// {
//     "message": "Only confirmed appointments can be paid",
//     "status": false
// }

// {
//     "status": true,
//     "checkout_url": "https://sandbox.api.getsafepay.com/checkout/pay?beacon=track_dd42d687-b895-492a-9505-3a86135661b0&cancel_url=https%3A%2F%2Fwww.google.com%2F&env=sandbox&order_id=07f8ad62-d905-4e81-abea-c6c654d42156&redirect_url=https%3A%2F%2Fwww.google.com%2F&source=custom&webhooks=true",
//     "tracker": "track_dd42d687-b895-492a-9505-3a86135661b0",
//     "payment_id": "d75ad7bb-ea27-4a59-b3ed-d42af3ebdf1c"
// }

// {
//     "message": "Payment already completed for this appointment",
//     "status": false
// }

// {
//     "status": true,
//     "payment_status": "pending"
// }

// {
//     "message": "Payment status fetched successfully",
//     "data": {
//         "payment_id": "9c1e1f67-8987-4333-b564-fba63e558fef",
//         "status": "pending",
//         "amount": 50000,
//         "currency": "PKR",
//         "created_at": "2026-04-14T12:10:51.44418+00:00",
//         "updated_at": "2026-04-14T13:24:44.78+00:00"
//     },
//     "status": true
// }

