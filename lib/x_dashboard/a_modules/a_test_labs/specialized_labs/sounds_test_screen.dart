// import 'package:audioplayers/audio_cache.dart';
// import 'package:audioplayers/audioplayers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/x_dashboard/b_widgets/layout/dashboard_layout.dart';
import 'package:bldrs/x_dashboard/b_widgets/wide_button.dart';
import 'package:flutter/material.dart';

// typedef void OnError(Exception exception);
//
//
// class SoundzScreen extends StatefulWidget {
//   @override
//   _SoundzScreen createState() =>  _SoundzScreen();
// }
//
// class _SoundzScreen extends State<SoundzScreen> {
//   Duration _duration = new Duration();
//   Duration _position = new Duration();
//   AudioPlayer advancedPlayer;
//   AudioCache audioCache;
//   String localFilePath;
//
//   @override
//   void initState() {
//     super.initState();
//     initPlayer();
//   }
//
//   void initPlayer() {
//     advancedPlayer = new AudioPlayer();
//     audioCache = new AudioCache(fixedPlayer: advancedPlayer);
//
//     advancedPlayer.durationHandler = (d) => setState(() {
//       _duration = d;
//     });
//
//     advancedPlayer.positionHandler = (p) => setState(() {
//       _position = p;
//     });
//   }
//
//
//   Widget _tab(List<Widget> children) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             children: children
//                 .map((w) => Container(child: w, padding: EdgeInsets.all(6.0)))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _btn(String txt, VoidCallback onPressed) {
//     return ButtonTheme(
//       minWidth: 48.0,
//       child: Container(
//         width: 150,
//         height: 45,
//         child: RaisedButton(
//             shape:
//             RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             child: Text(txt),
//             color: Colors.pink[900],
//             textColor: Colors.white,
//             onPressed: onPressed),
//       ),
//     );
//   }
//
//   Widget slider() {
//     return Slider(
//         activeColor: Colors.black,
//         inactiveColor: Colors.pink,
//         value: _position.inSeconds.toDouble(),
//         min: 0.0,
//         max: _duration.inSeconds.toDouble(),
//         onChanged: (double value) {
//           setState(() {
//             seekToSecond(value.toInt());
//             value = value;
//           });
//         });
//   }
//
//   Widget localAudio() {
//     return _tab([
//       _btn('Play', () => audioCache.play(Soundz.NextFlyer,mode: PlayerMode.LOW_LATENCY, volume: 1, )),
//       _btn('Pause', () => advancedPlayer.pause()),
//       _btn('Stop', () => advancedPlayer.stop()),
//       slider()
//     ]);
//   }
//
//   void seekToSecond(int second) {
//     Duration newDuration = Duration(seconds: second);
//
//     advancedPlayer.seek(newDuration);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 1,
//       child: MainLayout(
//
//         layoutWidget: Column(
//           children: <Widget>[
//             localAudio(),
//             DreamBox(
//               width: 200,
//               height: 50,
//               icon: Iconz.News,
//               verse: 'test play function',
//               boxFunction: (){
//                 playSound(Soundz.NextFlyer);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class SoundsTestScreen extends StatefulWidget {

  const SoundsTestScreen({
    Key key
  }) : super(key: key);

  @override
  _SoundsTestScreenState createState() => _SoundsTestScreenState();
}

class _SoundsTestScreenState extends State<SoundsTestScreen> {
// -----------------------------------------------------------------------------
  /// --- LOCAL LOADING BLOCK
  final ValueNotifier<bool> _loading = ValueNotifier(false); /// tamam disposed
// -----------------------------------
  Future<void> _triggerLoading() async {
    _loading.value = !_loading.value;
    blogLoading(
      loading: _loading.value,
      callerName: 'BzAuthorsPage',
    );
  }
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

  }
// -----------------------------------------------------------------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {

      _triggerLoading().then((_) async {

        /// FUCK

        await _triggerLoading();
      });

      _isInit = false;
    }
    super.didChangeDependencies();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    super.dispose();
    _loading.dispose();
  }
// -----------------------------------------------------------------------------
  void initPlayer() {
    // advancedPlayer = new AudioPlayer();
    // audioCache = new AudioCache(fixedPlayer: advancedPlayer);
    //
    // advancedPlayer.durationHandler = (d) => setState(() {
    //   _duration = d;
    // });
    //
    // advancedPlayer.positionHandler = (p) => setState(() {
    //   _position = p;
    // });
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return DashBoardLayout(
        loading: _loading,
        listWidgets: <Widget>[

          WideButton(
            verse: 'The Voice',
            onTap: (){
              blog('fuck the voice');
            },
          ),

        ],
    );

  }
}
