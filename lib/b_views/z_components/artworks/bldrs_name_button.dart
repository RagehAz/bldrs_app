import 'package:bldrs/b_views/z_components/artworks/bldrs_name.dart';

import 'package:flutter/material.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

class BldrsNameButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsNameButton({
    this.onTap,
    // this.size = 40,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  // final double size;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: Ratioz.appBarMargin),
        child: BldrsName(
          size: 40,
        ),
      ),
    );
  }
  /// --------------------------------------------------------------------------
}
