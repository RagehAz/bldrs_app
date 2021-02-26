import 'package:bldrs/view_brains/drafters/aligners.dart';
import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class InPyramidsBubble extends StatelessWidget {
final List<Widget> columnChildren;
final bool centered;
final Color bubbleColor;
final bool stretchy;

  InPyramidsBubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.WhiteGlass,
    this.stretchy = false,
});

  @override
  Widget build(BuildContext context) {

    double _pageMargin = Ratioz.ddAppBarMargin ;

    EdgeInsets _bubbleMargins =
    stretchy == true ? EdgeInsets.all(0) :
    EdgeInsets.only(right: _pageMargin, left: _pageMargin, bottom: _pageMargin);

    ///////////////////////////////////////////////////////////////////////////
    /// bos keda we need to consider this tree here in this bubble
    // return Material(
    //     color: Colorz.Nothing,
    //     child: InkWell(
    //     onTap: btOnTap,
    //     splashColor: Colorz.WhiteSmoke,
    //     child: InPyramidsBubble(
    ///////////////////////////////////////////////////////////////////////////


        return Container(
          width: stretchy == true ? null : superBubbleClearWidth(context) + 2*_pageMargin,
          margin: _bubbleMargins,
          padding: EdgeInsets.all(_pageMargin),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(Ratioz.ddAppBarCorner),
          ),
          alignment: centered == true ? Alignment.center : superCenterAlignment(context),

          child: Column(
            mainAxisSize: stretchy ? MainAxisSize.min : MainAxisSize.max,
            crossAxisAlignment: centered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: columnChildren,
          ),
    );
  }
}

class InBubbleTitle extends StatelessWidget {
  final String title;

  InBubbleTitle({
    @required this.title,
});

  @override
  Widget build(BuildContext context) {

    return SuperVerse(
      verse: title,
      margin: Ratioz.ddAppBarPadding,
      color: Colorz.Grey,
    );

  }
}


