import 'dart:async';

import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DreamBoxTapLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBoxTapLayer({
    @required this.width,
    @required this.height,
    @required this.splashColor,
    @required this.onTap,
    @required this.onTapUp,
    @required this.onTapDown,
    @required this.onTapCancel,
    @required this.deactivated,
    @required this.onDeactivatedTap,
    @required this.onLongTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final Color splashColor;
  final Function onTap;
  final Function onTapUp;
  final Function onTapDown;
  final Function onTapCancel;
  final bool deactivated;
  final Function onDeactivatedTap;
  final Function onLongTap;
  /// --------------------------------------------------------------------------
  Future<void> _onTap(BuildContext context) async {

    unawaited(Sounder.playButtonClick());
    // Keyboarders.minimizeKeyboardOnTapOutSide(context);

    if (deactivated == true){
      if (onDeactivatedTap != null){
        onDeactivatedTap();
      }
    }

    else {
      if (onTap != null){
        await Future.delayed(
            const Duration(milliseconds: 200,),
                () async { onTap(); }
        );
      }
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colorz.nothing,
        child: GestureDetector(
          // onLongPress: onLongTap,
          onTapDown: deactivated == true || onTapDown == null ?
              (TapDownDetails details) {}
              :
              (TapDownDetails details) => onTapDown(),
          onTapUp: deactivated == true || onTapUp == null ?
              (TapUpDetails details) {}
              :
              (TapUpDetails details) => onTapUp(),
          child: InkWell(
            splashColor: deactivated == true ? Colorz.white20 : splashColor,
            onTap: onTap == null && onDeactivatedTap == null ? null : () => _onTap(context),
            onTapCancel: onTapCancel,
            onLongPress: onLongTap,
          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
