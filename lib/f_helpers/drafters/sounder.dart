// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:just_audio/just_audio.dart';

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
    final AudioPlayer _audioPlayer = _getPlayer();
    await _audioPlayer.setAsset(asset);
    await _audioPlayer.play();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> playButtonClick() async {

    // const List<String> _sounds = <String>[
    //   click_a,
    //   click_b,
    //   click_c,
    // ];
    //
    // final int _index = Numeric.createRandomIndex(
    //     listLength: _sounds.length,
    // );
    //
    // await playAssetSound(_sounds[_index]);

  }
  // --------------------
  static Future<void> playIntro() async {
    unawaited(Sounder.playAssetSound(Sounder.bldrs_intro));
  }
  // -----------------------------------------------------------------------------

  /// SOUND FX

  // --------------------
  static const String _soundsPath = 'assets/sounds';
  // --------------------
  static const String whip_high = '$_soundsPath/whip_high.mp3' ;
  static const String whip_long = '$_soundsPath/whip_long.mp3' ;
  // --------------------
  static const String zip = '$_soundsPath/zip.mp3' ;
  static const String click_a = '$_soundsPath/click_a.mp3' ;
  static const String click_b = '$_soundsPath/click_b.mp3' ;
  static const String click_c = '$_soundsPath/click_c.mp3' ;
  // --------------------
  static const String bldrs_intro = '$_soundsPath/bldrs_intro.mp3' ;
  // --------------------
  static List<String> allSounds(){
    return <String>[
      whip_high,
      whip_long,
      zip,
      click_a,
      click_b,
      click_c,
      bldrs_intro,
    ];
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
