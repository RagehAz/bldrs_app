// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:mediators/mediators.dart';
/// => TAMAM
class BldrsSounder {
  // -----------------------------------------------------------------------------

  const BldrsSounder();

  // -----------------------------------------------------------------------------

  /// FCM SOUNDS

  // --------------------
  static const String nicoleSaysBldrsDotNet = 'res_name_nicole';
  static const String justinaSaysBldrsDotNet = 'res_name_justina';
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playIntro() async {
    await Sounder.playSound(
      wavAssetForAndroid: BldrsThemeSounds.bldrs_intro_wav,
      mp3Asset: BldrsThemeSounds.bldrs_intro,
    );
  }
  // -----------------------------------------------------------------------------
}
