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
final Color titleColor;
final bool redDot;
final String actionBtIcon;
final Function actionBtFunction;
final double bubbleWidth;
final Function bubbleOnTap;
final double actionBtSizeFactor;
final String leadingIcon;
final Color leadingIconColor;

  InPyramidsBubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.WhiteGlass,
    this.stretchy = false,
    this.title,
    this.titleColor = Colorz.White,
    this.redDot = false,
    this.actionBtIcon,
    this.actionBtFunction,
    this.bubbleWidth,
    this.bubbleOnTap,
    this.actionBtSizeFactor = 0.6,
    this.leadingIcon,
    this.leadingIconColor,
});

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    const double _pageMargin = Ratioz.appBarMargin ;
// -----------------------------------------------------------------------------
    EdgeInsets _bubbleMargins =
    stretchy == true ? const EdgeInsets.all(0) :
    const EdgeInsets.only(right: _pageMargin, left: _pageMargin, bottom: _pageMargin);

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

    double _bubbleWidth = stretchy == true ? null
        :
    bubbleWidth != null ? bubbleWidth
        :
    bubbleWidth == null ? Scale.superBubbleClearWidth(context) + (2 * _pageMargin * 0)
        :
        null;
// -----------------------------------------------------------------------------
    return Container(
          width: _bubbleWidth,
          margin: _bubbleMargins,
          // padding: EdgeInsets.all(_pageMargin),
          decoration: BoxDecoration(
            color: bubbleColor,
            borderRadius: BorderRadius.circular(Ratioz.appBarCorner),
          ),
          alignment: centered == true ? Alignment.center : Aligners.superCenterAlignment(context),

          child: Material(
            color: Colorz.Nothing,
            child: InkWell(
              onTap: bubbleOnTap,
              splashColor: Colorz.Yellow,
              borderRadius: BorderRadius.circular(Ratioz.appBarCorner),
              child: Padding(
                padding: const EdgeInsets.all(_pageMargin),
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

                        /// --- ACTION BUTTON
                        if(centered == true && actionBtIcon !=null)
                          Container(
                            height: actionBtSize,
                            width: actionBtSize,
                          ),

                        /// --- EXPANDER
                        if(centered == true)
                        Expanded(child: Container(),),

                        /// --- LEADING BUTTON
                        if (leadingIcon != null)
                          DreamBox(
                            height: actionBtSize,
                            width: actionBtSize,
                            corners: actionBtCorner,
                            // color: actionBtColor,
                            icon: leadingIcon,
                            iconColor: leadingIconColor,
                            iconSizeFactor: actionBtSizeFactor,
                            boxFunction: actionBtFunction,
                            bubble: false,
                          ),

                        /// --- BUBBLE TITLE
                        if (title != null)
                          Container(
                            width: _bubbleWidth - actionBtSize * 2,
                            padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
                            child: SuperVerse(
                              verse: title,
                              size: titleVerseSize,
                              redDot: redDot,
                              centered: centered,
                              color: titleColor,
                              italic: true,
                            ),
                          ),

                        /// --- EXPANDER
                        if(centered == true)
                          Expanded(child: Container(),),

                        /// --- ACTION BUTTON
                        if (actionBtIcon != null)
                        DreamBox(
                          height: actionBtSize,
                          width: actionBtSize,
                          corners: actionBtCorner,
                          // color: actionBtColor,
                          icon: actionBtIcon,
                          iconSizeFactor: actionBtSizeFactor,
                          boxFunction: actionBtFunction,
                        ),

                      ],
                    ),

                    ...columnChildren,

                  ],
                ),
              ),
            ),
          ),
    );
  }
}

