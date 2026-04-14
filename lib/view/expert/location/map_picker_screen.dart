// lib/view/expert/location/map_picker_screen.dart
//
// Uses: flutter_map + latlong2 (no Google API key required)
// pubspec.yaml dependencies to add:
//   flutter_map: ^6.1.0
//   latlong2: ^0.9.0
//   geocoding: ^3.0.0   (for reverse geocoding picked point)
//
// AndroidManifest.xml — add inside <manifest>:
//   <uses-permission android:name="android.permission.INTERNET"/>
//
// iOS Info.plist — no special key needed for OSM tiles.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:speechspectrum/constants/app_colors.dart';
import 'package:speechspectrum/constants/custom_size.dart';

/// Result returned when user confirms a location pick
class MapPickResult {
  final LatLng latLng;
  final String address;
  final String city;
  final String mapsUrl;

  MapPickResult({
    required this.latLng,
    required this.address,
    required this.city,
    required this.mapsUrl,
  });
}

class MapPickerScreen extends StatefulWidget {
  /// Optional initial position; defaults to Lahore, Pakistan
  final LatLng? initialPosition;

  const MapPickerScreen({super.key, this.initialPosition});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late final MapController _mapController;

  // Default: Lahore, Pakistan
  static const LatLng _defaultCenter = LatLng(31.5204, 74.3587);

  LatLng? _pickedPoint;
  String _pickedAddress = '';
  String _pickedCity = '';
  bool _isGeocoding = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    if (widget.initialPosition != null) {
      _pickedPoint = widget.initialPosition;
      _reverseGeocode(widget.initialPosition!);
    }
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _reverseGeocode(LatLng point) async {
    setState(() => _isGeocoding = true);
    try {
      final placemarks = await placemarkFromCoordinates(
        point.latitude,
        point.longitude,
      );
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final streetNumber = p.subThoroughfare ?? '';
        final street = p.thoroughfare ?? '';
        final subLocality = p.subLocality ?? '';
        final locality = p.locality ?? '';
        final adminArea = p.administrativeArea ?? '';

        // Build address string
        final addressParts = <String>[];
        if (streetNumber.isNotEmpty) addressParts.add(streetNumber);
        if (street.isNotEmpty) addressParts.add(street);
        if (subLocality.isNotEmpty) addressParts.add(subLocality);

        _pickedAddress = addressParts.isNotEmpty
            ? addressParts.join(', ')
            : (locality.isNotEmpty ? locality : 'Selected Location');

        _pickedCity = locality.isNotEmpty
            ? locality
            : (adminArea.isNotEmpty ? adminArea : '');
      }
    } catch (e) {
      debugPrint('Reverse geocode error: $e');
      _pickedAddress = '${point.latitude.toStringAsFixed(5)}, ${point.longitude.toStringAsFixed(5)}';
      _pickedCity = '';
    } finally {
      if (mounted) setState(() => _isGeocoding = false);
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _pickedPoint = point;
      _pickedAddress = '';
      _pickedCity = '';
    });
    _reverseGeocode(point);
  }

  void _confirmPick() {
    if (_pickedPoint == null) return;
    final lat = _pickedPoint!.latitude;
    final lng = _pickedPoint!.longitude;

    // Build Google Maps URL in the required format
    final mapsUrl = 'https://maps.google.com/?q=$lat,$lng';

    Get.back(
      result: MapPickResult(
        latLng: _pickedPoint!,
        address: _pickedAddress,
        city: _pickedCity,
        mapsUrl: mapsUrl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = CustomSize();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ── Map ─────────────────────────────────────────────
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialPosition ?? _defaultCenter,
              initialZoom: 13.0,
              onTap: _onMapTap,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.speechspectrum.app',
                maxZoom: 19,
              ),
              if (_pickedPoint != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _pickedPoint!,
                      width: 60,
                      height: 70,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                          CustomPaint(
                            size: const Size(12, 8),
                            painter: _TrianglePainter(AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),

          // ── Top AppBar overlay ───────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: size.customWidth(context) * 0.04,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Pick Location on Map',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: size.customWidth(context) * 0.042,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Center crosshair hint ────────────────────────────
          if (_pickedPoint == null)
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.touch_app_rounded,
                            color: Colors.white, size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Tap anywhere to drop a pin',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // ── Bottom panel ─────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(28)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    size.customWidth(context) * 0.05,
                    20,
                    size.customWidth(context) * 0.05,
                    size.customHeight(context) * 0.025,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Handle
                      Center(
                        child: Container(
                          width: 40,
                          height: 4,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      if (_pickedPoint == null) ...[
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.location_searching_rounded,
                                  color: AppColors.primaryColor, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'No location selected',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimaryColor,
                                    ),
                                  ),
                                  Text(
                                    'Tap the map to drop a pin',
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      color: AppColors.textSecondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  AppColors.primaryColor.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 0,
                            ),
                            child: Text(
                              'Confirm Location',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ] else ...[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: _isGeocoding
                                  ? const SizedBox(
                                      width: 22,
                                      height: 22,
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.location_on_rounded,
                                      color: AppColors.primaryColor, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _isGeocoding
                                        ? 'Getting address...'
                                        : (_pickedAddress.isNotEmpty
                                            ? _pickedAddress
                                            : 'Location selected'),
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimaryColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (_pickedCity.isNotEmpty) ...[
                                    const SizedBox(height: 2),
                                    Text(
                                      _pickedCity,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: AppColors.textSecondaryColor,
                                      ),
                                    ),
                                  ],
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_pickedPoint!.latitude.toStringAsFixed(5)}, '
                                    '${_pickedPoint!.longitude.toStringAsFixed(5)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.textSecondaryColor
                                          .withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Tap to re-pick
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _pickedPoint = null;
                                  _pickedAddress = '';
                                  _pickedCity = '';
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.errorColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.close_rounded,
                                    color: AppColors.errorColor, size: 16),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _isGeocoding ? null : _confirmPick,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              disabledBackgroundColor:
                                  AppColors.primaryColor.withOpacity(0.5),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              elevation: 2,
                            ),
                            icon: const Icon(Icons.check_circle_outline_rounded,
                                size: 20),
                            label: Text(
                              'Use This Location',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Zoom controls ────────────────────────────────────
          Positioned(
            right: 16,
            bottom: 220,
            child: Column(
              children: [
                _ZoomButton(
                  icon: Icons.add,
                  onTap: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom + 1,
                    );
                  },
                ),
                const SizedBox(height: 8),
                _ZoomButton(
                  icon: Icons.remove,
                  onTap: () {
                    _mapController.move(
                      _mapController.camera.center,
                      _mapController.camera.zoom - 1,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ZoomButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 8,
                offset: const Offset(0, 2))
          ],
        ),
        child: Icon(icon, color: AppColors.textPrimaryColor, size: 22),
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = ui.Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_TrianglePainter old) => old.color != color;
}