import 'package:bldrs/a_models/x_utilities/dimensions_model.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class NotePosterBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NotePosterBox({
    @required this.width,
    this.child,
    this.color = Colorz.white10,
    Key key
  }) : super(key: key);
  // --------------------
  final double width;
  final Color color;
  final Widget child;
  // --------------------
  /// SIZES
  // --------
  static const Dimensions standardSize = Dimensions(
    width: 720,
    height: 360,
  );
  // --------
  static const Dimensions oldSize = Dimensions(
    width: 360,
    height: 240,
  );
  // --------
  static const Dimensions iosMaxSize = Dimensions(
    width: 1038,
    height: 1038,
  );
  // --------
  static double getBoxHeight(double boxWidth){
    return Dimensions.getHeightByAspectRatio(
        aspectRatio: standardSize.getAspectRatio(),
        width: boxWidth,
    );
  }
  // --------------------
  /// ASPECT RATIO
  // --------
  static double getAspectRatio(){
    return standardSize.getAspectRatio();
  }
  // --------------------
  /// PADDING
  // --------
  static double getPaddingValue(double boxWidth){
    return boxWidth * 0.05;
  }
  // --------
  static EdgeInsets getPaddings(double boxWidth){
    return EdgeInsets.all(getPaddingValue(boxWidth));
  }
  // --------------------
  /// CLEAR SPACE
  // --------
  static double getClearWidth(double boxWidth){
    return boxWidth - (getPaddingValue(boxWidth) * 2);
  }
  // --------
  static double getClearHeight(double boxWidth){
    return getBoxHeight(boxWidth) - (getPaddingValue(boxWidth) * 2);
  }
  // --------------------
  /// CORNERS
  // --------
  static double getCornerValue(double boxWidth){
    // const double posterCornerValue = Bubble.cornersValue - Ratioz.appBarMargin;
    return boxWidth * 0.03;
  }
  // --------
  static BorderRadius getCorners({
    @required BuildContext context,
    @required double boxWidth,
  }){
    // const BorderRadius posterCorners = BorderRadius.all(Radius.circular(posterCornerValue));
    return Borderers.superCorners(
      context: context,
      corners: getCornerValue(boxWidth),
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: getBoxHeight(width),
      color: Colorz.white10,
      // decoration: BoxDecoration(
        // borderRadius: getCorners(
        //   context: context,
        //   boxWidth: width,
        // ),
      // ),
      alignment: Alignment.center,
      child: child,
    );

  }
  // -----------------------------------------------------------------------------
}
