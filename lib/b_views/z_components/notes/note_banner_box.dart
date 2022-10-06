import 'package:bldrs/a_models/x_utilities/image_size.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:flutter/material.dart';

class NoteBannerBox extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const NoteBannerBox({
    @required this.width,
    @required this.child,
    this.color,
    Key key
  }) : super(key: key);
  // --------------------
  final double width;
  final Color color;
  final Widget child;
  // -----------------------------------------------------------------------------
  static const ImageSize standardSize = ImageSize(
    width: 720,
    height: 360,
  );
  // --------------------
  static const ImageSize oldSize = ImageSize(
    width: 360,
    height: 240,
  );
  // --------------------
  static const ImageSize iosMaxSize = ImageSize(
    width: 1038,
    height: 1038,
  );
  // --------------------
  static double getBoxHeight(double boxWidth){
    return ImageSize.getHeightByAspectRatio(
        aspectRatio: standardSize.getAspectRatio(),
        width: boxWidth,
    );
  }
  // --------------------
  static double getPaddingValue(double boxWidth){
    return boxWidth * 0.05;
  }
  // --------------------
  static EdgeInsets getPaddings(double boxWidth){
    return EdgeInsets.all(getPaddingValue(boxWidth));
  }
  // --------------------
  static double getClearWidth(double boxWidth){
    return boxWidth - (getPaddingValue(boxWidth) * 2);
  }
  // --------------------
  static double getClearHeight(double boxWidth){
    return getBoxHeight(boxWidth) - (getPaddingValue(boxWidth) * 2);
  }
  // --------------------
  static double getAspectRatio(){
    return standardSize.getAspectRatio();
  }
  // --------------------
  static double getCornerValue(double boxWidth){
    return boxWidth * 0.03;
  }
  // --------------------
  static BorderRadius getCorners({
    @required BuildContext context,
    @required double boxWidth,
  }){
    return Borderers.superCorners(
      context: context,
      corners: getCornerValue(boxWidth),
    );
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: width,
        height: getBoxHeight(width),
        decoration: BoxDecoration(
          color: color,
          borderRadius: getCorners(
            context: context,
            boxWidth: width,
          ),
        ),
        alignment: Alignment.center,
        child: child,
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
