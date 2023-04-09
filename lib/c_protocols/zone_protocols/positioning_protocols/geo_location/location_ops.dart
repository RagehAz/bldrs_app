import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devicer/devicer.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
/// => TAMAM
class LocationOps {
  // -----------------------------------------------------------------------------

  const LocationOps();

  // -----------------------------------------------------------------------------

  /// GEO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Position> getCurrentPosition() async {

    Position _result;

    // LocationPermission _permission;
    //
    //
    // _permission = await Geolocator.checkPermission();
    //
    // if (_permission == LocationPermission.denied) {
    //   _permission = await Geolocator.requestPermission();
    //   if (_permission == LocationPermission.denied) {
    //     // Permissions are denied, next time you could try
    //     // requesting permissions again (this is also where
    //     // Android's shouldShowRequestPermissionRationale
    //     // returned true. According to Android guidelines
    //     // your App should show an explanatory UI now.
    //     return Future<Object>.error('Location permissions are denied');
    //   }
    // }
    //
    // if (_permission == LocationPermission.deniedForever) {
    //   // Permissions are denied forever, handle appropriately.
    //   return Future<Object>.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }
    //
    // /// When we reach here, permissions are granted and we can
    // /// continue accessing the position of the device.
    // ///

    final bool _canGetPosition = await PermitProtocol.fetchLocationPermitA(
        context: getContext(),
    );

    if (_canGetPosition == true){

      _result = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        // forceAndroidLocationManager: true,
        // timeLimit: Duration(seconds: Standards.maxLocationFetchSeconds)
      );

    }


    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<Placemark>> getPlaceMarksFromGeoPoint({
    @required GeoPoint geoPoint
  }) async {

    List<Placemark> _placeMarks = <Placemark>[];

    blog('getAddressFromPosition :starting getAddressFromPosition');

    if (geoPoint != null) {

      await tryAndCatch(
        invoker: 'getPlaceMarksFromGeoPoint',
        functions: () async {
          _placeMarks = await placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
        },
        onError: (String error) {
          blog('error getting placeMarks : $error');
        },
      );

      blog('getAddressFromPosition :found placemarks aho $_placeMarks');
    }

    else {
      blog('getAddressFromPosition : could not get this position placeMarks');
    }

    return _placeMarks;
  }
  // -----------------------------------------------------------------------------
}
