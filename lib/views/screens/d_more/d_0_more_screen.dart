import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/flyer/records/share_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/screens/d_more/d_2_select_city_screen.dart';
import 'package:bldrs/views/screens/d_more/d_4_change_language_screen.dart';
import 'package:bldrs/views/screens/d_more/d_5_about_bldrs_screen.dart';
import 'package:bldrs/views/screens/d_more/d_6_feedback_screen.dart';
import 'package:bldrs/views/screens/f_bz/f_x_bz_editor_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  // final AuthOps _authOps = AuthOps();
  final UserModel userModel;

  MoreScreen({
    @required this.userModel,
});
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    Widget _separator = BubblesSeparator();

    return MainLayout(
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      sky: Sky.Black,
      pageTitle: 'Options',
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: MaxBounceNavigator(
        child: Scroller(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              Stratosphere(),
              TileBubble(
                verse: Wordz.createBzAccount(context),
                icon: Iconz.Bz,
                iconSizeFactor: 0.9,
                btOnTap: () => Nav.goToNewScreen(context, BzEditorScreen(firstTimer: true, userModel: userModel)),
              ),

              _separator,

              TileBubble(
                verse: Wordz.inviteFriends(context),
                icon: DeviceChecker.deviceIsIOS() ? Iconz.ComApple : DeviceChecker.deviceIsAndroid() ? Iconz.ComGooglePlay : Iconz.Share,
                iconBoxColor: Colorz.Black230,
                verseColor: Colorz.White255,
                btOnTap: () async {
                  await Launchers.shareLink(context, LinkModel.bldrsWebSiteLink);
                },
              ),

              TileBubble(
                verse: Wordz.inviteBusinesses(context),
                icon: Iconz.Bz,
                iconBoxColor: Colorz.Black230,
                verseColor: Colorz.White255,
              ),

              _separator,

              TileBubble(
                verse: Wordz.changeCountry(context),
                icon: FlagBox(flag: Flagz.egy),
                iconSizeFactor: 0.9,
                btOnTap: () => Nav.goToNewScreen(context,

                    /// PLAN : when we include more countries, we just go to SelectCountryScreen();
                    // SelectCountryScreen()

                    /// but now we go to Egypt cities directly
                  SelectCityScreen(countryID: 'egy',)

                ),
              ),

              TileBubble(
                verse: Wordz.changeLanguage(context),
                icon: Iconz.Language,
                btOnTap: () => Nav.goToNewScreen(context, SelectLanguageScreen()),
              ),

              _separator,

              TileBubble(
                verse: '${Wordz.about(context)} ${Wordz.bldrsShortName(context)}',
                icon: Iconz.PyramidSingleYellow,
                iconSizeFactor: 0.8,
                btOnTap: () => Nav.goToNewScreen(context, AboutBldrsScreen()),

              ),
              TileBubble(
                verse: Wordz.feedback(context),
                icon: Iconz.UTSearching,
                iconSizeFactor: 0.6,
                btOnTap: () => Nav.goToNewScreen(context, FeedBack()),
              ),
              TileBubble(
                verse: Wordz.termsRegulations(context),
                icon: Iconz.Terms,
                iconSizeFactor: 0.6,
              ),

              _separator,

              TileBubble(
                verse: Wordz.advertiseOnBldrs(context),
                icon: Iconz.Advertise,
                iconSizeFactor: 0.6,
              ),
              // TileBubble(
              //   verse: 'Get Blrs.net Marketing materials',
              //   icon: Iconz.Marketing,
              //   iconSizeFactor: 0.7,
              // ),

              _separator,

              TileBubble(
                verse: 'Open App Tutorial',
                icon: Iconz.Scholar,
                iconSizeFactor: 0.6,
              ),
              TileBubble(
                verse: Wordz.whatIsFlyer(context),
                icon: Iconz.Flyer,
                iconSizeFactor: 0.6,
              ),
              TileBubble(
                verse: Wordz.whoAreBldrs(context),
                icon: Iconz.Bz,
                iconSizeFactor: 0.6,
              ),
              TileBubble(
                verse: Wordz.howItWorks(context),
                icon: Iconz.Gears,
                iconSizeFactor: 0.6,
              ),

              _separator,

              TileBubble(
                verse: Wordz.signOut(context),
                icon: Iconz.Exit,
                iconSizeFactor: 0.6,
                btOnTap: () => AuthOps().signOut(context: context, routeToUserChecker: true),
              ),

              _separator,

              TileBubble(
                verse: 'To the Beyond and Further',
                icon: Iconz.DvRageh,
                iconSizeFactor: 1,
                btOnTap: () => Nav.goToRoute(context, Routez.Obelisk),
              ),

              PyramidsHorizon(),

            ],
          ),
        ),
      ),
    );
  }
}
