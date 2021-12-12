import 'package:bldrs/db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/db/fire/ops/zone_ops.dart';
import 'package:bldrs/models/secondary_models/app_updates.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/zone_model.dart';
import 'package:bldrs/providers/bzz_provider.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/general_provider.dart';
import 'package:bldrs/providers/keywords_provider.dart';
import 'package:bldrs/providers/user_provider.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<void> controlHomeScreen(BuildContext context) async {

  /// A - SHOW AD FLYER

  /// B - APP STATE
  final bool _canContinue = await _initializeAppState(context);

  if (_canContinue == false){

  }

  else {

    /// C - USER MODEL
    await _initializeUserModel(context);

    /// D - ZONES
    await _initializeUserZone(context);

    /// E - SPONSORS
    await _initializeSponsors(context);

    /// F - KEYWORDS
    await _initializeKeywords(context);

    /// G - USER BZZ
    await _initializeUserBzz(context);

  }

}
// -----------------------------------------------------------------------------
Future<bool> _initializeAppState(BuildContext context) async {
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  await _generalProvider.getsetAppState(context);
  final AppState _appState = _generalProvider.appState;

  bool _canContinue = true;

  if (_appState.appUpdateRequired == true){

    _canContinue = false;
  }
  if (_appState.wordzUpdateRequired == true){

  }
  if (_appState.languageUpdateRequired == true){

  }
  if (_appState.termsUpdateRequired == true){

  }
  if (_appState.aboutBldrsUpdateRequired == true){

  }
  if (_appState.notificationsUpdateRequired == true){

  }
  if (_appState.sectionsUpdateRequired == true){

  }
  if (_appState.keywordsUpdateRequired == true){

  }
  if (_appState.zonesUpdateRequired == true){

  }

  return _canContinue;
}
// -----------------------------------------------------------------------------
Future<void> _initializeUserModel(BuildContext context) async {

  if (FireAuthOps.userIsSignedIn() == true){
    final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
    await _userProvider.getsetMyUserModel(context: context);
  }

}
// -----------------------------------------------------------------------------
Future<void> _initializeUserZone(BuildContext context) async {

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  final UserModel _myUserModel = _userProvider.myUserModel;

  if (_myUserModel != null && ZoneModel.zoneHasAllIDs(_myUserModel.zone)){

    await zoneProvider.getsetCurrentZoneAndCountryAndCity(context: context, zone: _myUserModel.zone);
    await zoneProvider.getsetUserCountryAndCity(context: context, zone: _myUserModel.zone);
    await zoneProvider.getsetContinentByCountryID(context: context, countryID: _myUserModel.zone.countryID);

  }

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
