import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/keywords_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/zone_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<void> controlHomeScreen(BuildContext context) async {
  /// A - SHOW AD FLYER

  /// C - USER MODEL
  await _initializeUserModel(context);

  /// D - ZONES
  await _initializeUserZone(context);

  /// E - PROMOTED FLYERS
  await _initializePromotedFlyers(context);

  /// F - SPONSORS
  await _initializeSponsors(context);

  /// G - KEYWORDS
  await _initializeKeywords(context);

  /// H - USER BZZ
  await _initializeUserBzz(context);

}
// -----------------------------------------------------------------------------
Future<void> _initializeUserModel(BuildContext context) async {
  if (FireAuthOps.userIsSignedIn() == true) {
    final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
    await _userProvider.getsetMyUserModel(context: context);
  }
}
// -----------------------------------------------------------------------------
Future<void> _initializeUserZone(BuildContext context) async {
  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  final UserModel _myUserModel = _userProvider.myUserModel;

  /// WHEN USER IS AUTHENTICATED
  if (_myUserModel != null && ZoneModel.zoneHasAllIDs(_myUserModel.zone)) {
    await zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _myUserModel.zone);
    await zoneProvider.getsetUserCountryAndCity(context: context, zone: _myUserModel.zone);
    await zoneProvider.getsetContinentByCountryID(context: context, countryID: _myUserModel.zone.countryID);
  }

  /// WHEN USER IS ANONYMOUS
  else {
    final ZoneModel _zoneByIP = await superGetZone(context);

    await zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _zoneByIP);
    await zoneProvider.getsetUserCountryAndCity(context: context, zone: _zoneByIP);
    await zoneProvider.getsetContinentByCountryID(context: context, countryID: _zoneByIP.countryID);
  }
}
// -----------------------------------------------------------------------------
Future<void> _initializeSponsors(BuildContext context) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.fetchSponsors(context);
}
// -----------------------------------------------------------------------------
Future<void> _initializeKeywords(BuildContext context) async {
  final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: false);
  await _keywordsProvider.getsetAllKeywords(context);
}
// -----------------------------------------------------------------------------
Future<void> _initializeUserBzz(BuildContext context) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.getSetMyBzz(context);
}
// -----------------------------------------------------------------------------
Future<void> _initializePromotedFlyers(BuildContext context) async {

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  await _flyersProvider.getSetPromotedFlyers(context);

}
// -----------------------------------------------------------------------------
