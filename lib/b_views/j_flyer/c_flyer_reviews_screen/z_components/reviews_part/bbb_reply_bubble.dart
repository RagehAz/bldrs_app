import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/b_review_bubble.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/bba_review_bubble_balloon.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/c_review_text_column.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/d_review_bubble_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/a_header/bz_logo.dart';
import 'package:bldrs/b_views/z_components/layouts/separator_line.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/paginator_notifiers.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/x_reviews_controller.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class BzReplyBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzReplyBubble({
    @required this.boxWidth,
    @required this.reviewModel,
    @required this.flyerModel,
    @required this.paginatorNotifiers,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double boxWidth;
  final ReviewModel reviewModel;
  final FlyerModel flyerModel;
  final PaginatorNotifiers paginatorNotifiers;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const double _logoWidth = ReviewBubble.userBalloonSize;

    final bool _imAuthorInFlyerBz = AuthorModel.checkImAuthorInBzOfThisFlyer(
      context: context,
      flyerModel: flyerModel,
    );

    final double _balloonWidth = boxWidth - _logoWidth - ReviewBubble.spacer * 0.5;

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
                width: _balloonWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    ReviewTextsColumn(
                      name: _bzModel?.name ?? '',
                      timeStamp: reviewModel?.replyTime,
                      text: reviewModel?.reply,
                      isCreatorMode: false,
                    ),

                    /// SEPARATOR LINE
                    if (_imAuthorInFlyerBz == true)
                      SeparatorLine(
                        width: _balloonWidth,
                        color: Colorz.white50,
                      ),

                    /// ( REPLY - AGREE ) BUTTONS
                    if (_imAuthorInFlyerBz == true)
                      SizedBox(
                        width: _balloonWidth,
                        child: Row(
                          children: <Widget>[

                            /// MORE BUTTON
                              ReviewBubbleButton(
                                count: null,
                                isOn: false,
                                verse: null,
                                icon: Iconz.more,
                                onTap: () => onReplyOptions(
                                  context: context,
                                  reviewModel: reviewModel,
                                  replaceMapNotifier: paginatorNotifiers.replaceMap,
                                ),
                              ),

                          ],
                        ),
                      ),


                  ],
                ),
              ),

            ],
          );

        },
      ),
    );

  }
}
