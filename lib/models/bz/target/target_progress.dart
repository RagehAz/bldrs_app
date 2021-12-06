import 'package:flutter/foundation.dart';

class TargetProgress{
  final String targetID;
  final int objective;
  final int current;

  const TargetProgress({
    @required this.targetID,
    @required this.objective,
    @required this.current,
  });

}
