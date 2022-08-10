import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class SeparatorLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SeparatorLine({
    this.lineIsON = true,
    this.width,
    this.margins,
    this.thickness = standardThickness,
    this.color = Colorz.yellow255,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool lineIsON;
  final double width;
  final dynamic margins;
  final double thickness;
  final Color color;
  /// --------------------------------------------------------------------------
  static const double standardThickness = 0.5;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _width = width ?? Bubble.clearWidth(context);

    final dynamic _margins = margins ?? const EdgeInsets.symmetric(vertical: Ratioz.appBarMargin);

    return Center(
      child: Container(
        width: _width,
        height: thickness,
        // alignment: Aligners.superCenterAlignment(context),
        margin: Scale.superMargins(margins: _margins) ,
        color: lineIsON ? color : null,
        // child: Container(
        //   width: _width * 0.8,
        //   height: 0.25,
        //   color: Colorz.yellow255,
        // ),
      ),
    );
  }
}