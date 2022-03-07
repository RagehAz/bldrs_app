import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class QuestionHeaderLabels extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionHeaderLabels({
    @required this.flyerBoxWidth,
    @required this.userModel,
    @required this.headerIsExpanded,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double flyerBoxWidth;
  final UserModel userModel;
  final bool headerIsExpanded;
  /// --------------------------------------------------------------------------
  static double getHeaderLabelWidth(double flyerBoxWidth) {
    return flyerBoxWidth * (Ratioz.xxflyerAuthorPicWidth + Ratioz.xxflyerAuthorNameWidth);
  }
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double labelsWidth = getHeaderLabelWidth(flyerBoxWidth);
    final double labelsHeight = flyerBoxWidth * (Ratioz.xxflyerHeaderMiniHeight - (2 * Ratioz.xxflyerHeaderMainPadding));
    final double _sidePadding = flyerBoxWidth * 0.015;
// -----------------------------------------------------------------------------
    return SizedBox(
        width: labelsWidth,
        height: labelsHeight,
        // color: Colorz.Bl,

        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _sidePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SuperVerse(
                verse: userModel.name,
                scaleFactor: flyerBoxWidth * 0.0035,
                size: 3,
              ),

              SuperVerse(
                verse: UserModel.userJobLine(userModel),
                scaleFactor: flyerBoxWidth * 0.0035 * 0.9,
                size: 2,
                weight: VerseWeight.thin,
              ),

            ],
          ),
        ));
  }
}
