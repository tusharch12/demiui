import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

Future queryBuildingData(LatLng latlng) async {
    final overpassUrl = 'https://overpass-api.de/api/interpreter';

    final query = '''
    [out:json];
    (
      way["building"](around:5,${latlng.latitude},${latlng.longitude});
      relation["building"](around:5,${latlng.latitude},${latlng.longitude});
    );
    out geom;
    ''';

    try {
      final response =
          await http.post(Uri.parse(overpassUrl), body: {'data': query});

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        print('Error fetching building data: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Exception: $e');
      return [];
    }
  }