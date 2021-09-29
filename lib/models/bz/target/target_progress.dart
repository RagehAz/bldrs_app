import 'package:flutter/foundation.dart';

class TargetProgress{
  final String targetID;
  final int objective;
  final int current;

  TargetProgress({
    @required this.targetID,
    @required this.objective,
    @required this.current,
  });

}