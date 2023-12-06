import 'dart:typed_data';

import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/permissions/permits.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/foundation.dart';

// // -----------------------------------------------------------------------------
// /*
// /// GIF THING
// // check this
// // https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// // https://pub.dev/packages/file_picker
// // Container(
// //   width: 200,
// //   height: 200,
// //   margin: EdgeInsets.all(30),
// //   color: Colorz.BloodTest,
// //   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// // ),
//  */

/// => TAMAM
class BldrsPicMaker {
  // --------------------------------------------------------------------------

  const BldrsPicMaker();

  // -----------------------------------------------------------------------------

  /// MAKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<PicModel?> makePic({
    required PicMakerType picMakerType,
    required bool cropAfterPick,
    required double aspectRatio,
    required int? compressWithQuality,
    required double? resizeToWidth,
    required String assignPath,
    required List<String> ownersIDs,
    required String name,
  }) async {
    PicModel? _output;
    Uint8List? _bytes;

    if(picMakerType == PicMakerType.galleryImage){
      _bytes = await PicMaker.pickAndCropSinglePic(
        context: getMainContext(),
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        resizeToWidth: resizeToWidth,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        langCode: Localizer.getCurrentLangCode(),
        confirmText: getWord('phid_continue'),
        compressWithQuality: compressWithQuality,
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onPickingError,
        // selectedAsset: selectedAsset,
      );
    }

    else if (picMakerType == PicMakerType.cameraImage){
      _bytes = await PicMaker.shootAndCropCameraPic(
        context: getMainContext(),
        cropAfterPick: cropAfterPick,
        aspectRatio: aspectRatio,
        resizeToWidth: resizeToWidth,
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        langCode: Localizer.getCurrentLangCode(),
        compressWithQuality: compressWithQuality,
        confirmText: getWord('phid_continue'),
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onPickingError,
      );
    }

    if (_bytes != null){

      _output = await PicModel.combinePicModel(
        ownersIDs: ownersIDs,
        name: name,
        bytes: _bytes,
        compressWithQuality: compressWithQuality,
        picMakerType: picMakerType,
        assignPath: assignPath,
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<PicModel>> makePics({
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressWithQuality,
    required double resizeToWidth,
    required String Function(int index) assignPath,
    required List<String> ownersIDs,
    required String Function(int index) picNameGenerator,
    required int maxAssets,
  }) async {

    final List<PicModel> _output = [];

    final List<Uint8List> _bytezz = await PicMaker.pickAndCropMultiplePics(
      context: getMainContext(),
      cropAfterPick: cropAfterPick,
      aspectRatio: aspectRatio,
      resizeToWidth: resizeToWidth,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      langCode: Localizer.getCurrentLangCode(),
      confirmText: getWord('phid_continue'),
      maxAssets: maxAssets,
      compressWithQuality: compressWithQuality,
      onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
      onError: onPickingError,
      // selectedAssets: selectedAssets,
    );

    if (Mapper.checkCanLoopList(_bytezz) == true){

      for (int i = 0; i < _bytezz.length; i++){

        final Uint8List bytes = _bytezz[i];

        final PicModel? _picModel = await PicModel.combinePicModel(
          ownersIDs: ownersIDs,
          name: picNameGenerator(i),
          bytes: bytes,
          compressWithQuality: compressWithQuality,
          picMakerType: PicMakerType.galleryImage,
          assignPath: assignPath(i),
        );

        if (_picModel != null){
          _output.add(_picModel);
        }

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// CROPPERS

  // --------------------
  /// NOT USED : NOT TESTED
  static Future<PicModel?> cropPic({
    required PicModel? pic,
    required double aspectRatio,
    required int compressionQuality,
  }) async {
    PicModel? _output;

    if (pic != null && pic.path != null && pic.meta != null && pic.meta?.name != null){

      final Uint8List? _bytes = await PicMaker.cropPic(
        context: getMainContext(),
        bytes: pic.bytes,
        confirmText: getWord('phid_continue'),
        appIsLTR: UiProvider.checkAppIsLeftToRight(),
        aspectRatio: aspectRatio,
      );

      if (_bytes != null){

        _output = await PicModel.combinePicModel(
          bytes: _bytes,
          picMakerType: PicMaker.decipherPicMakerType(pic.meta!.data!['source'])!,
          compressWithQuality: compressionQuality,
          assignPath: pic.path!,
          ownersIDs: pic.meta!.ownersIDs,
          name: pic.meta!.name!,
        );

      }

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// PERMISSION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onPermissionPermanentlyDenied(Permission permission) async {

    final String _bodyLine = getWord(_getPermissionWarningPhid(permission));
    final String _permissionLine = permission.toString();
    
    final bool? _go = await BldrsCenterDialog.showCenterDialog(
      boolDialog: true,
      titleVerse: const Verse(
        id: 'phid_permission_required',
        translate: true,
      ),
      bodyVerse: Verse(
        id: '$_bodyLine\n\n$_permissionLine',
        translate: false,
      ),
      confirmButtonVerse: const Verse(
        id: 'phid_go_to_settings',
        translate: true,
      ),
      noVerse: const Verse(
        id: 'phid_cancel',
        translate: true,
      ),
    );

    if (Mapper.boolIsTrue(_go) == true){
      await Permit.jumpToAppSettingsScreen();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String _getPermissionWarningPhid(Permission permission){

    switch (permission.toString()){
      case  'Permission.photos': return 'phid_media_permit_warning';
      case  'Permission.storage': return 'phid_media_permit_warning';
      case  'Permission.camera': return 'phid_camera_permit_warning';
      case  'Permission.mediaLibrary': return 'phid_media_permit_warning';
      case  'Permission.photosAddOnly': return 'phid_media_permit_warning';
      case  'Permission.accessMediaLocation': return 'phid_media_permit_warning';

      case  'Permission.location': return 'phid_location_permit_warning';
      case  'Permission.locationAlways': return 'phid_location_permit_warning';
      case  'Permission.locationWhenInUse': return 'phid_location_permit_warning';

      // case  'Permission.notification': return 'phid_notification_permit_warning'; break;

      // case  'Permission.microphone': return 'phid_microphone_permit_warning'; break;
      // case  'Permission.videos': return 'phid_videos_permit_warning'; break;
      // case  'Permission.audio': return 'phid_audio_permit_warning'; break;
      // case  'Permission.contacts': return 'phid_contacts_permit_warning'; break;
      // case  'Permission.speech': return 'phid_speech_permit_warning'; break;
      // case  'Permission.phone': return 'phid_phone_permit_warning'; break;
      // case  'Permission.sensors': return 'phid_sensors_permit_warning'; break;
      // case  'Permission.bluetooth': return 'phid_bluetooth_permit_warning'; break;
      // case  'Permission.reminders': return 'phid_reminders_permit_warning'; break;
      // case  'Permission.calendar': return 'phid_calendar_permit_warning'; break;
      // case  'Permission.sms': return 'phid_sms_permit_warning'; break;
      // case  'Permission.activityRecognition': return 'phid_activityRecognition_permit_warning'; break;
      // case  'Permission.unknown': return 'phid_unknown_permit_warning'; break;
      // case  'Permission.ignoreBatteryOptimizations': return 'phid_ignoreBatteryOptimizations_permit_warning'; break;
      // case  'Permission.manageExternalStorage': return 'phid_manageExternalStorage_permit_warning'; break;
      // case  'Permission.systemAlertWindow': return 'phid_systemAlertWindow_permit_warning'; break;
      // case  'Permission.requestInstallPackages': return 'phid_requestInstallPackages_permit_warning'; break;
      // case  'Permission.appTrackingTransparency': return 'phid_appTrackingTransparency_permit_warning'; break;
      // case  'Permission.criticalAlerts': return 'phid_criticalAlerts_permit_warning'; break;
      // case  'Permission.accessNotificationPolicy': return 'phid_accessNotificationPolicy_permit_warning'; break;
      // case  'Permission.bluetoothScan': return 'phid_bluetoothScan_permit_warning'; break;
      // case  'Permission.bluetoothAdvertise': return 'phid_bluetoothAdvertise_permit_warning'; break;
      // case  'Permission.bluetoothConnect': return 'phid_bluetoothConnect_permit_warning'; break;
      // case  'Permission.nearbyWifiDevices': return 'phid_nearbyWifiDevices_permit_warning'; break;
      // case  'Permission.scheduleExactAlarm': return 'phid_scheduleExactAlarm_permit_warning'; break;

      default: return 'phid_permission_warning';
    }

  }
  // -----------------------------------------------------------------------------

  /// PICKING ERROR

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onPickingError(String? error) async {

    await Dialogs.centerNotice(
      verse: getVerse('phid_somethingWentWrong')!,
      body: getVerse('phid_please_try_again'),
    );

  }
  // --------------------
}
