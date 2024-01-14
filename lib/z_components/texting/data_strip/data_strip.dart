import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bubbles/bubble/bubble.dart';
import 'package:bldrs/z_components/layouts/super_tool_tip.dart';
import 'package:bldrs/z_components/texting/data_strip/data_strip_with_headline.dart';
import 'package:bldrs/z_components/texting/data_strip/the_strip_of_data_strip.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboard.dart';
import 'package:flutter/material.dart';

class DataStrip extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStrip({
    required this.dataKey,
    required this.dataValue,
    this.color = Colorz.bloodTest,
    this.onKeyTap,
    this.onValueTap,
    this.width,
    this.withHeadline = false,
    this.isPercent = false,
    this.highlightText,
    this.tooTipVerse,
    this.height = 50,
    this.margins,
    super.key
  });
  /// --------------------------------------------------------------------------
  final String? dataKey;
  final dynamic dataValue;
  final Color color;
  final Function? onKeyTap;
  final Function? onValueTap;
  final double? width;
  final bool withHeadline;
  final bool isPercent;
  final ValueNotifier<dynamic>? highlightText;
  final Verse? tooTipVerse;
  final double height;
  final EdgeInsets? margins;
  /// --------------------------------------------------------------------------
  static const double verticalMargin = 2.5;
  static const double spacing = 5;
  // --------------------
  static Future<void> onStripTap({
    required dynamic dataValue,
  }) async {

    await Keyboard.copyToClipboardAndNotify(
      copy: dataValue.toString(),
    );

  }
  // --------------------
  static double getKeyWidth({
    required BuildContext context,
    double? width,
  }){

    final double _rowWidth = Bubble.bubbleWidth(
      bubbleWidthOverride: width,
      context: context,
    );

    return (_rowWidth - spacing) * 0.2;
  }
  // --------------------
  static double getValueWidth({
    required BuildContext context,
    double? width,
  }){

    final double _rowWidth = Bubble.bubbleWidth(
      bubbleWidthOverride: width,
      context: context,
    );

    return (_rowWidth - spacing) * 0.8;
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
        onKeyTap: onKeyTap,
        onValueTap: onValueTap,
        width: width,
        valueBoxColor: color,
        isPercent: isPercent,
        highlightText: highlightText,
      );

    }

    /// DATA STRIP WITH HEADLINE IN THE ROW
    else {

      final double _rowWidth = Bubble.bubbleWidth(
        bubbleWidthOverride: width,
        context: context,
      );

      return Center(
        child: SizedBox(
          key: const ValueKey<String>('DataStrip_tree'),
          width: _rowWidth,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                /// KEY
                SuperToolTip(
                  verse: tooTipVerse,
                  triggerMode: TooltipTriggerMode.longPress,
                  child: TheStripOfDataStrip(
                    width: getKeyWidth(
                      context: context,
                      width: width,
                    ),
                    height: height,
                    color: color,
                    highlightText: highlightText,
                    text: dataKey,
                    onTap: onKeyTap ?? () => onStripTap(
                      dataValue: dataKey,
                    ),
                  ),
                ),

                /// VALUE
                TheStripOfDataStrip(
                  width: getValueWidth(
                    context: context,
                    width: width,
                  ),
                  height: height,
                  highlightText: highlightText,
                  text: dataValue.toString(),
                  color: Colorz.white20,
                  onTap: onValueTap ?? () => onStripTap(
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
