import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/ratioz.dart';
import 'package:basics/helpers/classes/space/borderers.dart';
import 'package:bldrs/b_views/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/data_strip/data_strip.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/bldrs_aligners.dart';
import 'package:flutter/material.dart';

class DataStripWithHeadline extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStripWithHeadline({
    required this.dataKey,
    required this.dataValue,
    this.width,
    this.valueBoxColor = Colorz.white10,
    this.isPercent = false,
    this.onKeyTap,
    this.onValueTap,
    this.highlightText,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? dataKey;
  final dynamic dataValue;
  final double? width;
  final Color valueBoxColor;
  final bool isPercent;
  final Function? onKeyTap;
  final Function? onValueTap;
  final ValueNotifier<dynamic>? highlightText;
  /// --------------------------------------------------------------------------
  static const double rowHeight = 60;
  static const double keyRowHeight = rowHeight * 0.4;
  static const double valueRowHeight = rowHeight * 0.6;
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _rowWidth = width ?? BottomDialog.clearWidth() - DataStrip.verticalMargin * 2;
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
                dataValue: dataValue,
              ),
            ),

            /// VALUE
            DataStripValue(
              onTap: onValueTap ?? () => DataStrip.onStripTap(
                dataValue: dataValue,
              ),
              width: _rowWidth,
              height: valueRowHeight,
              topColor: valueBoxColor,
              backColor: valueBoxColor,
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
    required this.height,
    required this.width,
    required this.dataKey,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final String? dataKey;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      height: height,
      width: width,
      alignment: BldrsAligners.superCenterAlignment(context),
      child: BldrsText(
        labelColor: Colorz.nothing,
        verse: Verse(
          id: dataKey,
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
    required this.onTap,
    required this.width,
    required this.height,
    required this.valueIsPercentage,
    required this.dataValue,
    required this.valueString,
    required this.horizontalMargin,
    this.highlightText,
    this.topColor = Colorz.yellow80,
    this.backColor = Colorz.yellow80,
    super.key
  });
  /// --------------------------------------------------------------------------
  final Function? onTap;
  final double width;
  final double height;
  final Color topColor;
  final bool valueIsPercentage;
  final dynamic dataValue;
  final String? valueString;
  final double horizontalMargin;
  final ValueNotifier<dynamic>? highlightText;
  final Color? backColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => onTap?.call(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backColor,
          borderRadius: Borderers.constantCornersAll10,
        ),
        child: Stack(
          alignment: BldrsAligners.superCenterAlignment(context),
          children: <Widget>[

            /// BACK COLOR
            if (valueIsPercentage == true)
              BldrsBox(
                width: (dataValue / 100) * width,
                height: height,
                color: Colorz.black125,
                corners: Borderers.cornerAll(Ratioz.boxCorner8),
                // ),
              ),

            /// FRONT COLOR
            if (valueIsPercentage == true)
              BldrsBox(
                width: (dataValue / 100) * width,
                height: height,
                // decoration: BoxDecoration(
                color: topColor,
                corners: Borderers.cornerAll(Ratioz.boxCorner8),
                // ),
              ),

            if (valueString != null)
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: BldrsText(
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
