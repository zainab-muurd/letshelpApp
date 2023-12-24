import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class MapProvider with ChangeNotifier {
  CameraPosition? kGooglePlex;
  Marker? startMarker;
  LatLng? source;
  Set<Marker>? myMarker = {};
  GoogleMapController? gmc;
  String? sourceDetails;
  Map<String, String> data = {};

  Future<void> initState() async {
    await initValuesState();

    notifyListeners();
  }

  Future<void> initValuesState() async {
    myMarker!.clear();
    source = null;
    startMarker = null;
    await goToMyLocation();
  }

  Future<void> goToMyLocation() async {
    if (myMarker!.isNotEmpty) {
      myMarker!.clear();
    }

    final Position position;
    final LocationPermission pre = await Geolocator.checkPermission();
    if (pre == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    if (pre == LocationPermission.always ||
        pre == LocationPermission.whileInUse) {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      source = LatLng(position.altitude, position.longitude);

      startMarker = Marker(
        markerId: const MarkerId("1"),
        position: LatLng(position.latitude, position.longitude),
        onTap: () {},
      );

      kGooglePlex = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 2.55,
      );
      await onCameraMove(LatLng(position.latitude, position.longitude));
      // sourceDetails =
      //     await getAddress('${position.latitude},${position.longitude}');
      await _getAddress(position.latitude, position.longitude);
    }
    notifyListeners();
  }

  Future<void> onCameraMove(LatLng position) async {
    source = position;
    myMarker!.clear();
    startMarker = Marker(
      markerId: const MarkerId("1"),
      position: position,
    );
    myMarker!.add(startMarker!);
    // sourceDetails =
    //     await getAddress('${position.latitude},${position.longitude}');
    await _getAddress(position.latitude, position.longitude);

    notifyListeners();
  }

  Future<String> getAddress(String latlng) async {
    const String API_KEY = 'AIzaSyDCSt4ABayMg8O3n9Hvxb_vrs_1oUfWXuA';
    Map<String, String> data = {};

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latlng&language=ar&key=$API_KEY';
    final response = await http.get(Uri.parse(url));
    final responseData = json.decode(response.body);
    // var x = responseData['results'][0]['formatted_address'];
    print("results : ${responseData['results']}");

    for (var info in responseData['results'][0]['address_components']) {
      if (info['types'][0] == 'country') {
        data['country'] = info['long_name'];
        print("country : ${info['long_name']}");
      }
      if (info['types'][0].contains("administrative_area_level") &&
          data['city'] == null) {
        data['city'] = info['long_name'];
        print("city : ${info['long_name']}");
      }
      if (info['types'][0] == "route") {
        data['city'] = info['long_name'];
        print("street : ${info['long_name']}");
      }
    }
    if (data['street'] == null) {
      data['street'] = "الرجاء ادخال العنوان";
    }
    print("the data map are :   $data");

    return responseData['results'][0]['formatted_address'];
  }

  Future<void> _getAddress(double lat, double lang) async {
    data = {};
    var googleGeocoding =
        GoogleGeocoding("AIzaSyDCSt4ABayMg8O3n9Hvxb_vrs_1oUfWXuA");
    try {
      var result =
          await googleGeocoding.geocoding.getReverse(LatLon(lat, lang));
      for (var res in result!.results!) {
        for (var x in res.addressComponents!) {
          if (x.types![0] == 'route') {
            if (x.longName == "Unnamed Road") {
              data['street'] == "لا يوجد طريق";
            } else {
              print("the streeet is : ${x.longName}");
              data['street'] = x.longName!;
            }
          }

          if (x.types![0] == 'administrative_area_level_1') {
            print("${x.longName}${x.types}");
            data['city'] = x.longName!;
          }
          if (x.types![0] == 'country') {
            print("${x.longName}${x.types}");
            data['country'] = x.longName!;
          }
        }
        print("the data is : $data");
      }
    } catch (e) {
      print("error has been happend while get location details");
    }
  }
}
