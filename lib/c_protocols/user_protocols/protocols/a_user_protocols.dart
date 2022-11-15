import 'package:bldrs/c_protocols/user_protocols/protocols/compose_users.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/fetch_users.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/renovate_users.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/wipe_users.dart';

class UserProtocols {
  // -----------------------------------------------------------------------------

  const UserProtocols();

  // -----------------------------------------------------------------------------

  /// COMPOSE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const compose = ComposeUserProtocols.compose;
  // -----------------------------------------------------------------------------

  /// FETCH

  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetch = FetchUserProtocols.fetchUser;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const fetchUsers = FetchUserProtocols.fetchUsers;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const refetch = FetchUserProtocols.refetch;
  // -----------------------------------------------------------------------------

  /// RENOVATE

  // --------------------
  /// TESTED : WORKS PERFECT
  static const renovate = RenovateUserProtocols.renovateUser;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateLocally = RenovateUserProtocols.updateLocally;
  // -----------------------------------------------------------------------------

  /// PARTIAL RENOVATIONS

  // --------------------
  /// TESTED : WORKS PERFECT
  static const completeUserZoneModels = RenovateUserProtocols.completeUserZoneModels;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const followingProtocol = RenovateUserProtocols.followingProtocol;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const savingFlyerProtocol = RenovateUserProtocols.savingFlyerProtocol;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const refreshUserDeviceModel = RenovateUserProtocols.refreshUserDeviceModel;
  // --------------------
  /// TESTED : WORKS PERFECT
  static const updateMyUserTopics = RenovateUserProtocols.updateMyUserTopics;
  // -----------------------------------------------------------------------------

  /// WIPE

  // --------------------
  /// TASK : TEST ME
  static const wipeUser = WipeUserProtocols.wipeMyUser;
  // -----------------------------------------------------------------------------
}
