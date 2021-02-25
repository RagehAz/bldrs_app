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

  InPyramidsBubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.WhiteGlass,
});

  @override
  Widget build(BuildContext context) {

    double _pageMargin = Ratioz.ddAppBarMargin ;

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
          width: superBubbleClearWidth(context) + 2*_pageMargin,
          margin: EdgeInsets.only(right: _pageMargin, left: _pageMargin, bottom: _pageMargin),
          padding: EdgeInsets.all(_pageMargin),
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


