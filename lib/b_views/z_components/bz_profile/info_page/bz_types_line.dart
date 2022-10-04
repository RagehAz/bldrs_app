import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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

    final String _bzTypesString = BzModel.translateBzTypesIntoString(
      context: context,
      bzTypes: bzModel?.bzTypes,
      bzForm: bzModel?.bzForm,
      oneLine: oneLine,
    );

    return SizedBox(
      width: width,
      child: SuperVerse(
        verse: Verse(
          text: _bzTypesString,
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
