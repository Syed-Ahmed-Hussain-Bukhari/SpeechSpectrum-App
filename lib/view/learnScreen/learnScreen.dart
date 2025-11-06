import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    
    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Learn & Resources',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_outline, color: AppColors.textPrimaryColor),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Article
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(size.customWidth(context) * 0.05),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.accentColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'FEATURED',
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.whiteColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Understanding Early Signs of Autism',
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.whiteColor,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Learn about the developmental milestones and early indicators that may suggest autism spectrum disorder.',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.whiteColor.withOpacity(0.9),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      foregroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Read More',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            // Categories
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Browse by Category',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryCard(
                          context,
                          Icons.psychology_outlined,
                          'Development',
                          AppColors.primaryColor,
                          () {},
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryCard(
                          context,
                          Icons.favorite_outline,
                          'Healthcare',
                          AppColors.errorColor,
                          () {},
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildCategoryCard(
                          context,
                          Icons.school_outlined,
                          'Education',
                          AppColors.accentColor,
                          () {},
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildCategoryCard(
                          context,
                          Icons.groups_outlined,
                          'Support',
                          AppColors.successColor,
                          () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
            
            // Articles List
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.customWidth(context) * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Latest Articles',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  _buildArticleCard(
                    context,
                    'Communication Strategies for Children',
                    'Practical tips for improving verbal and non-verbal communication skills in children with autism.',
                    '8 min read',
                    Icons.chat_bubble_outline,
                    AppColors.primaryColor,
                  ),
                  _buildArticleCard(
                    context,
                    'Understanding Sensory Sensitivities',
                    'Learn how to recognize and manage sensory processing challenges commonly experienced by autistic children.',
                    '6 min read',
                    Icons.touch_app_outlined,
                    AppColors.warningColor,
                  ),
                  _buildArticleCard(
                    context,
                    'Social Skills Development',
                    'Activities and techniques to help children develop social interaction and relationship-building skills.',
                    '10 min read',
                    Icons.people_outline,
                    AppColors.successColor,
                  ),
                  _buildArticleCard(
                    context,
                    'Nutrition and Autism',
                    'Dietary considerations and nutritional strategies that may support overall well-being and development.',
                    '7 min read',
                    Icons.restaurant_outlined,
                    AppColors.errorColor,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: size.customHeight(context) * 0.03),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    IconData icon,
    String label,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleCard(
    BuildContext context,
    String title,
    String description,
    String readTime,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondaryColor,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 14, color: AppColors.greyColor),
                    SizedBox(width: 4),
                    Text(
                      readTime,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: AppColors.greyColor),
        ],
      ),
    );
  }
}