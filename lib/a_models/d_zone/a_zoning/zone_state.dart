import 'package:flutter/material.dart';

class ZoneState {

  const ZoneState({
    @required this.id,
    @required this.canCreateNewUsers,
    @required this.canCreateNewBzz,
    @required this.canCreateNewFlyers,
    @required this.localsCanReadBzz,
    @required this.localCanReadFlyers,
    @required this.globalsCanReadBzz,
    @required this.globalsCanReadFlyers,
  });

  final String id;

  /// CREATION
  final bool canCreateNewUsers;
  final bool canCreateNewBzz;
  final bool canCreateNewFlyers;

  /// LOCAL READING
  final bool localsCanReadBzz;
  final bool localCanReadFlyers;
  /// GLOBAL READING
  final bool globalsCanReadBzz;
  final bool globalsCanReadFlyers;


  static bool canViewHomeWall({
    @required ZoneState zoneState,
    @required bool isLocal,
  }) {
    if (isLocal) {
      return zoneState.localsCanReadBzz;
    } else {
      return zoneState.globalsCanReadBzz;
    }
  }

  // static bool canCreateUser


}
