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

  List<Widget> inPyramidsAppBarButtons({
    BuildContext context,
    Function switchingPages,
    inPyramidsPage currentPage,
    UserStatus userStatus,
  }) {

    double _abPadding = Ratioz.ddAppBarMargin;
    double _abHeight = Ratioz.ddAppBarHeight;
    double _profilePicHeight = _abHeight;
    double _abButtonsHeight = _abHeight - (_abPadding);

    bool _profileBlackAndWhite = currentPage == inPyramidsPage.Profile ? false : true;
    Color _collectionsColor = currentPage == inPyramidsPage.SavedFlyers ? Colorz.Yellow : Colorz.WhiteAir;
    Color _newsColor = currentPage == inPyramidsPage.News ? Colorz.Yellow : Colorz.WhiteAir;
    Color _moreColor = currentPage == inPyramidsPage.More ? Colorz.Yellow : Colorz.WhiteAir;

    String _collectionsPageTitle = currentPage == inPyramidsPage.SavedFlyers ? Wordz.savedFlyers(context) : null;
    double _collectionsBTWidth = currentPage == inPyramidsPage.SavedFlyers ? null : _abButtonsHeight;

    return <Widget>[

        // ---  SPACER
         SizedBox(
           width: _abPadding * 0.5,
           height: _abButtonsHeight,
         ),

         // --- COLLECTIONS
         DreamBox(
           width: _collectionsBTWidth,
           height: _abButtonsHeight,
           boxMargins: EdgeInsets.all(0),
           color: _collectionsColor,
           corners: _profilePicHeight * 0.22,
           iconSizeFactor: 0.8,
           icon: Iconz.SavedFlyers,
           boxFunction: () {switchingPages(inPyramidsPage.SavedFlyers);},
           verse: _collectionsPageTitle,
           verseColor: Colorz.BlackBlack,
           verseWeight: VerseWeight.bold,
           verseScaleFactor: 0.675,
           verseItalic: true,
         ),

         // ---  SPACER
         SizedBox(
           width: _abPadding * 0.5,
           height: _abButtonsHeight,
         ),

         // --- NEWS
         DreamBox(
           width: currentPage == inPyramidsPage.News ? null : _abButtonsHeight,
           height: _abButtonsHeight,
           boxMargins: EdgeInsets.all(0),
           color: _newsColor,
           corners: _profilePicHeight * 0.22,
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
           width: _abPadding * 0.5,
           height: _abButtonsHeight,
         ),

         // --- MORE
         DreamBox(
           width: currentPage == inPyramidsPage.More ? null : _abButtonsHeight,
           height: _abButtonsHeight,
           // boxMargins: EdgeInsets.all(_abPadding),
           color: _moreColor,
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
           padding: EdgeInsets.all(_abPadding * 0.5),
           child: UserBalloon(
             userPic: Iconz.DumAuthorPic,
             userStatus: userStatus,
             balloonWidth: _abButtonsHeight,
             blackAndWhite: _profileBlackAndWhite,
             onTap: () {switchingPages(inPyramidsPage.Profile);},
           ),
         ),

      ];
}
