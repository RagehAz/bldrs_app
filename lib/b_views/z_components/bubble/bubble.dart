import 'package:bldrs/b_views/z_components/bubble/bubble_title.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';


class Bubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Bubble({
    @required this.columnChildren,
    this.centered = false,
    this.bubbleColor = Colorz.white10,
    this.stretchy = false,
    this.title,
    this.titleColor = Colorz.white255,
    this.redDot = false,
    this.actionBtIcon,
    this.actionBtFunction,
    this.width,
    this.onBubbleTap,
    this.leadingAndActionButtonsSizeFactor = 0.6,
    this.leadingIcon,
    this.leadingIconColor,
    this.margins,
    this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
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
  final Function onBubbleTap;
  final double leadingAndActionButtonsSizeFactor;
  final String leadingIcon;
  final Color leadingIconColor;
  final dynamic margins;
  final dynamic corners;
  /// --------------------------------------------------------------------------
  static double clearWidth(BuildContext context, {double bubbleWidthOverride}) {
    final double _bubbleWidth = defaultWidth(context, bubbleWidthOverride: bubbleWidthOverride);
    const double _bubblePaddings = Ratioz.appBarMargin * 2;
    final double _inBubbleClearWidth = _bubbleWidth - _bubblePaddings;
    return _inBubbleClearWidth;
  }
// -----------------------------------------------------------------------------
  static double defaultWidth(BuildContext context, {double bubbleWidthOverride}) {
    final double _screenWidth = bubbleWidthOverride ?? Scale.superScreenWidth(context);
    const double _bubbleMargins = Ratioz.appBarMargin * 2;
    final double _bubbleWidth = _screenWidth - _bubbleMargins;
    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static double bubbleWidth({
    @required BuildContext context,
    double bubbleWidthOverride,
    bool stretchy,
  }) {
    final double _bubbleWidth = stretchy == true ? null : clearWidth(context, bubbleWidthOverride: bubbleWidthOverride);
    return _bubbleWidth;
  }
// -----------------------------------------------------------------------------
  static double _getTitleHeight(BuildContext context){
    const int _titleVerseSize = 2;
    return SuperVerse.superVerseRealHeight(
      context: context,
      size: _titleVerseSize,
      sizeFactor: 1,
      hasLabelBox: false,
    );
  }
// -----------------------------------------------------------------------------
  static double getHeightWithoutChildren(BuildContext context){
    final double _titleHeight = _getTitleHeight(context);
    final double _heights = (_pageMargin * 3) + _titleHeight;

    return _heights;
  }
// -----------------------------------------------------------------------------
  static const double cornersValue = Ratioz.appBarCorner;
  static const double _pageMargin = Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static const double clearCornersValue = Ratioz.appBarCorner - Ratioz.appBarMargin;
// -----------------------------------------------------------------------------
  static BorderRadius borders(
    BuildContext context,
  ) {
    return Borderers.superBorder(
        context: context,
        corners: cornersValue,
    );
  }
// -----------------------------------------------------------------------------
  static BorderRadius clearBorders(
    BuildContext context,
  ) {
    return Borderers.superBorder(
        context: context,
        corners: clearCornersValue,
    );
  }
// -----------------------------------------------------------------------------
  static double paddingValue(){
    return _pageMargin;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final EdgeInsets _bubbleMargins = margins == null && stretchy == true ?
    Scale.superMargins(margins: 0)
        :
    margins == null && stretchy == false ?
    Scale.superMargins(margins: _pageMargin)
        :
    margins != null ?
    Scale.superMargins(margins: margins)
        :
    Scale.superMargins(margins: margins);
// -----------------------------------------------------------------------------
    final double _bubbleWidth = width ??
        bubbleWidth(
          context: context,
          stretchy: stretchy,
        );
// -----------------------------------------------------------------------------
    final BorderRadius _corners = corners == null ?
    borders(context)
        :
    Borderers.superBorder(context: context, corners: corners);
// -----------------------------------------------------------------------------
    final Alignment _alignment = centered == true ?
    Alignment.center
        :
    Aligners.superCenterAlignment(context);
// -----------------------------------------------------------------------------
    final Widget _bubbleContents = _BubbleContents(
      title: title,
      width: width,
      centered: centered,
      actionBtFunction: actionBtFunction,
      actionBtIcon: actionBtIcon,
      leadingAndActionButtonsSizeFactor: leadingAndActionButtonsSizeFactor,
      leadingIcon: leadingIcon,
      leadingIconColor: leadingIconColor,
      redDot: redDot,
      stretchy: stretchy,
      titleColor: titleColor,
      columnChildren: columnChildren,
    );
// -----------------------------------------------------------------------------
    return Container(
      key: key,
      width: _bubbleWidth,
      margin: _bubbleMargins,
      // padding: EdgeInsets.all(_pageMargin),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: _corners,
      ),
      alignment: _alignment,
      child: onBubbleTap == null ?

      _bubbleContents

      :

      Material(
        color: Colorz.nothing,
        child: InkWell(
          onTap: onBubbleTap,
          splashColor: Colorz.yellow255,
          borderRadius: _corners,
          child: _bubbleContents,
        ),
      ),

    );
  }
}

class _BubbleContents extends StatelessWidget {

  /// --------------------------------------------------------------------------
  const _BubbleContents({
    @required this.columnChildren,
    @required this.centered,
    @required this.stretchy,
    @required this.title,
    @required this.titleColor,
    @required this.redDot,
    @required this.actionBtIcon,
    @required this.actionBtFunction,
    @required this.width,
    @required this.leadingAndActionButtonsSizeFactor,
    @required this.leadingIcon,
    @required this.leadingIconColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final bool centered;
  final bool stretchy;
  final String title;
  final Color titleColor;
  final bool redDot;
  final String actionBtIcon;
  final Function actionBtFunction;
  final double width;
  final double leadingAndActionButtonsSizeFactor;
  final String leadingIcon;
  final Color leadingIconColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _actionBtSize = Bubble._getTitleHeight(context);
// -----------------------------------------------------------------------------
    final double _actionBtCorner = _actionBtSize * 0.4;
// -----------------------------------------------------------------------------

    return Padding(
      key: const ValueKey<String>('_BubbleContents'),
      padding: const EdgeInsets.all(Bubble._pageMargin),
      child: Column(
        mainAxisSize: stretchy ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: centered == true ?
        MainAxisAlignment.center
            :
        MainAxisAlignment.start,
        crossAxisAlignment: centered == true ?
        CrossAxisAlignment.center
            :
        CrossAxisAlignment.start,
        children: <Widget>[

          if (title != null || actionBtIcon != null)
            Container(
              width: Bubble.clearWidth(context),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: centered == true ?
                MainAxisAlignment.start
                    :
                MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: centered == true ?
                MainAxisSize.min
                    :
                MainAxisSize.max,
                children: <Widget>[

                  /// --- ACTION BUTTON
                  if (centered == true && actionBtIcon != null)
                    SizedBox(
                      height: _actionBtSize,
                      width: _actionBtSize,
                    ),

                  /// --- EXPANDER
                  if (centered == true) const Expander(),

                  /// --- LEADING BUTTON
                  if (leadingIcon != null)
                    DreamBox(
                      height: _actionBtSize,
                      width: _actionBtSize,
                      corners: _actionBtCorner,
                      // color: actionBtColor,
                      icon: leadingIcon,
                      iconColor: leadingIconColor,
                      iconSizeFactor: leadingAndActionButtonsSizeFactor,
                      onTap: actionBtFunction,
                      bubble: false,
                    ),

                  /// --- BUBBLE TITLE
                  if (title != null)
                    BubbleTitle(
                      title: title,
                      centered: centered,
                      redDot: redDot,
                      titleColor: titleColor,
                    ),

                  /// --- EXPANDER
                  // if (centered == true)
                  const Expander(),

                  /// --- ACTION BUTTON
                  if (actionBtIcon != null)
                    DreamBox(
                      height: _actionBtSize * 1.25,
                      width: _actionBtSize * 1.25,
                      corners: _actionBtCorner,
                      // color: actionBtColor,
                      icon: actionBtIcon,
                      iconSizeFactor: leadingAndActionButtonsSizeFactor,
                      onTap: actionBtFunction,
                    ),

                ],
              ),
            ),

          ...columnChildren,

        ],
      ),
    );
  }
}
