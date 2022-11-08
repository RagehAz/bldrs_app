import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

/// --- THE HORIZON IS BOTTOM SCREEN PADDING THAT RESPECTS PYRAMIDS HEIGHT
class Horizon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Horizon({
    this.heightFactor = 1,
    this.considerKeyboard = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double heightFactor;
  final bool considerKeyboard;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double height =
    considerKeyboard == true ?
    Ratioz.horizon * heightFactor + MediaQuery.of(context).viewInsets.bottom
        :
    Ratioz.horizon * heightFactor;
    // --------------------
    return SizedBox(
      width: Scale.screenWidth(context),
      height: height,
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
