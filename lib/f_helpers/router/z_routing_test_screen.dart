import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/wide_button.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/sizing/stratosphere.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/router/a_route_name.dart';
import 'package:bldrs/f_helpers/router/c_dynamic_router.dart';
import 'package:flutter/material.dart';

class RoutingTestScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RoutingTestScreen({
    super.key
  });
  // --------------------------------------------------------------------------
  Widget _goTo(String route, {bool good = false, String? args}) {
    return WideButton(
      verse: Verse.plain(route),
      verseColor: good == true ? Colorz.green255 : Colorz.white200,
      onTap: () async {

        await DynamicRouter.goTo(
          route: route,
          arguments: args
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
          _goTo(RouteName.staticLogo, good: true),
          // --------------------------
          /// animatedLogoScreen
          _goTo(RouteName.animatedLogo, good: true),
          // -----------------------------------------------------------------------------

          /// MAIN

          // --------------------
          /// home
          _goTo(RouteName.home, good: true),
          // --------------------------
          /// auth
          _goTo(RouteName.auth, good: true),
          // --------------------------
          /// search
          _goTo(RouteName.search, good: true),
          // --------------------------
          /// appSettings
          _goTo(RouteName.appSettings, good: true),
          // -----------------------------------------------------------------------------

          /// PROFILE

          // --------------------
          /// profile
          _goTo(RouteName.myUserProfile, good: true),
          // --------------------
          /// notifications
          _goTo(RouteName.myUserNotes, good: true),
          // --------------------
          /// following
          _goTo(RouteName.myUserFollowing, good: true),
          // --------------------
          /// settings
          _goTo(RouteName.myUserSettings, good: true),
          // --------------------
          /// savedFlyers
          _goTo(RouteName.savedFlyers, good: true),
          // --------------------
          /// profileEditor
          /* HANDLED MANUALLY BY */
          // ------------------------------------------------------------

          /// MY BZ

          // --------------------
          /// myBzAboutPage
          _goTo(RouteName.myBzAboutPage, args: bzID, good: true),
          // --------------------
          /// myBzFlyersPage
          _goTo(RouteName.myBzFlyersPage, args: bzID, good: true),
          // --------------------
          /// myBzTeamPage
          _goTo(RouteName.myBzTeamPage, args: bzID, good: true),
          // --------------------
          /// myBzNotesPage
          _goTo(RouteName.myBzNotesPage, args: bzID, good: true),
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
          _goTo('${RouteName.userPreview}:$userID', good: true),
          // --------------------
          /// bzPreview
          _goTo('${RouteName.bzPreview}:$bzID', good: true),
          // --------------------
          /// flyerPreview
          _goTo('${RouteName.flyerPreview}:$flyerID', good: true),
          // --------------------
          /// flyerReview with ID
          _goTo('${RouteName.flyerReviews}:${flyerID}_$reviewID', good: true),
          // --------------------
          /// flyerReviews
          _goTo('${RouteName.flyerReviews}:$flyerID', good: true),
          // --------------------
          /// countryPreview
          /* LATER */
          // ------------------------------------------------------------

          /// WEB

          // --------------------
          /// underConstruction
          _goTo(RouteName.underConstruction, good: true),
          // --------------------
          /// banner
          _goTo(RouteName.banner, good: true),
          // --------------------
          /// privacy
          _goTo(RouteName.privacy, good: true),
          // --------------------
          /// terms
          _goTo(RouteName.terms, good: true),
          // --------------------
          /// deleteMyData
          _goTo(RouteName.deleteMyData, good: true),
          // --------------------
          /// dashboard

          // ------------------------------------------------------------
        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
