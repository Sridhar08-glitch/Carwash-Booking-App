import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../controllers/tracking_controller.dart';

class TrackingScreen extends ConsumerStatefulWidget {
  const TrackingScreen({super.key, required this.bookingId});
  final int bookingId;

  @override
  ConsumerState<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends ConsumerState<TrackingScreen> {
  GoogleMapController? _mapController;

  @override
  Widget build(BuildContext context) {
    final trackingState =
        ref.watch(trackingControllerProvider(widget.bookingId));
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    final hasLocation = trackingState.lat != null && trackingState.lng != null;
    final staffPos = hasLocation
        ? LatLng(trackingState.lat!, trackingState.lng!)
        : null;

    // Animate camera when position updates
    if (staffPos != null && _mapController != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(staffPos),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Tracking'),
        actions: [
          if (!trackingState.isConnected)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Icon(Icons.wifi_off, color: Colors.red),
            ),
        ],
      ),
      body: Stack(
        children: [
          // Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: staffPos ?? const LatLng(24.7136, 46.6753), // Riyadh
              zoom: 15,
            ),
            onMapCreated: (c) => _mapController = c,
            markers: staffPos != null
                ? {
                    Marker(
                      markerId: const MarkerId('staff'),
                      position: staffPos,
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueAzure),
                      infoWindow: const InfoWindow(title: 'Your washer'),
                    ),
                  }
                : {},
          ),

          // Bottom info panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Status pill
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _statusLabel(trackingState.bookingStatus),
                      style: tt.labelMedium
                          ?.copyWith(color: cs.onPrimaryContainer),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),

                  // ETA row
                  if (trackingState.etaMinutes != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer_outlined, color: cs.primary),
                        const SizedBox(width: 8),
                        Text(
                          'ETA: ${trackingState.etaMinutes} min',
                          style: tt.titleMedium?.copyWith(color: cs.primary),
                        ),
                      ],
                    )
                  else
                    Text(
                      hasLocation
                          ? 'Tracking your washer…'
                          : 'Waiting for location…',
                      style: tt.bodyMedium
                          ?.copyWith(color: cs.onSurfaceVariant),
                    ),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(String? status) => switch (status) {
        'accepted' => 'Washer accepted your job',
        'en_route' => 'Washer is on the way',
        'in_progress' => 'Wash in progress',
        'completed' => 'All done! 🎉',
        _ => 'Connecting…',
      };
}
