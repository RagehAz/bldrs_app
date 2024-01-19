import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_screens/d_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
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

    final double _logoWidth = Scale.responsive(
        context: context,
        landscape: Scale.screenShortestSide(context) * 0.4,
        portrait: Scale.screenShortestSide(context) * 0.5,
    );
    // --------------------
    return FloatingList(
      width: width,
      height: pageZoneHeight,
      columnChildren: [

        /// LOGO
        BldrsBox(
          width: _logoWidth,
          height: _logoWidth,
          icon: Iconz.bldrsNameSquare,
          // loading: false,
          bubble: false,
        ),

        BldrsText(
          width: _logoWidth,
            verse: const Verse(
              id: 'phid_bldrs_is',
              translate: true,
            ),
          maxLines: 10,
          scaleFactor: _logoWidth * 0.0048,
          // margin: const EdgeInsets.only(
          //   bottom: 10,
          //   right: 30,
          //   left: 30,
          // ),
        ),

        BldrsBox(
          height: _logoWidth * 0.15,
          width: _logoWidth * 0.15,
          bubble: false,
          icon: Iconz.planet,
          margins: 20,
        ),

      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
