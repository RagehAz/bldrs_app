import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/staging_model.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/user_profile_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/floating_flyer_type_selector/floating_flyer_type_selector.dart';
import 'package:bldrs/b_views/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:provider/provider.dart';

/*

wall order logic		        scoring logic
order dependencies		      scoring dependencies
following		                views
user interets		            sliding depth
ads - boosted flyers		    saves
trending		                bcard taps
time stamp		              follows
keywords relevancy		      calls
		                        reports
		                        hide
		                        invites
		                        shares
		                        review replies

 */

/// => TAMAM
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

  final String _countryFlag = currentZone?.icon;
  final bool _userIsSignedIn = Authing.userIsSignedIn();

  return <NavModel>[

    /// SIGN IN
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.signIn),
      titleVerse: const Verse(
        id: 'phid_sign',
        translate: true,
      ),
      icon: Iconz.normalUser,
      screen: const AuthScreen(),
      iconSizeFactor: 0.6,
      canShow: _userIsSignedIn == false,
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
        id: 'phid_complete_my_profile',
        translate: true,
      )
          :
      Verse(
        id: userModel.name,
        translate: false,
      ),
      icon: userModel?.picPath ?? Iconz.normalUser,
      screen: const UserProfileScreen(),
      iconSizeFactor: userModel?.picPath == null ? 0.55 : 1,
      iconColor: Colorz.nothing,
      canShow: _userIsSignedIn,
      forceRedDot: userModel == null || Formers.checkUserHasMissingFields(userModel: userModel),
    ),

    /// SAVED FLYERS
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.savedFlyers),
      titleVerse: const Verse(
        id: 'phid_savedFlyers',
        translate: true,
      ),
      icon: Iconz.saveOff,
      screen: const SavedFlyersScreen(),
      canShow: _userIsSignedIn,
    ),

    /// SEPARATOR
    if (_userIsSignedIn == true && UserModel.checkUserIsAuthor(userModel) == true)
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
            id: _bzModel.name,
            translate: false,
          ),
          icon: _bzModel.logoPath,
          iconSizeFactor: 1,
          iconColor: Colorz.nothing,
          screen: const MyBzScreen(),
          onNavigate: (){

            final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
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
      screen: () => ZoneSelection.goBringAZone(
        context: context,
        depth: ZoneDepth.city,
        zoneViewingEvent: ViewingEvent.homeView,
        settingCurrentZone: true,
        viewerCountryID: userModel?.zone?.countryID,
      ),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
      titleVerse: ZoneModel.generateObeliskVerse(
          zone: currentZone,
      ),
    ),

    /// SEPARATOR
    null,

    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.settings),
      titleVerse: const Verse(
        id: 'phid_settings',
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
  @required bool mounted,
}) async {

  final NavModel _navModel = models[index];

  setNotifier(
      notifier: progressBarModel,
      mounted: mounted,
      value: progressBarModel.value?.copyWith(
        index: index,
      ),
  );

  await Future.delayed(const Duration(milliseconds: 50), () async {

    if (_navModel.onNavigate != null){
      await _navModel.onNavigate();
    }

    if ( _navModel.screen is Function){
      await _navModel.screen();
    }

    else {
      await Nav.goToNewScreen(
        context: context,
        screen: _navModel.screen,
        // pageTransitionType: PageTransitionType.bottomToTop,
      );
    }

    setNotifier(
        notifier: progressBarModel,
        mounted: mounted,
        value: ProgressBarModel.emptyModel(),
    );

    UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);

  });

}
// -----------------------------------------------------------------------------

/// REFRESH WALL

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onRefreshHomeWall({
  @required BuildContext context,
  @required PaginationController paginationController,
  @required ValueNotifier<bool> loading,
  @required bool mounted,
}) async {
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

  setNotifier(notifier: loading, mounted: mounted, value: false);

  await Future.delayed(const Duration(milliseconds: 200), (){

    // paginationController.clear(
    //   mounted: mounted,
    // );

    // paginationController.

    setNotifier(notifier: loading, mounted: mounted, value: true);

  });



}
// -----------------------------------------------------------------------------

/// SETTING ACTIVE PHIDK

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSectionButtonTap(BuildContext context) async {

  final FlyerType flyerType = await Nav.goToNewScreen(
    context: context,
    pageTransitionType: Nav.superHorizontalTransition(context: context, inverse: true),
    screen: const FloatingFlyerTypeSelector(),
  );

  if (flyerType != null){

    final String phid = await PhidsPickerScreen.goPickPhid(
      context: context,
      flyerType: flyerType,
      event: ViewingEvent.homeView,
      onlyUseZoneChains: true,
      // selectedPhids:
    );

    if (phid != null){

      await setActivePhidK(
        phidK: phid,
        flyerType: flyerType,
      );

    }
  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> setActivePhidK({
  @required String phidK,
  @required FlyerType flyerType,
}) async {

  // blog('setActivePhidK : phidK : $phidK : for flyerType : $flyerType');

  const bool deactivated = false;

  /// WORKS GOOD : BUT DEPRECATED
  // final List<Chain> allChains = ChainsProvider.proGetBldrsChains(
  //     context: context,
  //     onlyUseZoneChains: false,
  //     listen: false
  // );
  // final String _chainID = Chain.getRootChainIDOfPhid(
  //   allChains: allChains,
  //   phid: phidK,
  // );
  // final FlyerType flyerType = FlyerTyper.concludeFlyerTypeByChainID(
  //   chainID: _chainID,
  // );

  /// A - if section is not active * if user is author or not
  if (deactivated == true) {

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(getMainContext(), listen: false);
    final String _cityName = _zoneProvider.currentZone.cityName;

    final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: flyerType
    );

    final String _title = '${Verse.transBake('phid_flyers_of')} '
                          '${Verse.transBake(_flyerTypePhid)} '
                          '${Verse.transBake('phid_are_not_available')} '
                          '${Verse.transBake('phid_inn')} '
                          '$_cityName';

    await CenterDialog.showCenterDialog(
      titleVerse: Verse(
          id: _title,
          translate: false,
      ),
      bodyVerse: const Verse(
        pseudo: 'The Bldrs in this city are adding flyers everyday to'
                ' properly present their markets.'
                '\nplease hold for couple of days and come back again.',
        id: 'phid_businesses_are_still_adding_flyers',
        translate: true,
      ),
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          DialogButton(
            verse: const Verse(
              id: 'phid_inform_a_friend',
              translate: true,
            ),
            width: 133,
            onTap: () => Launcher.shareBldrsWebsiteURL(),
          ),

          DialogButton(
            verse: const Verse(
              id: 'phid_go_back',
              translate: true,
            ),
            color: Colorz.yellow255,
            verseColor: Colorz.black230,
            onTap: () => Nav.goBack(
              context: getMainContext(),
              invoker: '_setActivePhidK.centerDialog',
            ),
          ),

        ],
      ),
    );
  }

  /// A - if section is active
  else {

    final ChainsProvider _keywordsProvider = Provider.of<ChainsProvider>(getMainContext(), listen: false);
    await _keywordsProvider.changeHomeWallFlyerType(
      flyerType: flyerType,
      phid: phidK,
      notify: true,
    );

  }


}
// -----------------------------------------------------------------------------
