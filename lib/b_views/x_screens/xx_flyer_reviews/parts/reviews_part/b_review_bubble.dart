import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/ba_review_user_image_balloon.dart';
import 'package:bldrs/b_views/x_screens/xx_flyer_reviews/parts/reviews_part/bb_review_text_balloon.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubble({
    @required this.isCreatorMode,
    @required this.pageWidth,
    @required this.flyerModel,
    this.reviewModel,
    this.reviewTextController,
    this.addMap,
    this.replyTextController,
    this.replaceMap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isCreatorMode;
  final double pageWidth;
  final ReviewModel reviewModel;
  final TextEditingController reviewTextController;
  final FlyerModel flyerModel;
  final TextEditingController replyTextController;
  final ValueNotifier<Map<String, dynamic>> replaceMap;
  final ValueNotifier<Map<String, dynamic>> addMap;
// ---------------------------------------------------

  /// USER BALLOON

// ---------------------------------
  static const double userBalloonSize = 50;
// ---------------------------------------------------

  /// SPACING

// ---------------------------------
  static const double spacer = Ratioz.appBarMargin;
// ---------------------------------------------------

    /// TEXT BUBBLE SIZING

// ---------------------------------
  static double getTextBubbleWidth({
    @required double pageWidth,
  }){
    return pageWidth - (3 * spacer) - userBalloonSize;
  }
// ---------------------------------
  static BorderRadius textBubbleCorners({
    @required BuildContext context,
  }){
    return Borderers.superBorderAll(context, Ratioz.appBarCorner);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      key: const ValueKey<String>('review_bubble_key'),
      width: pageWidth,
      margin: const EdgeInsets.only(bottom: spacer),
      child: FutureBuilder(
        future: UserProtocols.fetchUser(
            context: context,
            userID: reviewModel?.userID ?? AuthFireOps.superUserID(),
        ),
        builder: (_, AsyncSnapshot<UserModel> snap){

          final UserModel _userModel = snap.data;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// LEFT PADDING
                const SizedBox(width: spacer,),

                /// USER IMAGE BALLOON PART
                ReviewUserImageBalloon(
                  userModel: _userModel,
                ),

                /// SPACER
                const SizedBox(width: spacer,),

                /// REVIEW BALLOON PART
                ReviewTextBalloon(
                  isCreatorMode: isCreatorMode,
                  addMap: addMap,
                  userModel: _userModel,
                  reviewModel: reviewModel,
                  pageWidth: pageWidth,
                  reviewTextController: reviewTextController,
                  flyerModel: flyerModel,
                  replyTextController: replyTextController,
                  replaceMap: replaceMap,
                ),

                /// RIGHT SPACING
                const SizedBox(width: spacer,),

              ],
            );

        },
      ),
    );
  }
}
