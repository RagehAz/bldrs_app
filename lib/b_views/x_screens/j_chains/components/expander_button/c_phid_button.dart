import 'package:bldrs/b_views/x_screens/j_chains/components/expander_button/a_chain_button_box.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/d_providers/chains_provider.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhidButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PhidButton({
    @required this.phid,
    this.width,
    this.onTap,
    this.color = Colorz.white20,
    this.parentLevel = 1,
    this.isDisabled = false,
    this.xIsOn = false,
    this.margins,
    this.searchText,
    this.inverseAlignment,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final Color color;
  final String phid; // phrase id
  final Function onTap;
  final int parentLevel;
  final bool isDisabled;
  final bool xIsOn;
  final dynamic margins;
  final ValueNotifier<String> searchText;
  final bool inverseAlignment;
  /// --------------------------------------------------------------------------
  static double getHeight(){
    return ChainButtonBox.sonHeight();
  }
// -----------------------------------------------------------------------------
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

    return _icon;
  }
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
        verse: phid,
        margins: margins,
        // secondLine: TextGenerator.bzTypeSingleStringer(context, _bz.bzType),
        icon: _getIcon(context),
        iconSizeFactor: _getIconScaleFactor(),
        verseScaleFactor: _getVerseScaleFactor(),
        verseCentered: false,
        verseMaxLines: 2,
        bubble: false,
        verseShadow: false,
        verseItalic: true,
        onTap: onTap,
        verseHighlight: searchText,
        verseHighlightColor: Colorz.bloodTest,
      ),
    );

  }
}
