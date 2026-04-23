// lib/view/progress/progress_hub_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ProgressHubScreen extends StatelessWidget {
  const ProgressHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // ── Gradient App Bar ──────────────────────────────────────────
          SliverAppBar(
            expandedHeight: screenHeight * 0.28,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () => Get.back(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: _HubHeader(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
            ),
          ),

          // ── Body ──────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.05,
                vertical: screenHeight * 0.03,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section label
                  Text(
                    'Choose a category',
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.038,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondaryColor,
                      letterSpacing: 0.4,
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // ── Card 1 – Screening History ──────────────────────
                  _HubCard(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    gradientColors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withOpacity(0.75),
                    ],
                    icon: Icons.assignment_outlined,
                    badgeIcon: Icons.history_rounded,
                    title: 'Screening History',
                    subtitle:
                        'Review all past developmental screenings, scores, and find your child\'s therapist — plus manage child appointments in one place.',
                    statLabel: 'Total Screenings',
                    statValue: 'View All',
                    onTap: () => Get.toNamed(AppRoutes.history),
                  ),

                  SizedBox(height: screenHeight * 0.022),

                  // ── Card 2 – Speech Assessment History ─────────────
                  _HubCard(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                    gradientColors: [
                      AppColors.secondaryColor,
                      AppColors.secondaryColor.withOpacity(0.85),
                    ],
                    icon: Icons.mic_rounded,
                    badgeIcon: Icons.graphic_eq_rounded,
                    title: 'Speech Assessment\nHistory',
                    subtitle:
                        'Listen to recorded sessions, track pronunciation progress, consult with a therapist, and book your next session — all in one place.',
                    statLabel: 'Recordings',
                    statValue: 'View All',
                    onTap: () => Get.toNamed(AppRoutes.speechSubmissions),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // ── Info Banner ─────────────────────────────────────
                  _InfoBanner(
                    screenWidth: screenWidth,
                    screenHeight: screenHeight,
                  ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  HEADER WIDGET
// ═══════════════════════════════════════════════════════════════
class _HubHeader extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const _HubHeader({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.015,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon circle
              Container(
                width: screenWidth * 0.14,
                height: screenWidth * 0.14,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.35),
                    width: 1.5,
                  ),
                ),
                child: Icon(
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                  size: screenWidth * 0.07,
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              Text(
                'Progress & Results',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.065,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),

              SizedBox(height: screenHeight * 0.006),

              Text(
                'Track growth, milestones & speech journey',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.036,
                  color: Colors.white.withOpacity(0.82),
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: screenHeight * 0.025),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  HUB CARD WIDGET
// ═══════════════════════════════════════════════════════════════
class _HubCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final List<Color> gradientColors;
  final IconData icon;
  final IconData badgeIcon;
  final String title;
  final String subtitle;
  final String statLabel;
  final String statValue;
  final VoidCallback onTap;

  const _HubCard({
    required this.screenWidth,
    required this.screenHeight,
    required this.gradientColors,
    required this.icon,
    required this.badgeIcon,
    required this.title,
    required this.subtitle,
    required this.statLabel,
    required this.statValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradientColors.first.withOpacity(0.99),
            
            ),
            BoxShadow(
              color: gradientColors.first.withOpacity(0.99),
              
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              // Decorative circle – top right
              Positioned(
                top: -screenHeight * 0.04,
                right: -screenWidth * 0.08,
                child: Container(
                  width: screenWidth * 0.45,
                  height: screenWidth * 0.45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.07),
                  ),
                ),
              ),

              // Decorative circle – bottom left
              Positioned(
                bottom: -screenHeight * 0.03,
                left: -screenWidth * 0.05,
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.06),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.055),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row: icon + arrow
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Main icon
                        Container(
                          width: screenWidth * 0.13,
                          height: screenWidth * 0.13,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: screenWidth * 0.065,
                          ),
                        ),

                        // Arrow chip
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenHeight * 0.008,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.18),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Open',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.032,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: screenWidth * 0.038,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: screenHeight * 0.022),

                    // Title
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.052,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.25,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    // Subtitle
                    Text(
                      subtitle,
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.033,
                        color: Colors.white.withOpacity(0.82),
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.022),

                    // Divider
                    Container(
                      height: 1,
                      color: Colors.white.withOpacity(0.2),
                    ),

                    SizedBox(height: screenHeight * 0.015),

                    // Bottom stat row
                    Row(
                      children: [
                        Icon(
                          badgeIcon,
                          color: Colors.white.withOpacity(0.7),
                          size: screenWidth * 0.042,
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Text(
                          statLabel,
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.032,
                            color: Colors.white.withOpacity(0.75),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          statValue,
                          style: GoogleFonts.poppins(
                            fontSize: screenWidth * 0.032,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                          size: screenWidth * 0.042,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  INFO BANNER
// ═══════════════════════════════════════════════════════════════
class _InfoBanner extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const _InfoBanner({
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.045),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.09),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.25),
          width: 1.2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: AppColors.primaryColor,
            size: screenWidth * 0.05,
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'About Progress Tracking',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.036,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  'All screenings and speech recordings are securely stored. Your child\'s progress is automatically tracked over time so therapists can provide personalised guidance.',
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.031,
                    color: AppColors.textSecondaryColor,
                    height: 1.55,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}