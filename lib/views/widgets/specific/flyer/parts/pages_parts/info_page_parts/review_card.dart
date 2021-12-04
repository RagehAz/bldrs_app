import 'package:bldrs/controllers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/controllers/drafters/timerz.dart' as Timers;
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/models/flyer/records/review_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/info_page_parts/review_user_label.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final double width;
  final double corners;
  final ReviewModel review;
  final UserModel userModel;
  final String flyerID;
  final Function onShowReviewOptions;

  const ReviewCard({
    @required this.width,
    @required this.corners,
    @required this.review,
    @required this.userModel,
    @required this.flyerID,
    @required this.onShowReviewOptions,
    Key key,
  }) : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// REVIEW TIME
                SuperVerse(
                  verse: Timers.stringOnDateMonthYear(context: context, time: review.time),
                  size: 1,
                  color: Colorz.white125,
                  centered: false,
                  weight: VerseWeight.thin,
                  italic: true,
                ),

                /// REVIEW TEXT
                SuperVerse(
                  verse: review.body,
                  size: 2,
                  centered: false,
                  maxLines: 3,
                  color: Colorz.white255,
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




