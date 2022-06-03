import 'dart:async';

import 'package:bldrs/f_helpers/drafters/sounder.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart' as Keyboarders;

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
  /// --------------------------------------------------------------------------
  Future<void> _onTap(BuildContext context) async {

    unawaited(Sounder.playButtonClick());

    Keyboarders.minimizeKeyboardOnTapOutSide(context);

    await Future.delayed(
        const Duration(milliseconds: 200,),
            () async { onTap(); }
    );

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
          onTapDown: deactivated == true || onTapDown == null ?
              (TapDownDetails details) {}
              :
              (TapDownDetails details) => onTapDown(),
          onTapUp: deactivated == true || onTapUp == null ?
              (TapUpDetails details) {}
              :
              (TapUpDetails details) => onTapUp(),
          child: InkWell(
            splashColor: deactivated == true ? null : splashColor,
            onTap: onTap == null ? null : () => _onTap(context),
            onTapCancel: onTapCancel,
          ),
        ),
      ),
    );

  }
}
