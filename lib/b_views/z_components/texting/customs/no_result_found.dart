import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:flutter/material.dart';

class NoResultFound extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const NoResultFound({
    this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperVerse(
      verse: const Verse(
        text: 'phid_nothing_found',
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
