import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/a_models/g_statistics/records/record_type.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class ReportButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ReportButton({
    required this.modelType,
    required this.onTap,
    required this.width,
    this.color,
    super.key
  });
  /// --------------------------------------------------------------------------
  final ModelType modelType;
  final Function onTap;
  final Color? color;
  final double width;
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
    return BldrsBox(
      height: 45,
      width: width,
      verse: Verse(
        id: _buttonPhid,
        translate: true,
      ),
      color: color,
      icon: Iconz.yellowAlert,
      margins: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      iconSizeFactor: 0.7,
      verseScaleFactor: 0.6 / 0.7,
      verseWeight: VerseWeight.thin,
      verseColor: Colorz.yellow255,
      verseItalic: true,
      verseMaxLines: 2,
      onTap: onTap,

    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
