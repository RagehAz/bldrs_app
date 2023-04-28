import 'dart:async';

import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/c_protocols/auth_protocols/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/router/bldrs_nav.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
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

  await initializeUserZone(context);

  /// D - ZONES
  await initializeCurrentZone(context);

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
        initializeUserBzz(
          context: context,
          notify: true,
        ),
        /// H - USER FOLLOWED BZZ : USES BZZ PROVIDER
        initializeUserFollowedBzz(
            context: context,
            notify: true
        ),
      ]);

  /// I - KEYWORDS
  unawaited(initializeAllChains(context));

}
// -----------------------------------------------------------------------------

/// USER MISSING FIELDS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> _checkIfUserIsMissingFields({
  @required BuildContext context,
}) async {
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');
  if (Authing.getUserID() != null){

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();
    final UserModel _userModel = await UserLDBOps.readUserOps(userID: _authModel?.id);

    if (_authModel != null){

      blog('_checkIfUserIsMissingFields');
      AuthModel.blogAuthModel(authModel: _authModel);

      final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
        context: context,
        userModel: _userModel,
      );

      /// MISSING FIELDS FOUND
      if (_thereAreMissingFields == true){

        await _controlMissingFieldsCase(
          context: context,
          userModel: _userModel,
        );

      }

    }

  }
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _controlMissingFieldsCase({
  @required BuildContext context,
  @required UserModel userModel,
}) async {

  await Formers.showUserMissingFieldsDialog(
    context: context,
    userModel: userModel,
  );

  await Nav.goToNewScreen(
      context: context,
      screen: UserEditorScreen(
        userModel: userModel,
        reAuthBeforeConfirm: false,
        canGoBack: true,
        validateOnStartup: true,
        // checkLastSession: true,
        onFinish: () async {

          await BldrsNav.restartAndRoute(
            context: context,
          );

        },
      )

  );

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeUserFollowedBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  // blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ START');
  if (Authing.userIsSignedIn() == true){
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
Future<void> initializeUserBzz({
  @required BuildContext context,
  @required bool notify,
}) async {
  // blog('initializeHomeScreen._initializeUserBzz : ~~~~~~~~~~ START');
  if (Authing.userIsSignedIn() == true){
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
Future<void> initializeUserZone(BuildContext context) async {
  // blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ START');

  final UsersProvider _userProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _myUserModel = _userProvider.myUserModel;

  if (_myUserModel != null){

    final ZoneModel _userZoneCompleted = await ZoneProtocols.completeZoneModel(
      context: context,
      incompleteZoneModel: _myUserModel?.zone,
    );

    UsersProvider.proSetMyUserModel(
      context: context,
      userModel: _myUserModel?.copyWith(zone: _userZoneCompleted),
      notify: true,
    );

  }
  // blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeCurrentZone(BuildContext context) async {
  // blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ START');

  final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);

  if (_zoneProvider.currentZone == null){

    final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    /// USER ZONE IS DEFINED
    if (_myUserModel?.zone != null && Authing.userIsSignedIn() == true){

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
Future<void> initializeAllChains(BuildContext context) async {
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
