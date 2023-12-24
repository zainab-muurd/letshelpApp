import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as Loc;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:async';

import '../helper/location_helper.dart';
import '../theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_api_headers/src/my_platform.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MapToPickLocationScreen extends StatefulWidget {
  @override
  _MapToPickLocationScreenState createState() =>
      _MapToPickLocationScreenState();
}

class _MapToPickLocationScreenState extends State<MapToPickLocationScreen> {
  LatLng? _pickedLocation;
  LatLng? _curLocation;
  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;

  Future<void> _getcurrentplace() async {
    final locData = await Loc.Location().getLocation();
    setState(() {
      _curLocation = LatLng(locData.latitude!, locData.longitude!);
    });
  }

  @override
  void initState() {
    _getcurrentplace();
    super.initState();
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Future<void> updateLocation(double lat, double lng) async {
    mapController = await _controller.future;

    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 16.0,
        ),
      ),
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      mode: Mode.overlay,
      types: [],
      radius: 10000000,
      strictbounds: false,
      context: context,
      apiKey: GOOGLE_API_KEY,
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "SY")],
    );

    displayPrediction(p!);
  }

  Future<void> displayPrediction(Prediction p) async {
    GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: GOOGLE_API_KEY,
      apiHeaders: await GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail =
        await _places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry?.location.lat;
    final lng = detail.result.geometry?.location.lng;
    print(lat);
    print(lng);
    updateLocation(lat!, lng!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kTeal400,
        title: Text(
          'حدد موقع العقار على الخريطة',
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
              color: _pickedLocation == null ? Colors.grey : Colors.white,
            ),
            onPressed: _pickedLocation == null
                ? () => Navigator.of(context).pop(_curLocation)
                : () => Navigator.of(context).pop(_pickedLocation),
          )
        ],
      ),
      body: _curLocation == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      _curLocation!.latitude,
                      _curLocation!.longitude,
                    ),
                    zoom: 16,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    mapController = controller;
                  },
                  myLocationEnabled: true,
                  onTap: _selectLocation,
                  markers: _pickedLocation == null
                      ? {}
                      : {
                          Marker(
                            markerId: MarkerId('m1'),
                            position: _pickedLocation!,
                          ),
                        },
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30)),
                      color: Colors.black45,
                    ),
                    child: TextButton.icon(
                      onPressed: _handlePressButton,
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      label: Text(''),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  bool get wantKeepAlive => throw UnimplementedError();
}

class GoogleApiHeaders {
  final MyPlatform platform;

  /// Constructor with an optional parameter of [MyPlatform].
  /// Default to [MyPlatformImp] if the parameter is not provided.
  const GoogleApiHeaders([MyPlatform? platform])
      : platform = platform ?? const MyPlatformImp();

  static Map<String, String> _headers = {};
  final MethodChannel _channel = const MethodChannel('google_api_headers');

  /// Clear cached headers.
  @visibleForTesting
  static void clear() => _headers.clear();

  /// Get the headers required for calling Google APIs with a restricted key
  /// based on the platform (iOS or Android). For web,
  /// an empty header will be returned.
  Future<Map<String, String>> getHeaders() async {
    if (_headers.isEmpty && !kIsWeb && !platform.isDesktop) {
      final packageInfo = await PackageInfo.fromPlatform();
      if (platform.isIos) {
        _headers = {
          "X-Ios-Bundle-Identifier": packageInfo.packageName,
        };
      } else if (platform.isAndroid) {
        try {
          final sha1 = await _channel.invokeMethod(
            'getSigningCertSha1',
            packageInfo.packageName,
          );
          _headers = {
            "X-Android-Package": packageInfo.packageName,
            "X-Android-Cert": sha1,
          };
        } on PlatformException {
          _headers = {};
        }
      }
    }

    return _headers;
  }
}
