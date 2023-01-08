import 'dart:async';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/c_chain/aa_chain_path_converter.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/d_user/a_user_profile_screen/a_user_profile_screen.dart';
import 'package:bldrs/b_views/d_user/e_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
import 'package:bldrs/c_protocols/phrase_protocols/provider/phrase_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/h_caching/cache_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';

import 'package:bldrs/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class Nav {
  // -----------------------------------------------------------------------------

  const Nav();

  // -----------------------------------------------------------------------------

  /// GOING FORWARD

  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> slideToScreen(Widget screen, RouteSettings settings) {
    return PageTransition<dynamic>(
      child: screen,
      type: PageTransitionType.bottomToTop,
      // duration: Ratioz.durationFading200,
      // reverseDuration: Ratioz.durationFading200,
      curve: Curves.fastOutSlowIn,
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransition<dynamic> fadeToScreen(Widget screen, RouteSettings settings) {
    return PageTransition<dynamic>(
      child: screen,
      type: PageTransitionType.fade,
      duration: Ratioz.duration150ms,
      reverseDuration: Ratioz.duration150ms,
      curve: Curves.fastOutSlowIn,
      settings: settings,
    );
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> goToNewScreen({
    @required BuildContext context,
    @required Widget screen,
    PageTransitionType pageTransitionType = PageTransitionType.bottomToTop,
    Widget childCurrent,
  }) async {

    final dynamic _result = await Navigator.push(
      context,
      PageTransition<dynamic>(
        type: pageTransitionType,
        childCurrent: childCurrent,
        child: screen,
        // duration: Ratioz.durationFading200,
        // reverseDuration: Ratioz.durationFading200,
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.bottomCenter,
      ),
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToRoute(BuildContext context, String routezName, {dynamic arguments}) async {
    await Navigator.of(context).pushNamed(routezName, arguments: arguments);
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<dynamic> replaceScreen({
    @required BuildContext context,
    @required Widget screen,
    PageTransitionType transitionType = PageTransitionType.bottomToTop,
  }) async {

    final dynamic _result = await Navigator.pushReplacement(
        context,
        PageTransition<dynamic>(
          type: transitionType,
          child: screen,
          // duration: Ratioz.duration750ms,
          // reverseDuration: Ratioz.duration750ms,
          curve: Curves.fastOutSlowIn,
          alignment: Alignment.bottomCenter,
        )
    );

    return _result;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushNamedAndRemoveAllBelow({
    @required BuildContext context,
    @required String goToRoute,
  }) async {

    await Navigator.of(context).pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> pushAndRemoveUntil({
    @required BuildContext context,
    @required Widget screen,
  }) async {

    await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<dynamic>(
          builder: (_) => screen,
        ),
            (Route<dynamic> route) => route.isFirst);
  }
  // -----------------------------------------------------------------------------

  /// GOING BACK

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBack({
    @required BuildContext context,
    String invoker,
    dynamic passedData,
    bool addPostFrameCallback = false,
  }) async {

    await CacheOps.wipeCaches();

    if (context != null){
      blog('Nav.goBack : invoker : $invoker');


      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          final BuildContext _context = BldrsAppStarter.navigatorKey.currentContext;
          Navigator.pop(_context, passedData);
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.pop(context, passedData);
        });
      }


    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeApp(BuildContext context) async {
    await SystemNavigator.pop();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBackToLogoScreen({
    @required BuildContext context,
    @required bool animatedLogoScreen,
  }) async {


    if (animatedLogoScreen){
      await pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.animatedLogoScreen,
      );
    }
    else {

      /// we already remove this layer in
      // Navigator.popUntil(context, ModalRoute.withName(Routing.logoScreen));

      await pushNamedAndRemoveAllBelow(
        context: context,
        goToRoute: Routing.staticLogoScreen,
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goBackUntil({
    @required BuildContext context,
    @required String routeName,
    bool addPostFrameCallback = false,
  }) async {

    if (context != null){

      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.popUntil(context, ModalRoute.withName(routeName));
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.popUntil(context, ModalRoute.withName(routeName));
        });
      }


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

  /// I DONT KNO ABOUT THIS SHIT

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
    Navigator.removeRouteBelow(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
  }
  // -----------------------------------------------------------------------------

  /// TRANSITION

  // --------------------
  /// TESTED : WORKS PERFECT
  static PageTransitionType superHorizontalTransition(BuildContext context, {bool inverse = false}) {

    /// NOTE: IMAGINE OPENING AN ENGLISH BOOK => NEXT PAGE COMES FROM RIGHT TO LEFT

    /// LEFT TO RIGHT (EN)
    if (TextDir.checkAppIsLeftToRight(context) == true){

      return inverse == false ?
      /// NORMAL : <--- RIGHT TO LEFT (LIKE A BOOK)
      PageTransitionType.rightToLeftWithFade
          :
      /// INVERSE : ---> LEFT TO RIGHT
      PageTransitionType.leftToRightWithFade;
    }

    /// RIGHT TO LEFT (AR)
    else {
      return inverse == false ?
      /// NORMAL : ---> LEFT TO RIGHT (LIKE A BOOK)
      PageTransitionType.leftToRightWithFade
          :
      /// INVERSE : <--- RIGHT TO LEFT
      PageTransitionType.rightToLeftWithFade;
    }

  // -----------------------------------------------------------------------------
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
        await Nav.pushHomeAndRemoveAllBelow(
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

    if (_afterHomeRoute != null){

      Future<void> _goTo;

      switch(_afterHomeRoute.name){
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzScreen:
          _goTo = Nav.goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzNotesPage:
          _goTo = Nav.goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.notes,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myBzTeamPage:
          _goTo = Nav.goToMyBzScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
            replaceCurrentScreen: false,
            initialTab: BzTab.team,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myUserScreen:
          _goTo = Nav.goToMyUserScreen(
            context: context,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.myUserNotesPage:
          _goTo = Nav.goToMyUserScreen(
            context: context,
            userTab: UserTab.notifications,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.userPreview:
          _goTo = jumpToUserPreviewScreen(
            context: context,
            userID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.bzPreview:
          _goTo = jumpToBzPreviewScreen(
            context: context,
            bzID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.flyerPreview:
          _goTo = jumpToFlyerPreviewScreen(
            context: context,
            flyerID: _afterHomeRoute.arguments,
          ); break;
      // --------------------
      /// TESTED : WORKS PERFECT
        case Routing.flyerReviews:
          _goTo = jumpToFlyerReviewScreen(
            context: context,
            flyerIDAndReviewID: _afterHomeRoute?.arguments,
          ); break;
      // --------------------
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
        context: BldrsAppStarter.navigatorKey.currentContext,
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
          text: 'phid_exit_app_?',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'Would you like to exit and close Bldrs.net App ?',
          text: 'phid_exit_app_notice',
          translate: true,
        ),
        confirmButtonVerse: const Verse(
          text: 'phid_exit',
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

    await goToNewScreen(
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
      routeName: Routing.myBzScreen,
      arguments: bzID,
      notify: true,
    );

    await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );


  }
  // -----------------------------------------------------------------------------

  /// JUMPERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> jumpToUserPreviewScreen({
    @required BuildContext context,
    @required String userID,
  }) async {

    if (userID != null){

      final UserModel _userModel = await UserProtocols.fetch(
        context: context,
        userID: userID,
      );

      if (_userModel != null){

        await Nav.goToNewScreen(
          context: context,
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
    @required BuildContext context,
    @required String bzID,
  }) async {

    if (bzID != null){

      final BzModel _bzModel = await BzProtocols.fetchBz(
        context: context,
        bzID: bzID,
      );

      if (_bzModel != null){

        await Nav.goToNewScreen(
          context: context,
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
    @required BuildContext context,
    @required String flyerID,
  }) async {

    if (flyerID != null){

      final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
        flyerID: flyerID,
        context: context,
      );

      final BzModel _bzModel = await BzProtocols.fetchBz(
        bzID: _flyerModel?.bzID,
        context: context,
      );


      if (_flyerModel != null && _bzModel != null){

        await Nav.goToNewScreen(
          context: context,
          screen: FlyerPreviewScreen(
            flyerModel: _flyerModel,
            bzModel: _bzModel,
          ),
        );

      }

    }
  }
  // --------------------
  /// TASK : DO JUMP TO REVIEW THING
  static Future<void> jumpToFlyerReviewScreen({
    @required BuildContext context,
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

    assert(flyerIDAndReviewID != null, 'flyerIDAndReviewID is null');
    assert(flyerIDAndReviewID is String, 'flyerIDAndReviewID is not a String');

    final List<String> _flyerIDAndReviewID = ChainPathConverter.splitPathNodes(flyerIDAndReviewID);

    if (Mapper.checkCanLoopList(_flyerIDAndReviewID) == true){

      final String _flyerID = _flyerIDAndReviewID[0];
      final String _reviewID = _flyerIDAndReviewID[1];

      final FlyerModel _flyerModel = await FlyerProtocols.fetchFlyer(
        flyerID: _flyerID,
        context: context,
      );

      final BzModel _bzModel = await BzProtocols.fetchBz(
        bzID: _flyerModel?.bzID,
        context: context,
      );

      if (_flyerModel != null && _bzModel != null){

        await Nav.goToNewScreen(
          context: context,
          screen: FlyerPreviewScreen(
            flyerModel: _flyerModel,
            bzModel: _bzModel,
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
}
