import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/z_components/buttons/ba_review_user_image_balloon.dart';
import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBox({
    @required this.pageWidth,
    @required this.userID,
    @required this.builder,
    @required this.onReviewUserBalloonTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final String userID;
  final ValueChanged<UserModel> onReviewUserBalloonTap;
  final Widget Function(UserModel userModel) builder;
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
      key: const ValueKey<String>('ReviewBox'),
      width: pageWidth,
      margin: const EdgeInsets.only(bottom: spacer),
      child: FutureBuilder(
        future: UserProtocols.fetch(
          context: context,
          userID: userID,
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
                onTap: () => onReviewUserBalloonTap(_userModel),
              ),


              /// SPACER
              const SizedBox(width: spacer,),

              /// RIGHT BUBBLE
              builder(_userModel),

              /// RIGHT SPACING
              const SizedBox(width: spacer,),

            ],
          );

        },
      ),
    );

  }
}
