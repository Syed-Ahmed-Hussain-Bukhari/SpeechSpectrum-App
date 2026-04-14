// lib/services/location_service.dart
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:speechspectrum/models/location_model.dart';
import 'package:speechspectrum/routes/app_urls.dart';
import 'package:speechspectrum/services/shared_preferences_service.dart';

class LocationService {
  final Dio _dio = Dio();

  Future<Options> _authHeaders() async {
    final token = await SharedPreferencesService.getAccessToken();
    if (token == null || token.isEmpty) {
      throw Exception('No authentication token found');
    }
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  // GET all locations (global list for selection)
  Future<LocationListModel> getAllLocations() async {
    try {
      debugPrint('📍 Fetching all locations');
      final opts = await _authHeaders();
      final response = await _dio.get(
        APIEndPoints.expertLocations,
        options: opts,
      );
      debugPrint('✅ All locations fetched');
      return LocationListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Get all locations error: ${e.message}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch locations');
    }
  }

  // GET expert's own locations
  Future<LocationListModel> getExpertLocations(String expertId) async {
    try {
      debugPrint('📍 Fetching expert locations for: $expertId');
      final opts = await _authHeaders();
      final response = await _dio.get(
        '${APIEndPoints.baseUrl}/api/experts/$expertId/locations',
        options: opts,
      );
      debugPrint('✅ Expert locations fetched: ${(response.data['data'] as List?)?.length ?? 0}');
      return LocationListModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Get expert locations error: ${e.message}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch your locations');
    }
  }

  // POST create location
  Future<LocationSingleModel> createLocation({
    required String label,
    required String address,
    required String city,
    required String mapsUrl,
    bool isActive = true,
  }) async {
    try {
      debugPrint('📍 Creating location: $label');
      final opts = await _authHeaders();
      final data = {
        'label': label,
        'address': address,
        'city': city,
        'maps_url': mapsUrl,
        'is_active': isActive,
      };
      final response = await _dio.post(
        APIEndPoints.expertLocations,
        data: data,
        options: opts,
      );
      debugPrint('✅ Location created');
      return LocationSingleModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Create location error: ${e.message}');
      debugPrint('❌ Response: ${e.response?.data}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to create location');
    }
  }

  // PUT update location
  Future<LocationSingleModel> updateLocation({
    required String locationId,
    String? label,
    String? address,
    String? city,
    String? mapsUrl,
    bool? isActive,
  }) async {
    try {
      debugPrint('📍 Updating location: $locationId');
      final opts = await _authHeaders();
      final data = <String, dynamic>{};
      if (label != null) data['label'] = label;
      if (address != null) data['address'] = address;
      if (city != null) data['city'] = city;
      if (mapsUrl != null) data['maps_url'] = mapsUrl;
      if (isActive != null) data['is_active'] = isActive;

      final response = await _dio.put(
        '${APIEndPoints.expertLocations}/$locationId',
        data: data,
        options: opts,
      );
      debugPrint('✅ Location updated');
      return LocationSingleModel.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint('❌ Update location error: ${e.message}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to update location');
    }
  }

  // DELETE location
  Future<bool> deleteLocation(String locationId) async {
    try {
      debugPrint('📍 Deleting location: $locationId');
      final opts = await _authHeaders();
      await _dio.delete(
        '${APIEndPoints.expertLocations}/$locationId',
        options: opts,
      );
      debugPrint('✅ Location deleted');
      return true;
    } on DioException catch (e) {
      debugPrint('❌ Delete location error: ${e.message}');
      if (e.response?.statusCode == 401) throw Exception('Unauthorized - Please login again');
      throw Exception(e.response?.data['message'] ?? 'Failed to delete location');
    }
  }
}