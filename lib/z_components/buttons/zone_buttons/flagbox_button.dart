import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:basics/helpers/models/flag_model.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:flutter/material.dart';

class FlagBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FlagBox({
    required this.countryID,
    this.onTap,
    this.size = 35,
    this.corners,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? countryID;
  final Function? onTap;
  final double size;
  final double? corners;
  /// --------------------------------------------------------------------------
  static const double corner = Ratioz.boxCorner12;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String? _flagIcon = Flag.getCountryIcon(countryID);
    final BorderRadius _borderRadius = Borderers.cornerAll(corners ?? size * 0.3);
    // --------------------
    return BldrsBox(
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
