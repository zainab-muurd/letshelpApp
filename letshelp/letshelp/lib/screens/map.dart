// import 'dart:async';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:provider/provider.dart';

// import '../provider/auth-provider.dart';

// class MapScreen extends StatefulWidget {
//   static const routeName = "MapScreen";

//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   late Position position;

//   CameraPosition? initialCameraPosition;
//   String? API_KEY;

//   var lat;
//   var long;
//   Future getpermission() async {
//     bool services;
//     LocationPermission per;
//     services = await Geolocator.isLocationServiceEnabled();
//     print(services);
//     if (services == false) {
//       AwesomeDialog(context: context, body: const Text(""));
//     }
//     per = await Geolocator.checkPermission();
//     if (per == LocationPermission.denied) {
//       per = await Geolocator.requestPermission();
//     }

//     return per;
//   }

//   Future<Position?> getLatAndLong() async {
//     position = await Geolocator.getCurrentPosition();
//     lat = position.latitude;
//     long = position.longitude;
//     initialCameraPosition = CameraPosition(
//         target: LatLng(lat, long),
//         zoom: 17,
//         tilt: CAMERA_TILT,
//         bearing: CAMERA_BEARING);
//     setState(() {});
//     return null;
//   }

//   LatLng INITIAL_LOCATION = LatLng(34.7308000282197, 36.709456399999304);
//   final double CAMERA_ZOOM = 8;
//   final double CAMERA_TILT = 80;
//   final double CAMERA_BEARING = 30;

//   String zone = "المنطقة";
//   String? city;
//   String? country;
//   String? street;

//   //late GoogleMapController gmc = Goo;
//   Completer<GoogleMapController> controller = Completer();
//   BitmapDescriptor? sourceIcon;
//   Set<Marker> _markers = Set<Marker>();
//   //LatLng currentLocation = LatLng(23.692215072835225, 45.07613262634928);

//   @override
//   void initState() {
//     const String API_KEY = 'AIzaSyDCSt4ABayMg8O3n9Hvxb_vrs_1oUfWXuA';

//     super.initState();
//     getpermission().then((value) async {
//       await getLatAndLong().then((value) {
//         this.setInitialLocation();
//       });
//     });
//     //set up initial location

//     // set up marker icons
//     this.setSourceAndDestinationMarkerIcons();
//   }

//   void setSourceAndDestinationMarkerIcons() async {
//     sourceIcon = await BitmapDescriptor.defaultMarker;
//   }

//   void setInitialLocation() {
//     LatLng(INITIAL_LOCATION.latitude, INITIAL_LOCATION.longitude);
//   }

//   Future<String> getAddress(String latlng) async {
//     final url =
//         'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latlng&language=ar&key=$API_KEY';
//     final response = await http.get(Uri.parse(url));
//     // print(response.body);
//     final responseData = json.decode(response.body);
//     return responseData['results'][0]['formatted_address'];
//   }

//   _showPinsOnMap(LatLng tappedPoint) async {
//     List<Placemark> placemarks = await placemarkFromCoordinates(
//         tappedPoint.latitude, tappedPoint.longitude);
//     Map<String, String> locationInfo = {
//       "country": "${placemarks[0].country}",
//       "city": "${placemarks[0].subAdministrativeArea}",
//       "street": "${placemarks[0].street}",
//     };
//     var auth = Provider.of<Auth>(context, listen: false);
//     auth.setLocationValues(locationInfo);
//     print(" talha  $locationInfo");

//     setState(() {
//       _markers = {};
//       _markers.add(
//         Marker(
//             markerId: MarkerId(tappedPoint.toString()),
//             position: tappedPoint,
//             icon: sourceIcon!),
//       );
//     });
//   }

//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: initialCameraPosition == null
//           ? const Center(child: CircularProgressIndicator())
//           : Center(
//               child: SizedBox(
//                 height: height * 0.8,
//                 child: Stack(children: [
//                   GoogleMap(
//                     initialCameraPosition: initialCameraPosition!,
//                     myLocationButtonEnabled: true,
//                     compassEnabled: false,
//                     tiltGesturesEnabled: false,
//                     markers: Set.from(_markers),
//                     onTap: _showPinsOnMap,
//                     mapType: MapType.normal,
//                     onMapCreated: (GoogleMapController controller) {
//                       controller = controller;
//                     },
//                   ),
//                 ]),
//               ),
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:letshelp/provider/auth_provider.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';

import '../provider/map_provider.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Consumer<MapProvider>(
          builder: (context, mapProvider, _) => Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
                floatingActionButton: FloatingActionButton(
                  elevation: 10,
                  backgroundColor: kTeal400,
                  child: Text("تأكيد "),
                  onPressed: () async {
                    if (Provider.of<MapProvider>(context, listen: false).data !=
                            null &&
                        Provider.of<MapProvider>(context, listen: false)
                            .data
                            .isNotEmpty) {
                      Provider.of<Auth>(context, listen: false)
                              .countryName
                              .text =
                          Provider.of<MapProvider>(context, listen: false)
                              .data['country']!;
                      Provider.of<Auth>(context, listen: false).cityName.text =
                          Provider.of<MapProvider>(context, listen: false)
                              .data['city']!;
                      Provider.of<Auth>(context, listen: false)
                              .streetName
                              .text =
                          Provider.of<MapProvider>(context, listen: false)
                                  .data['street'] ??
                              "الرجاء التحديد بشكل يديوي ";
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: kTeal400,
                            content: Container(
                              child: Text(
                                " تم بنجاح تحديد الموقع ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            backgroundColor: Colors.redAccent,
                            content: Padding(
                              padding: EdgeInsets.all(10),
                              child: Container(
                                child: Text(
                                  " حدث خطأ اثناء تحديد الموقع    ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )),
                      );
                    }

                    Navigator.pop(context);
                  },
                ),
                body: mapProvider.kGooglePlex != null &&
                        mapProvider.startMarker != null
                    ? Stack(
                        children: [
                          GoogleMap(
                            zoomControlsEnabled: false,
                            onCameraMove: (position) async {
                              mapProvider.onCameraMove(position.target);
                            },
                            markers: mapProvider.myMarker!,
                            onTap: (position) {
                              mapProvider.onCameraMove(position);
                            },
                            mapType: MapType.normal,
                            initialCameraPosition: mapProvider.kGooglePlex!,
                            onMapCreated:
                                (GoogleMapController controller) async {
                              mapProvider.gmc = controller;
                              mapProvider.myMarker!
                                  .add(mapProvider.startMarker!);
                            },
                          ),
                        ],
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
          ),
        ),
      ),
    );
  }
}
