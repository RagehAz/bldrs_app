import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class BottomDialogRow extends StatelessWidget {
  final dynamic dataKey;
  final dynamic value;

  const BottomDialogRow({
    @required this.dataKey,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {

    const double _rowHeight = 40;
    const double _margin = 2.5;
    double _rowWidth = BottomDialog.dialogClearWidth(context) - _margin * 2;
    const double _keyButtonWidth = 80;
    const double _keyButtonMargin = Ratioz.appBarPadding;
    double _valueZoneWidth = _rowWidth - _keyButtonWidth - _keyButtonMargin * 2;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: _margin),
      color: Colorz.White10,
      child: Row(
        children: <Widget>[

          /// KEY
          DreamBox(
            height: _rowHeight,
            width: _keyButtonWidth,
            color: Colorz.White200,
            verse: dataKey.toString(),
            verseMaxLines: 2,
            verseScaleFactor: 0.5,
            verseWeight: VerseWeight.bold,
            verseColor: Colorz.Black255,
            verseShadow: false,
            margins: EdgeInsets.symmetric(horizontal: _keyButtonMargin),
          ),

          /// VALUE
          Container(
            width: _valueZoneWidth,
            height: _rowHeight,
            decoration: BoxDecoration(
              color: Colorz.BloodTest,
              borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner8),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: _keyButtonMargin),
              child: SuperVerse(
                verse: value.toString(),
                size: 1,
                centered: false,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
