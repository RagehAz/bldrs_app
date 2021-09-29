import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:flutter/material.dart';

class AuthorBubble extends StatelessWidget {
  final double flyerBoxWidth;
  final bool addAuthorButtonIsOn;
  final List<AuthorModel> bzAuthors;
  final bool showFlyers;
  final BzModel bzModel;
  final Function onAuthorLabelTap;
  final String selectedAuthorID;

  const AuthorBubble({
    @required this.flyerBoxWidth,
    @required this.addAuthorButtonIsOn,
    @required this.bzAuthors,
    @required this.showFlyers,
    @required this.bzModel,
    @required this.onAuthorLabelTap,
    @required this.selectedAuthorID,
});
// -----------------------------------------------------------------------------
  static double bubbleWidth(double flyerBoxWidth){
    return flyerBoxWidth - (2 * Ratioz.appBarMargin);
  }
// -----------------------------------------------------------------------------
  static double authorPicHeight(double flyerBoxWidth){
    return flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth;
  }
// -----------------------------------------------------------------------------
  static double titleHeight(double flyerBoxWidth){
    return authorPicHeight(flyerBoxWidth) * 0.4;
  }
// -----------------------------------------------------------------------------
  static double spacing(double flyerBoxWidth){
    return Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static double bubbleHeight(double flyerBoxWidth){

    double _titleHeight = titleHeight(flyerBoxWidth);
    double _authorPicHeight = authorPicHeight(flyerBoxWidth);
    double _spacing = spacing(flyerBoxWidth);

    double _bubbleHeight = _titleHeight + _authorPicHeight + (2 * _spacing);
    return _bubbleHeight;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    List<String> _bzTeamIDs = BzModel.getBzTeamIDs(bzModel);
    bool _thisIsMyBz = _bzTeamIDs.contains(superUserID());
    TinyBz _tinyBz = TinyBz.getTinyBzFromBzModel(bzModel);

    double _bubbleWidth = bubbleWidth(flyerBoxWidth);

    double _spacing = spacing(flyerBoxWidth);

    return Container(
      width: _bubbleWidth,
      height: bubbleHeight(flyerBoxWidth),
      decoration: BoxDecoration(
          color: addAuthorButtonIsOn == true ? Colorz.White10 : Colorz.White10,
          borderRadius: Borderers.superLogoShape(
            context: context,
            corner: AuthorPic.getCornerValue(flyerBoxWidth) + Ratioz.appBarMargin,
            zeroCornerEnIsRight: false,
          )
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          /// TOP SPACER
          SizedBox(
            height: _spacing,
            width: _bubbleWidth,
          ),

          /// TITLE
          Container(
            width: flyerBoxWidth - (2 * Ratioz.appBarMargin),
            height: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 0.4,
            // color: Colorz.BloodTest,
            alignment: Aligners.superCenterAlignment(context),
            padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
            child: SuperVerse(
              verse: 'The Team',
              size: 2,
              centered: false,
              weight: VerseWeight.thin,
              italic: true,
            ),
          ),

          /// AUTHORS ROW
          Container(
            width: flyerBoxWidth - (2 * Ratioz.appBarMargin),
            height: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth,
            child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                children: <Widget>[

                  /// AUTHORS LABELS
                  if (bzAuthors != null)
                    ...List<Widget>.generate(
                        bzAuthors.length,
                            (authorIndex) {
                          AuthorModel _author = bzAuthors[authorIndex];
                          TinyUser _tinyAuthor = TinyUser.getTinyAuthorFromAuthorModel(_author);
                          return
                            Row(
                              children: <Widget>[

                                AuthorLabel(
                                  showLabel: showFlyers == true ? true : false,
                                  flyerBoxWidth: flyerBoxWidth,
                                  tinyAuthor: _tinyAuthor,
                                  tinyBz: _tinyBz,
                                  authorGalleryCount: AuthorModel.getAuthorGalleryCountFromBzModel(bzModel, _author),
                                  onTap:
                                  // widget.bzTeamIDs.length == 1 ?
                                      (id) {
                                    onAuthorLabelTap(id);
                                  },
                                  // :(id){print('a77a');// tappingAuthorLabel();},
                                  labelIsOn: selectedAuthorID == bzAuthors[authorIndex].userID ? true : false,
                                ),

                                SizedBox(width: Ratioz.appBarPadding),

                              ],
                            );
                        }
                    ),

                  /// ADD NEW AUTHOR BUTTON
                  if (_thisIsMyBz == true && addAuthorButtonIsOn == true)
                    AuthorPic(
                      width: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth,
                      authorPic: null,
                      isAddAuthorButton: true,
                      tinyBz: _tinyBz,
                    ),

                ]
            ),
          ),


          /// BOTTOM SPACER
          SizedBox(
            height: _spacing,
            width: _bubbleWidth,
          ),

        ],
      ),
    );
  }
}
