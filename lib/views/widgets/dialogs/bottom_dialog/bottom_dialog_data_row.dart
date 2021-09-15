import 'package:bldrs/controllers/drafters/aligners.dart';
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
  final double width;
  final Color valueBoxColor;

  const BottomDialogRow({
    @required this.dataKey,
    @required this.dataValue,
    this.width,
    this.valueBoxColor = Colorz.White10,
  });

  @override
  Widget build(BuildContext context) {

    const double _rowHeight = 50;
    const double _margin = 2.5;
    double _rowWidth = width ?? BottomDialog.dialogClearWidth(context) - _margin * 2;
    const double _keyButtonWidth = 80;
    const double _keyButtonMargin = Ratioz.appBarPadding;
    double _valueZoneWidth = _rowWidth - _keyButtonWidth - _keyButtonMargin * 2;

    double _keyRowHeight = _rowHeight * 0.4;
    double _valueRowHeight = _rowHeight * 0.6;

    return Center(
      child: Container(
        height: _rowHeight,
        width: _rowWidth,
        margin: const EdgeInsets.symmetric(vertical: _margin),
        // color: Colorz.White10,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// KEY
            Container(
              height: _keyRowHeight,
              width: _rowWidth,
              alignment: Aligners.superCenterAlignment(context),
              child: SuperVerse(
                labelColor: Colorz.White10,
                verse: dataKey.toString(),
                size: 1,
                weight: VerseWeight.thin,
                color: Colorz.White255,
                shadow: false,
                italic: true,
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
                width: _rowWidth,
                height: _valueRowHeight,
                decoration: BoxDecoration(
                  color: valueBoxColor,
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
      ),
    );
  }
}
