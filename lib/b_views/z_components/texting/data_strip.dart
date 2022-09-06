import 'package:bldrs/b_views/z_components/bubble/bubble.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip_with_headline.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
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
    this.highlightText,
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
  final ValueNotifier highlightText;
  /// --------------------------------------------------------------------------
  static const double verticalMargin = 2.5;
  static const double height = 50;
  // -----------------------------------------------------------------------------
  static Future<void> onStripTap({
    @required BuildContext context,
    @required dynamic dataValue,
  }) async {

    await Keyboard.copyToClipboard(
      context: context,
      copy: dataValue.toString(),
    );

    TopDialog.showUnawaitedTopDialog(
      context: context,
      firstLine: 'data copied to clipboard',
      secondLine: dataValue.toString(),
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// DATA STRIP WITH HEADLINE SEPARATED
    if (withHeadline == true){

      return DataStripWithHeadline(
        key: const ValueKey<String>('DataStrip_DataStripWithHeadline'),
        dataKey: dataKey,
        dataValue: dataValue,
        onTap: onTap,
        width: width,
        valueBoxColor: color,
        isPercent: isPercent,
        highlightText: highlightText,
      );

    }

    /// DATA STRIP WITH HEADLINE IN THE ROW
    else {

      final double _rowWidth = width ?? Bubble.clearWidth(context);

      return Container(
        key: const ValueKey<String>('DataStrip_tree'),
        width: _rowWidth,
        height: height,
        margin: const EdgeInsets.symmetric(vertical: verticalMargin),
        // color: Colorz.yellow125,
        alignment: Alignment.center,
        child: SizedBox(
          width: _rowWidth,
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
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
                onTap: onTap ?? () => onStripTap(
                  context: context,
                  dataValue: dataValue,
                ),
              ),

              DreamBox(
                height: height,
                width: _rowWidth * 0.79,
                verse: dataValue.toString(),
                verseShadow: false,
                verseMaxLines: 2,
                verseScaleFactor: 0.6,
                bubble: false,
                color: color,
                verseWeight: VerseWeight.thin,
                verseCentered: false,
                onTap: onTap ?? () => onStripTap(
                  context: context,
                  dataValue: dataValue,
                ),
              ),



            ],
          ),
        ),
      );

    }

  }
  // -----------------------------------------------------------------------------
}
