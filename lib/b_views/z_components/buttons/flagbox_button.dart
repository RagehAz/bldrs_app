import 'package:bldrs/a_models/d_zone/b_country/flag.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class FlagBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlagBox({
    @required this.countryID,
    this.onTap,
    this.size = 35,
    this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String countryID;
  final Function onTap;
  final double size;
  final double corners;
  /// --------------------------------------------------------------------------
  static const double corner = Ratioz.boxCorner12;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _flagIcon = Flag.getFlagIcon(countryID);
    final BorderRadius _borderRadius = Borderers.cornerAll(context, corners ?? size * 0.3);
    // --------------------
    return DreamBox(
      width: size,
      height: size,
      icon: _flagIcon,
      onTap: onTap,
      corners: _borderRadius,
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
