import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/a_chain.dart';
import 'package:bldrs/a_models/d_zone/zone_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_user_profile_screen.dart';
import 'package:bldrs/b_views/d_user/b_user_editor_screen/a_user_editor_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/g_zoning/a_countries_screen/a_countries_screen.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/b_views/i_chains/a_pickers_screen/a_pickers_screen.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/zone_protocols/fire/zone_fire_ops.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/provider/flyers_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/provider/zone_provider.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------

/// INITIALIZATION

// --------------------
/// TESTED : WORKS PERFECT
Future<void> initializeHomeScreen(BuildContext context) async {

  await checkIfUserIsMissingFields(
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
// --------------------
/// TASK : USER MODEL SHOULD HAVE COMPLETE ZONE MODEL BY THIS POINT
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

  final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
  final UserModel _myUserModel = UsersProvider.proGetMyUserModel(
    context: context,
    listen: false,
  );

  /// USER ZONE IS DEFINED
  if (_myUserModel?.zone != null && AuthModel.userIsSignedIn() == true){

    await zoneProvider.fetchSetCurrentCompleteZone(
      context: context,
      zone: _myUserModel.zone,
      notify: true,
    );

  }

  /// USER ZONE IS NOT DEFINED
  else {

    final ZoneModel _zoneByIP = await ZoneFireOps.superGetZoneByIP(context);

    await zoneProvider.fetchSetCurrentCompleteZone(
      context: context,
      zone: _zoneByIP,
      notify: true,
    );

  }

  // blog('initializeHomeScreen._initializeCurrentZone : ~~~~~~~~~~ END');
}
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
Future<void> _initializeAllChains(BuildContext context) async {
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ START');
  final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
  await _chainsProvider.initializeAllChains(
    context: context,
    notify: true,
  );
  // blog('initializeHomeScreen._initializeAllChains : ~~~~~~~~~~ END');
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

/// USER MISSING FIELDS

// --------------------
/// TESTED : WORKS PERFECT
Future<void> checkIfUserIsMissingFields({
  @required BuildContext context,
}) async {
  // blog('initializeHomeScreen.checkIfUserIsMissingFields : ~~~~~~~~~~ START');
  if (AuthFireOps.superUserID() != null){

    final AuthModel _authModel = await AuthLDBOps.readAuthModel();

    final bool _thereAreMissingFields = Formers.checkUserHasMissingFields(_authModel?.userModel);

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
        userModel: authModel.userModel,
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
// -----------------------------------------------------------------------------

/// PYRAMIDS NAVIGATION

// --------------------
/// TESTED : WORKS PERFECT
List<NavModel> generateMainNavModels({
  @required BuildContext context,
  @required List<BzModel> bzzModels,
  @required ZoneModel currentZone,
  @required UserModel userModel,
}){

  final String _countryFlag = currentZone?.flag;

  return <NavModel>[

    /// SIGN IN
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.signIn),
      titleVerse: const Verse(
        text: 'phid_sign',
        translate: true,
      ),
      icon: Iconz.normalUser,
      screen: const AuthScreen(),
      iconSizeFactor: 0.6,
      canShow: AuthModel.userIsSignedIn() == false,
    ),

    /// QUESTIONS
    // NavModel(
    // id: NavModelID.questions,
    //   title: 'Questions',
    //   icon: Iconz.utPlanning,
    //   screen: const QScreen(),
    // ),

    /// MY PROFILE
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.profile),
      titleVerse: userModel?.name == null ?
      const Verse(
        text: 'phid_complete_my_profile',
        translate: true,
      )
          :
      Verse(
        text: userModel.name,
        translate: false,
      ),
      icon: userModel?.picPath ?? Iconz.normalUser,
      screen: const UserProfileScreen(),
      iconSizeFactor: userModel?.picPath == null ? 0.55 : 1,
      iconColor: Colorz.nothing,
      canShow: AuthModel.userIsSignedIn() == true,
      forceRedDot: userModel == null || Formers.checkUserHasMissingFields(userModel),
    ),

    /// SAVED FLYERS
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.savedFlyers),
      titleVerse: const Verse(
        text: 'phid_savedFlyers',
        translate: true,
      ),
      icon: Iconz.saveOff,
      screen: const SavedFlyersScreen(),
      canShow: AuthModel.userIsSignedIn() == true,
    ),

    /// SEPARATOR
    if (AuthModel.userIsSignedIn() == true && UserModel.checkUserIsAuthor(userModel) == true)
      null,

    /// MY BZZ
    ...List.generate(bzzModels.length, (index){

      final BzModel _bzModel = bzzModels[index];

      return NavModel(
          id: NavModel.getMainNavIDString(
            navID: MainNavModel.bz,
            bzID: _bzModel.id,
          ),
          titleVerse: Verse(
            text: _bzModel.name,
            translate: false,
          ),
          icon: _bzModel.logoPath,
          iconSizeFactor: 1,
          iconColor: Colorz.nothing,
          screen: const MyBzScreen(),
          onNavigate: (){

            final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
            _bzzProvider.setActiveBz(bzModel: _bzModel, notify: true);

          }
      );

    }),

    /// SEPARATOR
    null,

    /// ZONE
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.zone),
      icon: _countryFlag,
      screen: const CountriesScreen(
        selectCountryAndCityOnly: true,
        settingCurrentZone: true,
      ),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
      titleVerse: ZoneModel.generateObeliskVerse(
          context: context,
          zone: currentZone
      ),
    ),

    /// SEPARATOR
    null,

    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.settings),
      titleVerse: const Verse(
        text: 'phid_settings',
        translate: true,
      ),
      icon: Iconz.more,
      screen: const AppSettingsScreen(),
      iconSizeFactor: 0.6,
      iconColor: Colorz.nothing,
    ),

  ];
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onNavigate({
  @required int index,
  @required List<NavModel> models,
  @required ValueNotifier<ProgressBarModel> progressBarModel,
  @required BuildContext context,
  @required ValueNotifier<bool> isExpanded,
}) async {

  final NavModel _navModel = models[index];

  progressBarModel.value = progressBarModel.value?.copyWith(
    index: index,
  );
  // onTriggerExpansion();

  await Future.delayed(const Duration(milliseconds: 50), () async {

    if (_navModel.onNavigate != null){
      await _navModel.onNavigate();
    }

    await Nav.goToNewScreen(
      context: context,
      screen: _navModel.screen,
      transitionType: PageTransitionType.fade,
    );

    progressBarModel.value = ProgressBarModel.emptyModel();
    isExpanded.value = false;

  });


}
// -----------------------------------------------------------------------------

/// REFRESH WALL

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onRefreshHomeWall(BuildContext context) async {
  // final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  // final KeywordsProvider _keywordsProvider = Provider.of<KeywordsProvider>(context, listen: true);
  // final SectionClass.Section _currentSection = _keywordsProvider.currentSection;
  // final KW _currentKeyword = _keywordsProvider.currentKeyword;

  // await _flyersProvider.getsetWallFlyersBySectionAndKeyword(
  //   context: context,
  //   section: _currentSection,
  //   kw: _currentKeyword,
  // );

  blog('onRefreshHomeWall : SHOULD REFRESH SCREEN');

}
// -----------------------------------------------------------------------------

/// SETTING ACTIVE PHIDK

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSectionButtonTap(BuildContext context) async {

  final dynamic result = await Nav.goToNewScreen(
    context: context,
    transitionType: Nav.superHorizontalTransition(context),
    screen: PickersScreen(
      flyerTypeFilter: null,
      onlyUseCityChains: true,
      isMultipleSelectionMode: false,
      // onlyChainKSelection: false,
      pageTitleVerse: const Verse(
        text: 'phid_browse_flyers_by_keyword',
        translate: true,
      ),
      zone: ZoneProvider.proGetCurrentZone(
        context: context,
        listen: false,
      ),
    ),
  );

  if (result != null && result is String){

    await _setActivePhidK(
      context: context,
      phidK: result,
    );

  }

}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _setActivePhidK({
  @required BuildContext context,
  @required String phidK,
}) async {

  const bool deactivated = false;

  final List<Chain> allChains = ChainsProvider.proGetBldrsChains(
      context: context,
      onlyUseCityChains: false,
      listen: false
  );

  final String _chainID = Chain.getRootChainIDOfPhid(
    allChains: allChains,
    phid: phidK,
  );

  final FlyerType _flyerType = FlyerTyper.concludeFlyerTypeByChainID(
    chainID: _chainID,
  );

  /// A - if section is not active * if user is author or not
  if (deactivated == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final String _currentCityID = _zoneProvider.currentZone.cityID;

    final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: _flyerType
    );

    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse(
          text: '##Section "$_flyerTypePhid" is\nTemporarily closed in $_currentCityID',
          translate: true,
          variables: [_flyerTypePhid, _currentCityID]
      ),
      bodyVerse: Verse(
        text: '##The Bldrs in $_currentCityID are adding flyers everyday to properly present their markets.\nplease hold for couple of days and come back again.',
        translate: true,
        variables: _currentCityID,
      ),
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: const Verse(
              text: 'phid_inform_a_friend',
              translate: true,
            ),
            width: 133,
            onTap: () => Launcher.shareLink(
              context : context,
              link: Standards.bldrsWebSiteLink,
            ),
          ),

          DialogButton(
            verse: const Verse(
              text: 'phid_go_back',
              translate: true,
            ),
            color: Colorz.yellow255,
            verseColor: Colorz.black230,
            onTap: () => Nav.goBack(
              context: context,
              invoker: '_setActivePhidK.centerDialog',
            ),
          ),

        ],
      ),
    );
  }

  /// A - if section is active
  else {

    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(context, listen: false);
    await _keywordsProvider.changeHomeWallFlyerType(
      context: context,
      flyerType: _flyerType,
      phid: phidK,
      notify: true,
    );

  }


}
// -----------------------------------------------------------------------------
