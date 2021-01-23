import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bx_flagbox.dart';
import 'package:bldrs/views/widgets/bubbles/bubbles_separator.dart';
import 'package:bldrs/views/widgets/bubbles/tile_bubble.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';

class MorePage extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    return SliverList(
      delegate: SliverChildListDelegate([

        TileBubble(
          verse: Wordz.createBzAccount(context),
          icon: Iconz.Bz,
          iconSizeFactor: 0.9,
        ),

        BubblesSeparator(),

        TileBubble(
          verse: Wordz.inviteFriends(context),
          icon: Iconz.ComApple,
          iconBoxColor: Colorz.BlackBlack,
          verseColor: Colorz.White,
        ),

        TileBubble(
          verse: Wordz.inviteBusinesses(context),
          icon: Iconz.ComGooglePlay,
          iconBoxColor: Colorz.BlackBlack,
          verseColor: Colorz.White,
        ),

        BubblesSeparator(),

        TileBubble(
          verse: Wordz.changeCountry(context),
          icon: FlagBox(flag: Flagz.Egypt),
          iconSizeFactor: 0.9,
        ),

        TileBubble(
          verse: Wordz.changeLanguage(context),
          icon: Iconz.Language,
        ),

        BubblesSeparator(),

        TileBubble(
          verse: '${Wordz.about(context)} ${Wordz.bldrsShortName(context)}',
          icon: Iconz.PyramidSingleYellow,
          iconSizeFactor: 0.8,
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

        BubblesSeparator(),

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

        BubblesSeparator(),

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

        BubblesSeparator(),

        TileBubble(
          verse: Wordz.signOut(context),
          icon: Iconz.Exit,
          iconSizeFactor: 0.6,
          btOnTap: () async {
            print('Signing out');
            await _auth.signOut();
            goToRoute(context, Routez.Starting);
            },
        ),

        PyramidsHorizon(heightFactor: 5,),

      ]
      ),
    );
  }
}