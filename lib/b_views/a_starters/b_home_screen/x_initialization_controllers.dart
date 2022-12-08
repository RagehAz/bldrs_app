import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/a_user_editor_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeHomeScreen(BuildContext context) async {

  await _checkIfUserIsMissingFields(
    context: context,
  );

  await _initializeUserZone(context);

  /// D - ZONES
  await _initializeCurrentZone(context);

  await Future.wait(
      <Future<void>>[
        /// A - SHOW AD FLYER
        //
        /// E - PROMOTED FLYERS
        _initializePromotedFlyers(context),
        /// F - SPONSORS : USES BZZ PROVIDER
        _initializeSponsors(
          context: context,
          notify: true,
        ),
        /// G - USER BZZ : USES BZZ PROVIDER
        _initializeUserBzz(
          context: context,
          notify: true,
        ),
        /// H - USER FOLLOWED BZZ : USES BZZ PROVIDER
        _initializeUserFollowedBzz(
            context: context,
            notify: true
        ),
      ]);

  /// I - KEYWORDS
  unawaited(_initializeAllChains(context));

}
// -----------------------------------------------------------------------------

/// USER MISSING FIELDS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _checkIfUserIsMissingFields({
  @required BuildContext context,
}) async {
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');
  if (AuthFireOps.superUserID() != null){

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();

    final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
        context: context,
        userModel: _authModel?.userModel,
    );

    /// MISSING FIELDS FOUND
    if (_thereAreMissingFields == true){

      await _controlMissingFieldsCase(
        context: context,
        authModel: _authModel,
      );

    }

  }
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _controlMissingFieldsCase({
  @required BuildContext context,
  @required AuthModel authModel,
}) async {

  await Formers.showUserMissingFieldsDialog(
    context: context,
    userModel: authModel?.userModel,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: EditProfileScreen(
        userModel: authModel?.userModel,
        reAuthBeforeConfirm: false,
        canGoBack: true,
        validateOnStartup: true,
        // checkLastSession: true,
        onFinish: () async {
          await Nav.goBack(
            context: context,
            invoker: '_controlMissingFieldsCase',
          );
        },
      )

  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeUserFollowedBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  // blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ START');
  if (AuthModel.userIsSignedIn() == true){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    await _bzzProvider.fetchSetFollowedBzz(
      context: context,
      notify: notify,
    );
  }
  // blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeUserBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  // blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ START');
  if (AuthModel.userIsSignedIn() == true){
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    await _bzzProvider.fetchSetMyBzz(
      context: context,
      notify: notify,
    );
  }
  // blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ END');
}
// -----------------------------------------------------------------------------

/// ZONE INITIALIZATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeUserZone(BuildContext context) async {
  // blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ START');

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  if (_myUserModel != null){

    final ZoneModel _userZoneCompleted = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _myUserModel?.zone,
    );

    UsersProvider.proSetMyUserAndAuthModels(
      context: context,
      userModel: _myUserModel?.copyWith(zone: _userZoneCompleted),
      notify: true,
    );

  }
  // blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeCurrentZone(BuildContext context) async {
  // blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ START');

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  if (_zoneProvider.currentZone == null){

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    /// USER ZONE IS DEFINED
    if (_myUserModel?.zone != null && AuthModel.userIsSignedIn() == true){

      await _zoneProvider.fetchSetCurrentCompleteZone(
        context: context,
        zone: _myUserModel.zone,
        notify: true,
      );

    }

    /// USER ZONE IS NOT DEFINED
    else {

      final ZoneModel _zoneByIP = await ZoneProtocols.getZoneByIP(
        context: context,
      );

      await _zoneProvider.fetchSetCurrentCompleteZone(
        context: context,
        zone: _zoneByIP,
        notify: true,
      );

    }

  }

  // blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ END');
}
// -----------------------------------------------------------------------------

/// CHAIN INITIALIZATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeAllChains(BuildContext context) async {
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ START');
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  await _chainsProvider.initializeAllChains(
    context: context,
    notify: true,
  );
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ END');
}
// -----------------------------------------------------------------------------

/// SPONSORS AND ADS INITIALIZATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializeSponsors({
  @required BuildContext context,
  @required bool notify,
}) async {
  // blog('initializeHomeScreen._initializeSponsors : ~~~~~~~~~~ START');
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  await _bzzProvider.fetchSetSponsors(
    context: context,
    notify: notify,
  );
  // blog('initializeHomeScreen._initializeSponsors : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _initializePromotedFlyers(BuildContext context) async {
  // blog('initializeHomeScreen._initializePromotedFlyers : ~~~~~~~~~~ START');

  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);

  await _flyersProvider.fetchSetPromotedFlyers(
    context: context,
    notify: true,
  );

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
  // blog('initializeHomeScreen._initializePromotedFlyers : ~~~~~~~~~~ END');

}
// -----------------------------------------------------------------------------
