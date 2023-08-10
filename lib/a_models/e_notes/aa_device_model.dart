import 'dart:io';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/e_back_end/e_fcm/fcm.dart';
import 'package:flutter/foundation.dart';
/// => TAMAM
@immutable
class DeviceModel {
  /// --------------------------------------------------------------------------
  const DeviceModel({
    required this.id,
    required this.name,
    required this.token,
    required this.platform,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final String? name;
  final String? token;
  final String? platform;
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
  static DeviceModel? decipherFCMToken(Map<String, dynamic>? map) {
    DeviceModel? _device;

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
  /// TESTED : WORKS PERFECT
  static Future<DeviceModel> generateDeviceModel() async {

    final String? deviceID = await DeviceChecker.getDeviceID();
    final String? deviceName = await DeviceChecker.getDeviceName();
    final String? deviceToken = await FCM.generateToken();
    final String devicePlatform = kIsWeb == true ? 'web' : Platform.operatingSystem;

    return DeviceModel(
        id: deviceID,
        name: deviceName,
        token: deviceToken,
        platform: devicePlatform
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static const List<String> deviceTypesList = <String>[
    'web',
    'android',
    'ios',
    'windows',
  ];
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getPlatformIcon(String? platform){

    switch(platform){
      case 'web':       return Iconz.comWebsite;
      case 'android':   return Iconz.comGooglePlay;
      case 'ios':       return Iconz.comApple;
      case 'windows':   return Iconz.star;
      default: return null;
    }

  }
  // -----------------------------------------------------------------------------

  /// BLOGGING

  // --------------------
  /// TESTED : WORKS PERFECT
  void blogDevice(){
    blog('DeviceModel : id : $id : name : $name : platform $platform : token : $token');
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkDevicesAreIdentical({
    required DeviceModel? device1,
    required DeviceModel? device2,
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
