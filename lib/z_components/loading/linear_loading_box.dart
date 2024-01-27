import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class LinearLoadingBox extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LinearLoadingBox({
    required this.borderRadius,
    required this.direction,
    required this.loadingColor,
    required this.height,
    required this.width,
    this.boxColor = Colorz.nothing,
    super.key
  });
  // --------------------
  final BorderRadius borderRadius;
  final Axis direction;
  final Color loadingColor;
  final double height;
  final double width;
  final Color boxColor;
  // --------------------------------------------------------------------------
  int _getRotation(BuildContext context){

    /// LEFT => RIGHT
    if (UiProvider.checkAppIsLeftToRight() == true){

      if (direction == Axis.horizontal){
        /// THING GOES RIGHT TO LEFT
        return 2;
      }
      else {
        ///
        return 3;
      }

    }

    /// RIGHT => LEFT
    else {

      if (direction == Axis.horizontal){
        /// THING GOES LEFT TO RIGHT
        return 0;
      }
      else {
        return 3;
      }

    }

  }
  // --------------------------------------------------------------------------
  double _getWidth(){

    if (direction == Axis.vertical){
      return width;
    }

    else {
      return height;
    }

  }
  // --------------------
  double _getHeight(){

    if (direction == Axis.vertical){
      return height;
    }

    else {
      return width;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    return ClipRRect(
      borderRadius: borderRadius,
      child: RotatedBox(
        quarterTurns: _getRotation(context),
        child: SizedBox(
          width: _getHeight(),
          child: LinearProgressIndicator(
            color: loadingColor,
            backgroundColor: boxColor,
            minHeight: _getWidth(),
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
