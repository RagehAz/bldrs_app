import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart';
import 'package:bldrs/x_dashboard/z_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/z_widgets/wide_button.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundsTestScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const SoundsTestScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _SoundsTestScreenState createState() => _SoundsTestScreenState();
  /// --------------------------------------------------------------------------
}

class _SoundsTestScreenState extends State<SoundsTestScreen> {
  // -----------------------------------------------------------------------------
  final AudioPlayer _player = AudioPlayer();
  // -----------------------------------------------------------------------------
  /*
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
      addPostFrameCallBack: false,
    );
  }

   */
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // _init();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      // _triggerLoading(setTo: true).then((_) async {
      //
      //
      //   await _triggerLoading(setTo: false);
      // });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /// TAMAM
  @override
  void dispose() {
    // _loading.dispose();
    _player.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  /*
    //   Future<void> _init() async {
    //
    //     /// Inform the operating system of our app's audio attributes etc.
    //     /// We pick a reasonable default for an app that plays speech.
    //     final session = await AudioSession.instance;
    //     await session.configure(const AudioSessionConfiguration.speech());
    //
    //     /// Listen to errors during playback.
    //     _player.playbackEventStream.listen((event) {},
    //         onError: (Object e, StackTrace stackTrace) {
    //           blog('A stream error occurred: $e');
    //         });
    //
    //     /// Try to load audio from a source and catch any errors.
    //     await tryAndCatch(
    //       context: context,
    //       methodName: 'init sounds',
    //       functions: () async {
    //
    //         // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
    //         const String _url = 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3';
    //         final Uri _uri = Uri.parse(_url);
    //         final AudioSource _audioSource = AudioSource.uri(_uri);
    //         await _player.setAudioSource(_audioSource);
    //
    //       }
    //     );
    //
    //   }
    // -----------------------------------------------------------------------------
    //   @override
    //   void didChangeAppLifecycleState(AppLifecycleState state) {
    //     if (state == AppLifecycleState.paused) {
    //       // Release the player's resources when not in use. We use "stop" so that
    //       // if the app resumes later, it will still remember what position to
    //       // resume from.
    //       _player.stop();
    //     }
    //   }
      */
  // --------------------
  /*
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));
   */
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _allSounds = Sounder.allSounds();

    return DashBoardLayout(
        // loading: _loading,
        listWidgets: <Widget>[

          ...List.generate(_allSounds.length, (index){

            final String _sound = _allSounds[index];

            return WideButton(
              verse: Verse.plain(TextMod.removeTextBeforeLastSpecialCharacter(_sound, '/')),
              onTap: () async {

                await Sounder.playAssetSound(_sound);

              },
            );

          }),


        ],
    );

  }
// -----------------------------------------------------------------------------
}
