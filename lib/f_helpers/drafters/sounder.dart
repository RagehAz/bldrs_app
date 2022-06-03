// ignore_for_file: constant_identifier_names
import 'package:bldrs/f_helpers/drafters/numeric.dart' as Numeric;
import 'package:just_audio/just_audio.dart';


class Sounder  {
// -----------------------------------------------------------------------------

  /// INITIALIZATION

// ---------------------------------------------------
  /// private constructor to create instances of this class only in itself
  Sounder._thing();
// ---------------------------------------------------
  /// Singleton instance
  static final Sounder _singleton = Sounder._thing();
// ---------------------------------------------------
  /// Singleton accessor
  static Sounder get instance => _singleton;
// ---------------------------------------------------
  ///
  AudioPlayer _freePlayer;
// ---------------------------------------------------
  /// db object accessor
  AudioPlayer get player {
    return _freePlayer ??= AudioPlayer();
  }
// ---------------------------------------------------
  static AudioPlayer _getPlayer() {
    final AudioPlayer _result = Sounder.instance.player;
    return _result;
  }
// -----------------------------------------------------------------------------

  /// PLAY ASSET

// ---------------------------------------------------
  static Future<void> playAssetSound(String asset) async {
    final AudioPlayer _audioPlayer = _getPlayer();
    await _audioPlayer.setAsset(asset);
    await _audioPlayer.play();
  }
// -----------------------------------------------------------------------------

  /// SOUND FX

// -------------------------------------
  static const String _soundsPath = 'assets/sounds';
// -------------------------------------
  static const String whip_high = '$_soundsPath/whip_high.mp3' ;
  static const String whip_long = '$_soundsPath/whip_long.mp3' ;
// -----------------------------------------------------------------------------

  /// FCM SOUNDS

// -------------------------------------
  static const String _soundFileNameNicole = 'res_name_nicole';
  static const String _soundFileNameJustina = 'res_name_justina';
  static const String _soundFileNameEmma = 'res_name_emma';
  static const String _soundFileNameAmy = 'res_name_amy';
// -----------------------------------------------------------------------------
  static String getNotificationFilesPath(String fileNameWithoutExtension){
    return 'resource://raw/$fileNameWithoutExtension';
  }
// -----------------------------------------------------------------------------
  static String randomBldrsNameSoundPath(){

    final List<String> _notiSounds = <String>[
      _soundFileNameNicole,
      _soundFileNameJustina,
      _soundFileNameEmma,
      _soundFileNameAmy,
    ];

    final int _index = Numeric.createRandomIndex(listLength: _notiSounds.length);

    return getNotificationFilesPath(_notiSounds[_index]);
  }
// -----------------------------------------------------------------------------

}
