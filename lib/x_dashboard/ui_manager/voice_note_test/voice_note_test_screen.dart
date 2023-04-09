import 'dart:io';

import 'package:bldrs/b_views/z_components/buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/x_dashboard/zz_widgets/dashboard_layout.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

/// TASK : FOR IOS : YOU NEED TO DO THE LAST STEP IN XCODE MENTIONED EXACTLY HERE
/// https://youtu.be/j4mX0jtxWpA?t=127

class VoiceNoteScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const VoiceNoteScreen({
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  @override
  _VoiceNoteScreenState createState() => _VoiceNoteScreenState();
  /// --------------------------------------------------------------------------
}

class _VoiceNoteScreenState extends State<VoiceNoteScreen> {
  // -----------------------------------------------------------------------------
  final FlutterSoundRecorder recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  // -----------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({@required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    initRecorder();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading(setTo: true).then((_) async {

        /// FUCK

        await _triggerLoading(setTo: false);
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    recorder.closeRecorder();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  Future<void> initRecorder() async {
    final status = await Permission.microphone.request();

    if (status.isGranted == false) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await recorder.openRecorder();

    isRecorderReady = true;

    /// THIS ASSIGNS HOW OFTEN PROGRESS STREAM IS UPDATED
    await recorder.setSubscriptionDuration(
        const Duration(milliseconds: 100)
    );

  }
  // --------------------
  ///
  Future<void> record() async {
    if (isRecorderReady == true){
      await recorder.startRecorder(toFile: 'audio');
    }
  }
  // --------------------
  ///
  Future<void> stop() async {

    if (isRecorderReady == true){
      final String _path = await recorder.stopRecorder();
      final File _audioFile = File(_path);
      blog('AUDIO FILE: $_audioFile');

      setState(() {
        _file = _audioFile;
      });

    }


  }
  // --------------------
  File _file;
  ///
  Future<void> play() async {
    if (isRecorderReady == true){
      await Sounder.playSound(filePath: _file?.path);
    }
  }

  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return DashBoardLayout(
      loading: _loading,
      listWidgets: <Widget>[

        StreamBuilder<RecordingDisposition>(
          stream: recorder.onProgress,
          builder: (context, snapshot) {
            final RecordingDisposition recordingDisposition = snapshot.data;
            final Duration duration = recordingDisposition?.duration;
            final double decibels = recordingDisposition?.decibels;

            String twoDigits(int n) => n.toString().padLeft(2, '0');
            final String twoDigitMinutes = twoDigits(duration?.inMinutes?.remainder(60));
            final String twoDigitSeconds = twoDigits(duration?.inSeconds?.remainder(60));

            return BldrsText(
              verse: Verse.plain('$duration : $decibels : '
                  '$twoDigitMinutes:$twoDigitSeconds'),
              margin: const EdgeInsets.all(20),
              labelColor: Colorz.blue80,
            );
            },
        ),

        WideButton(
          verse: Verse.plain('RECORD'),
          icon: recorder.isRecording == true ? Iconz.pause : Iconz.balloonCircle,
          onTap: () async {

            if (recorder.isRecording == true){
              await stop();
            }
            else {
              await record();
            }

            setState(() {});

          },
        ),

        WideButton(
          verse: Verse.plain('RECORD'),
          isActive: _file != null,
          icon: Iconz.play,
          onTap: () async {

              await play();

          },
        ),


      ],
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
