import 'dart:convert';

import 'package:demiui/providers/map_pro.dart';
import 'package:demiui/providers/polygen_pro.dart';
import 'package:demiui/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  GoogleMapController? _mapController;
  Future<void> _setMapStyle(GoogleMapController controller) async {
    String style = await rootBundle.loadString('assets/my_style.json');
    controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    final markers = ref.watch(markerProvider);
    final polygons = ref.watch(polygonProvider);
    const CameraPosition initialPosition = CameraPosition(
      target: LatLng(26.866483, 75.756339), // Initial position
      zoom: 17.0,
    );
    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: Stack(
        children: [
          Container(
            height: h * 0.4,
            child: GoogleMap(
              initialCameraPosition: initialPosition,
              mapType: MapType.normal,
              markers: markers,
              polygons: polygons, // Use markers from provider
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
                _setMapStyle(controller);
                ref
                    .read(markerProvider.notifier)
                    .addMarker(const LatLng(26.866483, 75.756339), "hello");
              },
              onTap: (LatLng position) async {
                List<LatLng> boundaryPoints =
                    await fetchHouseBoundary(position);
                if (boundaryPoints.isNotEmpty && _mapController != null) {
                  ref.read(polygonProvider.notifier).addPolygon(boundaryPoints);
                  showModalBottomSheet(
                    isDismissible: false,
                    barrierColor: Colors.transparent,
                    isScrollControlled: false,
                    enableDrag: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return _inviteCard(context, h, w);
                    },
                  );
                }
              },
            ),
          ),
          appbar(h, w),
          const Align(
            alignment: Alignment.bottomCenter,
            child: BottomsheetContainer(),
          ),
        ],
      ),
    );
  }

  Widget appbar(h, w) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: h * 0.1, horizontal: w * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              child: const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.person_2_outlined,
              color: Colors.white,
            ),
          )),
          Container(
            height: h * 0.05,
            width: w * 0.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Color(0xFF111111),
            ),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    width: 0.11 * w,
                    height: 0.05 * h,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/img2.jpg',
                        fit: BoxFit.cover,
                      ),
                    )),
                const SizedBox(
                  width: 15,
                ),
                const Text(
                  '100 Martinique Ave',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
          Container(
              child: const CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(
              Icons.message_outlined,
              color: Colors.white,
            ),
          )),
        ],
      ),
    );
  }

  Widget _inviteCard(context, h, w) {
    return Container(
      margin: EdgeInsets.all(h * 0.04),
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
      decoration: BoxDecoration(
        color: Colors.black, // Card background color
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Invite & Earn Text
          Row(
            children: [
              const Text(
                'Invite & Earn',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70),
                onPressed: () {
                  ref.read(polygonProvider.notifier).addPolygon(
                      [LatLng(0, 0), LatLng(0, 0), LatLng(0, 0), LatLng(0, 0)]);
                  Navigator.pop(context);
                },
              )
            ],
          ),
          // const SizedBox(height: 10),

          const Text(
            'Invite your neighbor and you both receive \$10 when they claim their address.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white60,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          GestureDetector(
            onTap: () {},
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: Colors.white,
                ),
                height: h * 0.05,
                width: double.infinity,
                child: Center(child: const Text('Send invite'))),
          ),
        ],
      ),
    );
  }
}

Future<List<LatLng>> fetchHouseBoundary(LatLng position) async {
  final url =
      'https://overpass-api.de/api/interpreter?data=[out:json];way["building"](around:50,${position.latitude},${position.longitude});out geom;';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List<LatLng> boundaryPoints = [];

    // Parse the building coordinates
    for (var element in data['elements']) {
      if (element['geometry'] != null) {
        for (var geom in element['geometry']) {
          boundaryPoints.add(LatLng(geom['lat'], geom['lon']));
        }
      }
    }

    return boundaryPoints;
  } else {
    print('Failed to load boundary data.');
    return [];
  }
}
