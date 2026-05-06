import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  static const List<Map<String, String>> _faqs = [
    {
      'q': 'What is SpeechSpectrum?',
      'a':
          'SpeechSpectrum is an AI-powered mobile and web application that helps parents detect early signs of speech delays and Autism Spectrum Disorder (ASD) in children aged 1–10 years. It combines a structured questionnaire with voice/speech analysis to generate a risk assessment.',
    },
    {
      'q': 'Who is SpeechSpectrum designed for?',
      'a':
          'The app is designed primarily for parents and guardians of young children aged 1–10 years who want to monitor their child\'s speech and language development. Therapists and healthcare professionals can also use the platform through dedicated dashboards.',
    },
    {
      'q': 'Is SpeechSpectrum a medical diagnosis tool?',
      'a':
          'No. SpeechSpectrum is a screening tool, not a diagnostic tool. It provides a risk score to help identify children who may need further professional evaluation. Always consult a qualified healthcare professional or developmental specialist for a formal diagnosis.',
    },
    {
      'q': 'How does the questionnaire screening work?',
      'a':
          'The questionnaire is based on validated ASD screening checklists (such as Q-CHAT). You answer a set of structured questions about your child\'s behavior and communication patterns. A Random Forest machine learning model then analyzes your responses to calculate an ASD risk score.',
    },
    {
      'q': 'How does the speech/voice analysis work?',
      'a':
          'You record a short audio sample of your child speaking. The app extracts 49 acoustic features — including MFCCs, pitch, and prosody — from the recording. A Convolutional Neural Network (CNN) model then analyzes these features to identify patterns associated with ASD-related speech differences.',
    },
    {
      'q': 'How accurate is the screening?',
      'a':
          'The questionnaire model achieves around 91% accuracy on validated datasets, and the speech CNN model is trained on clinically relevant acoustic biomarkers. However, no automated screening tool is 100% accurate. Results should always be reviewed alongside professional medical opinion.',
    },
    {
      'q': 'What age range does the screening cover?',
      'a':
          'SpeechSpectrum supports screening for children aged 1–10 years. The questionnaire is calibrated for toddlers and early school-age children, which is the most critical window for early ASD detection and intervention.',
    },
    {
      'q': 'What are the early signs of ASD the app screens for?',
      'a':
          'The app screens for indicators such as limited vocabulary, reduced social interaction, unusual speech rhythm or intonation, lack of response to their name, delayed gestures, repetitive behaviors, and poor eye contact — all of which are validated early markers of ASD.',
    },
    {
      'q': 'How do I add my child\'s profile?',
      'a':
          'After logging in, go to the "My Children" section from your parent dashboard and tap "Add Child." Enter your child\'s name, date of birth, and other basic details. You can add multiple children and manage each profile separately.',
    },
    {
      'q': 'Can I track my child\'s screening history?',
      'a':
          'Yes. Both questionnaire assessment history and speech analysis history are saved in your account. You can revisit past results, compare progress over time, and download detailed screening reports from your dashboard.',
    },
    {
      'q': 'What does the risk score mean?',
      'a':
          'The risk score is a percentage or categorical indicator (e.g., Low / Moderate / High) that reflects the likelihood of ASD-related traits based on your child\'s responses and voice data. A higher score suggests a greater concern and a recommendation to consult a specialist.',
    },
    {
      'q': 'What should I do if the screening shows a high risk?',
      'a':
          'A high-risk result does not confirm a diagnosis. We recommend scheduling an appointment with a pediatric developmental specialist or speech-language pathologist. You can use the app\'s appointment booking feature to connect with professionals directly.',
    },
    {
      'q': 'Is my child\'s data private and secure?',
      'a':
          'Yes. All data — including questionnaire responses, audio recordings, and personal information — is encrypted in transit and at rest. We never sell or share your data with third parties without your explicit consent. You can request deletion of your data at any time.',
    },
    {
      'q': 'Does the app work offline?',
      'a':
          'Basic navigation is available offline, but screening features (questionnaire submission and speech analysis) require an internet connection to communicate with the AI models hosted on our cloud backend.',
    },
    {
      'q': 'What audio quality is needed for speech analysis?',
      'a':
          'For best results, record in a quiet room with minimal background noise, hold the device 15–30 cm from your child\'s mouth, and ensure the recording is at least 5–10 seconds long. Poor audio quality may reduce the accuracy of the speech model\'s predictions.',
    },
    {
      'q': 'Can a therapist or doctor view my child\'s results?',
      'a':
          'Yes. SpeechSpectrum has a therapist dashboard. You can share your child\'s screening reports with a registered therapist or doctor through the app\'s appointment and consultation system, enabling collaborative care.',
    },
    {
      'q': 'What is the difference between the questionnaire and speech screening?',
      'a':
          'The questionnaire captures behavioral and social indicators reported by the parent, while speech analysis captures objective acoustic features directly from the child\'s voice. Using both together provides a more comprehensive and reliable risk assessment than either method alone.',
    },
    {
      'q': 'Why is early screening important?',
      'a':
          'Research shows that early behavioral therapies and interventions for ASD — started during infancy or toddlerhood — lead to significantly greater improvements in social communication and cognitive functioning. Early detection opens the door to timely therapy during the most critical developmental window.',
    },
    {
      'q': 'How often should I screen my child?',
      'a':
          'There is no fixed interval, but developmental experts generally recommend screening during key milestones (12, 18, 24, and 36 months). If you notice new or worsening behavioral changes, you can run a screening at any time through the app.',
    },
    {
      'q': 'What should I do if I need more help understanding the results?',
      'a':
          'Each screening result comes with a detailed breakdown and educational guidance. If you still have questions, you can book a consultation with a therapist directly in the app, who can help you interpret the results and plan next steps.',
    },
  ];

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
          'FAQs',
          style: GoogleFonts.poppins(
            color: AppColors.textPrimaryColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header banner
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(size.customWidth(context) * 0.05),
            padding: EdgeInsets.symmetric(
              horizontal: size.customWidth(context) * 0.05,
              vertical: size.customHeight(context) * 0.025,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(Icons.quiz_outlined, color: AppColors.whiteColor, size: 36),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Frequently Asked Questions',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${_faqs.length} answers about SpeechSpectrum',
                        style: GoogleFonts.poppins(
                          color: AppColors.whiteColor.withOpacity(0.85),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // FAQ list
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: size.customWidth(context) * 0.05,
                right: size.customWidth(context) * 0.05,
                bottom: size.customHeight(context) * 0.04,
              ),
              itemCount: _faqs.length,
              separatorBuilder: (_, __) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                return _FAQCard(
                  question: _faqs[index]['q']!,
                  answer: _faqs[index]['a']!,
                  index: index + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FAQCard extends StatefulWidget {
  final String question;
  final String answer;
  final int index;

  const _FAQCard({
    required this.question,
    required this.answer,
    required this.index,
  });

  @override
  State<_FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<_FAQCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: _expanded
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (val) => setState(() => _expanded = val),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _expanded
                  ? AppColors.primaryColor
                  : AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '${widget.index}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _expanded
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
          ),
          title: Text(
            widget.question,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
          ),
          trailing: AnimatedRotation(
            turns: _expanded ? 0.5 : 0,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.primaryColor,
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.answer,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.textSecondaryColor,
                  height: 1.6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}