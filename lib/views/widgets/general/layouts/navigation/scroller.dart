import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Scroller extends StatelessWidget {
  final Widget child;

  const Scroller({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 3,
      radius: const Radius.circular(1.5),
      isAlwaysShown: false,
      controller: ScrollController(keepScrollOffset: true, initialScrollOffset: 0,),
      // controller: ,
      child: child,
    );
  }
}
// -----------------------------------------------------------------------------
