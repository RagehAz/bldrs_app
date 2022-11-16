import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/d_zone/country_model.dart';
import 'package:bldrs/b_views/d_user/e_user_preview_screen/user_preview_screen.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/f_bz/f_bz_preview_screen/a_bz_preview_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/routing.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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

    if (context != null){
      // blog('Nav.goBack : invoker : $invoker');


      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.pop(context, passedData);
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
  static Future<void> goBackToHomeScreen({
    @required BuildContext context,
    @required String invoker,
    bool addPostFrameCallback = false,
  }) async {
    blog('goBackToHomeScreen : popUntil Routing.home : $invoker');

    if (context != null){

      if (addPostFrameCallback == true){
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.popUntil(context, ModalRoute.withName(Routing.home));
        });
      }

      else {
        await Future.delayed(Duration.zero, (){
          Navigator.popUntil(context, ModalRoute.withName(Routing.home));
        });
      }


    }

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

    if (TextDir.checkAppIsLeftToRight(context) == true){
      return inverse == false ?
      PageTransitionType.rightToLeftWithFade
          :
      PageTransitionType.leftToRightWithFade;
    }

    else {
      return inverse == false ?
      PageTransitionType.leftToRightWithFade
          :
      PageTransitionType.rightToLeftWithFade;
    }

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

      await CenterDialog.closeCenterDialog(context);

      await Future.delayed(const Duration(milliseconds: 500), () async {
        await Nav.closeApp(context);
      },
      );

    }

  }
  // -----------------------------------------------------------------------------

  /// BZ SCREEN NAV.

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> goToMyBzScreen({
    @required BuildContext context,
    @required String bzID,
    @required bool replaceCurrentScreen,
  }) async {

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    final BzModel _bzModel = await BzProtocols.fetch(
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
  /// TESTED : WORKS PERFECT
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
/*
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

 */
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

      final BzModel _bzModel = await BzProtocols.fetch(
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
  /// PLAN : DO BLDRS PREVIEW SCREEN
  static Future<void> jumpToBldrsPreviewScreen({
    @required BuildContext context,
  }) async {
    blog('should go to Bldrs.net preview screen');
  }
  // --------------------
  /// PLAN : DO COUNTRY PREVIEW SCREEN
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
  // -----------------------------------------------------------------------------
}
