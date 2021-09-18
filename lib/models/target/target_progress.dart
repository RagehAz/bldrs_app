import 'package:flutter/foundation.dart';

class TargetProgress{
  final String targetID;
  final double objective;
  final double current;

  TargetProgress({
    @required this.targetID,
    @required this.objective,
    @required this.current,
  });

}