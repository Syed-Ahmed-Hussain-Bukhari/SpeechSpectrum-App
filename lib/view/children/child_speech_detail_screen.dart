// lib/view/children/child_speech_detail_screen.dart
//
// This is a thin wrapper — it receives { submissionId, childName } as arguments
// and delegates to the shared SpeechController (permanent singleton) to load
// the detail.  The UI is 100 % identical to SpeechDetailScreen so we simply
// redirect to that route after putting the submissionId where it expects it.
//
// We do NOT duplicate the full SpeechDetailScreen UI.  Instead we push the
// existing AppRoutes.speechDetail route with the submissionId string, which is
// exactly what that screen expects via Get.arguments.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speechspectrum/routes/app_routes.dart';

class ChildSpeechDetailScreen extends StatelessWidget {
  const ChildSpeechDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract arguments — can be Map or plain String
    final args = Get.arguments;
    late final String submissionId;

    if (args is Map<String, dynamic>) {
      submissionId = args['submissionId'] as String;
    } else {
      submissionId = args as String;
    }

    // Immediately redirect to the real detail screen with just the ID string,
    // which is exactly what SpeechDetailScreen expects.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Replace this route so Back from detail goes to child speech list
      Get.offNamed(AppRoutes.speechDetail, arguments: submissionId);
    });

    // Show a brief loading indicator while the redirect happens
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}