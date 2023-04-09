import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/bz_typer.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs_theme/bldrs_theme.dart';

import 'package:flutter/material.dart';

class BzTypesLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTypesLine({
    @required this.bzModel,
    @required this.width,
    this.centered = true,
    this.oneLine = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double width;
  final bool centered;
  final bool oneLine;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _bzTypesString = BzTyper.translateBzTypesIntoString(
      context: context,
      bzTypes: bzModel?.bzTypes,
      bzForm: bzModel?.bzForm,
      oneLine: oneLine,
    );

    return SizedBox(
      width: width,
      child: BldrsText(
        verse: Verse(
          id: _bzTypesString,
          translate: false,
        ),
        maxLines: 4,
        weight: VerseWeight.thin,
        italic: true,
        color: Colorz.grey255,
        centered: centered,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
