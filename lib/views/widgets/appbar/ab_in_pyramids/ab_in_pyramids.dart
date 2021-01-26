import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s11_sc_inpyramids_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

import '../ab_strip.dart';

class ABInPyramids extends StatelessWidget {
  final Function switchingPages;
  final inPyramidsPage currentPage;
  final UserStatus userStatus;

  ABInPyramids({
    @required this.switchingPages,
    @required this.currentPage,
    @required this.userStatus,
  });


  @override
  Widget build(BuildContext context) {

    double abPadding = Ratioz.ddAppBarMargin;
    double abHeight = Ratioz.ddAppBarHeight;
    double profilePicHeight = abHeight;
    double abButtonsHeight = abHeight - (abPadding);

    bool profileBlackAndWhite = currentPage == inPyramidsPage.Profile ? false : true;
    dynamic collectionsColor = currentPage == inPyramidsPage.SavedFlyers ? Colorz.Yellow : Colorz.WhiteAir;
    dynamic newsColor = currentPage == inPyramidsPage.News ? Colorz.Yellow : Colorz.WhiteAir;
    dynamic moreColor = currentPage == inPyramidsPage.More ? Colorz.Yellow : Colorz.WhiteAir;

    String collectionsPageTitle = currentPage == inPyramidsPage.SavedFlyers ? Wordz.savedFlyers(context) : null;
    double collectionsBTWidth = currentPage == inPyramidsPage.SavedFlyers ? null : abButtonsHeight;

    return AppBarStrip(
      rowWidgets : <Widget>[

        // ---  SPACER
         SizedBox(
           width: abPadding * 0.5,
           height: abButtonsHeight,
         ),

         // --- COLLECTIONS
         DreamBox(
           width: collectionsBTWidth,
           height: abButtonsHeight,
           boxMargins: EdgeInsets.all(0),
           color: collectionsColor,
           corners: profilePicHeight * 0.22,
           iconSizeFactor: 0.8,
           icon: Iconz.SavedFlyers,
           boxFunction: () {switchingPages(inPyramidsPage.SavedFlyers);},
           verse: collectionsPageTitle,
           verseColor: Colorz.BlackBlack,
           verseWeight: VerseWeight.bold,
           verseScaleFactor: 0.675,
           verseItalic: true,
         ),

         // ---  SPACER
         SizedBox(
           width: abPadding * 0.5,
           height: abButtonsHeight,
         ),

         // --- NEWS
         DreamBox(
           width: currentPage == inPyramidsPage.News ? null : abButtonsHeight,
           height: abButtonsHeight,
           boxMargins: EdgeInsets.all(0),
           color: newsColor,
           corners: profilePicHeight * 0.22,
           iconSizeFactor: 0.6,
           icon: Iconz.News,
           boxFunction: () {switchingPages(inPyramidsPage.News);},
           verse: currentPage == inPyramidsPage.News ? Wordz.news(context) : null,
           verseColor: Colorz.BlackBlack,
           verseWeight: VerseWeight.bold,
           verseScaleFactor: 0.9,
           verseItalic: true,
         ),

         // ---  SPACER
         SizedBox(
           width: abPadding * 0.5,
           height: abButtonsHeight,
         ),

         // --- MORE
         DreamBox(
           width: currentPage == inPyramidsPage.More ? null : abButtonsHeight,
           height: abButtonsHeight,
           // boxMargins: EdgeInsets.all(abPadding),
           color: moreColor,
           corners: Ratioz.ddAppBarButtonCorner,
           iconSizeFactor: 0.5,
           icon: Iconz.More,
           boxFunction: () {switchingPages(inPyramidsPage.More);},
           verse: currentPage == inPyramidsPage.More ? Wordz.more(context) : null,
           verseColor: Colorz.BlackBlack,
           verseWeight: VerseWeight.bold,
           verseScaleFactor: 1.08,
           verseItalic: true,
         ),

         // --- FILLER SPACE BETWEEN ITEMS
         Expanded(
           child: Container(),
         ),

         // --- PROFILE
         Padding(
           padding: EdgeInsets.all(abPadding * 0.5),
           child: UserBalloon(
             userPic: Iconz.DumAuthorPic,
             userStatus: userStatus,
             balloonWidth: abButtonsHeight,
             blackAndWhite: profileBlackAndWhite,
             onTap: () {switchingPages(inPyramidsPage.Profile);},
           ),
         ),

      ],
    );
  }
}
