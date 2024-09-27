import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

final polygonProvider =
    StateNotifierProvider<PolygonNotifier, List<Polygon>>((ref) {
  return PolygonNotifier();
});


class PolygonNotifier extends StateNotifier<List<Polygon>> {
  PolygonNotifier() : super([]);

  void addPolygon(dynamic data) {
    if(data.isEmpty){
      state =  [ Polygon(
            points: [LatLng(0,0)],
            color: Colors.lightGreen,
            borderStrokeWidth: 2.0,
            borderColor: Colors.lightGreen,
          )];
          return ;
    }


    if (data['elements'] == null || data['elements'].isEmpty) {
      print('No building found at this location.');

      return;
    }

    List<Polygon> newPolygons = [];

    for (var element in data['elements']) {
      if ((element['type'] == 'way' || element['type'] == 'relation') &&
          element['geometry'] != null) {
        List<LatLng> points = [];

        for (var node in element['geometry']) {
          points.add(LatLng(node['lat'], node['lon']));
        }

        newPolygons.add(
          Polygon(
            points: points,
            color: Colors.lightGreen,
            borderStrokeWidth: 2.0,
            borderColor: Colors.lightGreen,
          ),
        );
        break;
  }
}

   state = newPolygons;
  }}
