// // lib/view/payment/payment_webview_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// // Flutter redirect URL patterns — must match what was passed to /initiate
// const _kSuccessPath = '/payment/success';
// const _kCancelPath = '/payment/cancel';

// class WebViewPaymentScreen extends StatefulWidget {
//   const WebViewPaymentScreen({super.key});

//   @override
//   State<WebViewPaymentScreen> createState() => _WebViewPaymentScreenState();
// }

// class _WebViewPaymentScreenState extends State<WebViewPaymentScreen> {
//   late final WebViewController _controller;
//   late final String _checkoutUrl;
//   late final String _appointmentId;
//   late final String _tracker;

//   bool _isLoading = true;
//   bool _hasNavigated = false; // prevent double-fire

//   @override
//   void initState() {
//     super.initState();
//     final args = Get.arguments as Map<String, dynamic>;
//     _checkoutUrl = args['checkout_url'] as String;
//     _appointmentId = args['appointment_id'] as String;
//     _tracker = args['tracker'] as String;

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (_) => setState(() => _isLoading = true),
//           onPageFinished: (_) => setState(() => _isLoading = false),
//           onWebResourceError: (error) {
//             debugPrint('❌ WebView error: ${error.description}');
//             setState(() => _isLoading = false);
//           },
//           onNavigationRequest: (request) {
//             final url = request.url;
//             debugPrint('🌐 WebView navigating to: $url');
//             return _handleNavigation(url);
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(_checkoutUrl));
//   }

//   NavigationDecision _handleNavigation(String url) {
//     if (_hasNavigated) return NavigationDecision.prevent;

//     final uri = Uri.tryParse(url);
//     if (uri == null) return NavigationDecision.navigate;

//     // ── Success intercept ──────────────────────────────────
//     if (uri.path.contains(_kSuccessPath)) {
//       _hasNavigated = true;
//       final tracker = uri.queryParameters['tracker'] ?? _tracker;
//       final sig = uri.queryParameters['ref'];

//       debugPrint('✅ Payment success intercepted. tracker=$tracker sig=$sig');

//       Get.back(result: {
//         'outcome': 'success',
//         'tracker': tracker,
//         'sig': sig,
//         'appointment_id': _appointmentId,
//       });
//       return NavigationDecision.prevent;
//     }

//     // ── Cancel intercept ───────────────────────────────────
//     if (uri.path.contains(_kCancelPath)) {
//       _hasNavigated = true;
//       debugPrint('🚫 Payment cancel intercepted');
//       Get.back(result: {'outcome': 'cancelled'});
//       return NavigationDecision.prevent;
//     }

//     return NavigationDecision.navigate;
//   }

//   void _onManualClose() {
//     if (!_hasNavigated) {
//       _hasNavigated = true;
//       Get.back(result: {'outcome': 'cancelled'});
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0.5,
//         surfaceTintColor: Colors.transparent,
//         leading: GestureDetector(
//           onTap: _onManualClose,
//           child: Container(
//             margin: const EdgeInsets.all(8),
//             decoration: BoxDecoration(
//               color: AppColors.lightGreyColor,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: const Icon(
//               Icons.close_rounded,
//               color: AppColors.textPrimaryColor,
//               size: 20,
//             ),
//           ),
//         ),
//         title: Text(
//           'Secure Payment',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 16,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           Container(
//             margin: const EdgeInsets.only(right: 12),
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: AppColors.successColor.withOpacity(0.1),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.lock_rounded,
//                     size: 12, color: AppColors.successColor),
//                 const SizedBox(width: 4),
//                 Text(
//                   'Secure',
//                   style: GoogleFonts.poppins(
//                     fontSize: 11,
//                     color: AppColors.successColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             Container(
//               color: AppColors.whiteColor,
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const CircularProgressIndicator(
//                       color: AppColors.primaryColor,
//                       strokeWidth: 3,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'Loading payment page...',
//                       style: GoogleFonts.poppins(
//                         color: AppColors.textSecondaryColor,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// lib/view/payment/payment_webview_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Must match the paths used in PaymentController's _kRedirectUrl / _kCancelUrl
const _kSuccessPath = '/payment/success';
const _kCancelPath = '/payment/cancel';

class WebViewPaymentScreen extends StatefulWidget {
  const WebViewPaymentScreen({super.key});

  @override
  State<WebViewPaymentScreen> createState() => _WebViewPaymentScreenState();
}

class _WebViewPaymentScreenState extends State<WebViewPaymentScreen> {
  late final WebViewController _controller;
  late final String _checkoutUrl;
  late final String _appointmentId;
  late final String _tracker;

  bool _isLoading = true;
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    _checkoutUrl = args['checkout_url'] as String;
    _appointmentId = args['appointment_id'] as String;
    _tracker = args['tracker'] as String;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) {
            if (mounted) setState(() => _isLoading = true);
          },
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
          onWebResourceError: (error) {
            debugPrint('❌ WebView error: ${error.description}');
            if (mounted) setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) =>
              _handleNavigation(request.url),
        ),
      )
      ..loadRequest(Uri.parse(_checkoutUrl));
  }

  NavigationDecision _handleNavigation(String url) {
    if (_hasNavigated) return NavigationDecision.prevent;

    final uri = Uri.tryParse(url);
    if (uri == null) return NavigationDecision.navigate;

    debugPrint('🌐 WebView navigating: $url');

    // ── Success intercept ──────────────────────────────────
    if (uri.path.contains(_kSuccessPath)) {
      _hasNavigated = true;
      final tracker = uri.queryParameters['tracker'] ?? _tracker;
      final sig = uri.queryParameters['ref'];
      debugPrint('✅ Payment success. tracker=$tracker sig=$sig');
      Get.back(result: {
        'outcome': 'success',
        'tracker': tracker,
        'sig': sig,
        'appointment_id': _appointmentId,
      });
      return NavigationDecision.prevent;
    }

    // ── Cancel intercept ───────────────────────────────────
    if (uri.path.contains(_kCancelPath)) {
      _hasNavigated = true;
      debugPrint('🚫 Payment cancel intercepted');
      Get.back(result: {'outcome': 'cancelled'});
      return NavigationDecision.prevent;
    }

    return NavigationDecision.navigate;
  }

  void _onManualClose() {
    if (!_hasNavigated) {
      _hasNavigated = true;
      Get.back(result: {'outcome': 'cancelled'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0.5,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          onTap: _onManualClose,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.lightGreyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.close_rounded,
                color: AppColors.textPrimaryColor, size: 20),
          ),
        ),
        title: Text(
          'Secure Payment',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.successColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_rounded,
                    size: 12, color: AppColors.successColor),
                const SizedBox(width: 4),
                Text(
                  'Secure',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.successColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: AppColors.whiteColor,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(
                        color: AppColors.primaryColor, strokeWidth: 3),
                    const SizedBox(height: 16),
                    Text(
                      'Loading payment page...',
                      style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}