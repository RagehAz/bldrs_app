import 'package:bldrs/controllers/drafters/device_checkers.dart';
import 'package:bldrs/controllers/drafters/launchers.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/router/route_names.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/flagz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/wordz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/auth/google.dart';
import 'package:bldrs/models/records/share_model.dart';
import 'package:bldrs/models/sub_models/link_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/views/screens/s40_bz_editor_screen.dart';
import 'package:bldrs/views/screens/s60_about_bldrs.dart';
import 'package:bldrs/views/widgets/appbar/buttons/flagbox.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  final AuthService _auth = AuthService();
  final UserModel userModel;

  MoreScreen({
    @required this.userModel,
});

  @override
  Widget build(BuildContext context) {

    Widget _separator = BubblesSeparator();

    return MainLayout(
      appBarType: AppBarType.Basic,
      appBarBackButton: true,
      sky: Sky.Black,
      pyramids: Iconz.PyramidzYellow,
      layoutWidget: ListView(
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
            iconBoxColor: Colorz.BlackBlack,
            verseColor: Colorz.White,
            btOnTap: () => shareLink(context, LinkModel.bldrsWebSiteLink),
          ),

          TileBubble(
            verse: Wordz.inviteBusinesses(context),
            icon: Iconz.Bz,
            iconBoxColor: Colorz.BlackBlack,
            verseColor: Colorz.White,
          ),

          _separator,

          TileBubble(
            verse: Wordz.changeCountry(context),
            icon: FlagBox(flag: Flagz.egy),
            iconSizeFactor: 0.9,
          ),
          TileBubble(
            verse: Wordz.changeLanguage(context),
            icon: Iconz.Language,
          ),

          _separator,

          TileBubble(
            verse: '${Wordz.about(context)} ${Wordz.bldrsShortName(context)}',
            icon: Iconz.PyramidSingleYellow,
            iconSizeFactor: 0.8,
            btOnTap: () => Nav.goToNewScreen(context, AboutBldrs()),

          ),
          TileBubble(
            verse: Wordz.feedback(context),
            icon: Iconz.UTPlanning,
            // UserBubble(
            //   onTap: (){},
            //   userType: UserType.PlanningUser,
            //   bubbleWidth: 40,
            //   userPic: Iconz.DumAuthorPic,
            //   blackAndWhite: false,
            // ),
            iconSizeFactor: 0.6,
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
          TileBubble(
            verse: 'Get Blrs.net Marketing materials',
            icon: Iconz.Marketing,
            iconSizeFactor: 0.7,
          ),

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
            btOnTap: () async {
              print('Signing out');
              await signOutGoogle();
              await _auth.signOut(context);
              Nav.goToRoute(context, Routez.Starting);
            },
          ),

          _separator,

          TileBubble(
            verse: 'To the Beyond and Further',
            icon: Iconz.DvRageh,
            iconSizeFactor: 1,
            btOnTap: () => Nav.goToRoute(context, Routez.Obelisk),
          ),


          PyramidsHorizon(
            heightFactor: 5,
          ),

        ],
      ),
    );
  }
}
