// lib/view/expert/location/flutter_map_view_widget.dart
//
// Separated widget so flutter_map imports are isolated.
// Used by both map_picker_screen.dart and the in-app view.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:speechspectrum/constants/app_colors.dart';

/// Read-only map that shows a pin at [center] with label [label].
class FlutterMapViewWidget extends StatefulWidget {
  final LatLng center;
  final String label;
  final bool interactive;

  const FlutterMapViewWidget({
    super.key,
    required this.center,
    required this.label,
    this.interactive = false,
  });

  @override
  State<FlutterMapViewWidget> createState() => _FlutterMapViewWidgetState();
}

class _FlutterMapViewWidgetState extends State<FlutterMapViewWidget> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: widget.center,
        initialZoom: 15.0,
        interactionOptions: InteractionOptions(
          flags: widget.interactive
              ? InteractiveFlag.all
              : InteractiveFlag.pinchZoom | InteractiveFlag.doubleTapZoom,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.speechspectrum.app',
          maxZoom: 19,
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: widget.center,
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