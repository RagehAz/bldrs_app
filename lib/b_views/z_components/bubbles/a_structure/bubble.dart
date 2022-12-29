import 'package:bldrs/b_views/z_components/app_bar/a_bldrs_app_bar.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';

import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Bubble({
    @required this.columnChildren,
    @required this.bubbleHeaderVM,
    this.childrenCentered = false,
    this.bubbleColor = Colorz.white10,
    this.width,
    this.onBubbleTap,
    this.margin,
    this.corners,
    this.areTopCentered = true,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final BubbleHeaderVM bubbleHeaderVM;
  final bool childrenCentered;
  final Color bubbleColor;
  final double width;
  final Function onBubbleTap;
  final dynamic margin;
  final dynamic corners;
  final bool areTopCentered;
  // -----------------------------------------------------------------------------
  static double clearWidth(BuildContext context, {double bubbleWidthOverride}) {
    final double _bubbleWidth = bubbleWidth(context, bubbleWidthOverride: bubbleWidthOverride);
    const double _bubblePaddings = Ratioz.appBarMargin * 2;
    return _bubbleWidth - _bubblePaddings;
  }
  // --------------------
  static double bubbleWidth(BuildContext context, {double bubbleWidthOverride}) {
    return bubbleWidthOverride ?? BldrsAppBar.width(context);
  }
  // --------------------
  static double _getTitleHeight(BuildContext context){
    const int _titleVerseSize = 2;
    return SuperVerse.superVerseRealHeight(
      context: context,
      size: _titleVerseSize,
      sizeFactor: 1,
      hasLabelBox: false,
    );
  }
  // --------------------
  static double getHeightWithoutChildren(BuildContext context){
    return (_pageMargin * 3) + _getTitleHeight(context);
  }
  // --------------------
  static const double cornersValue = Ratioz.appBarCorner;
  static const double _pageMargin = Ratioz.appBarMargin;
  // --------------------
  static const double clearCornersValue = Ratioz.appBarCorner - Ratioz.appBarMargin;
  // --------------------
  static BorderRadius borders(BuildContext context,) {
    return Borderers.superCorners(
      context: context,
      corners: cornersValue,
    );
  }
  // --------------------
  static BorderRadius clearBorders(BuildContext context,) {
    return Borderers.superCorners(
      context: context,
      corners: clearCornersValue,
    );
  }
  // --------------------
  static double paddingValue(){
    return _pageMargin;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final EdgeInsets _bubbleMargins = margin == null ? EdgeInsets.zero : Scale.superMargins(margin: margin);
    // --------------------
    final double _bubbleWidth = bubbleWidth(context, bubbleWidthOverride: width);
    // --------------------
    final BorderRadius _corners = corners == null ?
    borders(context)
        :
    Borderers.superCorners(context: context, corners: corners);
    // --------------------
    final Alignment _alignment = childrenCentered == true ?
    (areTopCentered == true ? Alignment.topCenter : Alignment.center)
        :
    (areTopCentered == true ? Aligners.superTopAlignment(context) : Aligners.superCenterAlignment(context));
    // --------------------
    final Widget _bubbleContents = _BubbleContents(
      width: width,
      childrenCentered: childrenCentered,
      columnChildren: columnChildren,
      headerViewModel: bubbleHeaderVM,
    );
    // --------------------
    return Center(
      child: Container(
        key: key,
        width: _bubbleWidth,
        margin: _bubbleMargins.copyWith(bottom: Ratioz.appBarMargin),
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

      ),
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}

class _BubbleContents extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _BubbleContents({
    @required this.columnChildren,
    @required this.childrenCentered,
    @required this.width,
    @required this.headerViewModel,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final List<Widget> columnChildren;
  final bool childrenCentered;
  final double width;
  final BubbleHeaderVM headerViewModel;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Padding(
      key: const ValueKey<String>('_BubbleContents'),
      padding: const EdgeInsets.all(Bubble._pageMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: childrenCentered == true ?
        MainAxisAlignment.center
            :
        MainAxisAlignment.start,
        crossAxisAlignment: childrenCentered == true ?
        CrossAxisAlignment.center
            :
        CrossAxisAlignment.start,
        children: <Widget>[

          BubbleHeader(
            viewModel: headerViewModel.copyWith(
                headerWidth: headerViewModel?.headerWidth ??
                    (width == null ? null : width - 20)
            ),
          ),

          ...columnChildren,

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}
