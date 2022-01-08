import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/widgets/general/textings/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/borderers.dart' as Borderers;
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DataStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStrip({
    @required this.dataKey,
    @required this.dataValue,
    this.width,
    this.valueBoxColor = Colorz.white10,
    this.isPercent = false,
    this.onTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String dataKey;
  final dynamic dataValue;
  final double width;
  final Color valueBoxColor;
  final bool isPercent;
  final Function onTap;
  /// --------------------------------------------------------------------------
  Future<void> _onStripTap(BuildContext context) async {

      await Keyboarders.copyToClipboard(
        context: context,
        copy: dataValue.toString(),
      );

      await NavDialog.showNavDialog(
        context: context,
        firstLine: 'data copied to clipboard',
        secondLine: dataValue.toString(),
      );

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    const double _rowHeight = 60;
    const double _verticalMargin = 2.5;
    final double _rowWidth = width ?? BottomDialog.dialogClearWidth(context) - _verticalMargin * 2;
    const double _keyButtonMargin = Ratioz.appBarMargin;

    const double _keyRowHeight = _rowHeight * 0.4;
    const double _valueRowHeight = _rowHeight * 0.6;

    final bool _valueIsPercentage = isPercent == true && dataValue.runtimeType == double;

    final String _valueString = _valueIsPercentage == true ? '$dataValue %' : dataValue.toString();

    return Center(
      child: Container(
        height: _rowHeight,
        width: _rowWidth,
        margin: const EdgeInsets.symmetric(vertical: _verticalMargin),
        // color: Colorz.White10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// KEY
            Container(
              height: _keyRowHeight,
              width: _rowWidth,
              alignment: Aligners.superCenterAlignment(context),
              child: SuperVerse(
                labelColor: Colorz.nothing,
                verse: dataKey.toUpperCase(),
                size: 1,
                weight: VerseWeight.black,
                color: Colorz.white200,
                italic: true,
                onTap: () async {
                  await BottomDialog.showBottomDialog(
                    context: context,
                    draggable: true,
                    title: '$dataKey : ${dataValue.toString()}',
                    height: 150,
                    child: SizedBox(
                      width: BottomDialog.dialogClearWidth(context),
                      height: BottomDialog.dialogClearHeight(
                        draggable: true,
                        context: context,
                        titleIsOn: true,
                        overridingDialogHeight: 150,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DreamBox(
                            height: 50,
                            width: 200,
                            verse: 'Copy to clipboard',
                            verseScaleFactor: 0.6,
                            verseMaxLines: 2,
                            onTap: () async {
                              Nav.goBack(context);
                              // await null;

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
              onTap: onTap ?? () => _onStripTap(context),
              child: Container(
                width: _rowWidth,
                height: _valueRowHeight,
                decoration: BoxDecoration(
                  color: valueBoxColor,
                  borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner8),
                ),
                child: Stack(
                  alignment: Aligners.superCenterAlignment(context),
                  children: <Widget>[

                    if (_valueIsPercentage == true)
                      DreamBox(
                        width: (dataValue / 100) * _rowWidth,
                        height: _valueRowHeight,
                        // decoration: BoxDecoration(
                        color: Colorz.yellow80,
                        corners: Borderers.superBorderAll(
                            context, Ratioz.boxCorner8),
                        // ),
                      ),

                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          horizontal: _keyButtonMargin),
                      child: SuperVerse(
                        verse: _valueString,
                        centered: false,
                        shadow: true,
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}