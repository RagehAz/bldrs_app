import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/widgets/general/buttons/balloons/user_balloon.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/e_footer_button.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class ReviewBubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReviewBubble({
    @required this.pageWidth,
    @required this.flyerBoxWidth,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double pageWidth;
  final double flyerBoxWidth;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _imageBoxWidth = FooterButton.buttonSize(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
        tinyMode: false
    );

    final double _reviewBoxWidth = pageWidth - _imageBoxWidth;

    final BorderRadius _reviewBubbleBorders = FlyerBox.superLogoCorner(context: context, flyerBoxWidth: flyerBoxWidth);

    const double _paddings = 10;

    return Container(
      key: const ValueKey<String>('review_bubble_key'),
      width: pageWidth,
      margin: const EdgeInsets.only(bottom: _paddings),
      // height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Container(
            width: _imageBoxWidth,
            alignment: Alignment.bottomCenter,
            child: UserBalloon(
              userModel: UserModel.dummyUserModel(context),
              balloonWidth: _imageBoxWidth - (_paddings * 2),
              loading: false,
              onTap: (){blog('blah');},
              // balloonColor: ,
              balloonType: UserStatus.planning,
              shadowIsOn: false,
            ),
          ),

          Container(
            width: _reviewBoxWidth - _paddings,
            height: 100,
            decoration: BoxDecoration(
              color: Colorz.yellow255,
              borderRadius: _reviewBubbleBorders,
            ),
            padding: const EdgeInsets.all(Ratioz.appBarPadding),
            alignment: superTopAlignment(context),
            child: const SuperVerse(
              verse: 'Wallahy ya fandem elly fih el kheir y2addemo rabbena, mesh keda walla eh ?',
              maxLines: 100,
              centered: false,
            ),
          ),

        ],
      ),
    );
  }
}
