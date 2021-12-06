// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

  const String _soundFileNameNicole = 'res_name_nicole';
  const String _soundFileNameJustina = 'res_name_justina';
  const String _soundFileNameEmma = 'res_name_emma';
  const String _soundFileNameAmy = 'res_name_amy';
// -----------------------------------------------------------------------------
  String getNotificationFilesPath(String fileNameWithoutExtension){
    return
      'resource://raw/$fileNameWithoutExtension';
  }
// -----------------------------------------------------------------------------
  String  randomBldrsNameSoundPath(){

    final List<String> _notiSounds = <String>[
      _soundFileNameNicole,
      _soundFileNameJustina,
      _soundFileNameEmma,
      _soundFileNameAmy,
    ];
    
    final int _randomIndex = Random().nextInt(_notiSounds.length); // from 0 up to _notiSounds.length included

    return getNotificationFilesPath(_notiSounds[_randomIndex]);
  }
// -----------------------------------------------------------------------------

// // --- path of files neglects asset/ folder as you see because why not create some hidden bug to fuck developers bitch
// class Soundz {
//   const String NextFlyer       = 'sounds/whip_high.mp3' ; // assets/sounds/whip_high.mp3
//   const String PreviousFlyer   = 'sounds/whip_long.mp3' ; // assets/sounds/whip_long.mp3
// }
//
// Future<AudioPlayer> playSound (String sound) async {
//   AudioPlayer advancedPlayer = new AudioPlayer();
//   AudioCache audioCache = new AudioCache(fixedPlayer: advancedPlayer);
//   return await audioCache.play(sound ,mode: PlayerMode.MEDIA_PLAYER, volume: 50, );
// }
//
