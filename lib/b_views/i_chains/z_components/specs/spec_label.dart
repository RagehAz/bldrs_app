import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';

class SpecLabel extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SpecLabel({
    @required this.xIsOn,
    @required this.verse,
    @required this.onTap,
    @required this.onXTap,
    this.maxBoxWidth,
    this.searchText,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool xIsOn;
  final Verse verse;
  final Function onTap;
  final Function onXTap;
  final double maxBoxWidth;
  final ValueNotifier<String> searchText;
  /// --------------------------------------------------------------------------
  static const double height = 40;
  // --------------------
  @override
  Widget build(BuildContext context) {

    const EdgeInsets _margins = EdgeInsets.symmetric(vertical: 2.5);
    final double _maxLabelWidth = maxBoxWidth == null ? double.infinity : maxBoxWidth - (_margins.right * 2);
    final double _iconWidth = xIsOn == true ? height : 0;
    final double _verseMaxWidth = maxBoxWidth == null ? double.infinity : _maxLabelWidth - _iconWidth;

    return Container(
      height: 40,
      constraints: BoxConstraints(
        maxWidth: _maxLabelWidth,
      ),
      decoration: BoxDecoration(
        borderRadius: Borderers.cornerAll(context, height * 0.3),
        color: Colorz.black255,
      ),
      margin: _margins,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          if (xIsOn == true)
          BldrsBox(
            height: height,
            width: height,
            icon: xIsOn ? Iconz.xLarge : null,
            iconSizeFactor: 0.4,
            bubble: false,
            onTap: onXTap,
          ),

          GestureDetector(
            onTap: onTap,
            child: Container(
              height: height,
              constraints: BoxConstraints(
                maxWidth: _verseMaxWidth,
              ),
              padding: Scale.superInsets(
                context: context,
                appIsLTR: UiProvider.checkAppIsLeftToRight(context),
                enRight: 10,
                enLeft: xIsOn == true ? 0 : 10,
              ),
              child: BldrsText(
                verse: verse,
                weight: VerseWeight.thin,
                italic: true,
                centered: false,
                highlight: searchText,
              ),
            ),
          ),

        ],
      ),
    );

    // return DreamBox(
    //   // height: 40,
    //   // corners: 15,
    //   // icon: xIsOn ? Iconz.xLarge : null,
    //   // margins: const EdgeInsets.symmetric(vertical: 2.5),
    //   // verse: verse,
    //   // verseWeight: VerseWeight.thin,
    //   // verseItalic: true,
    //   verseScaleFactor: 1.6,
    //   verseShadow: false,
    //   // iconSizeFactor: 0.4,
    //   color: Colorz.black255,
    //   bubble: false,
    //   onTap: onTap,
    // );

  }
/// --------------------------------------------------------------------------
}
