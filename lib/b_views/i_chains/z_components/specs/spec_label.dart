import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class SpecLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecLabel({
    required this.xIsOn,
    required this.verse,
    required this.onTap,
    required this.onXTap,
    this.maxBoxWidth,
    this.searchText,
    super.key
  });
  /// --------------------------------------------------------------------------
  final bool xIsOn;
  final Verse? verse;
  final Function onTap;
  final Function onXTap;
  final double? maxBoxWidth;
  final ValueNotifier<String?>? searchText;
  /// --------------------------------------------------------------------------
  static const double height = 40;
  // --------------------
  static double getIconWidth({
    required bool xIsOn,
  }){
    return xIsOn == true ? height : 0;
  }
  // --------------------
  static EdgeInsets getTextMargins({
    required bool xIsOn,
  }){
    return Scale.superInsets(
      context: getMainContext(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enRight: 10,
      enLeft: xIsOn == true ? 0 : 10,
    );
  }
  // --------------------
  static double? getTextMaxWidth({
    required bool xIsOn,
    required double? maxBoxWidth,
  }){
    double? _output;

    if (maxBoxWidth != null){

      final EdgeInsets _textMargins = getTextMargins(xIsOn: xIsOn);
      final double _xIconWidth = getIconWidth(xIsOn: xIsOn);
      _output = maxBoxWidth - _textMargins.left - _textMargins.right - _xIconWidth - 20;

    }

    return _output;
  }
  // --------------------
  static const EdgeInsets getBoxMargins = EdgeInsets.only(
    bottom: 5,
  );
  // --------------------
  @override
  Widget build(BuildContext context) {

    const EdgeInsets _margins = getBoxMargins;

    final double? _verseMaxWidth = getTextMaxWidth(
      maxBoxWidth: maxBoxWidth,
      xIsOn: xIsOn,
    );

    final EdgeInsets _textMargins = getTextMargins(xIsOn: xIsOn);

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: Borderers.cornerAll(height * 0.3),
        color: Colorz.black255,
      ),
      margin: _margins,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          /// X BUTTON
          if (xIsOn == true)
          BldrsBox(
            height: height,
            width: height,
            icon: xIsOn ? Iconz.xLarge : null,
            iconSizeFactor: 0.4,
            bubble: false,
            onTap: onXTap,
          ),

          /// TEXT
          GestureDetector(
            onTap: () => onTap(),
            child: BldrsText(
              height: height,
              maxWidth: _verseMaxWidth,
              margin: _textMargins,
              verse: verse,
              weight: VerseWeight.thin,
              italic: true,
              centered: false,
              highlight: searchText,
            ),
          ),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
