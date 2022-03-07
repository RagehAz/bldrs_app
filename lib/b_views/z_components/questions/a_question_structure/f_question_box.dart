import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class QuestionBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const QuestionBox({
    @required this.boxWidth,
    this.stackWidgets,
    this.boxColor = Colorz.white20,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  // --- NEAT AND CLEAN
  /// width factor * screenWidth = flyerWidth
  final double boxWidth;
  /// internal parts of the flyer
  final List<Widget> stackWidgets;
  final Color boxColor;
// -----------------------------------------------------------------------------

  /// QUESTION CORNERS

  //--------------------------------o
  static double topCornerValue(double flyerBoxWidth) {

    final double _headerHeight = headerBoxHeight(
      flyerBoxWidth: flyerBoxWidth,
    );

    return _headerHeight * 0.5;
  }
  //--------------------------------o
  static double bottomCornerValue(double flyerBoxWidth) {
    return flyerBoxWidth * Ratioz.xxflyerBottomCorners;
  }
  //--------------------------------o
  static BorderRadius corners(BuildContext context, double flyerBoxWidth) {

    final double _questionToCorners = topCornerValue(flyerBoxWidth);
    // final double _questionBottomCorners = bottomCornerValue(flyerBoxWidth);

    return Borderers.superBorderOnly(
        context: context,
        enTopLeft: _questionToCorners,
        enBottomLeft: _questionToCorners,
        enBottomRight: _questionToCorners,
        enTopRight: _questionToCorners
    );
  }
// -----------------------------------------------------------------------------

  /// HEADER SIZES

  //--------------------------------o
  static double headerBoxHeight({
    @required double flyerBoxWidth
  }) {
    final double _miniHeaderHeightAtMiniState = flyerBoxWidth * Ratioz.xxflyerHeaderMiniHeight;
    return _miniHeaderHeightAtMiniState;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _questionZoneHeight = FlyerBox.height(context, boxWidth);
    final BorderRadius _flyerBorders = corners(context, boxWidth);
// -----------------------------------------------------------------------------
    return Center( /// to prevent flyer stretching out
      key: const ValueKey<String>('question_box'),
      child: Container(
        width: boxWidth,
        height: _questionZoneHeight,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: _flyerBorders,
        ),
        child: ClipRRect( /// because I will not pass borders to all children
          borderRadius: _flyerBorders,
          child: Container(
            width: boxWidth,
            height: _questionZoneHeight,
            alignment: Alignment.topCenter,
            child: Stack(
              alignment: Alignment.topCenter,
              children: stackWidgets ?? <Widget>[],
            ),
          ),
        ),
      ),
    );

  }
}
