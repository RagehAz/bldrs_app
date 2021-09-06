import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class DashboardDataRow extends StatelessWidget {
  final dynamic dataKey;
  final dynamic value;

  const DashboardDataRow({
    @required this.dataKey,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {

    const double _rowHeight = 40;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: <Widget>[

          /// Box
          DreamBox(
            height: 20,
            width: 20,
            color: Colorz.White200,
          ),

          /// Key
          DreamBox(
            height: _rowHeight,
            width: 80,
            color: Colorz.Yellow255,
            verse: dataKey.toString(),
            verseMaxLines: 2,
            verseScaleFactor: 0.5,
            verseWeight: VerseWeight.bold,
            verseColor: Colorz.Black255,
            verseShadow: false,
            margins: EdgeInsets.symmetric(horizontal: 5),
          ),

          Container(
            width: 260,
            height: _rowHeight,
            // color: Colorz.White20,
            child: SuperVerse(
              verse: value.toString(),
              size: 1,
              centered: false,
            ),
          ),

        ],
      ),
    );
  }
}
