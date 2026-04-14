// lib/models/location_model.dart

class LocationListModel {
  final bool success;
  final List<LocationItem> data;

  LocationListModel({required this.success, required this.data});

  factory LocationListModel.fromJson(Map<String, dynamic> json) {
    return LocationListModel(
      success: json['success'] ?? false,
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => LocationItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class LocationSingleModel {
  final bool success;
  final LocationItem data;

  LocationSingleModel({required this.success, required this.data});

  factory LocationSingleModel.fromJson(Map<String, dynamic> json) {
    return LocationSingleModel(
      success: json['success'] ?? false,
      data: LocationItem.fromJson(json['data']),
    );
  }
}

class LocationItem {
  final String locationId;
  final String expertId;
  final String label;
  final String address;
  final String city;
  final String mapsUrl;
  final bool isActive;
  final String createdAt;

  LocationItem({
    required this.locationId,
    required this.expertId,
    required this.label,
    required this.address,
    required this.city,
    required this.mapsUrl,
    required this.isActive,
    required this.createdAt,
  });

  factory LocationItem.fromJson(Map<String, dynamic> json) {
    return LocationItem(
      locationId: json['location_id'] ?? '',
      expertId: json['expert_id'] ?? '',
      label: json['label'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      mapsUrl: json['maps_url'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'address': address,
      'city': city,
      'maps_url': mapsUrl,
      'is_active': isActive,
    };
  }

  LocationItem copyWith({
    String? label,
    String? address,
    String? city,
    String? mapsUrl,
    bool? isActive,
  }) {
    return LocationItem(
      locationId: locationId,
      expertId: expertId,
      label: label ?? this.label,
      address: address ?? this.address,
      city: city ?? this.city,
      mapsUrl: mapsUrl ?? this.mapsUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt,
    );
  }
}