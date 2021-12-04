import 'package:bldrs/controllers/drafters/device_checkers.dart' as DeviceChecker;
import 'package:bldrs/controllers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/controllers/router/navigators.dart' as Nav;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart' as Iconz;
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/models/secondary_models/link_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/models/zone/country_model.dart';
import 'package:bldrs/models/zone/flag_model.dart';
import 'package:bldrs/providers/zone_provider.dart';
import 'package:bldrs/views/screens/d_more/d_1_select_country_screen.dart';
import 'package:bldrs/views/screens/d_more/d_4_change_language_screen.dart';
import 'package:bldrs/views/screens/d_more/d_5_about_bldrs_screen.dart';
import 'package:bldrs/views/screens/d_more/d_6_feedback_screen.dart';
import 'package:bldrs/views/screens/f_bz/f_x_bz_editor_screen.dart';
import 'package:bldrs/views/widgets/general/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/general/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/general/buttons/flagbox_button.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout/main_layout.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/max_bounce_navigator.dart';
import 'package:bldrs/views/widgets/general/layouts/navigation/scroller.dart';
import 'package:bldrs/views/widgets/general/layouts/night_sky.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MoreScreen extends StatelessWidget {
  // final AuthOps _authOps = AuthOps();
  final UserModel userModel;

  MoreScreen({
    @required this.userModel,
    Key key,
  }) : super(key: key);
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final ZoneProvider zoneProvider = Provider.of<ZoneProvider>(context, listen: true);
    final CountryModel _currentCountry = zoneProvider.currentCountry;
    final String _currentFlag = Flag.getFlagIconByCountryID(_currentCountry.id);

    return MainLayout(
      appBarType: AppBarType.Basic,
      // appBarBackButton: true,
      skyType: SkyType.Black,
      pageTitle: 'Options',
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: MaxBounceNavigator(
        child: Scroller(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[

              const Stratosphere(),

              TileBubble(
                verse: Wordz.createBzAccount(context),
                icon: Iconz.Bz,
                iconSizeFactor: 0.9,
                btOnTap: () => Nav.goToNewScreen(context, BzEditorScreen(firstTimer: true, userModel: userModel)),
              ),

              const BubblesSeparator(),

              TileBubble(
                verse: Wordz.inviteFriends(context),
                icon: DeviceChecker.deviceIsIOS() ? Iconz.ComApple : DeviceChecker.deviceIsAndroid() ? Iconz.ComGooglePlay : Iconz.Share,
                iconBoxColor: Colorz.black230,
                verseColor: Colorz.white255,
                btOnTap: () async {
                  await Launcher.shareLink(context, LinkModel.bldrsWebSiteLink);
                },
              ),

              TileBubble(
                verse: Wordz.inviteBusinesses(context),
                icon: Iconz.Bz,
                iconBoxColor: Colorz.black230,
                verseColor: Colorz.white255,
              ),

              const BubblesSeparator(),

              TileBubble(
                verse: Wordz.changeCountry(context),
                icon: FlagBox(flag: _currentFlag),
                iconSizeFactor: 0.9,
                btOnTap: () => Nav.goToNewScreen(context,


                    const SelectCountryScreen()

                  //   /// but now we go to Egypt cities directly
                  // SelectCityScreen(countryID: 'egy',)

                ),
              ),

              TileBubble(
                verse: Wordz.changeLanguage(context),
                icon: Iconz.Language,
                btOnTap: () => Nav.goToNewScreen(context, const SelectLanguageScreen()),
              ),

              const BubblesSeparator(),

              TileBubble(
                verse: '${Wordz.about(context)} ${Wordz.bldrsShortName(context)}',
                icon: Iconz.PyramidSingleYellow,
                iconSizeFactor: 0.8,
                btOnTap: () => Nav.goToNewScreen(context, const AboutBldrsScreen()),

              ),
              TileBubble(
                verse: Wordz.feedback(context),
                icon: Iconz.UTSearching,
                iconSizeFactor: 0.6,
                btOnTap: () => Nav.goToNewScreen(context, const FeedBack()),
              ),
              TileBubble(
                verse: Wordz.termsRegulations(context),
                icon: Iconz.Terms,
                iconSizeFactor: 0.6,
              ),

              const BubblesSeparator(),

              // TileBubble(
              //   verse: Wordz.advertiseOnBldrs(context),
              //   icon: Iconz.Advertise,
              //   iconSizeFactor: 0.6,
              // ),
              // TileBubble(
              //   verse: 'Get Blrs.net Marketing materials',
              //   icon: Iconz.Marketing,
              //   iconSizeFactor: 0.7,
              // ),
              // const BubblesSeparator(),

              const TileBubble(
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

              const BubblesSeparator(),

              TileBubble(
                verse: Wordz.signOut(context),
                icon: Iconz.Exit,
                iconSizeFactor: 0.6,
                btOnTap: () => FireAuthOps.signOut(context: context, routeToUserChecker: true),
              ),

              const PyramidsHorizon(),

            ],
          ),
        ),
      ),
    );
  }
}
