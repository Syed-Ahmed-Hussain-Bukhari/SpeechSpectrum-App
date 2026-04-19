// // lib/controllers/payment_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/payment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/payment_service.dart';
 
// // Flutter-specific redirect URLs — these are intercepted in WebView,
// // never actually loaded. Keep consistent with WebViewPaymentScreen.
// const _kRedirectUrl = 'https://speechspectrum.app/payment/success';
// const _kCancelUrl = 'https://speechspectrum.app/payment/cancel';
 
// class PaymentController extends GetxController {
//   final PaymentService _service = PaymentService();
 
//   // ── State ──────────────────────────────────────────────────
//   var isInitiating = false.obs;
//   var isVerifying = false.obs;
//   var isLoadingStatus = false.obs;
 
//   var paymentStatus = Rxn<PaymentStatusData>();
//   var verifyResult = Rxn<VerifyPaymentModel>();
 
//   // ── Fetch current payment status for an appointment ────────
//   Future<void> fetchPaymentStatus(String appointmentId) async {
//     try {
//       isLoadingStatus.value = true;
//       paymentStatus.value = null;
//       final result = await _service.getPaymentStatus(
//           appointmentId: appointmentId);
//       if (result.status) {
//         paymentStatus.value = result.data;
//       }
//     } catch (e) {
//       debugPrint('❌ fetchPaymentStatus: $e');
//       // Silently fail — UI will treat null as no-payment-found
//     } finally {
//       isLoadingStatus.value = false;
//     }
//   }
 
//   // ── Initiate payment → open WebView ───────────────────────
//   Future<void> initiatePayment(String appointmentId) async {
//     try {
//       isInitiating.value = true;
//       final result = await _service.initiatePayment(
//         appointmentId: appointmentId,
//         redirectUrl: _kRedirectUrl,
//         cancelUrl: _kCancelUrl,
//       );
//       if (result.status && result.checkoutUrl.isNotEmpty) {
//         // Navigate to WebView screen with checkout URL
//         final webResult = await Get.toNamed(
//           AppRoutes.paymentWebView,
//           arguments: {
//             'checkout_url': result.checkoutUrl,
//             'appointment_id': appointmentId,
//             'tracker': result.tracker,
//           },
//         );
//         // Handle result returned from WebView
//         await _handleWebViewResult(webResult, appointmentId);
//       } else {
//         _showError('Failed to get payment URL. Please try again.');
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isInitiating.value = false;
//     }
//   }
 
//   // ── Handle result after WebView closes ────────────────────
//   Future<void> _handleWebViewResult(
//       dynamic result, String appointmentId) async {
//     if (result == null) return;
 
//     final map = result as Map<String, dynamic>;
//     final outcome = map['outcome'] as String? ?? 'cancelled';
 
//     if (outcome == 'success') {
//       final tracker = map['tracker'] as String? ?? '';
//       final sig = map['sig'] as String?;
//       await _verifyAndNavigate(tracker, sig, appointmentId);
//     } else if (outcome == 'cancelled') {
//       Get.toNamed(AppRoutes.paymentCancel);
//     } else if (outcome == 'error') {
//       final msg = map['message'] as String? ?? 'Payment failed';
//       Get.toNamed(AppRoutes.paymentCancel,
//           arguments: {'error_message': msg});
//     }
//   }
 
//   // ── Verify payment and navigate to result screen ──────────
//   Future<void> _verifyAndNavigate(
//       String tracker, String? sig, String appointmentId) async {
//     try {
//       isVerifying.value = true;
//       final result =
//           await _service.verifyPayment(tracker: tracker, sig: sig);
//       verifyResult.value = result;
 
//       if (result.isPaid) {
//         // Refresh payment status badge
//         await fetchPaymentStatus(appointmentId);
//         Get.toNamed(AppRoutes.paymentSuccess,
//             arguments: {'appointment_id': appointmentId});
//       } else {
//         Get.toNamed(AppRoutes.paymentCancel,
//             arguments: {'payment_status': result.paymentStatus});
//       }
//     } catch (e) {
//       Get.toNamed(AppRoutes.paymentCancel,
//           arguments: {'error_message': e.toString().replaceAll('Exception: ', '')});
//     } finally {
//       isVerifying.value = false;
//     }
//   }
 
//   // ── Helpers ────────────────────────────────────────────────
//   void _showError(String msg) => Get.snackbar(
//         'Payment Error',
//         msg,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         margin: const EdgeInsets.all(16),
//         borderRadius: 12,
//         duration: const Duration(seconds: 4),
//       );
// }

// // lib/controllers/payment_controller.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/models/payment_model.dart';
// import 'package:speechspectrum/routes/app_routes.dart';
// import 'package:speechspectrum/services/payment_service.dart';

// // Flutter-specific redirect URLs — intercepted in WebView, never actually loaded.
// const _kRedirectUrl = 'https://speechspectrum.app/payment/success';
// const _kCancelUrl = 'https://speechspectrum.app/payment/cancel';

// class PaymentController extends GetxController {
//   final PaymentService _service = PaymentService();

//   // ── State ──────────────────────────────────────────────────
//   var isInitiating = false.obs;
//   var isVerifying = false.obs;
//   var isLoadingStatus = false.obs;

//   var paymentStatus = Rxn<PaymentStatusData>();
//   var verifyResult = Rxn<VerifyPaymentModel>();

//   // ── Fetch current payment status for an appointment ────────
//   Future<void> fetchPaymentStatus(String appointmentId) async {
//     try {
//       isLoadingStatus.value = true;
//       paymentStatus.value = null;
//       final result =
//           await _service.getPaymentStatus(appointmentId: appointmentId);
//       if (result.status) {
//         paymentStatus.value = result.data;
//       }
//     } catch (e) {
//       debugPrint('❌ fetchPaymentStatus: $e');
//       // Silently fail — UI treats null as unpaid/unknown
//     } finally {
//       isLoadingStatus.value = false;
//     }
//   }

//   // ── Initiate payment → open WebView ───────────────────────
//   Future<void> initiatePayment(String appointmentId) async {
//     try {
//       isInitiating.value = true;
//       final result = await _service.initiatePayment(
//         appointmentId: appointmentId,
//         redirectUrl: _kRedirectUrl,
//         cancelUrl: _kCancelUrl,
//       );
//       if (result.status && result.checkoutUrl.isNotEmpty) {
//         final webResult = await Get.toNamed(
//           AppRoutes.paymentWebView,
//           arguments: {
//             'checkout_url': result.checkoutUrl,
//             'appointment_id': appointmentId,
//             'tracker': result.tracker,
//           },
//         );
//         await _handleWebViewResult(webResult, appointmentId);
//       } else {
//         _showError('Failed to get payment URL. Please try again.');
//       }
//     } catch (e) {
//       _showError(e.toString().replaceAll('Exception: ', ''));
//     } finally {
//       isInitiating.value = false;
//     }
//   }

//   // ── Handle result after WebView closes ────────────────────
//   Future<void> _handleWebViewResult(
//       dynamic result, String appointmentId) async {
//     if (result == null) return;

//     final map = result as Map<String, dynamic>;
//     final outcome = map['outcome'] as String? ?? 'cancelled';

//     if (outcome == 'success') {
//       final tracker = map['tracker'] as String? ?? '';
//       final sig = map['sig'] as String?;
//       await _verifyAndNavigate(tracker, sig, appointmentId);
//     } else if (outcome == 'cancelled') {
//       Get.toNamed(AppRoutes.paymentCancel);
//     } else if (outcome == 'error') {
//       final msg = map['message'] as String? ?? 'Payment failed';
//       Get.toNamed(AppRoutes.paymentCancel, arguments: {'error_message': msg});
//     }
//   }

//   // ── Verify payment and navigate to result screen ──────────
//   Future<void> _verifyAndNavigate(
//       String tracker, String? sig, String appointmentId) async {
//     try {
//       isVerifying.value = true;
//       final result =
//           await _service.verifyPayment(tracker: tracker, sig: sig);
//       verifyResult.value = result;

//       if (result.isPaid) {
//         await fetchPaymentStatus(appointmentId);
//         Get.toNamed(AppRoutes.paymentSuccess,
//             arguments: {'appointment_id': appointmentId});
//       } else {
//         Get.toNamed(AppRoutes.paymentCancel,
//             arguments: {'payment_status': result.paymentStatus});
//       }
//     } catch (e) {
//       Get.toNamed(AppRoutes.paymentCancel,
//           arguments: {
//             'error_message': e.toString().replaceAll('Exception: ', '')
//           });
//     } finally {
//       isVerifying.value = false;
//     }
//   }

//   // ── Helpers ────────────────────────────────────────────────
//   void _showError(String msg) => Get.snackbar(
//         'Payment Error',
//         msg,
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: AppColors.errorColor,
//         colorText: AppColors.whiteColor,
//         margin: const EdgeInsets.all(16),
//         borderRadius: 12,
//         duration: const Duration(seconds: 4),
//       );
// }

// lib/controllers/payment_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/models/payment_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';
import 'package:speechspectrum/services/payment_service.dart';

// Flutter-specific redirect URLs — intercepted in WebView, never actually loaded.
const _kRedirectUrl = 'https://speechspectrum.app/payment/success';
const _kCancelUrl = 'https://speechspectrum.app/payment/cancel';

// How many times to retry verify before giving up
const _kMaxVerifyRetries = 4;
// Delay between retries (in seconds) — gives backend time to update
const _kRetryDelaySeconds = 2;

class PaymentController extends GetxController {
  final PaymentService _service = PaymentService();

  // ── State ──────────────────────────────────────────────────
  var isInitiating = false.obs;
  var isVerifying = false.obs;
  var isLoadingStatus = false.obs;

  var paymentStatus = Rxn<PaymentStatusData>();
  var verifyResult = Rxn<VerifyPaymentModel>();

  // ── Fetch current payment status for an appointment ────────
  Future<void> fetchPaymentStatus(String appointmentId) async {
    try {
      isLoadingStatus.value = true;
      paymentStatus.value = null;
      final result =
          await _service.getPaymentStatus(appointmentId: appointmentId);
      if (result.status) {
        paymentStatus.value = result.data;
      }
    } catch (e) {
      debugPrint('❌ fetchPaymentStatus: $e');
      // Silently fail — UI treats null as unpaid/unknown
    } finally {
      isLoadingStatus.value = false;
    }
  }

  // ── Initiate payment → open WebView ───────────────────────
  Future<void> initiatePayment(String appointmentId) async {
    try {
      isInitiating.value = true;
      final result = await _service.initiatePayment(
        appointmentId: appointmentId,
        redirectUrl: _kRedirectUrl,
        cancelUrl: _kCancelUrl,
      );
      if (result.status && result.checkoutUrl.isNotEmpty) {
        final webResult = await Get.toNamed(
          AppRoutes.paymentWebView,
          arguments: {
            'checkout_url': result.checkoutUrl,
            'appointment_id': appointmentId,
            'tracker': result.tracker,
          },
        );
        await _handleWebViewResult(webResult, appointmentId);
      } else {
        _showError('Failed to get payment URL. Please try again.');
      }
    } catch (e) {
      _showError(e.toString().replaceAll('Exception: ', ''));
    } finally {
      isInitiating.value = false;
    }
  }

  // ── Handle result after WebView closes ────────────────────
  Future<void> _handleWebViewResult(
      dynamic result, String appointmentId) async {
    if (result == null) return;

    final map = result as Map<String, dynamic>;
    final outcome = map['outcome'] as String? ?? 'cancelled';

    if (outcome == 'success') {
      final tracker = map['tracker'] as String? ?? '';
      final sig = map['sig'] as String?;
      // WebView said success — but backend may not have updated yet.
      // Re-verify with retries before deciding which screen to show.
      await _verifyWithRetryAndNavigate(tracker, sig, appointmentId);
    } else if (outcome == 'cancelled') {
      Get.toNamed(AppRoutes.paymentCancel);
    } else if (outcome == 'error') {
      final msg = map['message'] as String? ?? 'Payment failed';
      Get.toNamed(AppRoutes.paymentCancel, arguments: {'error_message': msg});
    }
  }

  // ── Verify with retries, then navigate ────────────────────
  //
  // Problem: The payment gateway redirects to the success URL as soon as the
  // user completes the flow, but the backend webhook that flips the status
  // from "pending" → "paid" can arrive a few seconds later.
  //
  // Solution: After the WebView returns a success outcome, call verifyPayment
  // up to [_kMaxVerifyRetries] times with a short delay between each attempt.
  // Navigate to success as soon as we get "paid"; fall back to cancel if all
  // retries return "pending".
  Future<void> _verifyWithRetryAndNavigate(
      String tracker, String? sig, String appointmentId) async {
    try {
      isVerifying.value = true;
      VerifyPaymentModel? lastResult;

      for (int attempt = 1; attempt <= _kMaxVerifyRetries; attempt++) {
        debugPrint(
            '🔁 Verify attempt $attempt / $_kMaxVerifyRetries  tracker=$tracker');

        try {
          lastResult = await _service.verifyPayment(tracker: tracker, sig: sig);
          verifyResult.value = lastResult;

          debugPrint(
              '📊 Attempt $attempt result: ${lastResult.paymentStatus} (status=${lastResult.status})');

          if (lastResult.isPaid) {
            // Confirmed paid — no need to retry further
            debugPrint('✅ Payment confirmed paid on attempt $attempt');
            break;
          }

          // Still pending — wait before next retry (skip delay on last attempt)
          if (attempt < _kMaxVerifyRetries) {
            debugPrint(
                '⏳ Still pending, waiting ${_kRetryDelaySeconds}s before retry...');
            await Future.delayed(
                const Duration(seconds: _kRetryDelaySeconds));
          }
        } catch (e) {
          debugPrint('❌ Verify attempt $attempt failed: $e');
          // Continue retrying even if one attempt throws
          if (attempt < _kMaxVerifyRetries) {
            await Future.delayed(
                const Duration(seconds: _kRetryDelaySeconds));
          }
        }
      }

      // Navigate based on final result
      if (lastResult != null && lastResult.isPaid) {
        await fetchPaymentStatus(appointmentId);
        Get.toNamed(AppRoutes.paymentSuccess,
            arguments: {'appointment_id': appointmentId});
      } else {
        // All retries returned pending — treat as failed/pending
        Get.toNamed(AppRoutes.paymentCancel, arguments: {
          'payment_status': lastResult?.paymentStatus ?? 'pending',
        });
      }
    } catch (e) {
      Get.toNamed(AppRoutes.paymentCancel, arguments: {
        'error_message': e.toString().replaceAll('Exception: ', ''),
      });
    } finally {
      isVerifying.value = false;
    }
  }

  // ── Helpers ────────────────────────────────────────────────
  void _showError(String msg) => Get.snackbar(
        'Payment Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.errorColor,
        colorText: AppColors.whiteColor,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 4),
      );
}