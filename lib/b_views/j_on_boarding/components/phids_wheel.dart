import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/classes/nums/numeric.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class PhidsWheel extends StatelessWidget {
  // --------------------------------------------------------------------------
  const PhidsWheel({
    required this.width,
    required this.phids,
    required this.height,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final List<String> phids;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SizedBox(
      width: width,
      height: 40,
      // color: Colorz.blue80,
      // alignment: Alignment.center,
      child: WheelChooser.custom(
        /// PHYSICS
        // ------
        /// WHEN INCREASED SHRINKS SPACING
        squeeze: 1,
        /// 0.0005 IS FLAT - 0.01 IS MAXIMUM WHEEL CURVATURE
        // perspective: 0.01, // is best value to avoid top and bottom flickering
        /// FLICKERS THE SCROLLING AND FUCKS EVERYTHING WHEN AT 0.1
        magnification: 0.001,
        // ------------------------
        /// BEHAVIOUR
        // ------
        /// WHEEL STARTING INDEX
        startPosition: Numeric.createRandomIndex(listLength: phids.length),
        /// ROTATION DIRECTION
        horizontal: true,
        /// LOOPS THE WHEEL LIST
        isInfinite: true,
        // ------------------------
        /// SIZING
        // ------
        listHeight: height,
        itemSize: 100,
        listWidth: width,
        // ------------------------
        /// SIZING
        // ------
        onValueChanged: (dynamic value) async {
          // final int _index = value;
          // final String _selectedIcon = standardLockIcons[_index].key!;
          // // blog('value changed to : $_selectedIcon');
          // onChanged(_selectedIcon);
        },
        children: <Widget>[

          ...List.generate(phids.length, (index){
            final String _phid = phids[index];
            final Verse? _verse = getVerse(_phid);
            final String? _icon = ChainsProvider.proGetPhidIcon(son: _phid);
            return BldrsBox(
              height: 30,
              width: 100,
              icon: _icon,
              verse: _verse,
              verseMaxLines: 2,
              verseWeight: VerseWeight.thin,
              verseCentered: _icon == null,
              verseScaleFactor: 0.6,
              color: Colorz.white20,
              bubble: false,
            );
          }),

        ],
      ),
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
