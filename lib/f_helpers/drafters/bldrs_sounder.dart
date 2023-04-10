// ignore_for_file: constant_identifier_names
import 'dart:async';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:mediators/mediators.dart';


// class Sounder  {
//   // -----------------------------------------------------------------------------
//
//   /// INITIALIZATION
//
//   // --------------------
//   /// private constructor to create instances of this class only in itself
//   Sounder._thing();
//   // --------------------
//   /// Singleton instance
//   static final Sounder _singleton = Sounder._thing();
//   // --------------------
//   /// Singleton accessor
//   static Sounder get instance => _singleton;
//   // --------------------
//   /// local instance
//   AudioPlayer _freePlayer;
//   // --------------------
//   /// instance getter
//   AudioPlayer get player {
//     return _freePlayer ??= AudioPlayer();
//   }
//   // --------------------
//   /// static instance getter
//   static AudioPlayer _getPlayer() {
//     return Sounder.instance.player;
//   }
//   // --------------------
//   /// Static dispose
//   static void dispose(){
//     _getPlayer().dispose();
//   }
//   // -----------------------------------------------------------------------------
//
//   /// PLAY SOUND
//
//   // --------------------
//   ///
//   static Future<void> playSound({
//     String mp3Asset,
//     String wavAssetForAndroid, // SOMETIMES WAV FILES WORK BETTER IN ANDROID
//     String filePath = '',
//     String url,
//     Map<String, String> urlHeaders,
//     bool preload = false,
//     Duration initialPosition = Duration.zero,
//     bool loop = false,
//     double initialVolume = 1,
//     bool canUseNetworkResourcesForLiveStreamingWhilePaused = false,
//     double initialSpeed = 1,
//   }) async {
//
//     if (mp3Asset != null || filePath != null || url != null) {
//       await tryAndCatch(
//         invoker: 'playAssetSound',
//         functions: () async {
//           final AudioPlayer _audioPlayer = _getPlayer();
//
//           /// SOUND ASSET
//           if (TextCheck.isEmpty(mp3Asset) == false) {
//             String _asset = mp3Asset;
//             if (DeviceChecker.deviceIsAndroid() == true) {
//               _asset = wavAssetForAndroid ?? mp3Asset;
//             }
//
//             await _audioPlayer.setAsset(
//               _asset,
//               preload: preload,
//               initialPosition: initialPosition,
//               // package: ,
//             );
//           }
//
//           /// SOUND FILE
//           else if (TextCheck.isEmpty(filePath) == false) {
//             await _audioPlayer.setFilePath(
//               filePath,
//               initialPosition: initialPosition,
//               preload: preload,
//             );
//           }
//
//           /// SOUND URL
//           else if (ObjectCheck.isAbsoluteURL(url) == true) {
//             await _audioPlayer.setUrl(
//               url,
//               headers: urlHeaders,
//               initialPosition: initialPosition,
//               preload: preload,
//             );
//           }
//
//           await Future.wait(<Future>[
//             /// VOLUME
//             if (initialVolume != 1) _audioPlayer.setVolume(initialVolume),
//
//             /// LOOPING
//             if (loop == true) _audioPlayer.setLoopMode(LoopMode.one),
//
//             /// INITIAL SPEED
//             if (initialSpeed != 1) _audioPlayer.setSpeed(initialSpeed),
//
//             /// NETWORK RESOURCE WHILE STREAMING
//             if (canUseNetworkResourcesForLiveStreamingWhilePaused == true)
//               _audioPlayer.setCanUseNetworkResourcesForLiveStreamingWhilePaused(true),
//           ]);
//
//           /// PLAY
//           await _audioPlayer.play();
//         },
//       );
//     }
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> playButtonClick() async {
//
//     const List<String> _sounds = <String>[
//       BldrsThemeSounds.click_a,
//       BldrsThemeSounds.click_b,
//       BldrsThemeSounds.click_c,
//     ];
//
//     final int _index = Numeric.createRandomIndex(
//         listLength: _sounds.length,
//     );
//
//     await playSound(
//       mp3Asset: _sounds[_index],
//     );
//
//   }
//   static String getFCMSoundFilePath(String fileNameWithoutExtension){
//     return 'resource://raw/$fileNameWithoutExtension';
//   }
//   // --------------------
//   static String randomBldrsNameSoundPath(){
//
//     final List<String> _notiSounds = <String>[
//       nicoleSaysBldrsDotNet,
//       justinaSaysBldrsDotNet,
//     ];
//
//     final int _index = Numeric.createRandomIndex(listLength: _notiSounds.length);
//
//     return getFCMSoundFilePath(_notiSounds[_index]);
//   }
//   // -----------------------------------------------------------------------------
// }

class BldrsSounder {
  // -----------------------------------------------------------------------------

  const BldrsSounder();

  // -----------------------------------------------------------------------------

  /// FCM SOUNDS

  // --------------------
  static const String nicoleSaysBldrsDotNet = 'res_name_nicole';
  static const String justinaSaysBldrsDotNet = 'res_name_justina';
  // --------------------
  static Future<void> playIntro() async {
    await Sounder.playSound(
      wavAssetForAndroid: BldrsThemeSounds.bldrs_intro_wav,
      mp3Asset: BldrsThemeSounds.bldrs_intro,
    );
  }
  // -----------------------------------------------------------------------------
}
