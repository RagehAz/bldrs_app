import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// --- THE HORIZON IS BOTTOM SCREEN PADDING THAT RESPECTS PYRAMIDS HEIGHT
class Horizon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Horizon({
    this.heightFactor = 1,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double heightFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Scale.superScreenWidth(context),
      height: Ratioz.horizon * heightFactor,
    );
  }

}
