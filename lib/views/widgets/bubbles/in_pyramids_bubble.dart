import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class InPyramidsBubble extends StatelessWidget {
final List<Widget> columnChildren;
final bool centered;
final Color bubbleColor;
final bool stretchy;
final String title;
final bool redDot;
final String actionBtIcon;
final Function actionBtFunction;

  InPyramidsBubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.WhiteGlass,
    this.stretchy = false,
    this.title,
    this.redDot = false,
    this.actionBtIcon,
    this.actionBtFunction,
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

    int titleVerseSize = 2;
    double actionBtSize = superVerseRealHeight(context, titleVerseSize, 1, null);
    double actionBtCorner = actionBtSize * 0.4;

    return Container(
          width: stretchy == true ? null : superBubbleClearWidth(context) + 2*_pageMargin,
          margin: _bubbleMargins,
          padding: EdgeInsets.all(_pageMargin),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(Ratioz.ddAppBarCorner),
          ),
          alignment: centered == true ? Alignment.center : Aligners.superCenterAlignment(context),

          child: Column(
            mainAxisSize: stretchy ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: centered == true ? MainAxisAlignment.center : MainAxisAlignment.start,
            crossAxisAlignment: centered == true ? CrossAxisAlignment.center : CrossAxisAlignment.start,
            children: <Widget>[

              if (title !=null || actionBtIcon != null)
              Row(
                mainAxisAlignment: centered == true ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: centered == true ? MainAxisSize.min : MainAxisSize.max,
                children: <Widget>[

                  if(centered == true && actionBtIcon !=null)
                    Container(
                      height: actionBtSize,
                      width: actionBtSize,
                    ),

                  if(centered == true)
                  Expanded(child: Container(),),

                  // --- BUBBLE TITLE
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                      child: SuperVerse(
                        verse: title,
                        size: titleVerseSize,
                        redDot: redDot,
                        centered: centered,
                        color: Colorz.YellowLingerie,
                      ),
                    ),

                  if(centered == true)
                    Expanded(child: Container(),),

                  // --- ACTION BUTTON
                  if (actionBtIcon != null)
                  DreamBox(
                    height: actionBtSize,
                    width: actionBtSize,
                    corners: actionBtCorner,
                    // color: actionBtColor,
                    icon: actionBtIcon,
                    iconSizeFactor: 0.6,
                    boxFunction: actionBtFunction,
                  ),

                ],
              ),

              ...columnChildren,

            ],
          ),
    );
  }
}

