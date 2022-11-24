import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/notes/x_components/note_red_dot.dart';
import 'package:flutter/material.dart';



class PyramidFloatingButton extends StatelessWidget {
  /// ---------------------------------------------------------------------------
  const PyramidFloatingButton({
    @required this.buttonModel,
    Key key
  }) : super(key: key);

  final PyramidButtonModel buttonModel;
  /// ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return NoteRedDotWrapper(
      childWidth: 40,
      redDotIsOn: buttonModel.redDotCount > 0,
      count: buttonModel.redDotCount,
      shrinkChild: true,
      child: DreamBox(
        height: 40,
        width: 40,
        corners: 20,
        color: buttonModel.color,
        icon: buttonModel.icon,
        iconSizeFactor: 0.6,
        onTap: buttonModel.onTap,
        onLongTap: buttonModel.onLongTap,
      ),
    );

  }
  /// ---------------------------------------------------------------------------
}

class PyramidButtonModel {
  /// ---------------------------------------------------------------------------
  PyramidButtonModel({
    @required this.icon,
    this.color,
    this.onTap,
    this.redDotCount = 0,
    this.onLongTap,
  });
  /// ---------------------------------------------------------------------------
  final int redDotCount;
  final String icon;
  final Color color;
  final Function onTap;
  final Function onLongTap;
  /// ---------------------------------------------------------------------------
}
