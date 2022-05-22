import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/iconizers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class BzTypesLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BzTypesLine({
    @required this.bzModel,
    @required this.width,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final BzModel bzModel;
  final double width;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final String _bzTypesString = BzModel.generateTranslatedBzTypesString(
      context: context,
      bzTypes: bzModel.bzTypes,
      bzForm: bzModel.bzForm,
    );

    return SizedBox(
      width: width,
      child: SuperVerse(
        verse: _bzTypesString,
        maxLines: 4,
        weight: VerseWeight.thin,
        italic: true,
        color: Colorz.grey255,
      ),
    );

  }
}
