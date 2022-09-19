import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String verse;
  final Color color;
  final String icon;
  final Function onTap;
  final double height;
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
      verseScaleFactor: 1.3,
      icon: icon,
      iconColor: Colorz.white230,
      iconSizeFactor: 0.5,
      onTap: onTap,
      color: color,
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
