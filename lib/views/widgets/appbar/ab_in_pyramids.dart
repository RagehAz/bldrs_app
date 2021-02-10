import 'package:bldrs/models/user_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/iconz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/screens/s11_inpyramids_screen.dart';
import 'package:bldrs/views/widgets/buttons/balloons/user_balloon.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/header_parts/common_parts/bz_logo.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ABInPyramids extends StatelessWidget {
    final Function switchingPages;
    final PageType currentPage;

    ABInPyramids({
      @required this.switchingPages,
      @required this.currentPage,
    });

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel>(context);
    FlyersProvider prof = Provider.of<FlyersProvider>(context, listen: true);

    double _abPadding = Ratioz.ddAppBarMargin;
    double _abHeight = Ratioz.ddAppBarHeight;
    double _profilePicHeight = _abHeight;
    double _abButtonsHeight = _abHeight - (_abPadding);

    bool _profileBlackAndWhite = currentPage == PageType.Profile ? false : true;
    bool _bzPageBlackAndWhite = currentPage == PageType.MyBz ? false : true;


        Color _collectionsColor = currentPage == PageType.SavedFlyers ? Colorz.Yellow : Colorz.WhiteAir;
    Color _newsColor = currentPage == PageType.News ? Colorz.Yellow : Colorz.WhiteAir;
    Color _moreColor = currentPage == PageType.More ? Colorz.Yellow : Colorz.WhiteAir;

    String _collectionsPageTitle = currentPage == PageType.SavedFlyers ? Wordz.savedFlyers(context) : null;
    double _collectionsBTWidth = currentPage == PageType.SavedFlyers ? null : _abButtonsHeight;

    Widget spacer = SizedBox(
      width: _abPadding * 0.5,
      height: _abButtonsHeight,
    );

    double _screenWidth = superScreenWidth(context);
    double _abWidth = _screenWidth - (2 * Ratioz.ddAppBarMargin);
    // double _blurValue = appBarType == AppBarType.Localizer || appBarType == AppBarType.Sections? 10 : 5;


    return StreamBuilder<UserModel>(
      stream: UserProvider(userID: _user.userID).userData,
      builder: (context, snapshot){
        if(snapshot.hasData == false){
          return Container(
            width: _abWidth,
            height: _abHeight,
            alignment: Alignment.centerRight,
              child: Loading(),
          );
        } else {
          UserModel userModel = snapshot.data;
          return
        Container(
          width: _abWidth,
          height: _abHeight,
          alignment: Alignment.center,
          margin:  EdgeInsets.all(0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(Ratioz.ddAppBarCorner)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              spacer,

              // --- COLLECTIONS
              DreamBox(
                width: _collectionsBTWidth,
                height: _abButtonsHeight,
                boxMargins: EdgeInsets.all(0),
                color: _collectionsColor,
                corners: _profilePicHeight * 0.22,
                iconSizeFactor: 0.8,
                icon: Iconz.SavedFlyers,
                boxFunction: () {switchingPages(PageType.SavedFlyers);},
                verse: _collectionsPageTitle,
                verseColor: Colorz.BlackBlack,
                verseWeight: VerseWeight.bold,
                verseScaleFactor: 0.675,
                verseItalic: true,
              ),

              spacer,

              // --- NEWS
              DreamBox(
                width: currentPage == PageType.News ? null : _abButtonsHeight,
                height: _abButtonsHeight,
                boxMargins: EdgeInsets.all(0),
                color: _newsColor,
                corners: _profilePicHeight * 0.22,
                iconSizeFactor: 0.6,
                icon: Iconz.News,
                boxFunction: () {switchingPages(PageType.News);},
                verse: currentPage == PageType.News ? Wordz.news(context) : null,
                verseColor: Colorz.BlackBlack,
                verseWeight: VerseWeight.bold,
                verseScaleFactor: 0.9,
                verseItalic: true,
              ),

              spacer,

              // --- MORE
              DreamBox(
                width: currentPage == PageType.More ? null : _abButtonsHeight,
                height: _abButtonsHeight,
                // boxMargins: EdgeInsets.all(_abPadding),
                color: _moreColor,
                corners: Ratioz.ddAppBarButtonCorner,
                iconSizeFactor: 0.5,
                icon: Iconz.More,
                boxFunction: () {switchingPages(PageType.More);},
                verse: currentPage == PageType.More ? Wordz.more(context) : null,
                verseColor: Colorz.BlackBlack,
                verseWeight: VerseWeight.bold,
                verseScaleFactor: 1.08,
                verseItalic: true,
              ),

              // --- FILLER SPACE BETWEEN ITEMS
              Expanded(
                child: Container(),
              ),

              // --- BZ LOGO
              if (userModel.userStatus == UserStatus.BzAuthor)
              Align(
                alignment: Alignment.center,
                child: BzLogo(
                  width: _abButtonsHeight,
                  image: prof.getBzByBzID(userModel.followedBzzIDs[0])?.bzLogo,
                  // margins: ,
                  zeroCornerIsOn: false,
                  onTap: () {switchingPages(PageType.MyBz);},
                blackAndWhite: _bzPageBlackAndWhite,
                ),
              ),

              spacer,

              // --- PROFILE
              Padding(
                padding: EdgeInsets.all(_abPadding * 0.5),
                child: UserBalloon(
                  userPic: userModel.pic, //Iconz.DumAuthorPic, /// should be userModel.pic
                  userStatus: userModel.userStatus,
                  balloonWidth: _abButtonsHeight,
                  blackAndWhite: _profileBlackAndWhite,
                  onTap: () {switchingPages(PageType.Profile);},
                ),
              ),

            ],
      ),
        );
    } // bent el kalb dih when u comment off the Loading indicator widget part with its condition
},
);
}
}
