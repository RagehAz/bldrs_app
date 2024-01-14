import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class NoResultFound extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoResultFound({
    this.color = Colorz.white255,
    this.verse,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Color color;
  final Verse? verse;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsText(
      key: const ValueKey<String>('NoResultFound'),
      verse: verse ?? const Verse(
        id: 'phid_nothing_found',
        translate: true,
        casing: Casing.upperCase,
      ),
      color: color,
      size: 4,
      maxLines: 3,
      italic: true,
      margin: 40,
    );

  }
  /// --------------------------------------------------------------------------
}
