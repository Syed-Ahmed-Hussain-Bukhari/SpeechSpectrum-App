// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import '../routes/app_routes.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
//   late AnimationController _sController;
//   late AnimationController _pController;
//   late AnimationController _fadeController;
  
//   late Animation<Offset> _sSlide;
//   late Animation<Offset> _pSlide;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
    
//     // S animation controller
//     _sController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
    
//     // P animation controller
//     _pController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );
    
//     // Fade controller for remaining text
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     // S slides from left
//     _sSlide = Tween<Offset>(
//       begin: const Offset(-2.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _sController,
//       curve: Curves.easeOutCubic,
//     ));

//     // P slides from right
//     _pSlide = Tween<Offset>(
//       begin: const Offset(2.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _pController,
//       curve: Curves.easeOutCubic,
//     ));

//     // Fade animation for remaining text
//     _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
//     );

//     _startAnimation();
//   }

//   void _startAnimation() async {
//     await Future.delayed(const Duration(milliseconds: 500));
//     _sController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 200));
//     _pController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 400));
//     _fadeController.forward();
    
//     await Future.delayed(const Duration(milliseconds: 1500));
//     Get.offNamed(AppRoutes.onboarding);
//   }

//   @override
//   void dispose() {
//     _sController.dispose();
//     _pController.dispose();
//     _fadeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Animated S
//             SlideTransition(
//               position: _sSlide,
//               child: Text(
//                 'S',
//                 style: GoogleFonts.poppins(
//                   fontSize: 72,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                   letterSpacing: 2,
//                 ),
//               ),
//             ),
//             // Animated p
//             SlideTransition(
//               position: _pSlide,
//               child: Text(
//                 'p',
//                 style: GoogleFonts.poppins(
//                   fontSize: 72,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                   letterSpacing: 2,
//                 ),
//               ),
//             ),
//             // Fading remaining text
//             FadeTransition(
//               opacity: _fadeAnimation,
//               child: Text(
//                 'eechSpectrum',
//                 style: GoogleFonts.poppins(
//                   fontSize: 72,
//                   fontWeight: FontWeight.bold,
//                   color: AppColors.whiteColor,
//                   letterSpacing: 2,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import '../routes/app_routes.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _sController;
//   late AnimationController _pController;
//   late List<AnimationController> _waveControllers;

//   late Animation<Offset> _sSlide;
//   late Animation<Offset> _pSlide;
//   late List<Animation<double>> _waveAnimations;

//   final String remainingText = 'eechSpectrum';

//   @override
//   void initState() {
//     super.initState();

//     // S animation controller
//     _sController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     // P animation controller
//     _pController = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     );

//     // Wave controllers for each letter
//     _waveControllers = List.generate(
//       remainingText.length,
//       (index) => AnimationController(
//         duration: const Duration(milliseconds: 400),
//         vsync: this,
//       ),
//     );

//     // S slides from left
//     _sSlide = Tween<Offset>(
//       begin: const Offset(-2.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _sController,
//       curve: Curves.easeOutCubic,
//     ));

//     // P slides from right
//     _pSlide = Tween<Offset>(
//       begin: const Offset(2.0, 0.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(
//       parent: _pController,
//       curve: Curves.easeOutCubic,
//     ));

//     // Wave animations for each letter (slide up + fade)
//     _waveAnimations = _waveControllers.map((controller) {
//       return Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
//       );
//     }).toList();

//     _startAnimation();
//   }

//   void _startAnimation() async {
//     // Start S animation
//     await Future.delayed(const Duration(milliseconds: 300));
//     _sController.forward();

//     // Start P animation
//     await Future.delayed(const Duration(milliseconds: 200));
//     _pController.forward();

//     // Start wave animation for remaining letters
//     await Future.delayed(const Duration(milliseconds: 400));
//     for (int i = 0; i < _waveControllers.length; i++) {
//       Future.delayed(Duration(milliseconds: i * 80), () {
//         if (mounted) {
//           _waveControllers[i].forward();
//         }
//       });
//     }

//     // Navigate to onboarding
//     await Future.delayed(const Duration(milliseconds: 2500));
//     if (mounted) {
//       Get.offNamed(AppRoutes.onboarding);
//     }
//   }

//   @override
//   void dispose() {
//     _sController.dispose();
//     _pController.dispose();
//     for (var controller in _waveControllers) {
//       controller.dispose();
//     }
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Calculate responsive font size
//     final screenWidth = MediaQuery.of(context).size.width;
//     final fontSize = screenWidth < 600
//         ? screenWidth * 0.12 // Mobile
//         : screenWidth < 1200
//             ? screenWidth * 0.08 // Tablet
//             : 72.0; // Desktop

//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: FittedBox(
//             fit: BoxFit.scaleDown,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 // Animated S
//                 SlideTransition(
//                   position: _sSlide,
//                   child: Text(
//                     'S',
//                     style: GoogleFonts.poppins(
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//                 // Animated p
//                 SlideTransition(
//                   position: _pSlide,
//                   child: Text(
//                     'p',
//                     style: GoogleFonts.poppins(
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.whiteColor,
//                       letterSpacing: 1,
//                     ),
//                   ),
//                 ),
//                 // Wave animated remaining text
//                 ...List.generate(remainingText.length, (index) {
//                   return AnimatedBuilder(
//                     animation: _waveAnimations[index],
//                     builder: (context, child) {
//                       return Transform.translate(
//                         offset: Offset(
//                           0,
//                           -30 * (1 - _waveAnimations[index].value),
//                         ),
//                         child: Opacity(
//                           opacity: _waveAnimations[index].value,
//                           child: Text(
//                             remainingText[index],
//                             style: GoogleFonts.poppins(
//                               fontSize: fontSize,
//                               fontWeight: FontWeight.bold,
//                               color: AppColors.whiteColor,
//                               letterSpacing: 1,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 }),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/view/splash/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';
import '../../services/storage_service.dart';
import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _sController;
  late AnimationController _pController;
  late List<AnimationController> _waveControllers;

  late Animation<Offset> _sSlide;
  late Animation<Offset> _pSlide;
  late List<Animation<double>> _waveAnimations;

  final String remainingText = 'eechSpectrum';


  @override
  void initState() {
    super.initState();

    // S animation controller
    _sController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // P animation controller
    _pController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Wave controllers for each letter
    _waveControllers = List.generate(
      remainingText.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );

    // S slides from left
    _sSlide = Tween<Offset>(
      begin: const Offset(-2.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _sController,
      curve: Curves.easeOutCubic,
    ));

    // P slides from right
    _pSlide = Tween<Offset>(
      begin: const Offset(2.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _pController,
      curve: Curves.easeOutCubic,
    ));

    // Wave animations for each letter (slide up + fade)
    _waveAnimations = _waveControllers.map((controller) {
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack),
      );
    }).toList();

    _startAnimation();
  }

  void _startAnimation() async {
    // Start S animation
    await Future.delayed(const Duration(milliseconds: 300));
    _sController.forward();

    // Start P animation
    await Future.delayed(const Duration(milliseconds: 200));
    _pController.forward();

    // Start wave animation for remaining letters
    await Future.delayed(const Duration(milliseconds: 400));
    for (int i = 0; i < _waveControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 80), () {
        if (mounted) {
          _waveControllers[i].forward();
        }
      });
    }

    // Wait for animation to complete
    await Future.delayed(const Duration(milliseconds: 2500));
    
    if (mounted) {
      _checkAuthenticationStatus();
    }
  }

  // Future<void> _checkAuthenticationStatus() async {
  //   try {
  //     // Check if user is logged in
  //     final isLoggedIn = await _storageService.isLoggedIn();
      
  //     if (isLoggedIn) {
  //       // Check if token is expired
  //       final isExpired = await _storageService.isTokenExpired();
        
  //       if (!isExpired) {
  //         // Token is valid, go to home
  //         print('User is logged in with valid token, navigating to home');
  //         Get.offAllNamed(AppRoutes.home);
  //       } else {
  //         // Token is expired, go to login
  //         print('Token expired, navigating to login');
  //         Get.offAllNamed(AppRoutes.login);
  //       }
  //     } else {
  //       // User not logged in, go to onboarding
  //       print('User not logged in, navigating to onboarding');
  //       Get.offAllNamed(AppRoutes.onboarding);
  //     }
  //   } catch (e) {
  //     print('Error checking auth status: $e');
  //     // On error, go to onboarding
  //     Get.offAllNamed(AppRoutes.onboarding);
  //   }
  // }

  Future<void> _checkAuthenticationStatus() async {
  try {
    final isLoggedIn = await SharedPreferencesService.isLoggedIn();

    if (isLoggedIn) {
      final isExpired = await SharedPreferencesService.isTokenExpired();

      if (!isExpired) {
          final userRole = await SharedPreferencesService.getRole();

        // Navigate based on role
        if (userRole?.toLowerCase() == 'expert') {
          // Navigate to Expert Home
          debugPrint('✅ Navigating to Expert Home');
          Get.offAllNamed(AppRoutes.expertHome);
        } else if (userRole?.toLowerCase() == 'parent') {
          // Navigate to Parent Home
          debugPrint('✅ Navigating to Parent Home');
          Get.offAllNamed(AppRoutes.home);
        } else {
          // Fallback - use shared preferences role
          final savedRole = await SharedPreferencesService.getRole();
          debugPrint('⚠️ Unknown role from response: $userRole, checking saved role: $savedRole');
          
          if (savedRole?.toLowerCase() == 'expert') {
            Get.offAllNamed(AppRoutes.expertHome);
          } else {
            Get.offAllNamed(AppRoutes.home);
          }
        }
        
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    } else {
      Get.offAllNamed(AppRoutes.onboarding);
    }
  } catch (e) {
    Get.offAllNamed(AppRoutes.onboarding);
  }
}


  @override
  void dispose() {
    _sController.dispose();
    _pController.dispose();
    for (var controller in _waveControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Calculate responsive font size
    final screenWidth = MediaQuery.of(context).size.width;
    final fontSize = screenWidth < 600
        ? screenWidth * 0.12 // Mobile
        : screenWidth < 1200
            ? screenWidth * 0.08 // Tablet
            : 72.0; // Desktop

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated S
                SlideTransition(
                  position: _sSlide,
                  child: Text(
                    'S',
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Animated p
                SlideTransition(
                  position: _pSlide,
                  child: Text(
                    'p',
                    style: GoogleFonts.poppins(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                // Wave animated remaining text
                ...List.generate(remainingText.length, (index) {
                  return AnimatedBuilder(
                    animation: _waveAnimations[index],
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          0,
                          -30 * (1 - _waveAnimations[index].value),
                        ),
                        child: Opacity(
                          opacity: _waveAnimations[index].value,
                          child: Text(
                            remainingText[index],
                            style: GoogleFonts.poppins(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}