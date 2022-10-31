import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/timers.dart';

class ClockRebuilder extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const ClockRebuilder({
    @required this.startTime,
    this.child,
    this.builder,
    this.duration,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final Duration duration;
  final DateTime startTime;
  final Widget Function(int timeDifference, Widget) builder;
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
  // --------------------
  @override
  void dispose() {
    timeDifference.dispose();
    super.dispose();
  }
  // -----------------------------------------------------------------------------
  final ValueNotifier<int> timeDifference = ValueNotifier(0);
  // --------------------
  Future<void> startClockRebuilder() async {

    if (mounted){

      final Duration _duration = widget.duration ?? const Duration(seconds: 1);

      await Future.delayed(_duration, () async {

        if (mounted){
          timeDifference.value = Timers.calculateTimeDifferenceInSeconds(
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
        child: widget.child,
        builder: (_, int _timeDifference, Widget child){

            return widget.builder(_timeDifference, child);

        }
    );

  }
// -----------------------------------------------------------------------------
}
