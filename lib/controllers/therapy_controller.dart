// import 'package:get/get.dart';

// // ─── Model ─────────────────────────────────────────────────────────────────────

// class TherapyExercise {
//   final String id;
//   final String title;
//   final String videoUrl; // YouTube video ID only
//   final String thumbnail;

//   const TherapyExercise({
//     required this.id,
//     required this.title,
//     required this.videoUrl,
//     required this.thumbnail,
//   });
// }

// // ─── Controller ────────────────────────────────────────────────────────────────

// class TherapyController extends GetxController {
//   // Currently selected exercise to play
//   final Rx<TherapyExercise?> currentExercise = Rx<TherapyExercise?>(null);

//   /// Call before navigating to VideoPlayerScreen
//   void openVideo(TherapyExercise exercise) {
//     currentExercise.value = exercise;
//   }

//   // ── Exercise Data ────────────────────────────────────────────────────────────

//   static const List<TherapyExercise> exercises = [
//     TherapyExercise(
//       id: '1',
//       title: 'First Words & Songs',
//       videoUrl: 'nXzvYnkXQNI',
//       thumbnail: 'https://img.youtube.com/vi/nXzvYnkXQNI/0.jpg',
//     ),
//     TherapyExercise(
//       id: '2',
//       title: 'Brain & Finger Warmup',
//       videoUrl: '4o1iRDFm8Ww',
//       thumbnail: 'https://img.youtube.com/vi/4o1iRDFm8Ww/mqdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '3',
//       title: 'Gesture Development',
//       videoUrl: 'pTLtcno5_cY',
//       thumbnail: 'https://img.youtube.com/vi/pTLtcno5_cY/0.jpg',
//     ),
//     TherapyExercise(
//       id: '4',
//       title: 'Simple Greeting Routine',
//       videoUrl: 'fN1Cyr0ZK9M',
//       thumbnail: 'https://img.youtube.com/vi/fN1Cyr0ZK9M/maxresdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '5',
//       title: 'Articulate Clearer Sounds',
//       videoUrl: 'R_fxJMHZ8ic',
//       thumbnail: 'https://img.youtube.com/vi/R_fxJMHZ8ic/mqdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '6',
//       title: 'Eye Contact Game',
//       videoUrl: '0hAF2FGdNwQ',
//       thumbnail: 'https://img.youtube.com/vi/0hAF2FGdNwQ/0.jpg',
//     ),
//     TherapyExercise(
//       id: '7',
//       title: 'Object Naming: Toy Box',
//       videoUrl: '37qPEWQMQa4',
//       thumbnail: 'https://img.youtube.com/vi/37qPEWQMQa4/0.jpg',
//     ),
//     TherapyExercise(
//       id: '8',
//       title: 'Focus & Attention Drill',
//       videoUrl: '5he1sCixSLM',
//       thumbnail: 'https://img.youtube.com/vi/5he1sCixSLM/mqdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '9',
//       title: 'Simple Body Parts',
//       videoUrl: 'SUt8q0EKbms',
//       thumbnail: 'https://img.youtube.com/vi/SUt8q0EKbms/maxresdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '10',
//       title: 'Alphabet Puzzle Solve',
//       videoUrl: 'D7Bg0KS1mz8',
//       thumbnail: 'https://img.youtube.com/vi/D7Bg0KS1mz8/maxresdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '11',
//       title: 'Action Verbs & Songs',
//       videoUrl: 'pSGVb60-BSw',
//       thumbnail: 'https://img.youtube.com/vi/pSGVb60-BSw/maxresdefault.jpg',
//     ),
//     TherapyExercise(
//       id: '12',
//       title: 'Interactive Animal Play',
//       videoUrl: '4Talws29mys',
//       thumbnail: 'https://img.youtube.com/vi/4Talws29mys/maxresdefault.jpg',
//     ),
//   ];
// }


import 'package:get/get.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// ─── Model ─────────────────────────────────────────────────────────────────────

class TherapyExercise {
  final String id;
  final String title;
  final String videoUrl; // YouTube video ID only
  final String thumbnail;

  const TherapyExercise({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnail,
  });
}

// ─── Controller ────────────────────────────────────────────────────────────────

class TherapyController extends GetxController {
  final Rx<TherapyExercise?> currentExercise = Rx<TherapyExercise?>(null);
  YoutubePlayerController? ytController;

  /// Call before navigating to VideoPlayerScreen
  void openVideo(TherapyExercise exercise) {
    currentExercise.value = exercise;
    ytController?.close();
    ytController = YoutubePlayerController.fromVideoId(
      videoId: exercise.videoUrl,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        mute: false,
        playsInline: false,
      ),
    );
  }

  /// Switch video without leaving player screen
  void switchVideo(TherapyExercise exercise) {
    currentExercise.value = exercise;
    ytController?.loadVideo(exercise.videoUrl);
  }

  @override
  void onClose() {
    ytController?.close();
    super.onClose();
  }

  // ── Exercise Data ─────────────────────────────────────────────────────────────

  static const List<TherapyExercise> exercises = [
    TherapyExercise(
      id: '1',
      title: 'First Words & Songs',
      videoUrl: 'nXzvYnkXQNI',
      thumbnail: 'https://img.youtube.com/vi/nXzvYnkXQNI/0.jpg',
    ),
    TherapyExercise(
      id: '2',
      title: 'Brain & Finger Warmup',
      videoUrl: '4o1iRDFm8Ww',
      thumbnail: 'https://img.youtube.com/vi/4o1iRDFm8Ww/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '3',
      title: 'Gesture Development',
      videoUrl: 'pTLtcno5_cY',
      thumbnail: 'https://img.youtube.com/vi/pTLtcno5_cY/0.jpg',
    ),
    TherapyExercise(
      id: '4',
      title: 'Simple Greeting Routine',
      videoUrl: 'fN1Cyr0ZK9M',
      thumbnail: 'https://img.youtube.com/vi/fN1Cyr0ZK9M/maxresdefault.jpg',
    ),
    TherapyExercise(
      id: '5',
      title: 'Articulate Clearer Sounds',
      videoUrl: 'R_fxJMHZ8ic',
      thumbnail: 'https://img.youtube.com/vi/R_fxJMHZ8ic/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '6',
      title: 'Eye Contact Game',
      videoUrl: '0hAF2FGdNwQ',
      thumbnail: 'https://img.youtube.com/vi/0hAF2FGdNwQ/0.jpg',
    ),
    TherapyExercise(
      id: '7',
      title: 'Object Naming: Toy Box',
      videoUrl: '37qPEWQMQa4',
      thumbnail: 'https://img.youtube.com/vi/37qPEWQMQa4/0.jpg',
    ),
    TherapyExercise(
      id: '8',
      title: 'Focus & Attention Drill',
      videoUrl: '5he1sCixSLM',
      thumbnail: 'https://img.youtube.com/vi/5he1sCixSLM/mqdefault.jpg',
    ),
    TherapyExercise(
      id: '9',
      title: 'Simple Body Parts',
      videoUrl: 'SUt8q0EKbms',
      thumbnail: 'https://img.youtube.com/vi/SUt8q0EKbms/maxresdefault.jpg',
    ),
    TherapyExercise(
      id: '10',
      title: 'Alphabet Puzzle Solve',
      videoUrl: 'D7Bg0KS1mz8',
      thumbnail: 'https://img.youtube.com/vi/D7Bg0KS1mz8/maxresdefault.jpg',
    ),
    TherapyExercise(
      id: '11',
      title: 'Action Verbs & Songs',
      videoUrl: 'pSGVb60-BSw',
      thumbnail: 'https://img.youtube.com/vi/pSGVb60-BSw/maxresdefault.jpg',
    ),
    TherapyExercise(
      id: '12',
      title: 'Interactive Animal Play',
      videoUrl: '4Talws29mys',
      thumbnail: 'https://img.youtube.com/vi/4Talws29mys/maxresdefault.jpg',
    ),
  ];
}