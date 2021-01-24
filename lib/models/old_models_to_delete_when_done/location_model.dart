import 'package:flutter/foundation.dart';

class LocationModel {
  final String locationID;
  final String ownerID;
  final double longitude;
  final double latitude;
  final String address;

  LocationModel({
    @required this.locationID,
    @required this.ownerID,
    @required this.longitude,
    @required this.latitude,
    this.address
  });
}





