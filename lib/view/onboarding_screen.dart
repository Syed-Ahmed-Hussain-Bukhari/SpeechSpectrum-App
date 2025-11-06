import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/components/custom_button.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import '../routes/app_routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _pages = [
    OnboardingData(
      title: 'Early Detection Matters',
      description: 'Identify potential speech delays and autism spectrum signs early through simple questionnaires and voice analysis.',
      icon: Icons.child_care,
      gradient: [Color(0xFF6C5CE7), Color(0xFF9B8DE7)],
    ),
    OnboardingData(
      title: 'AI-Powered Screening',
      description: 'Advanced machine learning analyzes speech patterns and behavioral data to provide accurate autism risk assessment.',
      icon: Icons.psychology,
      gradient: [Color(0xFF74B9FF), Color(0xFF0984E3)],
    ),
    OnboardingData(
      title: 'Support Your Child',
      description: 'Get personalized guidance, developmental insights, and recommendations to support your child\'s growth journey.',
      icon: Icons.family_restroom,
      gradient: [Color(0xFF00B894), Color(0xFF00CEC9)],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Get.offNamed(AppRoutes.signup),
                child: Padding(
                  padding: EdgeInsets.only(
                    right: size.customWidth(context) * 0.04,
                    top: size.customHeight(context) * 0.02,
                  ),
                  child: Text(
                    'Skip',
                    style: GoogleFonts.poppins(
                      fontSize: size.customWidth(context) * 0.04,
                      color: AppColors.textSecondaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            
            // PageView
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index], context);
                },
              ),
            ),
            
            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildDot(index, context),
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.04),
            
            // Next/Get Started button
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.customWidth(context) * 0.05,
              ),
              child: CustomButton(
                title: _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                height: size.customHeight(context) * 0.065,
                width: double.infinity,
                radius: size.customHeight(context) * 0.2,
                color: AppColors.primaryColor,
                loading: false,
                onTap: () {
                  if (_currentPage == _pages.length - 1) {
                    Get.offNamed(AppRoutes.signup);
                  } else {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.04),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingData data, BuildContext context) {
    final size = CustomSize();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon container with gradient
          Container(
            height: size.customHeight(context) * 0.25,
            width: size.customHeight(context) * 0.25,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: data.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(size.customHeight(context) * 0.125),
              boxShadow: [
                BoxShadow(
                  color: data.gradient[0].withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              data.icon,
              size: size.customHeight(context) * 0.12,
              color: AppColors.whiteColor,
            ),
          ),
          
          SizedBox(height: size.customHeight(context) * 0.06),
          
          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.065,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
              height: 1.3,
            ),
          ),
          
          SizedBox(height: size.customHeight(context) * 0.02),
          
          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.04,
              color: AppColors.textSecondaryColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index, BuildContext context) {
    final size = CustomSize();
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.01),
      height: size.customHeight(context) * 0.01,
      width: _currentPage == index
          ? size.customWidth(context) * 0.08
          : size.customWidth(context) * 0.02,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppColors.primaryColor
            : AppColors.greyColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(size.customHeight(context) * 0.005),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;
  final List<Color> gradient;

  OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
    required this.gradient,
  });
}