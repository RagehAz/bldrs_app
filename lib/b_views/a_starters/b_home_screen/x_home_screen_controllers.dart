import 'dart:async';

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/checks/tracers.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zoning/world_zoning.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/home_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/z_components/static_progress_bar/progress_bar_model.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/zz_archives/d_home_flyer_type_selector/floating_flyer_type_selector.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*

wall order logic		        scoring logic
order dependencies		      scoring dependencies
following		                views
user interests		            sliding depth
ads - boosted flyers		    saves
trending		                bz card taps
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
List<NavModel?> generateMainNavModels({
  required List<BzModel>? bzzModels,
  required ZoneModel? currentZone,
  required UserModel? userModel,
}){

  final String _countryFlag = currentZone?.icon ?? Iconz.planet;
  final bool _userIsSignedUp = Authing.userIsSignedUp(userModel?.signInMethod);

  // blog('generateMainNavModels() _userIsSignedUp: $_userIsSignedUp : ${userModel?.signInMethod}');

  return <NavModel?>[

    /// SIGN IN
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.signIn),
      titleVerse: const Verse(
        id: 'phid_sign',
        translate: true,
      ),
      icon: Iconz.normalUser,
      screen: RouteName.auth,
      iconSizeFactor: 0.6,
      canShow: _userIsSignedUp == false,

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
      const Verse(id: 'phid_complete_my_profile', translate: true)
          :
      Verse(id: userModel?.name, translate: false),
      icon: userModel?.picPath ?? Iconz.normalUser,
      screen: RouteName.myUserProfile,
      iconSizeFactor: userModel?.picPath == null ? 0.55 : 1,
      iconColor: Colorz.nothing,
      canShow: _userIsSignedUp,
      forceRedDot: userModel == null || Formers.checkUserHasMissingFields(userModel: userModel),
    ),

    /// SAVED FLYERS
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.savedFlyers),
      titleVerse: const Verse(
        id: 'phid_savedFlyers',
        translate: true,
      ),
      icon: Iconz.love,
      screen: RouteName.savedFlyers,
      canShow: _userIsSignedUp,
    ),

    /// SEPARATOR
    if (_userIsSignedUp == true && UserModel.checkUserIsAuthor(userModel) == true)
      null,

    /// MY BZZ
    if (Lister.checkCanLoop(bzzModels) == true)
    ...List.generate(bzzModels!.length, (index){

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
          screen: RouteName.myBzFlyersPage,
          onNavigate: () async {

            await HomeProvider.proSetActiveBzByID(
                bzID: _bzModel.id,
                context: getMainContext(),
                notify: true
            );

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
        depth: ZoneDepth.city,
        zoneViewingEvent: ViewingEvent.homeView,
        settingCurrentZone: true,
        viewerZone: userModel?.zone,
        selectedZone: ZoneProvider.proGetCurrentZone(context: getMainContext(), listen: false),
      ),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
      titleVerse: ZoneModel.generateObeliskVerse(
          zone: currentZone,
      ),
    ),

    /// SEPARATOR
    null,

    /// ON BOARDING
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.onBoarding),
      titleVerse: const Verse(
        id: 'phid_what_is_bldrs',
        translate: true,
      ),
      icon: Iconz.bldrsNameSquare,
      iconSizeFactor: 0.6,
      iconColor: Colorz.nothing,
      screen: () => OnBoardingScreen.goToOnboardingScreen(
        showDontShowAgainButton: false,
      ),
    ),

    /// SETTINGS
    NavModel(
      id: NavModel.getMainNavIDString(navID: MainNavModel.settings),
      titleVerse: const Verse(
        id: 'phid_settings',
        translate: true,
      ),
      icon: Iconz.more,
      screen: RouteName.appSettings,
      iconSizeFactor: 0.6,
      iconColor: Colorz.nothing,
    ),

  ];
}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> onNavigate({
  required int index,
  required List<NavModel?> models,
  required ValueNotifier<ProgressBarModel?>? progressBarModel,
  required BuildContext context,
  required bool mounted,
}) async {

  final NavModel? _navModel = models[index];

  setNotifier(
      notifier: progressBarModel,
      mounted: mounted,
      value: progressBarModel?.value?.copyWith(
        index: index,
      ),
  );

  await Future.delayed(const Duration(milliseconds: 50), () async {

    setNotifier(
      notifier: progressBarModel,
      mounted: mounted,
      value: ProgressBarModel.emptyModel(),
    );

    if (_navModel?.onNavigate != null){
      await _navModel?.onNavigate?.call();
    }

    if ( _navModel?.screen is Function){
      await _navModel?.screen();
    }

    else if (_navModel?.screen is String){
      await Nav.goToRoute(context, _navModel!.screen);
    }

    else if (_navModel?.screen is Widget){
      await BldrsNav.goToNewScreen(
        screen: _navModel?.screen,
        // pageTransitionType: PageTransitionType.bottomToTop,
      );
    }

    UiProvider.proSetPyramidsAreExpanded(setTo: false, notify: true);

  });

}
// -----------------------------------------------------------------------------

/// REFRESH WALL

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onRefreshHomeWall({
  required BuildContext context,
  required PaginationController paginationController,
  required ValueNotifier<bool> loading,
  required bool mounted,
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
Future<void> onSectionButtonTap() async {

  final FlyerType? flyerType = await BldrsNav.goToNewScreen(
    screen: const FloatingFlyerTypeSelector(),
  );

  if (flyerType != null){

    final String? phid = await PhidsPickerScreen.goPickPhid(
      flyerType: flyerType,
      event: ViewingEvent.homeView,
      onlyUseZoneChains: true,
      slideScreenFromEnLeftToRight: true,
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
  required String? phidK,
  required FlyerType? flyerType,
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
    final String? _cityName = _zoneProvider.currentZone?.cityName;

    final String? _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: flyerType
    );

    final String _title = '${getWord('phid_flyers_of')} '
                          '${getWord(_flyerTypePhid)} '
                          '${getWord('phid_are_not_available')} '
                          '${getWord('phid_inn')} '
                          '$_cityName';

    await BldrsCenterDialog.showCenterDialog(
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
