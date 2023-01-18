import 'dart:async';

import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_stages.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/a_models/x_ui/nav_model.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_user_profile_screen.dart';
import 'package:bldrs/b_views/e_saves/a_saved_flyers_screen/a_saved_flyers_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/g_zoning/x_zone_selection_ops.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/b_views/i_phid_picker/floating_flyer_type_selector/floating_flyer_type_selector.dart';
import 'package:bldrs/b_views/i_phid_picker/phids_picker_screen.dart';
import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/dialog_button.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/provider/zone_provider.dart';
import 'package:bldrs/f_helpers/drafters/formers.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
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
      forceRedDot: userModel == null || Formers.checkUserHasMissingFields(userModel: userModel, context: context),
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
      // screen: const CountriesScreen(
      //   zoneViewingEvent: ZoneViewingEvent.homeView,
      //   depth: ZoneDepth.district,
      //   settingCurrentZone: true,
      //
      //   // selectCountryAndCityOnly: true,
      // ),
      screen: () => ZoneSelection.goBringAZone(
        context: context,
        depth: ZoneDepth.district,
        zoneViewingEvent: ViewingEvent.homeView,
        settingCurrentZone: true,
      ),
      iconSizeFactor: 1,
      iconColor: Colorz.nothing,
      titleVerse: ZoneModel.generateObeliskVerse(
          context: context,
          zone: currentZone,
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
        pageTransitionType: PageTransitionType.fade,
      );
    }

    setNotifier(notifier: progressBarModel, mounted: mounted, value: ProgressBarModel.emptyModel());
    UiProvider.proSetPyramidsAreExpanded(context: context, setTo: false, notify: true);

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

  final FlyerType flyerType = await Nav.goToNewScreen(
    context: context,
    pageTransitionType: Nav.superHorizontalTransition(context, inverse: true),
    screen: const FloatingFlyerTypeSelector(),
  );

  if (flyerType != null){

    final String phid = await Nav.goToNewScreen(
      context: context,
      pageTransitionType: Nav.superHorizontalTransition(context),
      screen: PhidsPickerScreen(
        chainsIDs: FlyerTyper.getChainsIDsPerViewingEvent(
          context: context,
          flyerType: flyerType,
          event: ViewingEvent.homeView,
        ),
        onlyUseCityChains: true,
      ),
    );

    if (phid != null){

      await _setActivePhidK(
        context: context,
        phidK: phid,
        flyerType: flyerType,
      );

    }
  }


}
// --------------------
/// TESTED : WORKS PERFECT
Future<void> _setActivePhidK({
  @required BuildContext context,
  @required String phidK,
  @required FlyerType flyerType,
}) async {

  const bool deactivated = false;

  /// WORKS GOOD : BUT DEPRECATED
  // final List<Chain> allChains = ChainsProvider.proGetBldrsChains(
  //     context: context,
  //     onlyUseCityChains: false,
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

    final ZoneProvider _zoneProvider = Provider.of<ZoneProvider>(context, listen: false);
    final String _cityName = _zoneProvider.currentZone.cityName;

    final String _flyerTypePhid = FlyerTyper.getFlyerTypePhid(
        flyerType: flyerType
    );

    final String _title = '${Verse.transBake(context, 'phid_flyers_of')} '
                          '${Verse.transBake(context, _flyerTypePhid)} '
                          '${Verse.transBake(context, 'phid_are_not_available')} '
                          '${Verse.transBake(context, 'phid_inn')} '
                          '$_cityName';


    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: Verse(
          text: _title,
          translate: false,
      ),
      bodyVerse: const Verse(
        pseudo: 'The Bldrs in this city are adding flyers everyday to'
                ' properly present their markets.'
                '\nplease hold for couple of days and come back again.',
        text: 'phid_businesses_are_still_adding_flyers',
        translate: true,
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
      flyerType: flyerType,
      phid: phidK,
      notify: true,
    );

  }


}
// -----------------------------------------------------------------------------
