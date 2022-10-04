import 'package:bldrs/a_models/b_bz/target/target_progress.dart';
import 'package:bldrs/a_models/b_bz/target/target_reward.dart';
import 'package:flutter/foundation.dart';

@immutable
class TargetModel {
  /// --------------------------------------------------------------------------
  const TargetModel({
    @required this.id,
    @required this.name,
    @required this.description,
    this.instructions,
    this.reward,
    this.progress,
  });

  /// --------------------------------------------------------------------------
  final String id;
  final String name;
  final String description;
  final List<String> instructions;
  final TargetReward reward;
  final TargetProgress progress;

  /// --------------------------------------------------------------------------
}
