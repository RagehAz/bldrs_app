// ignore_for_file: non_constant_identifier_names
import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/strings/text_check.dart';
import 'package:basics/layouts/nav/nav.dart';
import 'package:basics/mediator/models/dimension_model.dart';
import 'package:basics/super_image/super_image.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/c_team_page/bz_team_page_controllers.dart';
import 'package:bldrs/b_views/j_flyer/b_slide_full_screen/a_slide_full_screen.dart';
import 'package:bldrs/b_views/j_flyer/z_components/c_groups/grid/components/zoomable_flyers_grid.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:bldrs/z_grid/z_grid.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class BldrsNav {
  // -----------------------------------------------------------------------------

  const BldrsNav();

  // -----------------------------------------------------------------------------

  /// BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> backFromHomeScreen({
    required BuildContext context,
    required ZGridController? zGridController,
  }) async {

      final bool _flyerIsOpen = !UiProvider.proGetLayoutIsVisible(
          context: getMainContext(),
          listen: false,
      );

      /// CLOSE FLYER
      if (_flyerIsOpen == true){

        await zoomOutFlyer(
          context: context,
          mounted: true,
          controller: zGridController,
        );

      }

      /// CLOSE APP
      else {

        final String? _currentPhid = ChainsProvider.proGetHomeWallPhid(
            context: context,
            listen: false,
        );

        /// WHILE WALL HAS PHID
        if (_currentPhid != null){

            final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
            await _chainsProvider.changeHomeWallFlyerType(
              notify: true,
              flyerType: null,
              phid: null,
            );

        }

        else {

          if (kIsWeb == false){

            final bool _result = await Dialogs.goBackDialog(
              titleVerse: const Verse(
                id: 'phid_exit_app_?',
                translate: true,
              ),
              bodyVerse: const Verse(
                id: 'phid_exit_app_notice',
                translate: true,
              ),
              confirmButtonVerse: const Verse(
                id: 'phid_exit',
                translate: true,
              ),
            );

            if (_result == true) {

              await BldrsCenterDialog.closeCenterDialog();

              await Future.delayed(
                const Duration(milliseconds: 500),
                    () async {
                  await Nav.closeApp();
                  },
              );

            }

          }

        }

      }

  }
  // -----------------------------------------------------------------------------

  /// LOADING

  // --------------------
  /// staticLogoScreen - animatedLogoScreen
  static Future<void> pushLogoRouteAndRemoveAllBelow({
    required bool animatedLogoScreen,
  }) async {


    if (animatedLogoScreen){
      await Nav.pushNamedAndRemoveAllBelow(
        context: getMainContext(),
        goToRoute: RouteName.animatedLogo,
      );
    }
    else {

      /// we already remove this layer in
      // Navigator.popUntil(context, ModalRoute.withName(Routing.logoScreen));

      await Nav.pushNamedAndRemoveAllBelow(
        context: getMainContext(),
        goToRoute: RouteName.staticLogo,
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// MAIN

  // --------------------
  /// home
  static Future<void> pushHomeRouteAndRemoveAllBelow() async {

    await Nav.pushNamedAndRemoveAllBelow(
      goToRoute: RouteName.home,
      context: getMainContext(),
    );

  }
  // --------------------
  /// auth
  static Future<void> pushAuthRoute() async {

    await Nav.goToRoute(getMainContext(), RouteName.auth);

  }
  // --------------------
  /// search
  static Future<void> pushSearchRoute() async {
    await Nav.goToRoute(getMainContext(), RouteName.search);
  }
  // --------------------
  /// appSettings
  static Future<void> pushAppSettingsRoute() async {
    await Nav.goToRoute(getMainContext(), RouteName.appSettings);
  }
  // -----------------------------------------------------------------------------

  /// PROFILE

  // --------------------
  /// user : profile - notifications - following - settings
  static Future<void> pushMyUserScreen({
    UserTab userTab = UserTab.profile,
  }) async {

    String? _path;

    switch (userTab){
      case UserTab.profile: _path =       RouteName.myUserProfile; break;
      case UserTab.notifications: _path = RouteName.myUserNotes; break;
      case UserTab.following: _path =     RouteName.myUserFollowing; break;
      case UserTab.settings: _path =      RouteName.myUserSettings; break;
    }

    await Nav.goToRoute(getMainContext(), _path);

    // await Nav.goToNewScreen(
    //   context: getMainContext(),
    //   screen: UserProfileScreen(
    //     userTab: userTab,
    //   ),
    // );

  }
  // --------------------
  /// savedFlyers
  static Future<void> pushSavedFlyersRoute() async {
    await Nav.goToRoute(getMainContext(), RouteName.savedFlyers);
  }
  // --------------------
  /// profileEditor
  /*
    HANDLED MANUALLY BY
    [onEditProfileTap]
    [_goToUserEditorForFirstTime]
    [_controlMissingFieldsCase]
  */
  // ------------------------------------------------------------

  /// MY BZ

  // --------------------
  /// myBzAboutPage - myBzFlyersPage - myBzTeamPage - myBzNotesPage
  static Future<void> goToMyBzScreen({
    required String? bzID,
    required bool replaceCurrentScreen,
    BzTab initialTab = BzTab.flyers,
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);

    final BzModel? _bzModel = await BzProtocols.fetchBz(
      bzID: bzID,
    );

    _bzzProvider.setActiveBz(
      bzModel: _bzModel,
      notify: true,
    );

    if (replaceCurrentScreen == true){
      await Nav.replaceScreen(
          context: getMainContext(),
          screen: MyBzScreen(
            initialTab: initialTab,
          )
      );
    }

    else {
      await Nav.goToNewScreen(
          context: getMainContext(),
          screen: MyBzScreen(
            initialTab: initialTab,
          )
      );
    }

  }
  // --------------------
  /// REBOOT TO INIT NEW BZ SCREEN
  static Future<void> goRebootToInitNewBzScreen({
    required BzModel? bzModel,
  }) async {

    if (bzModel != null){

      await onGoToAuthorEditorScreen(
        bzModel: bzModel,
        authorModel: AuthorModel.getAuthorFromBzByAuthorID(
          bz: bzModel,
          authorID: Authing.getUserID(),
        ),
        navAfterDone: false,
      );

      UiProvider.proSetAfterHomeRoute(
        routeName: RouteName.myBzAboutPage,
        arguments: bzModel.id,
        notify: true,
      );

      await pushLogoRouteAndRemoveAllBelow(
        animatedLogoScreen: true,
      );

    }

  }
  // --------------------
  /// bzEditor
  /*
    HANDLED MANUALLY BY
    [onEditBzButtonTap]
    [onCreateNewBzTap]
  */
  // --------------------
  /// flyerEditor
  /*
    HANDLED MANUALLY BY
    [_onEditFlyerButtonTap]
    [goToFlyerMaker]
  */
  // ------------------------------------------------------------

  /// PREVIEWS

  // --------------------
  /// userPreview
  static Future<void> jumpToUserPreviewScreen({
    required String? userID,
  }) async {

    if (userID != null){

      // await Nav.goToNewScreen(
      //   context: getMainContext(),
      //   screen: UserPreviewScreen(
      //     userID: userID,
      //   ),
      // );

      final String _route = '${RouteName.userPreview}:$userID';
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// bzPreview
  static Future<void> jumpToBzPreviewScreen({
    required String? bzID,
  }) async {

    if (bzID != null){

      // await Nav.goToNewScreen(
      //   context: getMainContext(),
      //   screen: BzPreviewScreen(
      //     bzID: bzID,
      //   ),
      // );

      final String _route = '${RouteName.bzPreview}:$bzID';
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// flyerPreview
  static Future<void> jumpToFlyerPreviewScreen({
    required String? flyerID,
  }) async {

    if (flyerID != null){

      // await Nav.goToNewScreen(
      //   context: getMainContext(),
      //   screen: FlyerPreviewScreen(
      //     flyerID: flyerID,
      //     // reviewID: ,
      //     // bzModel: _bzModel,
      //   ),
      // );

      final String _route = '${RouteName.flyerPreview}:$flyerID';
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// flyerReviews
  static Future<void> jumpToFlyerReviewScreen({
    required String? flyerID_reviewID,
  }) async {

    /// TASK : DO JUMP TO REVIEW THING
    /*

    In this method [NoteEvent.sendFlyerReceivedNewReviewByMe]

    The trigger to come here was :-

    TriggerModel(
        name: Routing.flyerReviews,
        argument: ChainPathConverter.combinePathNodes([
          reviewModel.flyerID, // index 0
          reviewModel.id, // index 1
        ]),

     */

    if (flyerID_reviewID != null){

      // final String? _flyerID = ReviewModel.getFlyerIDFromLinkPart(
      //     linkPart: flyerID_reviewID,
      // );
      // final String? _reviewID = ReviewModel.getReviewIDFromLinkPart(
      //     linkPart: flyerID_reviewID,
      // );
      //
      // if (_flyerID != null && _reviewID != null){
      //
      //   await Nav.goToNewScreen(
      //     context: getMainContext(),
      //     screen: FlyerPreviewScreen(
      //       flyerID: _flyerID,
      //       reviewID: _reviewID,
      //     ),
      //   );
      //
      // }

      final String _route = '${RouteName.flyerReviews}:$flyerID_reviewID';
      blog('jumpToFlyerReviewScreen : _route : $_route');
      await Nav.goToRoute(getMainContext(), _route);

    }

  }
  // --------------------
  /// countryPreview
  /*
  static Future<void> jumpToCountryPreviewScreen({
    required BuildContext context,
    required String countryID,
  }) async {

    if (countryID != null){

      final CountryModel _countryModel = await ZoneProtocols.fetchCountry(
          countryID: countryID,
      );

      if (_countryModel != null){

        blog('should go to Country preview screen');

        // await Nav.goToNewScreen(
        //   context: context,
        //   screen: CountryPreviewScreen(),
        // );

      }

    }

  }
   */
  // ------------------------------------------------------------

  /// WEB

  // --------------------
  /// underConstruction
  static Future<void> pushBldrsUnderConstructionRoute() async {
    await Nav.goToRoute(getMainContext(), RouteName.underConstruction);
    // await Nav.goToNewScreen(context: getMainContext(), screen: const BldrsUnderConstructionScreen());
  }
  // --------------------
  /// banner
  static Future<void> pushBannerRoute() async {
    await Nav.goToRoute(getMainContext(), RouteName.banner);
  }
  // --------------------
  /// privacy
  static Future<void> pushPrivacyScreen() async {

    if (kIsWeb == true){
      await Nav.goToRoute(getMainContext(), RouteName.privacy);
    }
    else {
      await Launcher.launchURL(Standards.privacyPolicyURL);
    }

  }
  // --------------------
  /// terms
  static Future<void> pushTermsScreen() async {

    if (kIsWeb == true){
      await Nav.goToRoute(getMainContext(), RouteName.terms);
    }
    else {
      await Launcher.launchURL(Standards.termsAndRegulationsURL);
    }

  }
  // --------------------
  /// deleteMyData
  static Future<void> pushDeleteMyDataScreen() async {

    await Nav.goToRoute(getMainContext(), RouteName.deleteMyData);

  }
  // -----------------------------------------------------------------------------

  /// AUTO NAV

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNav({
    required String? routeName,
    required bool startFromHome,
    String? arguments,
  }) async {

    if (TextCheck.isEmpty(routeName) == false){

      UiProvider.proSetAfterHomeRoute(
          routeName: routeName,
          arguments: arguments,
          notify: true
      );

      if (startFromHome == true){
        await pushHomeRouteAndRemoveAllBelow();
      }

      else {
        await autoNavigateFromHomeScreen();
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNavigateFromHomeScreen() async {

    final RouteSettings? _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: getMainContext(),
      listen: false,
    );

    // blog('autoNavigateFromHomeScreen : _afterHomeRoute : ${_afterHomeRoute?.name} : '
    //     'arg : ${_afterHomeRoute?.arguments}');

    if (_afterHomeRoute != null){

      /// CLEAR AFTER HOME ROUTE
      UiProvider.proClearAfterHomeRoute(
        notify: true,
      );

      await DynamicRouter.goTo(
        route: _afterHomeRoute.name,
        arguments: _afterHomeRoute.arguments as String,
      );

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> restartAndRoute({
    String? routeName,
    dynamic arguments,
  }) async {

    if (routeName != null) {
      UiProvider.proSetAfterHomeRoute(
        routeName: routeName,
        arguments: arguments,
        notify: true,
      );
    }

    await Nav.pushNamedAndRemoveAllBelow(
      context: getMainContext(),
      goToRoute: RouteName.staticLogo,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkNootTapStartsFromHome(String? routeName){

    switch (routeName){
      /// --------------------
      // case Routing.staticLogoScreen     : return true; break;
      // case Routing.animatedLogoScreen   : return true; break;
      /// --------------------
      // case Routing.home                 : return true; break;
      // case Routing.auth                 : return true; break;
      case RouteName.search               : return true;
      case RouteName.appSettings          : return true;
      /// --------------------
      case RouteName.myUserProfile              : return true;
      // case Routing.savedFlyers          : return true; break;
      // case Routing.profileEditor        : return true;
      /// --------------------
      case RouteName.myUserNotes      : return true;
      /// --------------------
      // case Routing.bzEditor             : return true;
      // case Routing.flyerEditor          : return true;
      /// --------------------
      case RouteName.myBzAboutPage       : return true;
      case RouteName.myBzFlyersPage       : return true;
      case RouteName.myBzTeamPage         : return true;
      case RouteName.myBzNotesPage        : return true;
      /// --------------------
      case RouteName.userPreview          : return false;
      case RouteName.bzPreview            : return false;
      case RouteName.flyerPreview         : return false;
      case RouteName.flyerReviews         : return false;
      // case RouteName.countryPreview       : return false;
      /// --------------------
      default: return true;
    }

  }
  // -----------------------------------------------------------------------------

  /// IMAGE FULL SCREEN

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByBytes({
    required BuildContext context,
    required Uint8List bytes,
    required Dimensions dims,
    required String title,
  }) async {

    await Nav.goToNewScreen(
        context: context,
        screen: SlideFullScreen(
          image: bytes,
          imageSize: dims,
          filter: ImageFilterModel.noFilter(),
          title: Verse.plain(title),
        ),
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToImageFullScreenByPath({
    required BuildContext context,
    required String? path,
    required String? title,
  }) async {

    final PicModel? _pic = await PicProtocols.fetchPic(path);

    await Nav.goToNewScreen(
        context: context,
        screen: SlideFullScreen(
          image: _pic?.bytes,
          imageSize: Dimensions(
            width: _pic?.meta?.width,
            height: _pic?.meta?.height,
          ),
          filter: ImageFilterModel.noFilter(),
          title: Verse.plain(title),
        ),
    );

  }
  // -----------------------------------------------------------------------------
}
