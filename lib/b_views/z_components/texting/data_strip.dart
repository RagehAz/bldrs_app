import 'package:bldrs/b_views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/widgets/general/dialogs/nav_dialog/nav_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
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
  static const double rowHeight = 60;
  static const double verticalMargin = 2.5;
  static const double keyRowHeight = rowHeight * 0.4;
  static const double valueRowHeight = rowHeight * 0.6;
// -----------------------------------------------------------------------------
  Future<void> _onKeyTap(BuildContext context) async {
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

    final double _rowWidth = width ?? BottomDialog.clearWidth(context) - verticalMargin * 2;
    final bool _valueIsPercentage = isPercent == true && dataValue is double;
    final String _valueString = _valueIsPercentage == true ? '$dataValue %' : dataValue.toString();

    return Center(
      child: Container(
        height: rowHeight,
        width: _rowWidth,
        margin: const EdgeInsets.symmetric(vertical: verticalMargin),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            /// KEY
            DataStripKey(
              height: keyRowHeight,
              width: _rowWidth,
              dataKey: dataKey,
              onTap: () => _onKeyTap(context),
            ),

            /// VALUE
            DataStripValue(
              onTap: onTap ?? () => _onStripTap(context),
              width: _rowWidth,
              height: valueRowHeight,
              color: valueBoxColor,
              valueIsPercentage: _valueIsPercentage,
              dataValue: dataValue,
              horizontalMargin: Ratioz.appBarMargin,
              valueString: _valueString,
            ),

          ],
        ),
      ),
    );
  }
}

class DataStripKey extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DataStripKey({
    @required this.height,
    @required this.width,
    @required this.dataKey,
    @required this.onTap,
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
        verse: dataKey.toUpperCase(),
        size: 1,
        weight: VerseWeight.black,
        color: Colorz.white200,
        italic: true,
        onTap: onTap,
      ),
    );
  }

}

class DataStripValue extends StatelessWidget {

  const DataStripValue({
    @required this.onTap,
    @required this.width,
    @required this.height,
    @required this.color,
    @required this.valueIsPercentage,
    @required this.dataValue,
    @required this.valueString,
    @required this.horizontalMargin,
    Key key
  }) : super(key: key);

  final Function onTap;
  final double width;
  final double height;
  final Color color;
  final bool valueIsPercentage;
  final dynamic dataValue;
  final String valueString;
  final double horizontalMargin;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: Borderers.superBorderAll(context, Ratioz.boxCorner8),
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
                corners: Borderers.superBorderAll(
                    context, Ratioz.boxCorner8),
                // ),
              ),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: horizontalMargin),
              child: SuperVerse(
                verse: valueString,
                centered: false,
                shadow: true,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
