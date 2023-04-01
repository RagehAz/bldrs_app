import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/b_auth/a_auth_screen/a_auth_screen.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_user_profile_screen.dart';
import 'package:bldrs/b_views/d_user/e_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/h_app_settings/a_app_settings_screen/a_app_settings_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
import 'package:mapper/mapper.dart';
import 'package:provider/provider.dart';
import 'package:stringer/stringer.dart';
/// => TAMAM
class BldrsNav {
  // -----------------------------------------------------------------------------

  const BldrsNav();

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBackToLogoScreen({
    @required BuildContext context,
    @required bool animatedLogoScreen,
  }) async {


    if (animatedLogoScreen){
      await Nav.pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.animatedLogoScreen,
      );
    }
    else {

      /// we already remove this layer in
      // Navigator.popUntil(context, ModalRoute.withName(Routing.logoScreen));

      await Nav.pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.staticLogoScreen,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushHomeAndRemoveAllBelow({
    @required BuildContext context,
    @required String invoker,
  }) async {

    blog('goBackToHomeScreen : popUntil Routing.home : $invoker');

    await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: Routing.home,
    );

  }
  // -----------------------------------------------------------------------------

  /// HOME SCREEN NAV.

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNav({
    @required BuildContext context,
    @required String routeName,
    @required bool startFromHome,
    Object arguments,
  }) async {

    if (TextCheck.isEmpty(routeName) == false){

      UiProvider.proSetAfterHomeRoute(
          context: context,
          routeName:routeName,
          arguments: arguments,
          notify: true
      );

      if (startFromHome == true){
        await pushHomeAndRemoveAllBelow(
          context: context,
          invoker: 'autoNav',
        );
      }

      else {
        await autoNavigateFromHomeScreen(context);
      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> autoNavigateFromHomeScreen(BuildContext context) async {

    final RouteSettings _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      listen: false,
    );

    blog('autoNavigateFromHomeScreen : _afterHomeRoute : ${_afterHomeRoute?.name} : '
        'arg : ${_afterHomeRoute?.arguments}');

    if (_afterHomeRoute != null){

      Future<void> _goTo;

      switch(_afterHomeRoute.name){
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzFlyersPage:
          _goTo = goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzAboutPage:
          _goTo = goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.about,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzNotesPage:
          _goTo = goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.notes,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzTeamPage:
          _goTo = goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.team,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myUserScreen:
          _goTo = goToMyUserScreen(
            context: context,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myUserNotesPage:
          _goTo = goToMyUserScreen(
            context: context,
            userTab: UserTab.notifications,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.userPreview:
          _goTo = jumpToUserPreviewScreen(
            userID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.bzPreview:
          _goTo = jumpToBzPreviewScreen(
            bzID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.flyerPreview:
          _goTo = jumpToFlyerPreviewScreen(
            flyerID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.flyerReviews:
          _goTo = jumpToFlyerReviewScreen(
            flyerIDAndReviewID: _afterHomeRoute?.arguments,
          ); break;
      // --------------------
        case Routing.appSettings:
          _goTo = Nav.goToNewScreen(
            context: context,
            screen: const AppSettingsScreen(),
          ); break;
      /// PLAN : ADD COUNTRIES PREVIEW SCREEN
      /*
       case Routing.countryPreview:
         return jumpToCountryPreviewScreen(
           context: context,
           countryID: _afterHomeRoute.arguments,
         ); break;
        */
      // --------------------
      /// PLAN : ADD BLDRS PREVIEW SCREEN
      /*
         case Routing.bldrsPreview:
           return jumpToBldrsPreviewScreen(
             context: context,
           ); break;
          */
      // --------------------
      }

      /// CLEAR AFTER HOME ROUTE
      UiProvider.proClearAfterHomeRoute(
        context: getContext(),
        notify: true,
      );

      await _goTo;

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> onLastGoBackInHomeScreen(BuildContext context) async {

    /// TO HELP WHEN PHRASES ARE NOT LOADED TO REBOOT SCREENS
    if (PhraseProvider.proGetPhidsAreLoaded(context) == false){
      await Nav.pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.staticLogoScreen,
      );
    }

    /// NORMAL CASE WHEN ON BACK WHILE IN HO
    else {

      final bool _result = await Dialogs.goBackDialog(
        context: context,
        titleVerse: const Verse(
          id: 'phid_exit_app_?',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'Would you like to exit and close Bldrs.net App ?',
          id: 'phid_exit_app_notice',
          translate: true,
        ),
        confirmButtonVerse: const Verse(
          id: 'phid_exit',
          translate: true,
        ),

      );

      if (_result == true){

        await CenterDialog.closeCenterDialog(context);

        await Future.delayed(const Duration(milliseconds: 500), () async {
          await Nav.closeApp(context);
        },
        );

      }

    }

  }
  // -----------------------------------------------------------------------------

  /// USER TAB NAV.

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToMyUserScreen({
    @required BuildContext context,
    UserTab userTab = UserTab.profile,
  }) async {

    await Nav.goToNewScreen(
      context: context,
      screen: UserProfileScreen(
        userTab: userTab,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// BZ SCREEN NAV.

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToMyBzScreen({
    @required BuildContext context,
    @required String bzID,
    @required bool replaceCurrentScreen,
    BzTab initialTab = BzTab.flyers,
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    final BzModel _bzModel = await BzProtocols.fetchBz(
      context: context,
      bzID: bzID,
    );

    _bzzProvider.setActiveBz(
      bzModel: _bzModel,
      notify: true,
    );

    if (replaceCurrentScreen == true){
      await Nav.replaceScreen(
          context: context,
          screen: MyBzScreen(
            initialTab: initialTab,
          )
      );
    }

    else {
      await Nav.goToNewScreen(
          context: context,
          screen: MyBzScreen(
            initialTab: initialTab,
          )
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goRebootToInitNewBzScreen({
    @required BuildContext context,
    @required String bzID,
  }) async {

    UiProvider.proSetAfterHomeRoute(
      context: context,
      routeName: Routing.myBzTeamPage,
      arguments: bzID,
      notify: true,
    );

    await goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );


  }
  // --------------------
  /// TASK : TEST ME
  static Future<void> restartAndRoute({
    @required BuildContext context,
    String routeName,
    dynamic arguments,
  }) async {

    if (routeName != null) {
      UiProvider.proSetAfterHomeRoute(
        context: context,
        routeName: routeName,
        arguments: arguments,
        notify: true,
      );
    }

    await Nav.pushNamedAndRemoveAllBelow(
      context: context,
      goToRoute: Routing.staticLogoScreen,
    );

  }
  // -----------------------------------------------------------------------------

  /// JUMPERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToUserPreviewScreen({
    @required String userID,
  }) async {

    if (userID != null){

      final UserModel _userModel = await UserProtocols.fetch(
        context: getContext(),
        userID: userID,
      );

      if (_userModel != null){

        await Nav.goToNewScreen(
          context: getContext(),
          screen: UserPreviewScreen(
            userModel: _userModel,
          ),
        );

      }

    }



  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToBzPreviewScreen({
    @required String bzID,
  }) async {

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(
        context: getContext(),
        bzID: bzID,
      );

      if (_bzModel != null){

        await Nav.goToNewScreen(
          context: getContext(),
          screen: BzPreviewScreen(
            bzModel: _bzModel,
          ),
        );

      }

    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToFlyerPreviewScreen({
    @required String flyerID,
  }) async {

    if (flyerID != null){

      blog('jumping to flyer preview screen');

      await Nav.goToNewScreen(
        context: getContext(),
        screen: FlyerPreviewScreen(
          flyerID: flyerID,
          // reviewID: ,
          // bzModel: _bzModel,
        ),
      );

    }
  }
  // --------------------
  /// TASK : DO JUMP TO REVIEW THING
  static Future<void> jumpToFlyerReviewScreen({
    @required Object flyerIDAndReviewID,
  }) async {

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

    blog('jumpToFlyerReviewScreen  the damn route is : $flyerIDAndReviewID');

    assert(flyerIDAndReviewID != null, 'flyerIDAndReviewID is null');
    assert(flyerIDAndReviewID is String, 'flyerIDAndReviewID is not a String');

    final List<String> _flyerIDAndReviewID = ChainPathConverter.splitPathNodes(flyerIDAndReviewID);

    if (Mapper.checkCanLoopList(_flyerIDAndReviewID) == true){

      final String _flyerID = _flyerIDAndReviewID[0];
      final String _reviewID = _flyerIDAndReviewID[1];

      if (_flyerID != null){

        await Nav.goToNewScreen(
          context: getContext(),
          screen: FlyerPreviewScreen(
            flyerID: _flyerID,
            reviewID: _reviewID,
          ),
        );

      }

    }

  }
  // --------------------
  /// PLAN : DO BLDRS PREVIEW SCREEN
  /*
  static Future<void> jumpToBldrsPreviewScreen({
    @required BuildContext context,
  }) async {
    blog('should go to Bldrs.net preview screen');
  }
   */
  // --------------------
  /// PLAN : DO COUNTRY PREVIEW SCREEN
  /*
  static Future<void> jumpToCountryPreviewScreen({
    @required BuildContext context,
    @required String countryID,
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
  // -----------------------------------------------------------------------------
  static Future<void> jumpToAuthScreen(BuildContext context) async {

    await Nav.goToNewScreen(
      context: context, //getContext(),
      screen: const AuthScreen(),
    );


  }
  // -----------------------------------------------------------------------------
}