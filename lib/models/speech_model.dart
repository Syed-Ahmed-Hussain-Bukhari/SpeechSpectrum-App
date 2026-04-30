// lib/models/speech_model.dart

class ParentSpeechModel {
  final String? id;
  final String? submissionId;
  final String? childName;
  final String? expertName;
  final String? audioUrl;
  final String? notes;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ParentSpeechModel({
    this.id,
    this.submissionId,
    this.childName,
    this.expertName,
    this.audioUrl,
    this.notes,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ParentSpeechModel.fromJson(Map<String, dynamic> json) {
    return ParentSpeechModel(
      id: json['_id']?.toString() ?? json['id']?.toString(),
      submissionId: json['submissionId']?.toString() ??
          json['submission_id']?.toString() ??
          json['submission']?.toString(),
      childName: json['childName']?.toString() ??
          json['child_name']?.toString() ??
          json['child']?['name']?.toString(),
      expertName: json['expertName']?.toString() ??
          json['expert_name']?.toString() ??
          json['expert']?['name']?.toString(),
      audioUrl: json['audioUrl']?.toString() ??
          json['audio_url']?.toString() ??
          json['recordingUrl']?.toString() ??
          json['recording_url']?.toString(),
      notes: json['notes']?.toString() ?? json['description']?.toString(),
      status: json['status']?.toString(),
      createdAt: json['createdAt']?.toString() ?? json['created_at']?.toString(),
      updatedAt: json['updatedAt']?.toString() ?? json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'submissionId': submissionId,
      'childName': childName,
      'expertName': expertName,
      'audioUrl': audioUrl,
      'notes': notes,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}