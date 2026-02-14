// // lib/view/expert/expert_linked_parents_screen.dart
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:speechspectrum/constants/app_colors.dart';
// import 'package:speechspectrum/constants/custom_size.dart';
// import 'package:speechspectrum/controllers/expert_consultation_controller.dart';

// class ExpertLinkedParentsScreen extends StatefulWidget {
//   const ExpertLinkedParentsScreen({super.key});

//   @override
//   State<ExpertLinkedParentsScreen> createState() => _ExpertLinkedParentsScreenState();
// }

// class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
//   late final ExpertConsultationController controller;

//   @override
//   void initState() {
//     super.initState();

//     // Get or create controller
//     if (Get.isRegistered<ExpertConsultationController>()) {
//       controller = Get.find<ExpertConsultationController>();
//     } else {
//       controller = Get.put(ExpertConsultationController());
//     }

//     // Fetch linked parents after build
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       controller.fetchLinkedParents();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final size = CustomSize();

//     return Scaffold(
//       backgroundColor: AppColors.lightGreyColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.whiteColor,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Linked Families',
//           style: GoogleFonts.poppins(
//             color: AppColors.textPrimaryColor,
//             fontSize: 18,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
//             onPressed: () => controller.fetchLinkedParents(),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircularProgressIndicator(
//                   color: AppColors.primaryColor,
//                   strokeWidth: 3,
//                 ),
//                 SizedBox(height: size.customHeight(context) * 0.02),
//                 Text(
//                   'Loading linked families...',
//                   style: GoogleFonts.poppins(
//                     color: AppColors.textSecondaryColor,
//                     fontSize: size.customWidth(context) * 0.035,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.linkedParents.isEmpty) {
//           return _buildEmptyState(context);
//         }

//         return ListView.builder(
//           padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//           itemCount: controller.linkedParents.length,
//           itemBuilder: (context, index) {
//             final linkedItem = controller.linkedParents[index];
//             return _buildLinkedParentCard(context, linkedItem);
//           },
//         );
//       }),
//     );
//   }

//   Widget _buildLinkedParentCard(BuildContext context, linkedItem) {
//     final size = CustomSize();

//     return Container(
//       margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
//       decoration: BoxDecoration(
//         color: AppColors.whiteColor,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.06),
//             blurRadius: 15,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.04),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 // Avatar/Icon
//                 Container(
//                   width: 70,
//                   height: 70,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         AppColors.accentColor.withOpacity(0.8),
//                         AppColors.accentColor,
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: const Icon(
//                     Icons.family_restroom_outlined,
//                     color: AppColors.whiteColor,
//                     size: 32,
//                   ),
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.04),

//                 // Info
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Parent ID',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.03,
//                           color: AppColors.textSecondaryColor,
//                         ),
//                       ),
//                       Text(
//                         linkedItem.parentUserId.substring(0, 12) + '...',
//                         style: GoogleFonts.poppins(
//                           fontSize: size.customWidth(context) * 0.038,
//                           fontWeight: FontWeight.w600,
//                           color: AppColors.textPrimaryColor,
//                         ),
//                       ),
//                       SizedBox(height: size.customHeight(context) * 0.004),
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.child_care_outlined,
//                             size: 14,
//                             color: AppColors.primaryColor,
//                           ),
//                           SizedBox(width: size.customWidth(context) * 0.015),
//                           Text(
//                             'Child: ${linkedItem.childId.substring(0, 8)}...',
//                             style: GoogleFonts.poppins(
//                               fontSize: size.customWidth(context) * 0.032,
//                               color: AppColors.primaryColor,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Linked Badge
//                 Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: AppColors.successColor.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Icon(
//                     Icons.link,
//                     color: AppColors.successColor,
//                     size: 20,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),
//             Divider(color: AppColors.greyColor.withOpacity(0.2)),
//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Linked Date
//             Row(
//               children: [
//                 Icon(
//                   Icons.calendar_today_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Text(
//                   'Linked since: ',
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//                 Text(
//                   linkedItem.getFormattedDate(),
//                   style: GoogleFonts.poppins(
//                     fontSize: size.customWidth(context) * 0.032,
//                     color: AppColors.textSecondaryColor,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.01),

//             // Link ID
//             Row(
//               children: [
//                 Icon(
//                   Icons.tag_outlined,
//                   size: 16,
//                   color: AppColors.textSecondaryColor,
//                 ),
//                 SizedBox(width: size.customWidth(context) * 0.02),
//                 Expanded(
//                   child: Text(
//                     'Link ID: ${linkedItem.linkId.substring(0, 12)}...',
//                     style: GoogleFonts.poppins(
//                       fontSize: size.customWidth(context) * 0.032,
//                       color: AppColors.textSecondaryColor,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: size.customHeight(context) * 0.015),

//             // Info Card
//             Container(
//               padding: EdgeInsets.all(size.customWidth(context) * 0.03),
//               decoration: BoxDecoration(
//                 color: AppColors.accentColor.withOpacity(0.05),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: AppColors.accentColor.withOpacity(0.2),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Icon(
//                     Icons.info_outline,
//                     size: 18,
//                     color: AppColors.accentColor,
//                   ),
//                   SizedBox(width: size.customWidth(context) * 0.02),
//                   Expanded(
//                     child: Text(
//                       'You can now access this family\'s records and provide consultation',
//                       style: GoogleFonts.poppins(
//                         fontSize: size.customWidth(context) * 0.032,
//                         color: AppColors.textPrimaryColor,
//                         height: 1.4,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildEmptyState(BuildContext context) {
//     final size = CustomSize();

//     return Center(
//       child: Padding(
//         padding: EdgeInsets.all(size.customWidth(context) * 0.08),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               width: 140,
//               height: 140,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     AppColors.primaryColor.withOpacity(0.1),
//                     AppColors.secondaryColor.withOpacity(0.1),
//                   ],
//                 ),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(
//                 Icons.link_off_outlined,
//                 size: 70,
//                 color: AppColors.primaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.03),
//             Text(
//               'No Linked Families',
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.052,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.textPrimaryColor,
//               ),
//             ),
//             SizedBox(height: size.customHeight(context) * 0.015),
//             Text(
//               'You don\'t have any linked families yet.\nApproved consultations will appear here.',
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: size.customWidth(context) * 0.038,
//                 color: AppColors.textSecondaryColor,
//                 height: 1.5,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// lib/view/expert/expert_linked_parents_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';
import 'package:speechspectrum/controllers/expert_consultation_controller.dart';

class ExpertLinkedParentsScreen extends StatefulWidget {
  const ExpertLinkedParentsScreen({super.key});

  @override
  State<ExpertLinkedParentsScreen> createState() =>
      _ExpertLinkedParentsScreenState();
}

class _ExpertLinkedParentsScreenState extends State<ExpertLinkedParentsScreen> {
  late final ExpertConsultationController controller;

  @override
  void initState() {
    super.initState();

    // Get or create controller
    if (Get.isRegistered<ExpertConsultationController>()) {
      controller = Get.find<ExpertConsultationController>();
    } else {
      controller = Get.put(ExpertConsultationController());
    }

    // Fetch linked parents after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchExpertLinkedParents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: AppColors.lightGreyColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Linked Families',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primaryColor),
            onPressed: () => controller.fetchExpertLinkedParents(),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 3,
                ),
                SizedBox(height: size.customHeight(context) * 0.02),
                Text(
                  'Loading linked families...',
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondaryColor,
                    fontSize: size.customWidth(context) * 0.035,
                  ),
                ),
              ],
            ),
          );
        }

        if (controller.linkedParents.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.builder(
          padding: EdgeInsets.all(size.customWidth(context) * 0.04),
          itemCount: controller.linkedParents.length,
          itemBuilder: (context, index) {
            final linkedParent = controller.linkedParents[index];
            return _buildLinkedParentCard(context, linkedParent);
          },
        );
      }),
    );
  }

  Widget _buildLinkedParentCard(BuildContext context, linkedParent) {
    final size = CustomSize();

    return Container(
      margin: EdgeInsets.only(bottom: size.customHeight(context) * 0.015),
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
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Child Avatar
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.accentColor.withOpacity(0.8),
                        AppColors.accentColor,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      linkedParent.children.getInitials(),
                      style: GoogleFonts.poppins(
                        color: AppColors.whiteColor,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.customWidth(context) * 0.04),

                // Child Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        linkedParent.children.childName,
                        style: GoogleFonts.poppins(
                          fontSize: size.customWidth(context) * 0.042,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.customHeight(context) * 0.004),
                      Row(
                        children: [
                          Icon(
                            Icons.family_restroom_outlined,
                            size: 14,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: size.customWidth(context) * 0.015),
                          Expanded(
                            child: Text(
                              'Linked Family',
                              style: GoogleFonts.poppins(
                                fontSize: size.customWidth(context) * 0.034,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Linked Badge
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.successColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.link,
                    color: AppColors.successColor,
                    size: 20,
                  ),
                ),
              ],
            ),

            SizedBox(height: size.customHeight(context) * 0.015),
            Divider(color: AppColors.greyColor.withOpacity(0.2)),
            SizedBox(height: size.customHeight(context) * 0.01),

            // Linked Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                ),
                SizedBox(width: size.customWidth(context) * 0.02),
                Text(
                  'Linked since: ',
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
                Text(
                  linkedParent.getFormattedDate(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.034,
                    color: AppColors.textPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Text(
                  linkedParent.getFormattedTime(),
                  style: GoogleFonts.poppins(
                    fontSize: size.customWidth(context) * 0.032,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),

            // SizedBox(height: size.customHeight(context) * 0.01),

            // // IDs Info (for reference)
            // Container(
            //   padding: EdgeInsets.all(size.customWidth(context) * 0.03),
            //   decoration: BoxDecoration(
            //     color: AppColors.lightGreyColor,
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Column(
            //     children: [
            //       _buildInfoRow(
            //         context,
            //         'Link ID',
            //         linkedParent.linkId,
            //         Icons.link_outlined,
            //       ),
            //       SizedBox(height: size.customHeight(context) * 0.008),
            //       _buildInfoRow(
            //         context,
            //         'Child ID',
            //         linkedParent.childId,
            //         Icons.child_care_outlined,
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, IconData icon) {
    final size = CustomSize();

    return Row(
      children: [
        Icon(
          icon,
          size: 14,
          color: AppColors.textSecondaryColor,
        ),
        SizedBox(width: size.customWidth(context) * 0.02),
        Text(
          '$label: ',
          style: GoogleFonts.poppins(
            fontSize: size.customWidth(context) * 0.032,
            color: AppColors.textSecondaryColor,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: size.customWidth(context) * 0.03,
              color: AppColors.textPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final size = CustomSize();

    return Center(
      child: Padding(
        padding: EdgeInsets.all(size.customWidth(context) * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 140,
              height: 140,
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
                Icons.link_off_outlined,
                size: 70,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.03),
            Text(
              'No Linked Families',
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.052,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: size.customHeight(context) * 0.015),
            Text(
              'You don\'t have any linked families yet.\nApproved consultations will appear here.',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: size.customWidth(context) * 0.038,
                color: AppColors.textSecondaryColor,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}