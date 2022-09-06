import 'package:flutter/foundation.dart';

@immutable
class TargetReward{
  /// --------------------------------------------------------------------------
  const TargetReward({
    @required this.targetID,
    @required this.ankh,
    @required this.slides,
  });
  /// --------------------------------------------------------------------------
  final String targetID;
  final int ankh;
  final int slides;
  /// --------------------------------------------------------------------------
}
