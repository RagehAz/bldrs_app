import 'package:bldrs/a_models/c_chain/aaa_phider.dart';
import 'package:bldrs/b_views/i_chains/z_components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/chain_protocols/provider/chains_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhidButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidButton({
    @required this.phid,
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
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final Color color;
  final String phid; // phrase id
  final int level;
  final bool isDisabled;
  final bool xIsOn;
  final dynamic margins;
  final ValueNotifier<dynamic> searchText;
  final bool inverseAlignment;
  final Verse secondLine;
  final Function onPhidTap;
  final Function onPhidDoubleTap;
  final Function onPhidLongTap;
  /// --------------------------------------------------------------------------
  static double getHeight(){
    return ChainButtonBox.sonHeight();
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  String _getIcon(BuildContext context){

    String _icon;

    if (xIsOn == true){
      _icon = Iconz.xLarge;
    }
    else {
      final ChainsProvider _chainsProvider = Provider.of<ChainsProvider>(context, listen: false);
      _icon = _chainsProvider.getPhidIcon(
        context: context,
        son: phid,
      );

    }

    // blog('PhidButton : _getIcon : phid : $phid : icon : $_icon');
    return _icon;
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
      child: DreamBox(
        height: getHeight(),
        width: width,
        color: color,
        verse: Verse(
          id: Phider.removeIndexFromPhid(phid: phid),
          translate: true,
        ),
        margins: margins,
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: _getIcon(context),
        iconSizeFactor: _getIconScaleFactor(),
        verseScaleFactor: _getVerseScaleFactor(),
        verseCentered: false,
        verseMaxLines: secondLine == null ? 2 : 1,
        bubble: false,
        verseShadow: false,
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
