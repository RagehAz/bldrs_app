import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/stream_checkers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/iconz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
import 'package:bldrs/models/flyer/records/review_model.dart';
import 'package:bldrs/models/user/tiny_user.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/providers/flyers_and_bzz/flyer_streamer.dart';
import 'package:bldrs/providers/users/user_streamer.dart';
import 'package:bldrs/views/widgets/bubbles/in_pyramids_bubble.dart';
import 'package:bldrs/views/widgets/buttons/PersonButton.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_card.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/info_page_parts/review_creator.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  final double flyerZoneWidth;
  final SuperFlyer superFlyer;

  const ReviewBubble({
    @required this.flyerZoneWidth,
    @required this.superFlyer,
  });



  @override
  Widget build(BuildContext context) {

    double _bubbleWidth = flyerZoneWidth - (Ratioz.appBarPadding * 2);
    EdgeInsets _bubbleMargins = EdgeInsets.only(top: Ratioz.appBarPadding, left: Ratioz.appBarPadding, right: Ratioz.appBarPadding);
    double _peopleBubbleBoxHeight = flyerZoneWidth * Ratioz.xxflyerAuthorPicWidth * 1.5;

    double _cornerSmall = flyerZoneWidth * Ratioz.xxflyerTopCorners;
    double _cornerBig = (flyerZoneWidth - (Ratioz.appBarPadding * 2)) * Ratioz.xxflyerBottomCorners;

    BorderRadius _bubbleCorners = Borderers.superBorderOnly(
      context: context,
      enTopLeft: _cornerSmall,
      enTopRight: _cornerSmall,
      enBottomLeft: _cornerBig,
      enBottomRight: _cornerBig,
    );

    double _cardCorners = _cornerSmall - Ratioz.appBarMargin;

    return tinyUserModelBuilder(
      context: context,
      userID: superUserID(),
      builder: (ctx, tinyUser){
        return
          InPyramidsBubble(
            bubbleWidth: _bubbleWidth,
            margins: _bubbleMargins,
            corners: _bubbleCorners,
            title: 'Flyer Reviews',
            leadingIcon: Iconz.BxDesignsOn,
            LeadingAndActionButtonsSizeFactor: 1,
            columnChildren: <Widget>[

              ReviewCreator(
                width: _bubbleWidth,
                corners: _cardCorners,
                tinyUser: tinyUser,
                superFlyer: superFlyer,
              ),

              reviewsStreamBuilder(
                  context: context,
                  flyerID: superFlyer.flyerID,
                  builder : (xxx, reviews){

                    return
                      Container(
                        width: _bubbleWidth,
                        child: Column(

                          children: <Widget>[

                            ...List.generate
                              (reviews.length, (index) =>
                                ReviewCard(
                                  width: _bubbleWidth,
                                  corners: _cardCorners,
                                  review: reviews[index],
                                  tinyUser: tinyUser,
                                  flyerID: superFlyer.flyerID,
                                  onShowReviewOptions: () => superFlyer.rec.onShowReviewOptions(reviews[index]),
                                ),
                            )
                          ],
                        ),
                      );
                  }
              ),


              // ...List.generate
              //   (3, (index) =>
              //           ReviewCard(
              //             width: _bubbleWidth,
              //             corners: _cardCorners,
              //             review: ReviewModel.dummyReview(),
              //           ),
              // ),

              /// bottom spaced
              Container(
                width: _bubbleWidth,
                height: _cornerBig - Ratioz.appBarMargin,
              ),

            ],
          );
      }
    );


  }
}
