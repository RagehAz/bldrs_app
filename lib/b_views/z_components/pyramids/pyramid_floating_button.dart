import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:flutter/material.dart';

class PyramidFloatingButton extends StatelessWidget {
  /// ---------------------------------------------------------------------------
  const PyramidFloatingButton({
    @required this.icon,
    this.color,
    this.onTap,
    this.redDotCount = 0,
    this.onLongTap,
    this.isDeactivated,
    Key key
  }) : super(key: key);
  /// ---------------------------------------------------------------------------
  final int redDotCount;
  final String icon;
  final Color color;
  final Function onTap;
  final Function onLongTap;
  final bool isDeactivated;
  /// ---------------------------------------------------------------------------
  static double size = 50;
  /// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return NoteRedDotWrapper(
      childWidth: size,
      redDotIsOn: redDotCount > 0,
      count: redDotCount,
      shrinkChild: true,
      child: BldrsBox(
        height: size,
        width: size,
        corners: size/2,
        color: color,
        icon: icon,
        iconSizeFactor: 0.6,
        onTap: onTap,
        onLongTap: onLongTap,
        isDisabled: isDeactivated,
      ),
    );

  }
  /// ---------------------------------------------------------------------------
}
