import 'package:bldrs/b_screens/d_on_boarding/a_on_boarding_screen.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class OnBoardingHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const OnBoardingHeadline({
    required this.phid,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String phid;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double width = OnBoardingScreen.getBubbleWidth();
    final double height = OnBoardingScreen.getPagesZoneHeight();
    final double _titleBoxHeight = OnBoardingScreen.getTitleBoxHeight();
    // --------------------
    return BldrsText(
      height: _titleBoxHeight,
      verse: Verse(
        id: phid,
        translate: true,
        casing: Casing.upperCase,
      ),
      scaleFactor: height * 0.002,
      width: width * 0.9,
      maxLines: 3,
      weight: VerseWeight.black,
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
