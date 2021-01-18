import 'package:bldrs/ambassadors/services/auth.dart';
import 'package:bldrs/view_brains/router/navigators.dart';
import 'package:bldrs/view_brains/router/route_names.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/views/widgets/appbar/buttons/bx_flagbox.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'in_pyramids_items/in_pyramids_bubble.dart';

class MorePage extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    // double pageMargin = Ratioz.ddAppBarMargin;

    return SliverList(
      delegate: SliverChildListDelegate([

        MorePGTile(
          verse: 'Create a New Business Profile',
          icon: Iconz.Bz,
          iconSizeFactor: 0.9,
        ),

        BubblesSeparator(),

        MorePGTile(
          verse: 'Tell your friend about Bldrs.net',
          icon: Iconz.ComApple,
          iconBoxColor: Colorz.BlackBlack,
          verseColor: Colorz.White,
        ),

        MorePGTile(
          verse: 'Tell your friend about Bldrs.net',
          icon: Iconz.ComGooglePlay,
          iconBoxColor: Colorz.BlackBlack,
          verseColor: Colorz.White,
        ),

        BubblesSeparator(),

        MorePGTile(
          verse: 'Change Country',
          icon: FlagBox(flag: Flagz.Egypt),
          iconSizeFactor: 0.9,
        ),

        MorePGTile(
          verse: 'Change App language',
          icon: Iconz.Language,
        ),

        BubblesSeparator(),

        MorePGTile(
          verse: 'About Bldrs.net',
          icon: Iconz.PyramidSingleYellow,
          iconSizeFactor: 0.8,
        ),

        MorePGTile(
          verse: 'Send us your feedback',
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

        MorePGTile(
          verse: 'Terms & Regulations',
          icon: Iconz.Terms,
          iconSizeFactor: 0.6,
        ),

        BubblesSeparator(),

        MorePGTile(
          verse: 'Advertise on Bldrs.net',
          icon: Iconz.Advertise,
          iconSizeFactor: 0.6,
        ),

        MorePGTile(
          verse: 'Get Blrs.net Marketing materials',
          icon: Iconz.Marketing,
          iconSizeFactor: 0.7,
        ),

        BubblesSeparator(),

        MorePGTile(
          verse: 'Open App Tutorial',
          icon: Iconz.Scholar,
          iconSizeFactor: 0.6,
        ),

        MorePGTile(
          verse: 'What is a flyer?',
          icon: Iconz.Flyer,
          iconSizeFactor: 0.6,
        ),

        MorePGTile(
          verse: 'Who Are The Builders ?',
          icon: Iconz.Bz,
          iconSizeFactor: 0.6,
        ),

        MorePGTile(
          verse: 'How it Works ?',
          icon: Iconz.Gears,
          iconSizeFactor: 0.6,
        ),

        BubblesSeparator(),

        MorePGTile(
          verse: 'Sign out',
          icon: Iconz.Exit,
          iconSizeFactor: 0.6,
          btOnTap: () async {
            print('Signing out');
            await _auth.signOut();
            goToRoute(context, Routez.Starting);
            },
        ),

        PyramidsHorizon(),

      ]
      ),
    );
  }
}


class MorePGTile extends StatelessWidget {
  final String verse;
  final dynamic icon;
  final Color iconBoxColor;
  final double iconSizeFactor;
  final Color verseColor;
  final Function btOnTap;

  MorePGTile({
    @required this.verse,
    @required this.icon,
    this.iconBoxColor = Colorz.Nothing,
    this.iconSizeFactor = 0.6,
    this.verseColor = Colorz.White,
    this.btOnTap,
});

  @override
  Widget build(BuildContext context) {

    double iconBoxWidth = 30;
    double iconWidth = (iconSizeFactor * iconBoxWidth);
    double iconBoxPadding = iconBoxWidth - iconWidth;

    return Material(
      color: Colorz.Nothing,
      child: InkWell(
        onTap: btOnTap,
        splashColor: Colorz.WhiteSmoke,
        child: InPyramidsBubble(

          bubbleColor: Color.fromARGB(3, 255, 255, 255),
          columnChildren: <Widget>[

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                icon.runtimeType == String ?
                DreamBox(
                  width: iconBoxWidth,
                  height: iconBoxWidth,
                  icon: icon,
                  iconSizeFactor: iconSizeFactor,
                  color: iconBoxColor,
                  iconRounded: false,
                  boxMargins: EdgeInsets.symmetric(horizontal: 0),
                ) :
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Container(
                      width: iconBoxWidth,
                      height: iconBoxWidth,
                      padding: EdgeInsets.all(iconBoxPadding),
                      child: icon,
                    ),
                  ),


                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: SuperVerse(
                    verse: verse,
                    margin: 5,
                    color: verseColor,
                    maxLines: 2,
                    centered: false,
                  ),
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}

