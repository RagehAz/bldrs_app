import 'package:mapper/mapper.dart';
import 'package:flutter/material.dart';

class HashGroup {
  // -----------------------------------------------------------------------------
  const HashGroup({
    @required this.id,
    @required this.hashtags,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final List<HashModel> hashtags;
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<HashModel> getHashModelsFromHashGroups({
    @required List<HashGroup> hashGroups,
    @required String id,
  }) {
    List<HashModel> _output = <HashModel>[];

    if (id != null && Mapper.checkCanLoopList(hashGroups) == true) {

      _output = hashGroups.firstWhere((HashGroup hashModel) => hashModel.id == id)?.hashtags;

    }

    return _output;
  }
  // -----------------------------------------------------------------------------
  void f(){}
}

class HashModel {
  // -----------------------------------------------------------------------------
  const HashModel({
    @required this.id,
    this.views = 0,
    this.searches = 0,
    this.used = 0,
  });
  // -----------------------------------------------------------------------------
  final String id;
  final int views;
  final int searches;
  final int used;
  // -----------------------------------------------------------------------------

  void f(){}
}
