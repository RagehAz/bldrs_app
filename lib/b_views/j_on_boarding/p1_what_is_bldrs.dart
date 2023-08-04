import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/b_views/z_components/artworks/bldrs_name_logo_slogan.dart';
import 'package:flutter/material.dart';

class AWhatIsBldrsPage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AWhatIsBldrsPage({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double width = OnBoardingScreen.getBubbleWidth();
    final double height = OnBoardingScreen.getPagesZoneHeight();
    // --------------------
    return FloatingList(
      width: width,
      height: height,
      columnChildren: [

        /// LOGO
        Transform.scale(
          scale: 0.7,
          child: const LogoSlogan(
          ),
        ),

        /// IS THE BUILDERS NETWORK



      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
