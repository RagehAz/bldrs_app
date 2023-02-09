import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopWatchController {
  // -----------------------------------------------------------------------------
  StopWatchController({
    this.onStart,
    this.onStop,
    this.onLap,
    this.onPause,
  });
  // -----------------------------------------------------------------------------
  final Function onStart;
  final Function onPause;
  final Function onLap;
  final Function onStop;
  // -----------------------------------------------------------------------------

  /// STOPWATCH SINGLETON

  // --------------------
  /// TIMER INSTANCE
  StopWatchTimer _timer;
  StopWatchTimer get timer => _timer ??= StopWatchTimer();
  // -----------------------------------------------------------------------------

  /// DISPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  void dispose() {
    _timer?.dispose();
  }
  // -----------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  void start() {
    _timer.onExecute.add(StopWatchExecute.start);

    if (onStart != null){
      onStart();
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void pause() {
    _timer.onExecute.add(StopWatchExecute.stop);

    if (onPause != null){
      onPause();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void lap() {
    _timer.onExecute.add(StopWatchExecute.lap);

    if (onLap != null){
      onLap();
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void stop() {
    _timer.onExecute.add(StopWatchExecute.reset);
    if (onStop != null){
      onStop();
    }
  }
  // -----------------------------------------------------------------------------
}
