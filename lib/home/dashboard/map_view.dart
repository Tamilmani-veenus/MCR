import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mcr/home/dashboard/title_providers.dart';
import '../../controller/site_location_controller.dart';
import 'app_bar.dart';
import 'button_widget.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SetMapView extends StatefulWidget {
  final String? latitude;
  final String? longitude;
  final String? ProjectId;


  const SetMapView({super.key, this.latitude, this.longitude, this.ProjectId});

  @override
  State<SetMapView> createState() => _SetMapViewState();
}

class _SetMapViewState extends State<SetMapView> {
  SiteLocationController siteLocationController = Get.put(SiteLocationController());
  // List<Marker> markers = [];
  // List<CircleMarker> circles = [];
  String? address;

  late LatLng _initialLatLng;
  GoogleMapController? _mapController;

  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  @override
  void initState() {
    // initValue();
    _initialLatLng = LatLng(
      double.parse(widget.latitude!),
      double.parse(widget.longitude!),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => initValue());
    super.initState();
  }

  @override

  // Widget build(BuildContext context) {
  //   ScreenUtil.init(context);
  //   return Scaffold(
  //     body: Stack(
  //       children: [
  //         FlutterMap(
  //           options: MapOptions(
  //             initialCenter: LatLng(double.parse(widget.latitude!),double.parse(widget.longitude!)),
  //             initialZoom: 18,
  //             cameraConstraint: CameraConstraint.contain(
  //               bounds: LatLngBounds(
  //                 const LatLng(-90, -180),
  //                 const LatLng(90, 180),
  //               ),
  //             ),
  //             onTap: handleTap,
  //           ),
  //           children: [
  //             openStreetMapTileLayer,
  //             CircleLayer(
  //               circles: circles,
  //             ),
  //             MarkerLayer(
  //               markers: markers,
  //             ),
  //           ],
  //         ),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           crossAxisAlignment: CrossAxisAlignment.end,
  //           children: [
  //             Padding(
  //               padding: EdgeInsets.only(bottom: 16.r,left: 16.r,right: 16.r),
  //               child: ButtonWidget(
  //                 maxHeight: 40.h,
  //                 color: Theme.of(context).primaryColor,
  //                 title: const Text(
  //                   "Submit",
  //                   style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 14.0,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 onTap: () async {
  //                   await siteLocationController.setSiteLocation(widget.ProjectId.toString());
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBarWidget(
          leading: Padding(
            padding: EdgeInsets.only(
              top: 16.r,
            ),
            child: Builder(
              builder: (context) {
                return InkWell(
                  radius: 24.0,
                  onTap: () {
                    Get.back();
                  },
                  child: const Center(
                    child: SizedBox(
                        height: 18,
                        child: Icon(Icons.arrow_back, color: Colors.white)),
                  ),
                );
              },
            ),
          ), title: '',
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialLatLng,
                zoom: 18,
              ),
              markers: _markers,
              circles: _circles,
              onMapCreated: (controller) {
                _mapController = controller;
              },
              onTap: handleTap,
              myLocationEnabled: false,
              zoomControlsEnabled: false,
            ),
            Positioned(
              bottom: 25,
              left: 16,
              right: 16,
              child: ButtonWidget(
                maxHeight: 40.h,
                color: Theme.of(context).primaryColor,
                title: const Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                onTap: () async {
                  await siteLocationController.setSiteLocation(widget.ProjectId.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  // Future<void> handleTap(TapPosition tapPosition, LatLng tapLocation) async {
  //   setState(() {
  //     markers.clear();
  //     circles.clear();
  //     markers.add(
  //       Marker(
  //         alignment: Alignment.topCenter,
  //         point: tapLocation,
  //         child: const Icon(
  //           Icons.location_on,
  //           size: 40.0,
  //           color: Colors.red,
  //         ),
  //       ),
  //     );
  //     circles.add(
  //       CircleMarker(
  //         point: tapLocation,
  //         radius: double.parse(siteLocationController.radius.text),
  //         useRadiusInMeter: true,
  //         color: Colors.blue.withOpacity(0.1),
  //         borderColor: Colors.blue,
  //         borderStrokeWidth: 0.5,
  //       ),
  //     );
  //   });
  //
  //   //old code-TM
  //
  //   // List<Placemark> placemarks = await placemarkFromCoordinates(tapLocation.latitude, tapLocation.longitude);
  //   // if (placemarks.isNotEmpty) {
  //   //   Placemark firstPlacemark = placemarks.first;
  //   //   address = '${firstPlacemark.street}, ${firstPlacemark.locality}, '
  //   //       '${firstPlacemark.postalCode}, ${firstPlacemark.country}';
  //   //   Fluttertoast.showToast(msg:'Tapped Location Address : $address');
  //   // }
  //   //
  //   // if (kDebugMode) {
  //   //   print('Tapped location: Latitude: ${tapLocation.latitude}, Longitude: ${tapLocation.longitude}');
  //   //   print('Address: $address');
  //   //   siteLocationController.latitude = "${tapLocation.latitude}";
  //   //   siteLocationController.longitude = "${tapLocation.longitude}";
  //   //   siteLocationController.punchInAddress = address;
  //   // }
  //
  //   final url = Uri.parse(
  //       'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${tapLocation.latitude}&lon=${tapLocation.longitude}');
  //
  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'User-Agent': 'FlutterApp (your_email@example.com)', // Replace with your email or app name
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final displayName = data['display_name'] ?? 'No address found';
  //     final addressData = data['address'] ?? {};
  //
  //     // You can also use specific fields if you want
  //     String formattedAddress = displayName;
  //
  //     Fluttertoast.showToast(msg: 'Tapped Location Address: $formattedAddress');
  //
  //     if (kDebugMode) {
  //       print('Tapped location: Latitude: ${tapLocation.latitude}, Longitude: ${tapLocation.longitude}');
  //       print('Address JSON: ${data['address']}');
  //       print('Full Address: $formattedAddress');
  //     }
  //
  //     siteLocationController.latitude = "${tapLocation.latitude}";
  //     siteLocationController.longitude = "${tapLocation.longitude}";
  //     siteLocationController.punchInAddress = formattedAddress;
  //
  //   } else {
  //     // Fluttertoast.showToast(msg: 'Failed to get address from OSM');
  //   }
  // }

  Future<void> handleTap(LatLng tapLocation) async {
    setState(() {
      _markers.clear();
      _circles.clear();

      _markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: tapLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );

      _circles.add(
        Circle(
          circleId: const CircleId('selected_radius'),
          center: tapLocation,
          radius: double.parse(siteLocationController.radius.text),
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withOpacity(0.1),
          strokeWidth: 1,
        ),
      );
    });

    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=jsonv2&lat=${tapLocation.latitude}&lon=${tapLocation.longitude}');

    final response = await http.get(
      url,
      headers: {
        'User-Agent': 'FlutterApp (https://skconstructions.in/contact)', // Replace with your email or app name
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final displayName = data['display_name'] ?? 'No address found';
      final addressData = data['address'] ?? {};

      // You can also use specific fields if you want
      String formattedAddress = displayName;

      Fluttertoast.showToast(msg: 'Tapped Location Address: $formattedAddress');

      if (kDebugMode) {
        print('Tapped location: Latitude: ${tapLocation.latitude}, Longitude: ${tapLocation.longitude}');
        print('Address JSON: ${data['address']}');
        print('Full Address: $formattedAddress');
      }

      siteLocationController.latitude = "${tapLocation.latitude}";
      siteLocationController.longitude = "${tapLocation.longitude}";
      siteLocationController.punchInAddress = formattedAddress;

    } else {
      // Fluttertoast.showToast(msg: 'Failed to get address from OSM');
    }
  }



  // void initValue() {
  //   setState(() {
  //     markers.clear();
  //     circles.clear();
  //     markers.add(
  //       Marker(
  //         alignment: Alignment.topCenter,
  //         point: LatLng(double.parse(widget.latitude!),double.parse(widget.longitude!)),
  //         child: const Icon(
  //           Icons.location_on,
  //           size: 40.0,
  //           color: Colors.red,
  //         ),
  //       ),
  //     );
  //     circles.add(
  //       CircleMarker(
  //         point: LatLng(double.parse(widget.latitude!),double.parse(widget.longitude!)),
  //         radius: double.parse(siteLocationController.radius.text),
  //         useRadiusInMeter: true,
  //         color: Colors.blue.withOpacity(0.1),
  //         borderColor: Colors.blue,
  //         borderStrokeWidth: 0.5,
  //       ),
  //     );
  //   });
  // }

  void initValue() {
    _markers.add(
      Marker(
        markerId: const MarkerId('initial_marker'),
        position: _initialLatLng,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    );

    _circles.add(
      Circle(
        circleId: const CircleId('initial_circle'),
        center: _initialLatLng,
        radius: double.parse(siteLocationController.radius.text),
        strokeColor: Colors.blue,
        fillColor: Colors.blue.withOpacity(0.1),
        strokeWidth: 1,
      ),
    );

    setState(() {});
  }

}
