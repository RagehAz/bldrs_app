import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/db/fire/auth_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/header_parts/author_bubble/author_label.dart';
import 'package:flutter/material.dart';

class AuthorBubble extends StatelessWidget {
  final double flyerBoxWidth;
  final bool addAuthorButtonIsOn;
  final List<AuthorModel> bzAuthors;
  final bool showFlyers;
  final BzModel bzModel;
  final Function onAuthorLabelTap;
  final String selectedAuthorID;
  final List<FlyerModel> bzFlyers;

  const AuthorBubble({
    @required this.flyerBoxWidth,
    @required this.addAuthorButtonIsOn,
    @required this.bzAuthors,
    @required this.showFlyers,
    @required this.bzModel,
    @required this.onAuthorLabelTap,
    @required this.selectedAuthorID,
    @required this.bzFlyers,
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
  static const double spacing = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static double bubbleHeight(double flyerBoxWidth){

    final double _titleHeight = titleHeight(flyerBoxWidth);
    final double _authorPicHeight = authorPicHeight(flyerBoxWidth);
    final double _bubbleHeight = _titleHeight + _authorPicHeight + (2 * spacing);

    return _bubbleHeight;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final List<String> _bzTeamIDs = BzModel.getBzTeamIDs(bzModel);
    final bool _thisIsMyBz = _bzTeamIDs.contains(superUserID());
    final BzModel _bz = bzModel;

    final double _bubbleWidth = bubbleWidth(flyerBoxWidth);

    return Container(
      width: _bubbleWidth,
      height: bubbleHeight(flyerBoxWidth),
      decoration: BoxDecoration(
          color: addAuthorButtonIsOn == true ? Colorz.white10 : Colorz.white10,
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
            height: spacing,
            width: _bubbleWidth,
          ),

          /// TITLE
          Container(
            width: flyerBoxWidth - (2 * Ratioz.appBarMargin),
            height: flyerBoxWidth * Ratioz.xxflyerAuthorPicWidth * 0.4,
            // color: Colorz.BloodTest,
            alignment: Aligners.superCenterAlignment(context),
            padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin * 2),
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
                padding: const EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
                key: PageStorageKey<String>('authorsRow_${bzModel.id}'),
                children: <Widget>[

                  /// AUTHORS LABELS
                  if (bzAuthors != null)
                    ...List<Widget>.generate(
                        bzAuthors.length,
                            (authorIndex) {
                          AuthorModel _author = bzAuthors[authorIndex];
                          return
                            Row(
                              children: <Widget>[

                                AuthorLabel(
                                  showLabel: showFlyers == true ? true : false,
                                  flyerBoxWidth: flyerBoxWidth,
                                  authorID: _author.userID,
                                  bzModel: _bz,
                                  authorGalleryCount: AuthorModel.getAuthorGalleryCountFromBzModel(
                                    bzModel: bzModel,
                                    author: _author,
                                    bzFlyers: bzFlyers,
                                  ),
                                  onTap:
                                  // widget.bzTeamIDs.length == 1 ?
                                      (id) {
                                    onAuthorLabelTap(id);
                                  },
                                  // :(id){print('a77a');// tappingAuthorLabel();},
                                  labelIsOn: selectedAuthorID == bzAuthors[authorIndex].userID ? true : false,
                                ),

                                const SizedBox(width: Ratioz.appBarPadding),

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
                    ),

                ]
            ),
          ),


          /// BOTTOM SPACER
          SizedBox(
            height: spacing,
            width: _bubbleWidth,
          ),

        ],
      ),
    );
  }
}
