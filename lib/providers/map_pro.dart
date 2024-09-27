import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';


final markerProvider =
    StateNotifierProvider<MarkerNotifier, List<Marker>>((ref) {
  return MarkerNotifier();
});

class MarkerNotifier extends StateNotifier<List<Marker>> {
  MarkerNotifier() : super([]);

  void addMarker(LatLng position, String title) async {

    final newMarker = Marker(
      point: position,
      child: Image.asset('assets/marker.png')
      );

    state = [newMarker];
  }
}
