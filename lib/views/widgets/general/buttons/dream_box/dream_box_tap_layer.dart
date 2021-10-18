import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DreamBoxTapLayer extends StatelessWidget {
  final double width;
  final double height;
  final Color splashColor;
  final Function onTap;
  final Function onTapUp;
  final Function onTapDown;
  final Function onTapCancel;
  final bool inActiveMode;

  const DreamBoxTapLayer({
    @required this.width,
    @required this.height,
    @required this.splashColor,
    @required this.onTap,
    @required this.onTapUp,
    @required this.onTapDown,
    @required this.onTapCancel,
    @required this.inActiveMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          onTapDown: inActiveMode == true || onTapDown == null ? (TapDownDetails details){} : (TapDownDetails details) => onTapDown(),
          onTapUp: inActiveMode == true || onTapUp == null ? (TapUpDetails details){} : (TapUpDetails details) => onTapUp(),
          child: InkWell(
            splashColor: inActiveMode == true ? null : splashColor,
            onTap: onTap == null ? null : () async {onTap();},
            onTapCancel: onTapCancel,
          ),
        ),
      ),
    );
  }
}
