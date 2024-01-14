import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/layouts/super_tool_tip.dart';
import 'package:bldrs/z_components/notes/x_components/red_dot_badge.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class PyramidFloatingButton extends StatelessWidget {
  /// ---------------------------------------------------------------------------
  const PyramidFloatingButton({
    required this.icon,
    this.color,
    this.onTap,
    this.redDotCount = 0,
    this.onLongTap,
    this.isDeactivated,
    this.iconColor,
    this.toolTip,
    super.key
  });
  /// ---------------------------------------------------------------------------
  final int redDotCount;
  final dynamic icon;
  final Color? color;
  final Function? onTap;
  final Function? onLongTap;
  final bool? isDeactivated;
  final Color? iconColor;
  final Verse? toolTip;
  /// ---------------------------------------------------------------------------
  static double size = 45;
  /// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SuperToolTip(
      triggerMode: TooltipTriggerMode.longPress,
      verse: toolTip,
      child: RedDotBadge(
        approxChildWidth: size,
        redDotIsOn: redDotCount > 0,
        count: redDotCount,
        shrinkChild: true,
        child: BldrsBox(
          height: size,
          width: size,
          corners: size/2,
          color: color,
          icon: icon,
          iconColor: iconColor,
          iconSizeFactor: 0.6,
          onTap: onTap,
          onLongTap: onLongTap,
          isDisabled: isDeactivated,
        ),
      ),
    );

  }
  /// ---------------------------------------------------------------------------
}
