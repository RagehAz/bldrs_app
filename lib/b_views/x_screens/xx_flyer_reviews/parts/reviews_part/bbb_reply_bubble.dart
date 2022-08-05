import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/b_review_bubble.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/bba_review_bubble_balloon.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/c_review_text_column.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:flutter/material.dart';

class BzReplyBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzReplyBubble({
    @required this.boxWidth,
    @required this.reviewModel,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final ReviewModel reviewModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _logoWidth = ReviewBubble.userBalloonSize;

    return SizedBox(
      width: boxWidth,
      child: FutureBuilder(
        future: BzProtocols.fetchBzByFlyerID(context: context, flyerID: reviewModel?.flyerID),
        builder: (_, AsyncSnapshot<Object> snapshot){

          final BzModel _bzModel = snapshot.data;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              /// BZ LOGO
              BzLogo(
                width: _logoWidth,
                image: _bzModel?.logo,
                zeroCornerIsOn: true,
              ),

              /// SPACER
              const SizedBox(width: ReviewBubble.spacer * 0.5),

              /// REPLY TEXT BOX
              ReviewBubbleBox(
                width: boxWidth - _logoWidth - ReviewBubble.spacer * 0.5,
                child: ReviewTextsColumn(
                  name: _bzModel?.name ?? '',
                  timeStamp: reviewModel?.replyTime,
                  text: reviewModel?.reply,
                  isCreatorMode: false,
                ),
              ),

            ],
          );

        },
      ),
    );

  }
}
