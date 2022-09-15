import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/j_flyer/a_flyer_screen/a_flyer_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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
    PageTransitionType transitionType = PageTransitionType.bottomToTop,
    Widget childCurrent,
  }) async {

    final dynamic _result = await Navigator.push(
      context,
      PageTransition<dynamic>(
        type: transitionType,
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
  static Future<void> pushNamedAndRemoveAllBelow({
    @required BuildContext context,
    @required String goToRoute,
  }) async {

    await Navigator.of(context).pushNamedAndRemoveUntil(goToRoute, (Route<dynamic> route) => false);

  }
  // --------------------
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
  static void goBack({
    @required BuildContext context,
    @required String invoker,
    dynamic passedData,
  }) {
    if (context != null){
      blog('Nav.goBack : invoker : $invoker');
      Navigator.pop(context, passedData);
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> closeApp(BuildContext context) async {
    await SystemNavigator.pop();
  }
  // --------------------
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
  static void goBackUntil(BuildContext context, String routeName) {

    Navigator.popUntil(context, ModalRoute.withName(routeName));
  }
  // --------------------
  static void goBackToHomeScreen({
    @required BuildContext context,
    @required String invoker,
  }) {
    blog('goBackToHomeScreen : popUntil Routing.home : $invoker');
    Navigator.popUntil(context, ModalRoute.withName(Routing.home));
  }
  // -----------------------------------------------------------------------------

  /// I DONT KNO ABOUT THIS SHIT

  // --------------------
  static Future<void> removeRouteBelow(BuildContext context, Widget screen) async {
    Navigator.removeRouteBelow(context, MaterialPageRoute<dynamic>(builder: (BuildContext context) => screen));
  }
  // -----------------------------------------------------------------------------

  /// TRANSITION

  // --------------------
  static PageTransitionType superHorizontalTransition(BuildContext context, {bool inverse = false}) {

    /// NOTE: IMAGINE OPENING AN ENGLISH BOOK => NEXT PAGE COMES FROM RIGHT TO LEFT

    final PageTransitionType _enBookDirection = inverse == false ?
    PageTransitionType.rightToLeftWithFade
        :
    PageTransitionType.leftToRightWithFade;

    final PageTransitionType _arBookDirection = inverse == false ?
    PageTransitionType.leftToRightWithFade
        :
    PageTransitionType.rightToLeftWithFade;

    final PageTransitionType _transition = TextDir.appIsLeftToRight(context) == true ?
    _enBookDirection
        :
    _arBookDirection;

    return _transition;
  // -----------------------------------------------------------------------------
  }
  // -----------------------------------------------------------------------------

  /// HOME SCREEN NAV.

  // --------------------
  static Future<void> autoNavigateFromHomeScreen(BuildContext context) async {

    final RouteSettings _afterHomeRoute = UiProvider.proGetAfterHomeRoute(
      context: context,
      listen: false,
    );

    if (_afterHomeRoute != null){

      if (_afterHomeRoute.name == Routing.myBz){

        await Nav.goToMyBzScreen(
          context: context,
          bzID: _afterHomeRoute.arguments,
          replaceCurrentScreen: false,
        );

      }

      /// CLEAR AFTER HOME ROUTE
      UiProvider.proClearAfterHomeRoute(
        context: context,
        notify: true,
      );

    }

  }
  // --------------------
  static Future<void> onLastGoBackInHomeScreen(BuildContext context) async {

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

      CenterDialog.closeCenterDialog(context);

      await Future.delayed(const Duration(milliseconds: 500), () async {
        await Nav.closeApp(context);
      },
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// BZ SCREEN NAV.

  // --------------------
  static Future<void> goToMyBzScreen({
    @required BuildContext context,
    @required String bzID,
    @required bool replaceCurrentScreen,
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
          screen: const MyBzScreen()
      );
    }

    else {
      await Nav.goToNewScreen(
          context: context,
          screen: const MyBzScreen()
      );
    }


  }
  // --------------------
  static Future<void> goRebootToInitNewBzScreen({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
    _uiProvider.setAfterHomeRoute(
      settings: RouteSettings(
        name:  Routing.myBz,
        arguments: bzID,
      ),
      notify: true,
    );

    await Nav.goBackToLogoScreen(
      context: context,
      animatedLogoScreen: true,
    );


  }
  // -----------------------------------------------------------------------------

  /// FLYER NAVIGATORS

  // --------------------
  static Future<void> openFlyerOldWay(BuildContext context, String flyerID) async {
    await Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 750),
      pageBuilder: (_, __, ___) {
        return Hero(
          tag: flyerID, // galleryCoFlyers[index].flyer.flyerID,
          child: const Material(
            type: MaterialType.transparency,
            child: FlyerScreen(
              // flyerID: flyerID, // galleryCoFlyers[index].flyer.flyerID,
            ),
          ),
        );
      },
    ));
  }
  // --------------------
  static Future<void> openFlyer({
    @required BuildContext context,
    String flyerID,
    FlyerModel flyer,
    bool isSponsored = false,
  }) async {

    /// A - by  flyer
    if (flyer != null) {

      await goToNewScreen(
          context: context,
          screen: FlyerScreen(
            flyerModel: flyer,
            flyerID: flyerID,
            isSponsored: isSponsored,
          )
      );

    }

    /// A - by flyerID
    else if (flyerID != null) {
      await goToRoute(context, Routing.flyerScreen, arguments: flyerID);
    }

    // /// A - nothing give
    // else {
    //   // do nothing
    // }
  }
  // -----------------------------------------------------------------------------
}
