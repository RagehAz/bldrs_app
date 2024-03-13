part of super_time_line;

class LeftSelectorHandle extends StatelessWidget {
  // --------------------------------------------------------------------------
  const LeftSelectorHandle({
    required this.height,
    required this.leftPx,
    required this.onHorizontalDragEnd,
    required this.onHorizontalDragUpdate,
    super.key
  });
  // --------------------
  final double height;
  final double leftPx;
  final GestureDragUpdateCallback onHorizontalDragUpdate;
  final GestureDragEndCallback onHorizontalDragEnd;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    const double _corner = TimelineScale.handleWidth * 0.5;
    // --------------------
    return GestureDetector(
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Container(
        width: TimelineScale.handleWidth,
        height: height,
        margin: EdgeInsets.only(
          left: leftPx,
        ),
        decoration: BoxDecoration(
          color: TimelineScale.selectorColor,
          borderRadius: Borderers.cornerOnly(
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enBottomLeft: _corner,
            enTopLeft: _corner,
          ),
        ),
        alignment: Alignment.center,
        child: const SuperImage(
          loading: false,
          width: TimelineScale.handleWidth,
          height: TimelineScale.handleWidth,
          pic: Iconz.arrowLeft,
          iconColor: Colorz.black255,
          scale: 0.6,
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class RightSelectorHandle extends StatelessWidget {
  // --------------------------------------------------------------------------
  const RightSelectorHandle({
    required this.height,
    required this.rightPixels,
    required this.onHorizontalDragEnd,
    required this.onHorizontalDragUpdate,
    super.key
  });
  // --------------------
  final double height;
  final double rightPixels;
  final GestureDragUpdateCallback onHorizontalDragUpdate;
  final GestureDragEndCallback onHorizontalDragEnd;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return GestureDetector(
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      child: Container(
        width: TimelineScale.handleWidth,
        height: height,
        margin: EdgeInsets.only(
          left: rightPixels + TimelineScale.handleWidth,
        ),
        decoration: BoxDecoration(
          color: TimelineScale.selectorColor,
          borderRadius: Borderers.cornerOnly(
            appIsLTR: UiProvider.checkAppIsLeftToRight(),
            enBottomRight: TimelineScale.handleCorner,
            enTopRight: TimelineScale.handleCorner,
          ),
        ),
        alignment: Alignment.center,
        child: const SuperImage(
          loading: false,
          width: TimelineScale.handleWidth,
          height: TimelineScale.handleWidth,
          pic: Iconz.arrowRight,
          iconColor: Colorz.black255,
          scale: 0.6,
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

class SelectorTopLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SelectorTopLine({
    required this.leftPixels,
    required this.rightPixels,
    super.key
  });
  // --------------------
  final double rightPixels;
  final double leftPixels;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: rightPixels - leftPixels,
        height: TimelineScale.selectorHorizontalLineThickness,
        color: TimelineScale.selectorColor,
        margin: EdgeInsets.only(
          left: leftPixels + TimelineScale.handleWidth,
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}

class SelectorBottomLine extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SelectorBottomLine({
    required this.leftPixels,
    required this.rightPixels,
    super.key
  });
  // --------------------
  final double rightPixels;
  final double leftPixels;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        width: rightPixels - leftPixels,
        height: TimelineScale.selectorHorizontalLineThickness,
        color: TimelineScale.selectorColor,
        margin: EdgeInsets.only(
          left: leftPixels + TimelineScale.handleWidth,
        ),
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}
