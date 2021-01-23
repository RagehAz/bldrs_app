import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:flutter/material.dart';

class InPyramidsBubble extends StatelessWidget {
final List<Widget> columnChildren;
final bool centered;
final Color bubbleColor;

  InPyramidsBubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.WhiteAir,
});

  @override
  Widget build(BuildContext context) {

    double pageMargin = Ratioz.ddAppBarMargin ;
    return Container(
      width: superBubbleClearWidth(context) + 2*pageMargin,
      margin: EdgeInsets.only(right: pageMargin, left: pageMargin, bottom: pageMargin),
      padding: EdgeInsets.all(pageMargin),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(Ratioz.ddAppBarCorner),
      ),
      alignment: centered == true ? Alignment.center : superCenterAlignment(context),

      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: centered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: columnChildren,
      ),
    );
  }
}

