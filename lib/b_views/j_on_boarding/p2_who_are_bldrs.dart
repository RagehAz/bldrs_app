import 'package:basics/layouts/views/floating_list.dart';
import 'package:bldrs/b_views/j_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/b_views/j_on_boarding/components/bz_types_wheel.dart';
import 'package:flutter/material.dart';

class BWhoAreBldrs extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BWhoAreBldrs({
    super.key
  });
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double width = OnBoardingScreen.getBubbleWidth();
    final double height = OnBoardingScreen.getPagesZoneHeight();
    final double pageZoneHeight = OnBoardingScreen.getPagesZoneHeight();
    // --------------------
    return FloatingList(
      width: width,
      height: height,
      columnChildren: [

        BzTypesWheel(
          pageZoneHeight: pageZoneHeight,
          width: width,
        ),
      ],
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
