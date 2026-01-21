// lib/models/child_model.dart
import 'package:intl/intl.dart';

class ChildModel {
  final String message;
  final ChildData? data;
  final bool status;

  ChildModel({
    required this.message,
    this.data,
    required this.status,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      message: json['message'] ?? '',
      data: json['data'] != null ? ChildData.fromJson(json['data']) : null,
      status: json['status'] ?? false,
    );
  }
}

class ChildrenListModel {
  final String message;
  final List<ChildData> data;
  final bool status;

  ChildrenListModel({
    required this.message,
    required this.data,
    required this.status,
  });

  factory ChildrenListModel.fromJson(Map<String, dynamic> json) {
    return ChildrenListModel(
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((child) => ChildData.fromJson(child))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }
}

class ChildData {
  final String childId;
  final String parentUserId;
  final String childName;
  final String dateOfBirth;
  final String gender;
  final String createdAt;

  ChildData({
    required this.childId,
    required this.parentUserId,
    required this.childName,
    required this.dateOfBirth,
    required this.gender,
    required this.createdAt,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      childId: json['child_id'] ?? '',
      parentUserId: json['parent_user_id'] ?? '',
      childName: json['child_name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'parent_user_id': parentUserId,
      'child_name': childName,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'created_at': createdAt,
    };
  }

  // Helper method to get age
  int getAge() {
    try {
      final birthDate = DateTime.parse(dateOfBirth);
      final today = DateTime.now();
      int age = today.year - birthDate.year;
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  // Helper method to get formatted date
  String getFormattedDate() {
    try {
      final date = DateTime.parse(dateOfBirth);
      return DateFormat('MMM dd, yyyy').format(date);
    } catch (e) {
      return dateOfBirth;
    }
  }

  // Helper method to get gender display text
  String getGenderDisplay() {
    return gender.substring(0, 1).toUpperCase() + gender.substring(1);
  }
}

class DeleteChildResponse {
  final String message;
  final bool status;

  DeleteChildResponse({
    required this.message,
    required this.status,
  });

  factory DeleteChildResponse.fromJson(Map<String, dynamic> json) {
    return DeleteChildResponse(
      message: json['message'] ?? '',
      status: json['status'] ?? false,
    );
  }
}