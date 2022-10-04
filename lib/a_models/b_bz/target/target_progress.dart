import 'package:flutter/foundation.dart';

@immutable
class TargetProgress{
  /// --------------------------------------------------------------------------
  const TargetProgress({
    @required this.targetID,
    @required this.objective,
    @required this.current,
  });
  /// --------------------------------------------------------------------------
  final String targetID;
  final int objective;
  final int current;
  /// --------------------------------------------------------------------------
}
