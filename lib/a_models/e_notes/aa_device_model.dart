import 'dart:io';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/foundation.dart';

@immutable
class DeviceModel {
  /// --------------------------------------------------------------------------
  const DeviceModel({
    @required this.id,
    @required this.name,
    @required this.token,
    @required this.platform,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String name;
  final String token;
  final String platform;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'token': token,
      'platform': platform,
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static DeviceModel decipherFCMToken(Map<String, dynamic> map) {
    DeviceModel _device;

    if (map != null) {
      _device = DeviceModel(
        id: map['id'],
        name: map['name'],
        token: map['token'],
        platform: map['platform'],
      );
    }

    return _device;
  }
  // -----------------------------------------------------------------------------

  /// GENERATOR

  // --------------------
  static Future<DeviceModel> generateDeviceModel() async {

    final String deviceID = await DeviceChecker.getDeviceID();
    final String deviceName = await DeviceChecker.getDeviceName();
    final String deviceToken = await FCM.generateToken();
    final String devicePlatform = Platform.operatingSystem;

    return DeviceModel(
        id: deviceID,
        name: deviceName,
        token: deviceToken,
        platform: devicePlatform
    );

  }
  // -----------------------------------------------------------------------------

  /// CHECKERS

  // --------------------
  ///
  static bool checkDevicesAreIdentical({
    @required DeviceModel device1,
    @required DeviceModel device2,
  }){
    bool _identical = false;

    if (device1 == null && device2 == null){
      _identical = true;
    }
    else {

      if (device1 != null && device2 != null){

        if (
            device1.id == device2.id &&
            device1.name == device2.name &&
            device1.token == device2.token &&
            device1.platform == device2.platform
        ){
          _identical = true;
        }

      }

    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDevice(){
    blog('DeviceModel : id : $id : name : $name : platform $platform : token : $token');
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is DeviceModel){
      _areIdentical = checkDevicesAreIdentical(
          device1: this,
          device2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      name.hashCode^
      token.hashCode^
      platform.hashCode;
  // -----------------------------------------------------------------------------
}
