import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
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
    @required this.headerViewModel,
    this.childrenCentered = false,
    this.bubbleColor = Colorz.white10,
    this.stretchy = false,
    this.screenWidth,
    this.onBubbleTap,
    this.margins,
    this.corners,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final BubbleHeaderVM headerViewModel;
  final bool childrenCentered;
  final Color bubbleColor;
  final bool stretchy;
  final double screenWidth;
  final Function onBubbleTap;
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
    final double _bubbleWidth = screenWidth ??
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
    final Alignment _alignment = childrenCentered == true ?
    Alignment.center
        :
    Aligners.superCenterAlignment(context);
// -----------------------------------------------------------------------------
    final Widget _bubbleContents = _BubbleContents(
      width: screenWidth,
      childrenCentered: childrenCentered,
      stretchy: stretchy,
      columnChildren: columnChildren,
      headerViewModel: headerViewModel,
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
    @required this.childrenCentered,
    @required this.stretchy,
    @required this.width,
    @required this.headerViewModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final bool childrenCentered;
  final bool stretchy;
  final double width;
  final BubbleHeaderVM headerViewModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      key: const ValueKey<String>('_BubbleContents'),
      padding: const EdgeInsets.all(Bubble._pageMargin),
      child: Column(
        mainAxisSize: stretchy ? MainAxisSize.min : MainAxisSize.max,
        mainAxisAlignment: childrenCentered == true ?
        MainAxisAlignment.center
            :
        MainAxisAlignment.start,
        crossAxisAlignment: childrenCentered == true ?
        CrossAxisAlignment.center
            :
        CrossAxisAlignment.start,
        children: <Widget>[

            // Container(
            //   width: Bubble.clearWidth(context),
            //   alignment: Alignment.topCenter,
            //   child: Row(
            //     mainAxisAlignment: centered == true ?
            //     MainAxisAlignment.start
            //         :
            //     MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisSize: centered == true ?
            //     MainAxisSize.min
            //         :
            //     MainAxisSize.max,
            //     children: <Widget>[
            //
            //       /// --- ACTION BUTTON
            //       if (centered == true && actionBtIcon != null)
            //         SizedBox(
            //           height: _actionBtSize,
            //           width: _actionBtSize,
            //         ),
            //
            //       /// --- EXPANDER
            //       if (centered == true) const Expander(),
            //
            //       /// --- LEADING BUTTON
            //       if (leadingIcon != null)
            //         DreamBox(
            //           height: _actionBtSize,
            //           width: _actionBtSize,
            //           corners: _actionBtCorner,
            //           // color: actionBtColor,
            //           icon: leadingIcon,
            //           iconColor: leadingIconColor,
            //           iconSizeFactor: leadingAndActionButtonsSizeFactor,
            //           onTap: actionBtFunction,
            //           bubble: false,
            //         ),
            //
            //       /// --- BUBBLE TITLE
            //       if (title != null)
            //         BubbleTitle(
            //           title: title,
            //           centered: centered,
            //           redDot: redDot,
            //           titleColor: titleColor,
            //         ),
            //
            //       /// --- EXPANDER
            //       // if (centered == true)
            //       const Expander(),
            //
            //       /// --- ACTION BUTTON
            //       if (actionBtIcon != null)
            //         DreamBox(
            //           height: _actionBtSize * 1.25,
            //           width: _actionBtSize * 1.25,
            //           corners: _actionBtCorner,
            //           // color: actionBtColor,
            //           icon: actionBtIcon,
            //           iconSizeFactor: leadingAndActionButtonsSizeFactor,
            //           onTap: actionBtFunction,
            //         ),
            //
            //     ],
            //   ),
            // ),
            BubbleHeader(
              viewModel: headerViewModel,
            ),

          ...columnChildren,

        ],
      ),
    );
  }
}
