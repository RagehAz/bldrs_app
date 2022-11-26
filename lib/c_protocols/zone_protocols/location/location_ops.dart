import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    bool _serviceEnabled;
    LocationPermission permission;

    /// Test if location services are enabled.
    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future<Object>.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future<Object>.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future<Object>.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    /// When we reach here, permissions are granted and we can
    /// continue accessing the position of the device.

    final Position _result = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.medium,
      // forceAndroidLocationManager: true,
      // timeLimit: Duration(seconds: Standards.maxLocationFetchSeconds)
    );

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
      _placeMarks = await placemarkFromCoordinates(geoPoint.latitude, geoPoint.longitude);
      blog('getAddressFromPosition :found placemarks aho $_placeMarks');
    }

    else {
      blog('getAddressFromPosition : could not get this position placeMarks');
    }

    return _placeMarks;
  }
  // -----------------------------------------------------------------------------
}
