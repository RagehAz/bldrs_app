import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Scroller extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Scroller({
    @required this.child,
    this.controller,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Widget child;
  final ScrollController controller;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

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
// -----------------------------------------------------------------------------
