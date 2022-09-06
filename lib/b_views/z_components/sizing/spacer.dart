import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class Spacer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Spacer({
    this.heightFactor = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double heightFactor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (heightFactor == 1){
      return const SizedBox(
        height: Ratioz.appBarMargin,
        width: Ratioz.appBarMargin,
      );
    }

    else {
      return SizedBox(
        height: Ratioz.appBarMargin * heightFactor,
        width: Ratioz.appBarMargin * heightFactor,
      );
    }

  }
/// --------------------------------------------------------------------------
}
