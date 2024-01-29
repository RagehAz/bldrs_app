import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/h_navigation/routing/routing.dart';
import 'package:bldrs/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/z_components/sizing/stratosphere.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class RoutingTestScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RoutingTestScreen({
    super.key
  });
  // --------------------------------------------------------------------------
  Widget _goTo(String routeSettingsName, {bool good = false, String? args}) {
    return WideButton(
      verse: Verse.plain(routeSettingsName),
      verseColor: good == true ? Colorz.green255 : Colorz.white200,
      onTap: () async {

        await ScreenRouter.goTo(
          routeSettingsName: routeSettingsName,
          args: args
        );

        },
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const String userID = '1H2osf0ITLXJ9wVgcxPEYrkR2Px1';
    const String bzID = 'nVqAKcz2QxSY6qDz6tjc';
    const String flyerID = 'XTTsVsZAIoisvL4v0XGj';
    const String reviewID = 'r9rAUqi5SHj0N6NLJuyS';
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      appBarType: AppBarType.basic,
      pyramidsAreOn: true,
      title: const Verse(
        id: '',
        translate: false,
      ),
      child: FloatingList(
        padding: Stratosphere.stratosphereSandwich,
        columnChildren: <Widget>[

          // -----------------------------------------------------------------------------

          /// LOADING

          // --------------------
          /// staticLogoScreen
          _goTo(ScreenName.staticLogo, good: true),
          // -----------------------------------------------------------------------------

          /// MAIN

          // --------------------
          /// home
          _goTo(ScreenName.home, good: true),
          // --------------------------
          // /// auth
          // _goTo(RouteName.auth, good: true),
          // --------------------------
          // /// search
          // _goTo(RouteName.search, good: true),
          // // --------------------------
          // /// appSettings
          // _goTo(RouteName.appSettings, good: true),
          // -----------------------------------------------------------------------------

          /// PROFILE

          // --------------------
          // /// profile
          // _goTo(RouteName.myUserProfile, good: true),
          // // --------------------
          // /// notifications
          // _goTo(RouteName.myUserNotes, good: true),
          // // --------------------
          // /// following
          // _goTo(RouteName.myUserFollowing, good: true),
          // // --------------------
          // /// settings
          // _goTo(RouteName.myUserSettings, good: true),
          // // --------------------
          // /// savedFlyers
          // _goTo(RouteName.savedFlyers, good: true),
          // --------------------
          /// profileEditor
          /* HANDLED MANUALLY BY */
          // ------------------------------------------------------------

          /// MY BZ

          // --------------------
          // /// myBzAboutPage
          // _goTo(RouteName.myBzAboutPage, args: bzID, good: true),
          // // --------------------
          // /// myBzFlyersPage
          // _goTo(RouteName.myBzFlyersPage, args: bzID, good: true),
          // // --------------------
          // /// myBzTeamPage
          // _goTo(RouteName.myBzTeamPage, args: bzID, good: true),
          // // --------------------
          // /// myBzNotesPage
          // _goTo(RouteName.myBzNotesPage, args: bzID, good: true),
          // --------------------
          /// bzEditor
          /* HANDLED MANUALLY BY */
          // --------------------
          /// bzEditor
          /* HANDLED MANUALLY BY */
          // ------------------------------------------------------------

          /// PREVIEWS

          // --------------------
          /// userPreview
          _goTo('${ScreenName.userPreview}:$userID', good: true),
          // --------------------
          /// bzPreview
          _goTo('${ScreenName.bzPreview}:$bzID', good: true),
          // --------------------
          /// flyerPreview
          _goTo('${ScreenName.flyerPreview}:$flyerID', good: true),
          // --------------------
          /// flyerReview with ID
          _goTo('${ScreenName.flyerReviews}:${flyerID}_$reviewID', good: true),
          // --------------------
          /// flyerReviews
          _goTo('${ScreenName.flyerReviews}:$flyerID', good: true),
          // --------------------
          /// countryPreview
          /* LATER */
          // ------------------------------------------------------------

          /// WEB

          // --------------------
          /// underConstruction
          _goTo(ScreenName.underConstruction, good: true),
          // --------------------
          /// banner
          _goTo(ScreenName.banner, good: true),
          // --------------------
          /// privacy
          _goTo(ScreenName.privacy, good: true),
          // --------------------
          /// terms
          _goTo(ScreenName.terms, good: true),
          // --------------------
          /// deleteMyData
          _goTo(ScreenName.deleteMyData, good: true),
          // --------------------
          /// dashboard

          // ------------------------------------------------------------

          WideButton(
            verse: Verse.plain('restart and routes'),
            verseColor: Colorz.red255,
            onTap: () async {

              // await BldrsNav.restartAndRoute(
              //     route: RouteName.myBzFlyersPage,
              //     arguments: bzID,
              // );
              },
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
