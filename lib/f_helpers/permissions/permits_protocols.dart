import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/permissions/permits.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

class PermitProtocol {
  // -----------------------------------------------------------------------------

  const PermitProtocol();

  // -----------------------------------------------------------------------------

  /// PHOTO GALLERY

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchGalleryPermit({
    @required BuildContext context,
  }) async {

    // // final bool _permissionGranted =
    // await Permit.requestPermission(
    //   context: context,
    //   permission: Permission.photos,
    // );
    //
    // // final bool _storageGranted =
    // await Permit.requestPermission(
    //   context: context,
    //   permission: Permission.storage,
    // );

    final PermissionState per = await Permit.requestPhotoManagerPermission();
    bool _canPick = per.hasAccess;

    if (_canPick == false){
      _canPick = await Permit.requestPermission(
        context: context,
        permission: Permission.storage,
      );
    }

    return _canPick;
  }
  // -----------------------------------------------------------------------------

  /// CAMERA

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchCameraPermit({
    @required BuildContext context,
  }) async {

    if (DeviceChecker.deviceIsIOS() == true){
      return true;
    }
    else {

      final bool _permissionGranted = await Permit.requestPermission(
        context: context,
        permission: Permission.camera,
      );

      return _permissionGranted;

    }

  }
  // -----------------------------------------------------------------------------

  /// LOCATION

  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchLocationPermitA({
    @required BuildContext context,
  }) async {

    final bool _permissionGranted = await Permit.requestPermission(
      context: context,
      permission: Permission.location,
    );

    return _permissionGranted;
  }
  // --------------------
  /// WORKS PERFECT FOR ANDROID
  static Future<bool> fetchLocationPermitB({
    @required BuildContext context,
  }) async {

    final bool _permissionGranted = await Permit.requestGeolocatorPermission(
      context: context,
    );

    return _permissionGranted;
  }
  // -----------------------------------------------------------------------------
}
