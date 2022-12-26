import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrscolors/bldrscolors.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';

class DataStripWithHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStripWithHeadline({
    @required this.dataKey,
    @required this.dataValue,
    this.width,
    this.valueBoxColor = Colorz.white10,
    this.isPercent = false,
    this.onKeyTap,
    this.onValueTap,
    this.highlightText,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String dataKey;
  final dynamic dataValue;
  final double width;
  final Color valueBoxColor;
  final bool isPercent;
  final Function onKeyTap;
  final Function onValueTap;
  final ValueNotifier<dynamic> highlightText;
  /// --------------------------------------------------------------------------
  static const double rowHeight = 60;
  static const double keyRowHeight = rowHeight * 0.4;
  static const double valueRowHeight = rowHeight * 0.6;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _rowWidth = width ?? BottomDialog.clearWidth(context) - DataStrip.verticalMargin * 2;
    final bool _valueIsPercentage = isPercent == true && dataValue is double;
    final String _valueString = _valueIsPercentage == true ? '$dataValue %' : dataValue.toString();
    // --------------------
    return Center(
      child: Container(
        height: rowHeight,
        width: _rowWidth,
        margin: const EdgeInsets.symmetric(vertical: DataStrip.verticalMargin),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// KEY
            DataStripKey(
              height: keyRowHeight,
              width: _rowWidth,
              dataKey: dataKey,
              onTap: onKeyTap ?? () => DataStrip.onStripTap(
                context: context,
                dataValue: dataValue,
              ),
            ),

            /// VALUE
            DataStripValue(
              onTap: onValueTap ?? () => DataStrip.onStripTap(
                context: context,
                dataValue: dataValue,
              ),
              width: _rowWidth,
              height: valueRowHeight,
              color: valueBoxColor,
              valueIsPercentage: _valueIsPercentage,
              dataValue: dataValue,
              horizontalMargin: Ratioz.appBarMargin,
              valueString: _valueString,
              highlightText: highlightText,
            ),

          ],
        ),
      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class DataStripKey extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStripKey({
    @required this.height,
    @required this.width,
    @required this.dataKey,
    this.onTap,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final String dataKey;
  final Function onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: width,
      alignment: Aligners.superCenterAlignment(context),
      child: SuperVerse(
        labelColor: Colorz.nothing,
        verse: Verse(
          text: dataKey,
          translate: false,
          casing: Casing.upperCase,
        ),
        size: 1,
        weight: VerseWeight.black,
        color: Colorz.white200,
        italic: true,
        onTap: onTap,
      ),
    );

  }
  /// --------------------------------------------------------------------------
}

class DataStripValue extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStripValue({
    @required this.onTap,
    @required this.width,
    @required this.height,
    @required this.color,
    @required this.valueIsPercentage,
    @required this.dataValue,
    @required this.valueString,
    @required this.horizontalMargin,
    this.highlightText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Function onTap;
  final double width;
  final double height;
  final Color color;
  final bool valueIsPercentage;
  final dynamic dataValue;
  final String valueString;
  final double horizontalMargin;
  final ValueNotifier<dynamic> highlightText;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: Borderers.constantCornersAll10,
        ),
        child: Stack(
          alignment: Aligners.superCenterAlignment(context),
          children: <Widget>[

            if (valueIsPercentage == true)
              DreamBox(
                width: (dataValue / 100) * width,
                height: height,
                // decoration: BoxDecoration(
                color: Colorz.yellow80,
                corners: Borderers.cornerAll(
                    context, Ratioz.boxCorner8),
                // ),
              ),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: SuperVerse(
                verse: Verse.plain(valueString),
                centered: false,
                shadow: true,
                highlight: highlightText,
              ),
            ),

          ],
        ),
      ),
    );

  }
  /// --------------------------------------------------------------------------
}
