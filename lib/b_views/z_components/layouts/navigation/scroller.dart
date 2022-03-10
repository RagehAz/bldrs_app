import 'package:flutter/material.dart';

class Scroller extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Scroller({
    @required this.child,
    this.controller,
    this.isOn = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final ScrollController controller;
  final bool isOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (isOn == false){
      return child;
    }

    else {
      final ScrollController _controller = controller ?? ScrollController();
      return Scrollbar(
        thickness: 3,
        radius: const Radius.circular(1.5),
        isAlwaysShown: false,
        controller: _controller,
        interactive: false,
        // hoverThickness: 40,
        // showTrackOnHover: false,
        scrollbarOrientation: ScrollbarOrientation.right,
        notificationPredicate: (ScrollNotification notification){

          // print('notification.metrics.pixels : ${notification.metrics.pixels}');

          return true;
        },
        // controller: ,
        child: child,
      );
    }

  }
}
// -----------------------------------------------------------------------------