import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/review_button/a_review_button_structure/a_review_page_starter.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timerz;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubble({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    @required this.userModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double flyerBoxWidth;
  final UserModel userModel;
  /// --------------------------------------------------------------------------
  static double bubbleMarginValue(){
    return Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static double reviewBubbleCornerValue({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }){

    final double _expandedPageCornerValue = ReviewPageStarter.expandedCornerValue(
        context: context,
        flyerBoxWidth: flyerBoxWidth
    );

    final double _reviewPageMargin = bubbleMarginValue();
    final double _reviewBubbleCornerValue = _expandedPageCornerValue - _reviewPageMargin;
    return _reviewBubbleCornerValue;
  }
// -----------------------------------------------------------------------------
  static BorderRadius reviewBubbleBorders({
    @required BuildContext context,
    @required double flyerBoxWidth,
}){
    final double _reviewBubbleCornerValue = reviewBubbleCornerValue(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    return Borderers.superBorderAll(context, _reviewBubbleCornerValue);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _imageBoxWidth = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _reviewBoxWidth = pageWidth - _imageBoxWidth;

    final BorderRadius _reviewBubbleBorders = reviewBubbleBorders(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );

    final double _bubbleMargin = bubbleMarginValue();

    final DateTime _reviewTime = Timerz.createDate(year: 1987, month: 6, day: 10);

    return Container(
      key: const ValueKey<String>('review_bubble_key'),
      width: pageWidth,
      margin: EdgeInsets.only(bottom: _bubbleMargin),
      // height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          /// USER IMAGE BALLOON PART
          Container(
            width: _imageBoxWidth,
            alignment: Alignment.bottomCenter,
            child: UserBalloon(
              userModel: userModel,
              balloonWidth: _imageBoxWidth - (_bubbleMargin * 2),
              loading: false,
              onTap: (){blog('tapping user balloon in reviews');},
              // balloonColor: ,
              balloonType: UserStatus.planning,
              shadowIsOn: false,
            ),
          ),

          /// REVIEW BALLOON PART
          Container(
            width: _reviewBoxWidth - _bubbleMargin,
            decoration: BoxDecoration(
              color: Colorz.white20,
              borderRadius: _reviewBubbleBorders,
            ),
            padding: EdgeInsets.all(_bubbleMargin),
            alignment: superTopAlignment(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                SuperVerse(
                  verse: userModel.name,
                ),

                SuperVerse(
                  verse: Timerz.getSuperTimeDifferenceString(
                    from: _reviewTime,
                    to: DateTime.now(),
                  ),
                  weight: VerseWeight.thin,
                  italic: true,
                  color: Colorz.white200,
                  scaleFactor: 0.9,
                ),

                const SuperVerse(
                  verse: 'Wallahy ya fandem elly fih el kheir y2addemo rabbena, mesh keda walla eh ?',
                  maxLines: 100,
                  centered: false,
                  weight: VerseWeight.thin,
                  scaleFactor: 1.1,
                ),

              ],
            ),
          ),

        ],
      ),
    );
  }
}
