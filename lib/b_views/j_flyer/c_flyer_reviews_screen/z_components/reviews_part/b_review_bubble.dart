import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/sub/review_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/ba_review_user_image_balloon.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/reviews_part/bb_review_text_balloon.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
import 'package:bldrs/b_views/z_components/streamers/fire/paginator_notifiers.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubble({
    @required this.isCreatorMode,
    @required this.pageWidth,
    @required this.flyerModel,
    @required this.paginatorNotifiers,
    @required this.appBarType,
    @required this.globalKey,
    this.reviewModel,
    this.reviewTextController,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool isCreatorMode;
  final double pageWidth;
  final ReviewModel reviewModel;
  final TextEditingController reviewTextController;
  final FlyerModel flyerModel;
  final PaginatorNotifiers paginatorNotifiers;
  final AppBarType appBarType;
  final GlobalKey globalKey;
  // -----------------------------------------------------------------------------

  /// USER BALLOON

  // --------------------
  static const double userBalloonSize = 50;
  // -----------------------------------------------------------------------------

  /// SPACING

  // --------------------
  static const double spacer = Ratioz.appBarMargin;
  // -----------------------------------------------------------------------------

    /// TEXT BUBBLE SIZING

  // --------------------
  static double getTextBubbleWidth({
    @required double pageWidth,
  }){
    return pageWidth - (3 * spacer) - userBalloonSize;
  }
  // --------------------
  static const BorderRadius textBubbleCorners = BldrsAppBar.corners;
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
                  appBarType: appBarType,
                  isCreatorMode: isCreatorMode,
                  userModel: _userModel,
                  reviewModel: reviewModel,
                  pageWidth: pageWidth,
                  reviewTextController: reviewTextController,
                  flyerModel: flyerModel,
                  paginatorNotifiers: paginatorNotifiers,
                  globalKey: globalKey,
                ),

                /// RIGHT SPACING
                const SizedBox(width: spacer,),

              ],
            );

        },
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
