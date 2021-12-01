import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Scroller extends StatelessWidget {
  final Widget child;
  final ScrollController controller;

  const Scroller({
    @required this.child,
    this.controller,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ScrollController _controller = controller == null ? ScrollController(keepScrollOffset: true, initialScrollOffset: 0,) : controller;

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
