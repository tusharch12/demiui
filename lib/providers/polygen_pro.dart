import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final polygonProvider =
    StateNotifierProvider<PolygonNotifier, Set<Polygon>>((ref) {
  return PolygonNotifier();
});

class PolygonNotifier extends StateNotifier<Set<Polygon>> {
  PolygonNotifier() : super({});

  void addPolygon(List<LatLng> boundaryPoints) {
    List<LatLng> newList = boundaryPoints.sublist(0, 4);
    final polygon = Polygon(
      polygonId: PolygonId(boundaryPoints.toString()),
      points: newList, // House boundary points
      fillColor: Colors.lightGreen, 
      strokeColor: const Color.fromARGB(255, 183, 240, 117),
      strokeWidth: 1,
    );

    state = {polygon};
  }
}
