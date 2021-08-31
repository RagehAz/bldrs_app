// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

class Audioz{
// -----------------------------------------------------------------------------
  static String _soundFile_name_nicole = 'res_name_nicole';
  static String _soundFile_name_justina = 'res_name_justina';
  static String _soundFile_name_emma = 'res_name_emma';
  static String _soundFile_name_amy = 'res_name_amy';
// -----------------------------------------------------------------------------
  static String getNotificationFilesPath(String fileNameWithoutExtension){
    return
      'resource://raw/$fileNameWithoutExtension';
  }
// -----------------------------------------------------------------------------
  static String  randomBldrsNameSoundPath(){

    List<String> _notiSounds = <String>[
      _soundFile_name_nicole,
      _soundFile_name_justina,
      _soundFile_name_emma,
      _soundFile_name_amy,
    ];
    
    int _randomIndex = Random().nextInt(_notiSounds.length); // from 0 up to _notiSounds.length included

    return getNotificationFilesPath(_notiSounds[_randomIndex]);
  }
// -----------------------------------------------------------------------------

// // --- path of files neglects asset/ folder as you see because why not create some hidden bug to fuck developers bitch
// class Soundz {
//   static const String NextFlyer       = 'sounds/whip_high.mp3' ; // assets/sounds/whip_high.mp3
//   static const String PreviousFlyer   = 'sounds/whip_long.mp3' ; // assets/sounds/whip_long.mp3
// }
//
// Future<AudioPlayer> playSound (String sound) async {
//   AudioPlayer advancedPlayer = new AudioPlayer();
//   AudioCache audioCache = new AudioCache(fixedPlayer: advancedPlayer);
//   return await audioCache.play(sound ,mode: PlayerMode.MEDIA_PLAYER, volume: 50, );
// }
//

}