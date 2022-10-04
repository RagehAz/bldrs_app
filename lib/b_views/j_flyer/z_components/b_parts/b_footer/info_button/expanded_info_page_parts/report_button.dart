import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

class ReportButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReportButton({
    @required this.modelType,
    @required this.onTap,
    this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final ModelType modelType;
  final Function onTap;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final String _buttonPhid = modelType == ModelType.flyer ? 'phid_report_flyer'
        :
    modelType == ModelType.bz ? 'phid_report_bz_account'
        :
    'phid_report';
    // --------------------
    return DreamBox(
      height: 35,
      verse: Verse(
        text: _buttonPhid,
        translate: true,
      ),
      color: color,
      icon: Iconz.yellowAlert,
      margins: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      iconSizeFactor: 0.7,
      verseWeight: VerseWeight.thin,
      verseColor: Colorz.yellow255,
      verseItalic: true,
      onTap: onTap,

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
