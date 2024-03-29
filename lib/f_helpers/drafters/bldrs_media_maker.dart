import 'package:basics/helpers/maps/mapper.dart';
import 'package:basics/helpers/permissions/permits.dart';
import 'package:basics/mediator/pic_maker/pic_maker.dart';
import 'package:basics/mediator/models/media_models.dart';
import 'package:basics/mediator/video_maker/video_maker.dart';
import 'package:bldrs/b_screens/h_media_screens/bldrs_cropping_screen/bldrs_cropping_screen.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/debuggers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';

import '../../b_screens/h_media_screens/bldrs_video_editor_screen/bldrs_video_editor.dart';

// -----------------------------------------------------------------------------
/*
/// GIF THING
// check this
// https://stackoverflow.com/questions/67173576/how-to-get-or-pick-local-gif-file-from-device
// https://pub.dev/packages/file_picker
// Container(
//   width: 200,
//   height: 200,
//   margin: EdgeInsets.all(30),
//   color: Colorz.BloodTest,
//   child: Image.network('https://media.giphy.com/media/hYUeC8Z6exWEg/giphy.gif'),
// ),
 */

/// => TAMAM
class BldrsMediaMaker {
  // --------------------------------------------------------------------------

  const BldrsMediaMaker();

  // --------------------------------------------------------------------------

  /// MAKERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> makePic({
    required MediaOrigin mediaOrigin,
    required bool cropAfterPick,
    required double aspectRatio,
    required int? compressWithQuality,
    required double? resizeToWidth,
    required String Function (String? title) uploadPathMaker,
    required List<String> ownersIDs,
  }) async {
    MediaModel? _output;

    if(mediaOrigin == MediaOrigin.galleryImage){
      _output = await PicMaker.pickAndCropSinglePic(
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
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        onCrop: (MediaModel? media) => BldrsCroppingScreen.onCropSinglePic(
          media: media,
          aspectRatio: aspectRatio,
        ),
        // selectedAsset: selectedAsset,
      );
    }

    else if (mediaOrigin == MediaOrigin.cameraImage){
      _output = await PicMaker.shootAndCropCameraPic(
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
        ownersIDs: ownersIDs,
        uploadPathMaker: uploadPathMaker,
        locale: Localizer.getCurrentLocale(),
        onCrop: (List<MediaModel> medias) => BldrsCroppingScreen.onCropMultiplePics(
          medias: medias,
          aspectRatio: aspectRatio,
        ),
      );
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<MediaModel>> makePics({
    required bool cropAfterPick,
    required double aspectRatio,
    required int compressWithQuality,
    required double resizeToWidth,
    required String Function(int index, String? title) uploadPathGenerator,
    required List<String> ownersIDs,
    required int maxAssets,
  }) async {

    final List<MediaModel> _output = await PicMaker.pickAndCropMultiplePics(
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
      uploadPathGenerator: uploadPathGenerator,
      ownersIDs: ownersIDs,
      onCrop: (List<MediaModel> medias) => BldrsCroppingScreen.onCropMultiplePics(
        medias: medias,
        aspectRatio: aspectRatio,
      ),
      // selectedAssets: selectedAssets,
    );

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// VIDEO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Map<String, MediaModel>?> makeVideo({
    required MediaOrigin mediaOrigin,
    required bool cropAfterPick,
    required double aspectRatio,
    required double? resizeToWidth,
    required int? compressWithQuality,
    required String Function (String? title) uploadPathMaker,
    required List<String> ownersIDs,
    required bool createCover,
  }) async {
    MediaModel? _video;
    MediaModel? _cover;

    if(mediaOrigin == MediaOrigin.galleryVideo){
      _video = await VideoMaker.pickVideo(
        context: getMainContext(),
        langCode: Localizer.getCurrentLangCode(),
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onPickingError,
        uploadPathMaker: uploadPathMaker,
        ownersIDs: ownersIDs,
      );
    }

    else if (mediaOrigin == MediaOrigin.cameraVideo){
      _video = await VideoMaker.shootVideo(
        context: getMainContext(),
        langCode: Localizer.getCurrentLangCode(),
        onPermissionPermanentlyDenied: onPermissionPermanentlyDenied,
        onError: onPickingError,
        locale: Localizer.getCurrentLocale(),
        uploadPathMaker: uploadPathMaker,
        ownersIDs: ownersIDs,
      );
    }

    if (cropAfterPick == true){
      _video = await _editVideo(
        video: _video,
      );
    }

    if (createCover == true){
      _cover = await _createVideoCover(
        video: _video,
      );
    }

    if (_video == null){
      return null;
    }
    else {

      final Map<String, MediaModel> _map = {
        'video': _video,
      };

      if (_cover != null){
        _map['cover'] = _cover;
      }

      return _map;
    }
  }
  // -----------------------------------------------------------------------------

  /// EDIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> _editVideo({
    required MediaModel? video,
  }) async {

    final MediaModel? _output = await BldrsNav.goToNewScreen(
        screen: VideoEditorScreen(
          video: video,
        ),
    );

    return _output ?? video;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<MediaModel?> _createVideoCover({
    required MediaModel? video,
  }) async {

    final MediaModel? _cover = await BldrsNav.goToNewScreen(
      screen: VideoCoverCreatorScreen(
        video: video,
      ),
    );

    return _cover;
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

    await throwStandardError(
      invoker: 'BldrsMediaMaker.onPickingError',
      error: error,
    );

    await Dialogs.centerNotice(
      verse: getVerse('phid_somethingWentWrong')!,
      body: getVerse('phid_please_try_again'),
    );

  }
  // -----------------------------------------------------------------------------
}
