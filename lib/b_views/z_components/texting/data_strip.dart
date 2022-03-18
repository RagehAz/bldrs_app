import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';


class DataStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStrip({
    @required this.dataKey,
    @required this.dataValue,
    this.color = Colorz.bloodTest,
    this.onTap,
    this.width,
    this.withHeadline = false,
    this.isPercent = false,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String dataKey;
  final dynamic dataValue;
  final Color color;
  final Function onTap;
  final double width;
  final bool withHeadline;
  final bool isPercent;
  /// --------------------------------------------------------------------------
  static const double verticalMargin = 2.5;
  static const double height = 50;
// -----------------------------------------------------------------------------
  static Future<void> onKeyTap({
    @required BuildContext context,
    @required String dataKey,
    @required dynamic dataValue,
  }) async {
    await BottomDialog.showBottomDialog(
      context: context,
      draggable: true,
      title: '$dataKey : ${dataValue.toString()}',
      height: 150,
      child: SizedBox(
        width: BottomDialog.clearWidth(context),
        height: BottomDialog.clearHeight(
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
  }
// -----------------------------------------------------------------------------
  static Future<void> onStripTap({
    @required BuildContext context,
    @required dynamic dataValue,
  }) async {

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

    if (withHeadline == true){

      return DataStripWithHeadline(
        dataKey: dataKey,
        dataValue: dataValue,
        onTap: onTap,
        width: width,
        valueBoxColor: color,
        isPercent: isPercent,
      );

    }

    final double _rowWidth = width ?? Bubble.clearWidth(context);

    return Container(
      width: _rowWidth,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: verticalMargin),
      // color: Colorz.yellow125,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          DreamBox(
            height: height,
            width: _rowWidth * 0.2,
            verse: dataKey,
            verseShadow: false,
            verseMaxLines: 2,
            verseScaleFactor: 0.6,
            bubble: false,
            color: color,
            verseWeight: VerseWeight.thin,
            onTap: onTap,
          ),

          DreamBox(
            height: height,
            width: _rowWidth * 0.79,
            verse: dataValue,
            verseShadow: false,
            verseMaxLines: 2,
            verseScaleFactor: 0.6,
            bubble: false,
            color: color,
            verseWeight: VerseWeight.thin,
            verseCentered: false,
            onTap: onTap,
          ),



        ],
      ),
    );

  }
}
