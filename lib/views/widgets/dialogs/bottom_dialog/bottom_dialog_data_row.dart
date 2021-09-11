import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/keyboarders.dart';
import 'package:bldrs/controllers/router/navigators.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';


class BottomDialogRow extends StatelessWidget {
  final String dataKey;
  final dynamic dataValue;

  const BottomDialogRow({
    @required this.dataKey,
    @required this.dataValue,
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
            onTap: () async {

              await BottomDialog.showBottomDialog(
                context: context,
                draggable: true,
                title: '${dataKey.toString()} : ${dataValue.toString()}',
                height: 150,
                child: Container(
                  width: BottomDialog.dialogClearWidth(context),
                  height: BottomDialog.dialogClearHeight(
                    draggable: true,
                    context: context,
                    titleIsOn: true,
                    overridingDialogHeight: 150,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      DreamBox(
                        height: 50,
                        width: 200,
                        verse: 'Copy to clipboard',
                        verseScaleFactor: 0.6,
                        verseMaxLines: 2,
                        onTap: () async {

                          await Nav.goBack(context);

                          await Keyboarders.copyToClipboard(
                            context: context,
                            copy: dataValue.toString(),
                          );


                        },
                      ),

                    ],

                  ),
                ),
              );

            },
          ),

          /// VALUE
          GestureDetector(
            onTap: () async {

              await Keyboarders.copyToClipboard(
                context: context,
                copy: dataValue.toString(),
              );

            },
            child: Container(
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
                  verse: dataValue.toString(),
                  size: 1,
                  centered: false,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
