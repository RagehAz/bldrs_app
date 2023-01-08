// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:bldrs/f_helpers/drafters/device_checkers.dart';
import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:just_audio/just_audio.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class Sounder  {
  // -----------------------------------------------------------------------------

  /// INITIALIZATION

  // --------------------
  /// private constructor to create instances of this class only in itself
  Sounder._thing();
  // --------------------
  /// Singleton instance
  static final Sounder _singleton = Sounder._thing();
  // --------------------
  /// Singleton accessor
  static Sounder get instance => _singleton;
  // --------------------
  /// local instance
  AudioPlayer _freePlayer;
  // --------------------
  /// instance getter
  AudioPlayer get player {
    return _freePlayer ??= AudioPlayer();
  }
  // --------------------
  /// static instance getter
  static AudioPlayer _getPlayer() {
    return Sounder.instance.player;
  }
  // --------------------
  /// Static dispose
  static void dispose(){
    _getPlayer().dispose();
  }
  // -----------------------------------------------------------------------------

  /// PLAY ASSET

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playAssetSound(String asset) async {

    final bool _isAndroid = DeviceChecker.deviceIsAndroid();
    final bool _isIntroSound =
            asset == BldrsThemeSounds.bldrs_intro_wav
            ||
            asset == BldrsThemeSounds.bldrs_intro;

    if (_isAndroid == true && _isIntroSound == false){
      /// PLAN : ACTIVATE VOICES ON ANDROID LATER IN YOUR LIFE WHEN THINGS BECOME LITTLE HAPPIER
    }
    else {
      final AudioPlayer _audioPlayer = _getPlayer();
      await tryAndCatch(
        invoker: 'playAssetSound',
        functions: () async {
          await _audioPlayer.setAsset(asset);
          await _audioPlayer.play();
        },
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playButtonClick() async {

    const List<String> _sounds = <String>[
      BldrsThemeSounds.click_a,
      BldrsThemeSounds.click_b,
      BldrsThemeSounds.click_c,
    ];

    final int _index = Numeric.createRandomIndex(
        listLength: _sounds.length,
    );

    await playAssetSound(_sounds[_index]);

  }
  // --------------------
  static Future<void> playIntro() async {

    if (DeviceChecker.deviceIsAndroid() == true){
      unawaited(Sounder.playAssetSound(BldrsThemeSounds.bldrs_intro_wav));
    }

    else {
      unawaited(Sounder.playAssetSound(BldrsThemeSounds.bldrs_intro));
    }

  }
  // -----------------------------------------------------------------------------

  /// FCM SOUNDS

  // --------------------
  static const String nicoleSaysBldrsDotNet = 'res_name_nicole';
  static const String justinaSaysBldrsDotNet = 'res_name_justina';
  // --------------------
  static String getNootFilesPath(String fileNameWithoutExtension){
    return 'resource://raw/$fileNameWithoutExtension';
  }
  // --------------------
  static String randomBldrsNameSoundPath(){

    final List<String> _notiSounds = <String>[
      nicoleSaysBldrsDotNet,
      justinaSaysBldrsDotNet,
    ];

    final int _index = Numeric.createRandomIndex(listLength: _notiSounds.length);

    return getNootFilesPath(_notiSounds[_index]);
  }
  // -----------------------------------------------------------------------------
}
