import 'dart:async';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/auth_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/i_flyer/h_0_flyer_screen.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/zone_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
Future<void> initializeHomeScreen(BuildContext context) async {
  /// A - SHOW AD FLYER

  /// C - USER MODEL
  await _initializeUserModel(context);

  /// D - ZONES
  await _initializeUserZone(context);

  /// E - PROMOTED FLYERS
  unawaited(_initializePromotedFlyers(context));

  /// F - SPONSORS : USES BZZ PROVIDER
  await _initializeSponsors(
    context: context,
    notify: true,
  );

  /// G - USER BZZ : USES BZZ PROVIDER
  await _initializeUserBzz(
    context: context,
    notify: true,
  );

  /// H - USER FOLLOWED BZZ : USES BZZ PROVIDER
  await _initializeUserFollowedBzz(
    context: context,
    notify: true
  );

  /// I - KEYWORDS
  await _initializeSpecsAndKeywords(context);

  /// J - SAVED FLYERS
  await _initializeSavedFlyers(context);

}
// -----------------------------------------------------------------------------
Future<void> _initializeUserModel(BuildContext context) async {

  if (AuthModel.userIsSignedIn() == true) {

    final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _userProvider.myUserModel;

    if (_myUserModel == null){

      await _userProvider.getsetMyUserModelAndCountryAndCity(context);

    }

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
Future<void> _initializeSponsors({
  @required BuildContext context,
  @required bool notify,
}) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.getSetSponsors(
    context: context,
    notify: notify,
  );
}
// -----------------------------------------------------------------------------
Future<void> _initializeSpecsAndKeywords(BuildContext context) async {
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  await _chainsProvider.getSetAllChains(context);
}
// -----------------------------------------------------------------------------
Future<void> _initializeUserBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.getSetMyBzz(
    context: context,
    notify: notify,
  );
}
// -----------------------------------------------------------------------------
Future<void> _initializeUserFollowedBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.getsetFollowedBzz(
    context: context,
    notify: notify,
  );
}
// -----------------------------------------------------------------------------
Future<void> _initializePromotedFlyers(BuildContext context) async {
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  await _flyersProvider.getSetPromotedFlyers(context);

  /// OPEN FIRST PROMOTED FLYER IF POSSIBLE
  // final List<FlyerModel> _promotedFlyers = _flyersProvider.promotedFlyers;
  // if (Mapper.canLoopList(_promotedFlyers)){
  //   await Future.delayed(Ratioz.duration150ms, () async {
  //
  //      unawaited(Nav.openFlyer(
  //        context: context,
  //        flyer: _flyersProvider.promotedFlyers[0],
  //        isSponsored: true,
  //      ));
  //
  //   });
  // }
}
// -----------------------------------------------------------------------------
Future<void> _initializeSavedFlyers(BuildContext context) async {

  if (AuthModel.userIsSignedIn() == true ){

    final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _myUserModel = _userProvider.myUserModel;

    final List<String> _savedFlyersIDs = _myUserModel.savedFlyersIDs;

    if (Mapper.canLoopList(_savedFlyersIDs)){

      final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
      await _flyersProvider.getsetSavedFlyers(context);
    }

  }
}
// -----------------------------------------------------------------------------
bool initializeFlyersPagination({
  @required BuildContext context,
  @required ScrollController scrollController,
  @required bool canPaginate,
}) {

  bool _canPaginate = canPaginate;

  scrollController.addListener(() async {

    final double _maxScroll = scrollController.position.maxScrollExtent;
    final double _currentScroll = scrollController.position.pixels;
    // final double _screenHeight = Scale.superScreenHeight(context);
    const double _paginationHeightLight = Ratioz.horizon * 3;

    if (_maxScroll - _currentScroll <= _paginationHeightLight && _canPaginate == true){

      // blog('_maxScroll : $_maxScroll : _currentScroll : $_currentScroll : diff : ${_maxScroll - _currentScroll} : _delta : $_delta');

      _canPaginate = false;

      await readMoreFlyers(context);

      _canPaginate = true;

    }

  });

  return _canPaginate;
}
// -----------------------------------------------------------------------------
Future<void> readMoreFlyers(BuildContext context) async {
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  await _flyersProvider.paginateWallFlyers(context);
}
// -----------------------------------------------------------------------------
Future<void> onFlyerTap({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  // blog('OPENING FLYER ID : ${flyer?.id}');

  await Nav.goToNewScreen(context,
      FlyerScreen(
        flyerModel: flyer,
        flyerID: flyer.id,
        initialSlideIndex: 0,
      )
  );

}
// -----------------------------------------------------------------------------