import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchCounterBuilder extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const StopWatchCounterBuilder({
    @required this.controller,
    @required this.builder,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final StopWatchController controller;
  final Widget Function(String displayTime) builder;
  /// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<int>(
      stream: controller.timer.rawTime,
      initialData: controller.timer.rawTime.value,
      builder: (BuildContext context, AsyncSnapshot<int> snap) {

        final int value = snap.data;
        final String displayTime = StopWatchTimer.getDisplayTime(value, hours: true);

        return builder(displayTime);

      },
    );

  }
  /// -----------------------------------------------------------------------------
}
