import 'package:bldrs/models/target/target_progress.dart';
import 'package:bldrs/models/target/target_reward.dart';
import 'package:flutter/foundation.dart';

class TargetModel{
  final String id;
  final String name;
  final String description;
  final List<String> instructions;
  final TargetReward reward;
  final TargetProgress progress;

  const TargetModel({
    @required this.id,
    @required this.name,
    @required this.description,
    this.instructions,
    this.reward,
    this.progress,
  });
// -----------------------------------------------------------------------------
}
