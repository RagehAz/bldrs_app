import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/strings/text_mod.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:bldrs/z_components/buttons/expander_button/a_expanding_button_box.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/localization/localizer.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:flutter/material.dart';

class PhidButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidButton({
    required this.phid,
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
    this.maxWidth,
    this.height,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double? width;
  final Color color;
  final String? phid;
  final int? level;
  final bool isDisabled;
  final bool xIsOn;
  final dynamic margins;
  final ValueNotifier<dynamic>? searchText;
  final bool? inverseAlignment;
  final Verse? secondLine;
  final Function? onPhidTap;
  final Function? onPhidDoubleTap;
  final Function? onPhidLongTap;
  final double? maxWidth;
  final double? height;
  /// --------------------------------------------------------------------------
  static double getHeight(){
    return ExpandingButtonBox.sonHeight();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String? _getIcon(){

    String? _icon;

    if (xIsOn == true){
      _icon = Iconz.xLarge;
    }
    else {
      _icon = StoragePath.phids_phid(phid);
    }

    return _icon;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static double getVerseScaleFactor({
    required bool xIsOn,
  }){
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
  Verse? _cleanVerse(){

    String? _text = getWord(phid);

    if (_text == ''){
      return null;
    }
    else {

      if (_text.length > Standards.maxPhidCharLengthBeforeTrim){

        _text = TextMod.removeAllCharactersAfterNumberOfCharacters(
            text: _text,
            numberOfChars: Standards.maxPhidCharLengthBeforeTrim
        );

        return Verse(
          id: '$_text...',
          translate: false,
        );

      }
      else {

        return Verse(
          id: _text,
          translate: false,
        );

      }

    }




  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    return ExpandingButtonBox(
      key: const ValueKey<String>('PhidButton'),
      width: width,
      inverseAlignment: inverseAlignment,
      child: BldrsBox(
        height: height ?? getHeight(),
        width: width,
        maxWidth: maxWidth,
        color: color,
        verse: _cleanVerse(),
        margins: margins,
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: _getIcon(),
        iconSizeFactor: _getIconScaleFactor(),
        verseScaleFactor: getVerseScaleFactor(
          xIsOn: xIsOn,
        ),
        verseCentered: false,
        verseMaxLines: secondLine == null ? 2 : 1,
        bubble: false,
        // verseShadow: false,
        verseItalic: true,
        verseHighlight: searchText,
        secondLine: secondLine,
        secondVerseMaxLines: 1,
        onTap: onPhidTap,
        onDoubleTap: onPhidDoubleTap,
        onLongTap: onPhidLongTap,
      ),
    );

  }
// -----------------------------------------------------------------------------
}
