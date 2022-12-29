import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuditorButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const AuditorButton({
    @required this.verse,
    @required this.onTap,
    @required this.color,
    @required this.icon,
    @required this.height,
    this.iconSizeFactor = 0.5,
    this.verseScaleFactor = 1.3,
    this.verseColor = Colorz.white255,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Color color;
  final String icon;
  final Function onTap;
  final double height;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final Color verseColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    const int _numberOfItems = 2;

    final double _buttonWidth = Scale.getUniformRowItemWidth(
      context: context,
      numberOfItems: _numberOfItems,
      boxWidth: BottomDialog.clearWidth(context),
    );

    return DreamBox(
      height: height,
      width: _buttonWidth,
      verse: Verse.plain(verse),
      verseScaleFactor: verseScaleFactor,
      icon: icon,
      iconColor: Colorz.white230,
      iconSizeFactor: iconSizeFactor,
      onTap: onTap,
      color: color,
      verseCentered: false,
      verseColor: verseColor,
      margins: const EdgeInsets.only(bottom: 10),
    );

  }
  /// --------------------------------------------------------------------------
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<String>('verse', verse));
    properties.add(DiagnosticsProperty<Color>('color', color));
    properties.add(DiagnosticsProperty<String>('icon', icon));
    properties.add(DiagnosticsProperty<Function>('onTap', onTap));
  }
  /// --------------------------------------------------------------------------
}
