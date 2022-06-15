import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;

class ClockRebuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ClockRebuilder({
    this.builder,
    this.duration,
    this.startTime,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Duration duration;
  final DateTime startTime;
  final Widget Function(int timeDifference) builder;
  /// --------------------------------------------------------------------------
  @override
  _ClockRebuilderState createState() => _ClockRebuilderState();
/// --------------------------------------------------------------------------
}

class _ClockRebuilderState extends State<ClockRebuilder> {
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    startClockRebuilder();
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    timeDifference.dispose();
    super.dispose();
  }
// -----------------------------------------------------------------------------
  final ValueNotifier<int> timeDifference = ValueNotifier(0);
// ---------------------------------------------------------
  Future<void> startClockRebuilder() async {

    if (mounted){

      final Duration _duration = widget.duration ?? const Duration(seconds: 1);

      await Future.delayed(_duration, () async {

        if (mounted){
          timeDifference.value = Timers.getTimeDifferenceInSeconds(
              from: widget.startTime,
              to: DateTime.now(),
          );
          await startClockRebuilder();
        }

      });

    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
        valueListenable: timeDifference,
        builder: (_, int _timeDifference, Widget child){

          return widget.builder(_timeDifference);

        }
    );

  }

}