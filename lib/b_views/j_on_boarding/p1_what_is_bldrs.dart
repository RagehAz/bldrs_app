import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
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
    final double pageZoneHeight = OnBoardingScreen.getPagesZoneHeight();
    // --------------------
    return FloatingList(
      width: width,
      height: pageZoneHeight,
      columnChildren: [

        /// LOGO
        BldrsBox(
          width: pageZoneHeight * 0.4,
          height: pageZoneHeight * 0.4,
          icon: Iconz.bldrsNameSquare,
          // loading: false,
          bubble: false,
        ),

        const BldrsText(
            verse: Verse(
              id: 'phid_bldrs_is',
              translate: true,
            ),
          maxLines: 10,
          margin: EdgeInsets.only(
            bottom: 10,
            right: 20,
            left: 20,
          ),
        ),

        const BldrsBox(
          height: 35,
          width: 35,
          bubble: false,
          icon: Iconz.planet,
          margins: 10,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
