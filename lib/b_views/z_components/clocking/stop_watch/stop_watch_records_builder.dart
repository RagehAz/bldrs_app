import 'package:bldrs/b_views/z_components/clocking/stop_watch/stop_watch_controller.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchRecordsBuilder extends StatelessWidget {
  /// -----------------------------------------------------------------------------
  const StopWatchRecordsBuilder({
    @required this.controller,
    @required this.builder,
    Key key
  }) : super(key: key);
  /// -----------------------------------------------------------------------------
  final StopWatchController controller;
  final Widget Function(List<StopWatchRecord> records) builder;
  /// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<StopWatchRecord>>(
      stream: controller.timer.records,
      initialData: controller.timer.records.value,
      builder: (BuildContext context, AsyncSnapshot<List<StopWatchRecord>> snap) {

        final List<StopWatchRecord> records = snap.data;

        return builder(records);

      },
    );

  }
  /// -----------------------------------------------------------------------------
}
