import 'package:bldrs/controllers/drafters/aligners.dart';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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
    this.bubbleColor = Colorz.white20,
    this.stretchy = false,
    this.title,
    this.titleColor = Colorz.white255,
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
    final double _bubbleWidth = defaultWidth(context);
    const double _bubblePaddings = Ratioz.appBarMargin * 2;
    final double _inBubbleClearWidth = _bubbleWidth - _bubblePaddings;
    return _inBubbleClearWidth;
  }
// -----------------------------------------------------------------------------
  static double defaultWidth(BuildContext context){
    final double _screenWidth = Scale.superScreenWidth(context);
    const double _bubbleMargins = Ratioz.appBarPadding * 2;
    final double _bubbleWidth = _screenWidth - _bubbleMargins;
    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static double bubbleWidth({BuildContext context, bool stretchy, }){
    final double _bubbleWidth = stretchy == true ? null
        :
    clearWidth(context);

    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static const double cornersValue = Ratioz.appBarCorner;
  static const double _pageMargin = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static const double clearCornersValue = Ratioz.appBarCorner - Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static BorderRadius borders(BuildContext context,){
    return
    Borderers.superBorder(context: context, corners: cornersValue);
  }
// -----------------------------------------------------------------------------
  static BorderRadius clearBorders(BuildContext context,){
    return
      Borderers.superBorder(context: context, corners: clearCornersValue);
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final EdgeInsets _bubbleMargins =
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

    const int _titleVerseSize = 2;
    final double _actionBtSize = SuperVerse.superVerseRealHeight(context, _titleVerseSize, 1, null);
    final double _actionBtCorner = _actionBtSize * 0.4;

    final double _bubbleWidth = width != null ? width :
    bubbleWidth(
      context: context,
      stretchy: stretchy,
    );

// -----------------------------------------------------------------------------
    final double _titleWidth = stretchy == true ? null : _bubbleWidth - _actionBtSize * 2;
// -----------------------------------------------------------------------------
    final BorderRadius _corners =
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
        color: Colorz.nothing,
        child: InkWell(
          onTap: bubbleOnTap,
          splashColor: Colorz.yellow255,
          borderRadius: _corners,
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
                            height: _actionBtSize,
                            width: _actionBtSize,
                          ),

                        /// --- EXPANDER
                        if(centered == true)
                          const Expander(),

                        /// --- LEADING BUTTON
                        if (leadingIcon != null)
                          DreamBox(
                            height: _actionBtSize,
                            width: _actionBtSize,
                            corners: _actionBtCorner,
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
                              size: _titleVerseSize,
                              redDot: redDot,
                              centered: centered,
                              color: titleColor,
                              italic: true,
                            ),
                          ),

                        /// --- EXPANDER
                        if(centered == true)
                          const Expander(),

                        /// --- ACTION BUTTON
                        if (actionBtIcon != null)
                        DreamBox(
                          height: _actionBtSize,
                          width: _actionBtSize,
                          corners: _actionBtCorner,
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

