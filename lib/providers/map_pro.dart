import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final markerProvider =
    StateNotifierProvider<MarkerNotifier, Set<Marker>>((ref) {
  return MarkerNotifier();
});

class MarkerNotifier extends StateNotifier<Set<Marker>> {
  MarkerNotifier() : super({});

  void addMarker(LatLng position, String title) async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(
          size: Size(30, 30),
        ),
        'assets/marker.png');
    final newMarker = Marker(
        markerId: MarkerId(position.toString()),
        position: position,
        infoWindow: InfoWindow(title: title),
        icon: customIcon);

    state = {newMarker};
  }
}
