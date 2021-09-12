import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/drafters/text_shapers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
final List<Widget> columnChildren;
final bool centered;
final Color bubbleColor;
final bool stretchy;
final String title;
final Color titleColor;
final bool redDot;
final String actionBtIcon;
final Function actionBtFunction;
final double width;
final Function bubbleOnTap;
final double LeadingAndActionButtonsSizeFactor;
final String leadingIcon;
final Color leadingIconColor;
final dynamic margins;
final dynamic corners;
final Key key;

  Bubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.White20,
    this.stretchy = false,
    this.title,
    this.titleColor = Colorz.White255,
    this.redDot = false,
    this.actionBtIcon,
    this.actionBtFunction,
    this.width,
    this.bubbleOnTap,
    this.LeadingAndActionButtonsSizeFactor = 0.6,
    this.leadingIcon,
    this.leadingIconColor,
    this.margins,
    this.corners,
    this.key,
});
// -----------------------------------------------------------------------------
  static double clearWidth(BuildContext context){
    double _bubbleWidth = defaultWidth(context);
    double _bubblePaddings = Ratioz.appBarMargin * 2;
    double _inBubbleClearWidth = _bubbleWidth - _bubblePaddings;
    return _inBubbleClearWidth;
  }
// -----------------------------------------------------------------------------
  static double defaultWidth(BuildContext context){
    double _screenWidth = Scale.superScreenWidth(context);
    double _bubbleMargins = Ratioz.appBarMargin * 2;
    double _bubbleWidth = _screenWidth - _bubbleMargins;
    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static double bubbleWidth({BuildContext context, bool stretchy, }){
    double _bubbleWidth = stretchy == true ? null
        :
    clearWidth(context);

    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static double cornersValue(){
    return Ratioz.appBarCorner;
  }
// -----------------------------------------------------------------------------
  static double clearCornersValue(){
    return Ratioz.appBarCorner - Ratioz.appBarMargin;
  }
// -----------------------------------------------------------------------------
  static BorderRadius borders(BuildContext context,){
    return
    Borderers.superBorder(context: context, corners: cornersValue());
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _pageMargin = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
    EdgeInsets _bubbleMargins =
    margins == null && stretchy == true ? Scale.superMargins(margins: 0) :
    margins == null && stretchy == false ? Scale.superMargins(margins: _pageMargin) :
    margins != null ? Scale.superMargins(margins: margins) :
    Scale.superMargins(margins: margins) ;

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

    double _bubbleWidth = width != null ? width :
    bubbleWidth(
      context: context,
      stretchy: stretchy,
    );

// -----------------------------------------------------------------------------
    double _titleWidth = stretchy == true ? null : _bubbleWidth - actionBtSize * 2;
// -----------------------------------------------------------------------------
    BorderRadius _corners =
    corners == null ? borders(context)
    :
    Borderers.superBorder(context: context, corners: corners);
// -----------------------------------------------------------------------------
//     Tracer.traceWidgetBuild(widgetName: 'InPyramidsBubble', varName: 'title', varValue: title);
    return Container(
      key: key,
      width: _bubbleWidth,
      margin: _bubbleMargins,
      // padding: EdgeInsets.all(_pageMargin),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: _corners,
      ),
      alignment: centered == true ? Alignment.center : Aligners.superCenterAlignment(context),
      child: Material(
        color: Colorz.Nothing,
        child: InkWell(
          onTap: bubbleOnTap,
          splashColor: Colorz.Yellow255,
          borderRadius: _corners,
          child: Padding(
            padding: EdgeInsets.all(_pageMargin),
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
                          Expander(),

                        /// --- LEADING BUTTON
                        if (leadingIcon != null)
                          DreamBox(
                            height: actionBtSize,
                            width: actionBtSize,
                            corners: actionBtCorner,
                            // color: actionBtColor,
                            icon: leadingIcon,
                            iconColor: leadingIconColor,
                            iconSizeFactor: LeadingAndActionButtonsSizeFactor,
                            onTap: actionBtFunction,
                            bubble: false,
                          ),

                        /// --- BUBBLE TITLE
                        if (title != null)
                          Container(
                            width: _titleWidth,
                            padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin, left: Ratioz.appBarPadding, right:  Ratioz.appBarPadding),
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
                          Expander(),

                        /// --- ACTION BUTTON
                        if (actionBtIcon != null)
                        DreamBox(
                          height: actionBtSize,
                          width: actionBtSize,
                          corners: actionBtCorner,
                          // color: actionBtColor,
                          icon: actionBtIcon,
                          iconSizeFactor: LeadingAndActionButtonsSizeFactor,
                          onTap: actionBtFunction,
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

