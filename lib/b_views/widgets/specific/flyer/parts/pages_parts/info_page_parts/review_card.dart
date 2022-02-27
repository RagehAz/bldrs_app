import 'package:bldrs/a_models/flyer/records/review_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_user_label.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewCard({
    @required this.width,
    @required this.corners,
    @required this.review,
    @required this.userModel,
    @required this.flyerID,
    @required this.onShowReviewOptions,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
  final double width;
  final double corners;
  final ReviewModel review;
  final UserModel userModel;
  final String flyerID;
  final Function onShowReviewOptions;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      // height: 50,
      decoration: BoxDecoration(
        color: Colorz.white10,
        borderRadius: Borderers.superBorderAll(context, corners),
        border: Border.all(width: 0.5, color: Colorz.yellow80),
      ),
      child: Column(
        children: <Widget>[
          /// USER LABEL
          ReviewUserLabel(
            tinyUser: userModel,
            hasEditButton: true,
            onReviewOptions: onShowReviewOptions,
          ),

          /// REVIEW BODY
          Container(
            width: width,
            padding: const EdgeInsets.all(Ratioz.appBarMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// REVIEW TIME
                SuperVerse(
                  verse: Timers.stringOnDateMonthYear(
                      context: context, time: review.time),
                  size: 1,
                  color: Colorz.white125,
                  centered: false,
                  weight: VerseWeight.thin,
                  italic: true,
                ),

                /// REVIEW TEXT
                SuperVerse(
                  verse: review.body,
                  centered: false,
                  maxLines: 3,
                  italic: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
