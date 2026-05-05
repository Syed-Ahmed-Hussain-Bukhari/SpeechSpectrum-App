// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';
// // // import '../routes/app_routes.dart';


// // // class SplashScreen extends StatefulWidget {
// // //   const SplashScreen({super.key});

// // //   @override
// // //   State<SplashScreen> createState() => _SplashScreenState();
// // // }

// // // class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
// // //   late AnimationController _sController;
// // //   late AnimationController _pController;
// // //   late AnimationController _fadeController;
  
// // //   late Animation<Offset> _sSlide;
// // //   late Animation<Offset> _pSlide;
// // //   late Animation<double> _fadeAnimation;

// // //   @override
// // //   void initState() {
// // //     super.initState();
    
// // //     // S animation controller
// // //     _sController = AnimationController(
// // //       duration: const Duration(milliseconds: 600),
// // //       vsync: this,
// // //     );
    
// // //     // P animation controller
// // //     _pController = AnimationController(
// // //       duration: const Duration(milliseconds: 600),
// // //       vsync: this,
// // //     );
    
// // //     // Fade controller for remaining text
// // //     _fadeController = AnimationController(
// // //       duration: const Duration(milliseconds: 800),
// // //       vsync: this,
// // //     );

// // //     // S slides from left
// // //     _sSlide = Tween<Offset>(
// // //       begin: const Offset(-2.0, 0.0),
// // //       end: Offset.zero,
// // //     ).animate(CurvedAnimation(
// // //       parent: _sController,
// // //       curve: Curves.easeOutCubic,
// // //     ));

// // //     // P slides from right
// // //     _pSlide = Tween<Offset>(
// // //       begin: const Offset(2.0, 0.0),
// // //       end: Offset.zero,
// // //     ).animate(CurvedAnimation(
// // //       parent: _pController,
// // //       curve: Curves.easeOutCubic,
// // //     ));

// // //     // Fade animation for remaining text
// // //     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
// // //       CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
// // //     );

// // //     _startAnimation();
// // //   }

// // //   void _startAnimation() async {
// // //     await Future.delayed(const Duration(milliseconds: 500));
// // //     _sController.forward();
    
// // //     await Future.delayed(const Duration(milliseconds: 200));
// // //     _pController.forward();
    
// // //     await Future.delayed(const Duration(milliseconds: 400));
// // //     _fadeController.forward();
    
// // //     await Future.delayed(const Duration(milliseconds: 1500));
// // //     Get.offNamed(AppRoutes.onboarding);
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _sController.dispose();
// // //     _pController.dispose();
// // //     _fadeController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: AppColors.primaryColor,
// // //       body: Center(
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           crossAxisAlignment: CrossAxisAlignment.center,
// // //           children: [
// // //             // Animated S
// // //             SlideTransition(
// // //               position: _sSlide,
// // //               child: Text(
// // //                 'S',
// // //                 style: GoogleFonts.poppins(
// // //                   fontSize: 72,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: AppColors.whiteColor,
// // //                   letterSpacing: 2,
// // //                 ),
// // //               ),
// // //             ),
// // //             // Animated p
// // //             SlideTransition(
// // //               position: _pSlide,
// // //               child: Text(
// // //                 'p',
// // //                 style: GoogleFonts.poppins(
// // //                   fontSize: 72,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: AppColors.whiteColor,
// // //                   letterSpacing: 2,
// // //                 ),
// // //               ),
// // //             ),
// // //             // Fading remaining text
// // //             FadeTransition(
// // //               opacity: _fadeAnimation,
// // //               child: Text(
// // //                 'eechSpectrum',
// // //                 style: GoogleFonts.poppins(
// // //                   fontSize: 72,
// // //                   fontWeight: FontWeight.bold,
// // //                   color: AppColors.whiteColor,
// // //                   letterSpacing: 2,
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }


// // // import 'package:flutter/material.dart';
// // // import 'package:get/get.dart';
// // // import 'package:google_fonts/google_fonts.dart';
// // // import 'package:speechspectrum/constants/app_colors.dart';
// // // import '../routes/app_routes.dart';

// // // class SplashScreen extends StatefulWidget {
// // //   const SplashScreen({super.key});

// // //   @override
// // //   State<SplashScreen> createState() => _SplashScreenState();
// // // }

// // // class _SplashScreenState extends State<SplashScreen>
// // //     with TickerProviderStateMixin {
// // //   late AnimationController _sController;
// // //   late AnimationController _pController;
// // //   late List<AnimationController> _waveControllers;

// // //   late Animation<Offset> _sSlide;
// // //   late Animation<Offset> _pSlide;
// // //   late List<Animation<double>> _waveAnimations;

// // //   final String remainingText = 'eechSpectrum';

// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //     // S animation controller
// // //     _sController = AnimationController(
// // //       duration: const Duration(milliseconds: 600),
// // //       vsync: this,
// // //     );

// // //     // P animation controller
// // //     _pController = AnimationController(
// // //       duration: const Duration(milliseconds: 600),
// // //       vsync: this,
// // //     );

// // //     // Wave controllers for each letter
// // //     _waveControllers = List.generate(
// // //       remainingText.length,
// // //       (index) => AnimationController(
// // //         duration: const Duration(milliseconds: 400),
// // //         vsync: this,
// // //       ),
// // //     );

// // //     // S slides from left
// // //     _sSlide = Tween<Offset>(
// // //       begin: const Offset(-2.0, 0.0),
// // //       end: Offset.zero,
// // //     ).animate(CurvedAnimation(
// // //       parent: _sController,
// // //       curve: Curves.easeOutCubic,
// // //     ));

// // //     // P slides from right
// // //     _pSlide = Tween<Offset>(
// // //       begin: const Offset(2.0, 0.0),
// // //       end: Offset.zero,
// // //     ).animate(CurvedAnimation(
// // //       parent: _pController,
// // //       curve: Curves.easeOutCubic,
// // //     ));

// // //     // Wave animations for each letter (slide up + fade)
// // //     _waveAnimations = _waveControllers.map((controller) {
// // //       return Tween<double>(begin: 0.0, end: 1.0).animate(
// // //         CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
// // //       );
// // //     }).toList();

// // //     _startAnimation();
// // //   }

// // //   void _startAnimation() async {
// // //     // Start S animation
// // //     await Future.delayed(const Duration(milliseconds: 300));
// // //     _sController.forward();

// // //     // Start P animation
// // //     await Future.delayed(const Duration(milliseconds: 200));
// // //     _pController.forward();

// // //     // Start wave animation for remaining letters
// // //     await Future.delayed(const Duration(milliseconds: 400));
// // //     for (int i = 0; i < _waveControllers.length; i++) {
// // //       Future.delayed(Duration(milliseconds: i * 80), () {
// // //         if (mounted) {
// // //           _waveControllers[i].forward();
// // //         }
// // //       });
// // //     }

// // //     // Navigate to onboarding
// // //     await Future.delayed(const Duration(milliseconds: 2500));
// // //     if (mounted) {
// // //       Get.offNamed(AppRoutes.onboarding);
// // //     }
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _sController.dispose();
// // //     _pController.dispose();
// // //     for (var controller in _waveControllers) {
// // //       controller.dispose();
// // //     }
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // Calculate responsive font size
// // //     final screenWidth = MediaQuery.of(context).size.width;
// // //     final fontSize = screenWidth < 600
// // //         ? screenWidth * 0.12 // Mobile
// // //         : screenWidth < 1200
// // //             ? screenWidth * 0.08 // Tablet
// // //             : 72.0; // Desktop

// // //     return Scaffold(
// // //       backgroundColor: AppColors.primaryColor,
// // //       body: Center(
// // //         child: Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
// // //           child: FittedBox(
// // //             fit: BoxFit.scaleDown,
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.center,
// // //               crossAxisAlignment: CrossAxisAlignment.center,
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 // Animated S
// // //                 SlideTransition(
// // //                   position: _sSlide,
// // //                   child: Text(
// // //                     'S',
// // //                     style: GoogleFonts.poppins(
// // //                       fontSize: fontSize,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: AppColors.whiteColor,
// // //                       letterSpacing: 1,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 // Animated p
// // //                 SlideTransition(
// // //                   position: _pSlide,
// // //                   child: Text(
// // //                     'p',
// // //                     style: GoogleFonts.poppins(
// // //                       fontSize: fontSize,
// // //                       fontWeight: FontWeight.bold,
// // //                       color: AppColors.whiteColor,
// // //                       letterSpacing: 1,
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 // Wave animated remaining text
// // //                 ...List.generate(remainingText.length, (index) {
// // //                   return AnimatedBuilder(
// // //                     animation: _waveAnimations[index],
// // //                     builder: (context, child) {
// // //                       return Transform.translate(
// // //                         offset: Offset(
// // //                           0,
// // //                           -30 * (1 - _waveAnimations[index].value),
// // //                         ),
// // //                         child: Opacity(
// // //                           opacity: _waveAnimations[index].value,
// // //                           child: Text(
// // //                             remainingText[index],
// // //                             style: GoogleFonts.poppins(
// // //                               fontSize: fontSize,
// // //                               fontWeight: FontWeight.bold,
// // //                               color: AppColors.whiteColor,
// // //                               letterSpacing: 1,
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       );
// // //                     },
// // //                   );
// // //                 }),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // lib/view/splash/splash_screen.dart
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:speechspectrum/constants/app_colors.dart';
// // import 'package:speechspectrum/services/shared_preferences_service.dart';
// // import '../../services/storage_service.dart';
// // import '../routes/app_routes.dart';

// // class SplashScreen extends StatefulWidget {
// //   const SplashScreen({super.key});

// //   @override
// //   State<SplashScreen> createState() => _SplashScreenState();
// // }

// // class _SplashScreenState extends State<SplashScreen>
// //     with TickerProviderStateMixin {
// //   late AnimationController _sController;
// //   late AnimationController _pController;
// //   late List<AnimationController> _waveControllers;

// //   late Animation<Offset> _sSlide;
// //   late Animation<Offset> _pSlide;
// //   late List<Animation<double>> _waveAnimations;

// //   final String remainingText = 'eechSpectrum';


// //   @override
// //   void initState() {
// //     super.initState();

// //     // S animation controller
// //     _sController = AnimationController(
// //       duration: const Duration(milliseconds: 600),
// //       vsync: this,
// //     );

// //     // P animation controller
// //     _pController = AnimationController(
// //       duration: const Duration(milliseconds: 600),
// //       vsync: this,
// //     );

// //     // Wave controllers for each letter
// //     _waveControllers = List.generate(
// //       remainingText.length,
// //       (index) => AnimationController(
// //         duration: const Duration(milliseconds: 400),
// //         vsync: this,
// //       ),
// //     );

// //     // S slides from left
// //     _sSlide = Tween<Offset>(
// //       begin: const Offset(-2.0, 0.0),
// //       end: Offset.zero,
// //     ).animate(CurvedAnimation(
// //       parent: _sController,
// //       curve: Curves.easeOutCubic,
// //     ));

// //     // P slides from right
// //     _pSlide = Tween<Offset>(
// //       begin: const Offset(2.0, 0.0),
// //       end: Offset.zero,
// //     ).animate(CurvedAnimation(
// //       parent: _pController,
// //       curve: Curves.easeOutCubic,
// //     ));

// //     // Wave animations for each letter (slide up + fade)
// //     _waveAnimations = _waveControllers.map((controller) {
// //       return Tween<double>(begin: 0.0, end: 1.0).animate(
// //         CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
// //       );
// //     }).toList();

// //     _startAnimation();
// //   }

// //   void _startAnimation() async {
// //     // Start S animation
// //     await Future.delayed(const Duration(milliseconds: 300));
// //     _sController.forward();

// //     // Start P animation
// //     await Future.delayed(const Duration(milliseconds: 200));
// //     _pController.forward();

// //     // Start wave animation for remaining letters
// //     await Future.delayed(const Duration(milliseconds: 400));
// //     for (int i = 0; i < _waveControllers.length; i++) {
// //       Future.delayed(Duration(milliseconds: i * 80), () {
// //         if (mounted) {
// //           _waveControllers[i].forward();
// //         }
// //       });
// //     }

// //     // Wait for animation to complete
// //     await Future.delayed(const Duration(milliseconds: 2500));
    
// //     if (mounted) {
// //       _checkAuthenticationStatus();
// //     }
// //   }

// //   // Future<void> _checkAuthenticationStatus() async {
// //   //   try {
// //   //     // Check if user is logged in
// //   //     final isLoggedIn = await _storageService.isLoggedIn();
      
// //   //     if (isLoggedIn) {
// //   //       // Check if token is expired
// //   //       final isExpired = await _storageService.isTokenExpired();
        
// //   //       if (!isExpired) {
// //   //         // Token is valid, go to home
// //   //         print('User is logged in with valid token, navigating to home');
// //   //         Get.offAllNamed(AppRoutes.home);
// //   //       } else {
// //   //         // Token is expired, go to login
// //   //         print('Token expired, navigating to login');
// //   //         Get.offAllNamed(AppRoutes.login);
// //   //       }
// //   //     } else {
// //   //       // User not logged in, go to onboarding
// //   //       print('User not logged in, navigating to onboarding');
// //   //       Get.offAllNamed(AppRoutes.onboarding);
// //   //     }
// //   //   } catch (e) {
// //   //     print('Error checking auth status: $e');
// //   //     // On error, go to onboarding
// //   //     Get.offAllNamed(AppRoutes.onboarding);
// //   //   }
// //   // }

// // //   Future<void> _checkAuthenticationStatus() async {
// // //   try {
// // //     final isLoggedIn = await SharedPreferencesService.isLoggedIn();

// // //     if (isLoggedIn) {
// // //       final isExpired = await SharedPreferencesService.isTokenExpired();

// // //       if (!isExpired) {
// // //           final userRole = await SharedPreferencesService.getRole();

// // //         // Navigate based on role
// // //         if (userRole?.toLowerCase() == 'expert') {
// // //           // Navigate to Expert Home
// // //           debugPrint('✅ Navigating to Expert Home');
// // //           // Get.offAllNamed(AppRoutes.expertHome);
// // //           Get.offAllNamed(AppRoutes.expertMain);
// // //         } else if (userRole?.toLowerCase() == 'parent') {
// // //           // Navigate to Parent Home
// // //           debugPrint('✅ Navigating to Parent Home');
// // //           Get.offAllNamed(AppRoutes.home);
// // //         } else {
// // //           // Fallback - use shared preferences role
// // //           final savedRole = await SharedPreferencesService.getRole();
// // //           debugPrint('⚠️ Unknown role from response: $userRole, checking saved role: $savedRole');
          
// // //           if (savedRole?.toLowerCase() == 'expert') {
// // //             // Get.offAllNamed(AppRoutes.expertHome);
// // //             Get.offAllNamed(AppRoutes.expertMain);
// // //           } else {
// // //             Get.offAllNamed(AppRoutes.home);
// // //           }
// // //         }
        
// // //       } else {
// // //         Get.offAllNamed(AppRoutes.login);
// // //       }
// // //     } else {
// // //       Get.offAllNamed(AppRoutes.onboarding);
// // //     }
// // //   } catch (e) {
// // //     Get.offAllNamed(AppRoutes.onboarding);
// // //   }
// // // }

// // Future<void> _checkAuthenticationStatus() async {
// //   try {
// //     // Check if onboarding has ever been seen
// //     final onboardingSeen = await SharedPreferencesService.isOnboardingSeen();

// //     if (!onboardingSeen) {
// //       // First time ever — show onboarding
// //       Get.offAllNamed(AppRoutes.onboarding);
// //       return;
// //     }

// //     // Onboarding already seen — check login state
// //     final isLoggedIn = await SharedPreferencesService.isLoggedIn();

// //     if (isLoggedIn) {
// //       final isExpired = await SharedPreferencesService.isTokenExpired();

// //       if (!isExpired) {
// //         final userRole = await SharedPreferencesService.getRole();

// //         if (userRole?.toLowerCase() == 'expert') {
// //           Get.offAllNamed(AppRoutes.expertMain);
// //         } else {
// //           Get.offAllNamed(AppRoutes.home);
// //         }
// //       } else {
// //         Get.offAllNamed(AppRoutes.login);
// //       }
// //     } else {
// //       // Logged out — go straight to login (onboarding already seen)
// //       Get.offAllNamed(AppRoutes.login);
// //     }
// //   } catch (e) {
// //     Get.offAllNamed(AppRoutes.login);
// //   }
// // }


// //   @override
// //   void dispose() {
// //     _sController.dispose();
// //     _pController.dispose();
// //     for (var controller in _waveControllers) {
// //       controller.dispose();
// //     }
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     // Calculate responsive font size
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final fontSize = screenWidth < 600
// //         ? screenWidth * 0.12 // Mobile
// //         : screenWidth < 1200
// //             ? screenWidth * 0.08 // Tablet
// //             : 72.0; // Desktop

// //     return Scaffold(
// //       backgroundColor: AppColors.primaryColor,
// //       body: Center(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 20.0),
// //           child: FittedBox(
// //             fit: BoxFit.scaleDown,
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               crossAxisAlignment: CrossAxisAlignment.center,
// //               mainAxisSize: MainAxisSize.min,
// //               children: [
// //                 // Animated S
// //                 SlideTransition(
// //                   position: _sSlide,
// //                   child: Text(
// //                     'S',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: fontSize,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.whiteColor,
// //                       letterSpacing: 1,
// //                     ),
// //                   ),
// //                 ),
// //                 // Animated p
// //                 SlideTransition(
// //                   position: _pSlide,
// //                   child: Text(
// //                     'p',
// //                     style: GoogleFonts.poppins(
// //                       fontSize: fontSize,
// //                       fontWeight: FontWeight.bold,
// //                       color: AppColors.whiteColor,
// //                       letterSpacing: 1,
// //                     ),
// //                   ),
// //                 ),
// //                 // Wave animated remaining text
// //                 ...List.generate(remainingText.length, (index) {
// //                   return AnimatedBuilder(
// //                     animation: _waveAnimations[index],
// //                     builder: (context, child) {
// //                       return Transform.translate(
// //                         offset: Offset(
// //                           0,
// //                           -30 * (1 - _waveAnimations[index].value),
// //                         ),
// //                         child: Opacity(
// //                           opacity: _waveAnimations[index].value,
// //                           child: Text(
// //                             remainingText[index],
// //                             style: GoogleFonts.poppins(
// //                               fontSize: fontSize,
// //                               fontWeight: FontWeight.bold,
// //                               color: AppColors.whiteColor,
// //                               letterSpacing: 1,
// //                             ),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   );
// //                 }),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// // lib/view/splash/splash_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/services/shared_preferences_service.dart';
// import '../routes/app_routes.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   // Phase 1: Logo fades/scales in
//   late AnimationController _logoController;
//   late Animation<double> _logoFade;
//   late Animation<double> _logoScale;

//   // Phase 2: SpeechSpectrum text slides up + fades in
//   late AnimationController _textController;
//   late Animation<double> _textFade;
//   late Animation<Offset> _textSlide;

//   // Phase 3: Early Insight text slides up + fades in
//   late AnimationController _earlyController;
//   late Animation<double> _earlyFade;
//   late Animation<Offset> _earlySlide;

//   // Phase 4: Transition — phase 1-3 fade OUT, final image fades IN
//   late AnimationController _outController;
//   late Animation<double> _outFade; // fades out group

//   late AnimationController _finalController;
//   late Animation<double> _finalFade;
//   late Animation<double> _finalScale;

//   bool _showFinal = false;

//   @override
//   void initState() {
//     super.initState();

//     // --- Logo ---
//     _logoController = AnimationController(
//       duration: const Duration(milliseconds: 700),
//       vsync: this,
//     );
//     _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
//     );
//     _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
//       CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
//     );

//     // --- SpeechSpectrum text ---
//     _textController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _textController, curve: Curves.easeIn),
//     );
//     _textSlide = Tween<Offset>(
//       begin: const Offset(0, 0.4),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
//     );

//     // --- Early Insight text ---
//     _earlyController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
//     _earlyFade = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _earlyController, curve: Curves.easeIn),
//     );
//     _earlySlide = Tween<Offset>(
//       begin: const Offset(0, 0.4),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(parent: _earlyController, curve: Curves.easeOutCubic),
//     );

//     // --- Fade out group ---
//     _outController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _outFade = Tween<double>(begin: 1.0, end: 0.0).animate(
//       CurvedAnimation(parent: _outController, curve: Curves.easeIn),
//     );

//     // --- Final image ---
//     _finalController = AnimationController(
//       duration: const Duration(milliseconds: 700),
//       vsync: this,
//     );
//     _finalFade = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _finalController, curve: Curves.easeIn),
//     );
//     _finalScale = Tween<double>(begin: 0.85, end: 1.0).animate(
//       CurvedAnimation(parent: _finalController, curve: Curves.easeOutBack),
//     );

//     _startAnimation();
//   }

//   void _startAnimation() async {
//     // Step 1: Logo appears
//     await Future.delayed(const Duration(milliseconds: 300));
//     _logoController.forward();

//     // Step 2: SpeechSpectrum text slides up
//     await Future.delayed(const Duration(milliseconds: 700));
//     _textController.forward();

//     // Step 3: Early Insight text slides up
//     await Future.delayed(const Duration(milliseconds: 500));
//     _earlyController.forward();

//     // Hold for a moment so user can read
//     await Future.delayed(const Duration(milliseconds: 1000));

//     // Step 4: Fade out the group
//     _outController.forward();
//     await Future.delayed(const Duration(milliseconds: 500));

//     // Step 5: Show final image
//     if (mounted) {
//       setState(() => _showFinal = true);
//       _finalController.forward();
//     }

//     // Wait then navigate
//     await Future.delayed(const Duration(milliseconds: 1200));
//     if (mounted) {
//       _checkAuthenticationStatus();
//     }
//   }

//   Future<void> _checkAuthenticationStatus() async {
//     try {
//       final onboardingSeen = await SharedPreferencesService.isOnboardingSeen();

//       if (!onboardingSeen) {
//         Get.offAllNamed(AppRoutes.onboarding);
//         return;
//       }

//       final isLoggedIn = await SharedPreferencesService.isLoggedIn();

//       if (isLoggedIn) {
//         final isExpired = await SharedPreferencesService.isTokenExpired();

//         if (!isExpired) {
//           final userRole = await SharedPreferencesService.getRole();

//           if (userRole?.toLowerCase() == 'expert') {
//             Get.offAllNamed(AppRoutes.expertMain);
//           } else {
//             Get.offAllNamed(AppRoutes.home);
//           }
//         } else {
//           Get.offAllNamed(AppRoutes.login);
//         }
//       } else {
//         Get.offAllNamed(AppRoutes.login);
//       }
//     } catch (e) {
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }

//   @override
//   void dispose() {
//     _logoController.dispose();
//     _textController.dispose();
//     _earlyController.dispose();
//     _outController.dispose();
//     _finalController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final logoSize = size.width < 600
//         ? size.width * 0.35
//         : size.width < 1200
//             ? size.width * 0.25
//             : 200.0;

//     final textWidth = size.width < 600
//         ? size.width * 0.65
//         : size.width < 1200
//             ? size.width * 0.45
//             : 360.0;

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // ── Phase 1–3 group ──────────────────────────────────────────
//             if (!_showFinal)
//               FadeTransition(
//                 opacity: _outFade,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Logo
//                     FadeTransition(
//                       opacity: _logoFade,
//                       child: ScaleTransition(
//                         scale: _logoScale,
//                         child: Image.asset(
//                           'assets/images/logo.jpeg',
//                           width: logoSize,
//                           height: logoSize,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: size.height * 0.025),

//                     // SpeechSpectrum text
//                     FadeTransition(
//                       opacity: _textFade,
//                       child: SlideTransition(
//                         position: _textSlide,
//                         child: Image.asset(
//                           'assets/images/speechSpectrum_text.jpeg',
//                           width: textWidth,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                     SizedBox(height: size.height * 0.015),

//                     // Early Insight text
//                     FadeTransition(
//                       opacity: _earlyFade,
//                       child: SlideTransition(
//                         position: _earlySlide,
//                         child: Image.asset(
//                           'assets/images/early_insight_text.jpeg',
//                           width: textWidth * 0.75,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//             // ── Phase 4: Final image ──────────────────────────────────────
//             if (_showFinal)
//               FadeTransition(
//                 opacity: _finalFade,
//                 child: ScaleTransition(
//                   scale: _finalScale,
//                   child: Image.asset(
//                     'assets/images/logo_with_text.jpeg',
//                     width: size.width < 600
//                         ? size.width * 0.75
//                         : size.width < 1200
//                             ? size.width * 0.55
//                             : 450.0,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/view/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Phase 1: Logo fades/scales in
  late AnimationController _logoController;
  late Animation<double> _logoFade;
  late Animation<double> _logoScale;

  // Phase 2: SpeechSpectrum text slides up + fades in
  late AnimationController _textController;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;

  // Phase 3: Early Insight text slides up + fades in
  late AnimationController _earlyController;
  late Animation<double> _earlyFade;
  late Animation<Offset> _earlySlide;

  // Phase 4: Transition — phase 1-3 fade OUT, final image fades IN
  late AnimationController _outController;
  late Animation<double> _outFade; // fades out group

  late AnimationController _finalController;
  late Animation<double> _finalFade;
  late Animation<double> _finalScale;

  bool _showFinal = false;

  @override
  void initState() {
    super.initState();

    // --- Logo ---
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );
    _logoScale = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // --- SpeechSpectrum text ---
    _textController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    // --- Early Insight text ---
    _earlyController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _earlyFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _earlyController, curve: Curves.easeIn),
    );
    _earlySlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _earlyController, curve: Curves.easeOutCubic),
    );

    // --- Fade out group ---
    _outController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _outFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _outController, curve: Curves.easeIn),
    );

    // --- Final image ---
    _finalController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _finalFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeIn),
    );
    _finalScale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _finalController, curve: Curves.easeOutBack),
    );

    _startAnimation();
  }

  void _startAnimation() async {
    // Step 1: Logo appears
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // Step 2: SpeechSpectrum text slides up
    await Future.delayed(const Duration(milliseconds: 700));
    _textController.forward();

    // Step 3: Early Insight text slides up
    await Future.delayed(const Duration(milliseconds: 500));
    _earlyController.forward();

    // Hold for a moment so user can read
    await Future.delayed(const Duration(milliseconds: 1000));

    // Step 4: Fade out the group
    _outController.forward();
    await Future.delayed(const Duration(milliseconds: 500));

    // Step 5: Show final image
    if (mounted) {
      setState(() => _showFinal = true);
      _finalController.forward();
    }

    // Wait then navigate
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      _checkAuthenticationStatus();
    }
  }

  Future<void> _checkAuthenticationStatus() async {
    try {
      final onboardingSeen = await SharedPreferencesService.isOnboardingSeen();

      if (!onboardingSeen) {
        Get.offAllNamed(AppRoutes.onboarding);
        return;
      }

      final isLoggedIn = await SharedPreferencesService.isLoggedIn();

      if (isLoggedIn) {
        final isExpired = await SharedPreferencesService.isTokenExpired();

        if (!isExpired) {
          final userRole = await SharedPreferencesService.getRole();

          if (userRole?.toLowerCase() == 'expert') {
            Get.offAllNamed(AppRoutes.expertMain);
          } else {
            Get.offAllNamed(AppRoutes.home);
          }
        } else {
          Get.offAllNamed(AppRoutes.login);
        }
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _earlyController.dispose();
    _outController.dispose();
    _finalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // ── SIZE CONTROLS ────────────────────────────────────────────────────────
    // To make logo bigger/smaller → change the multiplier after size.width
    //   e.g. 0.70 = 70% of screen width (bigger), 0.35 = smaller
    final logoSize = size.width < 600
        ? size.width * 0.70   // mobile  — was 0.35
        : size.width < 1200
            ? size.width * 0.50   // tablet  — was 0.25
            : 400.0;              // desktop — was 200.0

    // To make SpeechSpectrum text wider/narrower → change this multiplier
    //   e.g. 0.90 = 90% of screen width (wider), 0.50 = narrower
    final textWidth = size.width < 600
        ? size.width * 0.90   // mobile  — was 0.65
        : size.width < 1200
            ? size.width * 0.80   // tablet  — was 0.45
            : 720.0;              // desktop — was 360.0

    // To make Early Insight text wider → increase the 0.90 fraction below
    //   It is calculated as textWidth * fraction, so 0.90 = 90% of textWidth
    // ────────────────────────────────────────────────────────────────────────

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // ── Phase 1–3 group ──────────────────────────────────────────
            if (!_showFinal)
              FadeTransition(
                opacity: _outFade,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    FadeTransition(
                      opacity: _logoFade,
                      child: ScaleTransition(
                        scale: _logoScale,
                        child: Image.asset(
                          'assets/images/logo.jpeg',
                          width: logoSize,
                          height: logoSize,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.025),

                    // SpeechSpectrum text
                    FadeTransition(
                      opacity: _textFade,
                      child: SlideTransition(
                        position: _textSlide,
                        child: Image.asset(
                          'assets/images/speechSpectrum_text.jpeg',
                          width: textWidth,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: size.height * 0.015),

                    // Early Insight text
                    FadeTransition(
                      opacity: _earlyFade,
                      child: SlideTransition(
                        position: _earlySlide,
                        child: Image.asset(
                          'assets/images/early_insight_text.jpeg',
                          width: textWidth * 1.5,  // ← change 1.0 to make Early Insight wider/narrower
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // ── Phase 4: Final image ──────────────────────────────────────
            if (_showFinal)
              FadeTransition(
                opacity: _finalFade,
                child: ScaleTransition(
                  scale: _finalScale,
                  child: Image.asset(
                    'assets/images/logo_with_text.jpeg',
                    width: size.width < 600
                        ? size.width * 0.95   // mobile  — was 0.75
                        : size.width < 1200
                            ? size.width * 0.85   // tablet  — was 0.55
                            : 900.0,              // desktop — was 450.0
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}