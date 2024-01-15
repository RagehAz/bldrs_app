import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/user_editor_screen.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:fire/super_fire.dart';
import 'package:provider/provider.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeHomeScreen() async {

  await checkIfUserIsMissingFields();

  await initializeUserZone();

  /// D - ZONES
  await initializeCurrentZone();

  /// I - KEYWORDS
  unawaited(initializeAllChains());

}
// -----------------------------------------------------------------------------

/// USER MISSING FIELDS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> checkIfUserIsMissingFields() async {
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');

  final UserModel? _userModel = UsersProvider.proGetMyUserModel(
    context: getMainContext(),
    listen: false,
  );

  if (Authing.userIsSignedUp(_userModel?.signInMethod) == true){

    // _userModel?.blogUserModel(invoker: 'initializeHomeScreen.checkIfUserIsMissingFields');

    if (_userModel != null){

      // blog('_checkIfUserIsMissingFields');
      // AuthModel.blogAuthModel(authModel: _authModel);

      final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(
        userModel: _userModel,
      );

      /// MISSING FIELDS FOUND
      if (_thereAreMissingFields == true){

        await _controlMissingFieldsCase(
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
  required UserModel userModel,
}) async {

  // blog('_controlMissingFieldsCase');
  // userModel.blogUserModel(invoker: '_controlMissingFieldsCase');

  await Formers.showUserMissingFieldsDialog(
    userModel: userModel,
  );

  await BldrsNav.goToNewScreen(
      screen: UserEditorScreen(
        initialTab: UserEditorTab.pic,
        firstTimer: false,
        userModel: userModel,
        reAuthBeforeConfirm: false,
        canGoBack: true,
        validateOnStartup: true,
        // checkLastSession: true,
        onFinish: () async {

          await BldrsNav.restartAndRoute();

        },
      )

  );

}
// -----------------------------------------------------------------------------

/// ZONE INITIALIZATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeUserZone() async {
  // blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ START');

  final UsersProvider _userProvider = Provider.of<UsersProvider>(getMainContext(), listen: false);
  final UserModel? _myUserModel = _userProvider.myUserModel;

  if (_myUserModel != null){

    ZoneModel? _userZoneCompleted = _myUserModel.zone;

    _userZoneCompleted ??= await ZoneProtocols.getZoneByIP();

    _userZoneCompleted = await ZoneProtocols.completeZoneModel(
      incompleteZoneModel: _myUserModel.zone,
      invoker: 'initializeHomeScreen.initializeUserZone',
    );

    UsersProvider.proSetMyUserModel(
      userModel: _myUserModel.copyWith(zone: _userZoneCompleted),
      notify: true,
    );

  }
  // blog('initializeHomeScreen._initializeUserZone : ~~~~~~~~~~ END');
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeCurrentZone() async {
  // blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ START');

  // final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);

  /// NO NEED
  // if (_zoneProvider.currentZone == null){
  //
  //   final UserModel? _myUserModel =
  //
  //   /// USER ZONE IS DEFINED
  //   if (_myUserModel?.zone != null){// && Authing.userIsSignedUp(_myUserModel?.signInMethod) == true){
  //
  //     await _zoneProvider.setCurrentZone(
  //       zone: _myUserModel?.zone,
  //       setCountryOnly: false,
  //       notify: true,
  //       invoker: 'initializeHomeScreen.initializeCurrentZone',
  //     );
  //
  //   }
  //
  //   /// USER ZONE IS NOT DEFINED
  //   else {
  //
  //     final ZoneModel? _zoneByIP = await ZoneProtocols.getZoneByIP();
  //
  //     await _zoneProvider.setCurrentZone(
  //       zone: _zoneByIP,
  //       setCountryOnly: true,
  //       notify: true,
  //       invoker: 'initializeHomeScreen.initializeCurrentZone',
  //     );
  //
  //   }
  //
  // }
  //
  // else {
  //
  //   await _zoneProvider.setCurrentZone(
  //     zone: ZoneModel.planetZone,
  //     setCountryOnly: false,
  //     notify: true,
  //     invoker: 'initializeHomeScreen.initializeCurrentZone',
  //   );
  //
  // }

  // blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ END');
}
// -----------------------------------------------------------------------------

/// CHAIN INITIALIZATIONS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeAllChains() async {
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ START');
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
  await _chainsProvider.initializeAllChains(
    notify: true,
  );
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ END');
}
// -----------------------------------------------------------------------------
