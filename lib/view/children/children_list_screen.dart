// lib/view/children/children_list_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/child_controller.dart';
import 'package:speechspectrum/models/child_model.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ChildrenListScreen extends StatelessWidget {
  const ChildrenListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();
    // Initialize controller properly to avoid GetX errors
   final ChildController controller = Get.put(ChildController());


    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      body: CustomScrollView(
        slivers: [
          // App Bar with gradient
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.25,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildHeader(context),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
              onPressed: () => Get.back(),
            ),
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.02,
                MediaQuery.of(context).size.width * 0.05,
                MediaQuery.of(context).size.height * 0.01,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchController,
                  onChanged: controller.searchChildren,
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    color: AppColors.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search by child name...',
                    hintStyle: GoogleFonts.poppins(
                      color: AppColors.greyColor,
                      fontSize: MediaQuery.of(context).size.width * 0.038,
                    ),
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                     suffixIcon: Obx(() {
                  return controller.searchText.value.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: AppColors.greyColor),
                          onPressed: controller.clearSearch,
                        )
                      : const SizedBox.shrink();
                }),

                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                      vertical: MediaQuery.of(context).size.height * 0.018,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Children List
          Obx(() {
            if (controller.isLoading.value) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                        strokeWidth: 3,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      Text(
                        'Loading children...',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (controller.filteredChildren.isEmpty) {
              return SliverFillRemaining(
                child: _buildEmptyState(context, controller),
              );
            }

            return SliverPadding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final child = controller.filteredChildren[index];
                    return _buildChildCard(context, controller, child);
                  },
                  childCount: controller.filteredChildren.length,
                ),
              ),
            );
          }),

          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed(AppRoutes.createChild),
        backgroundColor: AppColors.primaryColor,
        elevation: 4,
        icon: const Icon(Icons.add, color: AppColors.whiteColor),
        label: Text(
          'Add Child',
          style: GoogleFonts.poppins(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryColor, AppColors.secondaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.child_care_rounded,
                  size: 40,
                  color: AppColors.whiteColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text(
                'My Children',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.005),
              Text(
                'Manage your children profiles',
                style: GoogleFonts.poppins(
                  color: AppColors.whiteColor.withOpacity(0.9),
                  fontSize: MediaQuery.of(context).size.width * 0.035,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildCard(BuildContext context, ChildController controller, ChildData child) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.015),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.toNamed(
            AppRoutes.childDetails,
            arguments: child,
          ),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
            child: Row(
              children: [
                // Avatar
                Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: child.gender.toLowerCase() == 'male'
                          ? [Colors.blue.shade300, Colors.blue.shade600]
                          : [Colors.pink.shade300, Colors.pink.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: (child.gender.toLowerCase() == 'male' 
                            ? Colors.blue 
                            : Colors.pink).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    child.gender.toLowerCase() == 'male' ? Icons.boy : Icons.girl,
                    size: 42,
                    color: AppColors.whiteColor,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.04),

                // Child Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        child.childName,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.006),
                      Row(
                        children: [
                          const Icon(
                            Icons.cake_outlined,
                            size: 16,
                            color: AppColors.textSecondaryColor,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                          Text(
                            '${child.getAge()} years old',
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.035,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.004),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 16,
                            color: AppColors.textSecondaryColor,
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.015),
                          Text(
                            child.getFormattedDate(),
                            style: GoogleFonts.poppins(
                              fontSize: MediaQuery.of(context).size.width * 0.032,
                              color: AppColors.textSecondaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Action Buttons
                Column(
                  children: [
                    IconButton(
                      onPressed: () => Get.toNamed(
                        AppRoutes.editChild,
                        arguments: child,
                      ),
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppColors.primaryColor,
                        size: 22,
                      ),
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      onPressed: () => _showDeleteDialog(context, controller, child),
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColors.errorColor,
                        size: 22,
                      ),
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ChildController controller) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor.withOpacity(0.1),
                      AppColors.secondaryColor.withOpacity(0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.child_care_rounded,
                  size: 85,
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'No children found'
                    : 'No Children Added Yet',
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.052,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text(
                controller.searchController.text.isNotEmpty
                    ? 'Try searching with a different name'
                    : 'Start by adding your first child profile\nto begin tracking their development',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, ChildController controller, ChildData child) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.errorColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.errorColor,
                  size: 45,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              Text(
                'Delete Child Profile',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.015),
              Text(
                'Are you sure you want to delete ${child.childName}\'s profile?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.038,
                  color: AppColors.textSecondaryColor,
                  height: 1.4,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                'This action cannot be undone.',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.034,
                  color: AppColors.errorColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.015,
                        ),
                        side: BorderSide(color: AppColors.greyColor.withOpacity(0.5)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                          color: AppColors.textSecondaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                  Expanded(
                    child: Obx(() => ElevatedButton(
                          onPressed: controller.isDeleting.value
                              ? null
                              : () => controller.deleteChild(child.childId),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.errorColor,
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).size.height * 0.015,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: controller.isDeleting.value
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.whiteColor,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Delete',
                                  style: GoogleFonts.poppins(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}