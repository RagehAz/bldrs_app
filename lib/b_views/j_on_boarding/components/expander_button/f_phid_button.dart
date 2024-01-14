import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:flutter/material.dart';
import 'a_chain_button_box.dart';

class PhidButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidButton({
    required this.phid,
    required this.appIsLTR,
    required this.textDirection,
    this.width,
    this.onPhidTap,
    this.color = Colorz.white20,
    this.level = 1,
    this.isDisabled = false,
    this.xIsOn = false,
    this.margins,
    this.searchText,
    this.inverseAlignment,
    this.secondLine,
    this.onPhidDoubleTap,
    this.onPhidLongTap,
    this.textWeight,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final Color color;
  final String phid; // phrase id
  final int level;
  final bool isDisabled;
  final bool xIsOn;
  final dynamic margins;
  final ValueNotifier<dynamic>? searchText;
  final bool? inverseAlignment;
  final String? secondLine;
  final Function? onPhidTap;
  final Function? onPhidDoubleTap;
  final Function? onPhidLongTap;
  final bool appIsLTR;
  final TextDirection textDirection;
  final FontWeight? textWeight;
  /// --------------------------------------------------------------------------
  static double getHeight(){
    return ChainButtonBox.sonHeight();
  }

  // --------------------
  /// TESTED : WORKS PERFECT
  double _getVerseScaleFactor(){
    double _scaleFactor;

    if (xIsOn == true){
      _scaleFactor = 1.7;
    }
    else {
      _scaleFactor = 0.65;
    }

    return _scaleFactor;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _getIconScaleFactor(){
    double _scaleFactor;

    if (xIsOn == true){
      _scaleFactor = 0.4;
    }
    else {
      _scaleFactor = 1;
    }

    return _scaleFactor;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return ChainButtonBox(
      key: const ValueKey<String>('PhidButton'),
      boxWidth: width,
      inverseAlignment: inverseAlignment,
      child: SuperBox(
        height: getHeight(),
        width: width,
        color: color,
        text: phid,
        margins: margins,
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: Iconz.dvDonaldDuck,
        iconSizeFactor: _getIconScaleFactor(),
        textScaleFactor: _getVerseScaleFactor(),
        textCentered: false,
        textMaxLines: secondLine == null ? 2 : 1,
        bubble: false,
        textItalic: true,
        textHighlight: searchText,
        secondText: secondLine,
        secondTextMaxLines: 1,
        onTap: onPhidTap,
        onDoubleTap: onPhidDoubleTap,
        onLongTap: onPhidLongTap,
        appIsLTR: appIsLTR,
        textDirection: textDirection,
        textWeight: textWeight,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
