// ignore_for_file: unused_element

part of keywords_tree;

/// => TAMAM
class TreeLine extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TreeLine({
    required this.isTop,
    required this.isBottom,
    this.lineThickness = 2,
    this.width = 40,
    this.height = 40,
    this.radius = 20,
    this.lineColor = Colorz.white255,
    this.horizontalLineTopMarginRatioOfHeight = 0,
    this.verticalLineSideMarginRatioOfWidth = 0,
    this.isLTR = true,
    this.isGoingDown = true,
    this.onlyVertical = false,
    this.isBlank = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool isTop;
  final bool isBottom;
  final double width;
  final double height;
  final double lineThickness;
  final Color lineColor;
  final double radius;
  final double horizontalLineTopMarginRatioOfHeight;
  final double verticalLineSideMarginRatioOfWidth;
  final bool isLTR;
  final bool isGoingDown;
  final bool onlyVertical;
  final bool isBlank;
  // -----------------------------------------------------------------------------
  double getClearHeight(){
    return height - lineThickness;
  }
  // --------------------
  double getClearWidth(){
    return width - lineThickness;
  }
  // --------------------
  double getMaxPossibleRadius(){

    final double _horizontalLineTopMargin = _getHorizontalLineVerticalMargin();
    final double _remainingHeight = height - _horizontalLineTopMargin - lineThickness;

    final double _verticalLineSideMargin = getVerticalLineHorizontalPadding();
    final double _remainingWidth = width - _verticalLineSideMargin -lineThickness;

    if (_remainingWidth > _remainingHeight){
      return _remainingHeight * 0.5;
    }
    else {
      return _remainingWidth * 0.5;
    }

  }
  // --------------------
  double _getHorizontalLineVerticalMargin(){
    return getClearHeight() * horizontalLineTopMarginRatioOfHeight;
  }
  // --------------------
  double getRadius(){

    final double _maxPossibleRadius = getMaxPossibleRadius();

    if (radius > _maxPossibleRadius){
      return _maxPossibleRadius;
    }
    else {
      return radius;
    }

  }
  // --------------------
  double getVerticalLineVerticalPadding() {

    if (onlyVertical == true){
      return 0;
    }

    else {

      if (isGoingDown == true){
        if (isBottom == true) {
          return getRadius() + _getHorizontalLineVerticalMargin();
        }

        else {
          return 0;
        }
      }

      else {
        if (isTop == true) {
          return getRadius() + _getHorizontalLineVerticalMargin();
        }

        else {
          return 0;
        }
      }

    }

  }
  // --------------------
  double _getHorizontalLineWidth(){
    final double _radius = getRadius();
    return width - _radius - getVerticalLineHorizontalPadding();
  }
  // --------------------
  double getVerticalLineHorizontalPadding(){
    return getClearWidth() * verticalLineSideMarginRatioOfWidth;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {

    if (isBlank == true){
      return SizedBox(
        width: width,
        height: height,
      );
    }

    else if (isGoingDown == true){
      return _TreeLineGoingDown(
        isTop: isTop,
        isBottom: isBottom,
        lineThickness: lineThickness,
        width: width,
        height: height,
        radius: getRadius(),
        lineColor: lineColor,
        isLTR: isLTR,
        horizontalLineBottomMargin: _getHorizontalLineVerticalMargin(),
        horizontalLineWidth: _getHorizontalLineWidth(),
        verticalLineBottomPadding: getVerticalLineVerticalPadding(),
        onlyVertical: onlyVertical,
        verticalLineSideMargin: getVerticalLineHorizontalPadding(),
      );
    }

    else {
      return _TreeLineGoingUp(
        isTop: isTop,
        isBottom: isBottom,
        lineThickness: lineThickness,
        width: width,
        height: height,
        radius: getRadius(),
        lineColor: lineColor,
        horizontalLineTopMarginRatioOfHeight: horizontalLineTopMarginRatioOfHeight,
        isLTR: isLTR,
        horizontalLineTopMargin: _getHorizontalLineVerticalMargin(),
        horizontalLineWidth: _getHorizontalLineWidth(),
        verticalLineMargin: getVerticalLineVerticalPadding(),
        onlyVertical: onlyVertical,
        verticalLineSideMargin: getVerticalLineHorizontalPadding(),
      );
    }

  }
// -----------------------------------------------------------------------------
}

/// TAMAM
class _TreeLineGoingDown extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TreeLineGoingDown({
    required this.isTop,
    required this.isBottom,
    required this.horizontalLineBottomMargin,
    required this.horizontalLineWidth,
    required this.verticalLineBottomPadding,
    required this.verticalLineSideMargin,
    this.lineThickness = 2,
    this.width = 40,
    this.height = 40,
    this.radius = 20,
    this.lineColor = Colorz.white255,
    this.isLTR = true,
    this.onlyVertical = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool isTop;
  final bool isBottom;
  final double width;
  final double height;
  final double lineThickness;
  final Color lineColor;
  final double radius;
  final bool isLTR;
  final double horizontalLineBottomMargin;
  final double horizontalLineWidth;
  final double verticalLineBottomPadding;
  final double verticalLineSideMargin;
  final bool onlyVertical;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: Transform(
        transform: Matrix4.rotationY(isLTR == true ? 0 : pi),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[

            /// VERTICAL LINE
            Container(
              height: height,
              width: width,
              alignment: Alignment.topLeft,
              child: Container(
                width: lineThickness,
                height: height - verticalLineBottomPadding,
                color: lineColor,
                margin: EdgeInsets.only(
                  left: verticalLineSideMargin,
                ),
              ),
            ),

            /// HORIZONTAL LINE
            if (onlyVertical == false)
            Container(
              width: width,
              height: height,
              alignment: Alignment.bottomLeft,
              child: Container(
                width: horizontalLineWidth,
                height: lineThickness,
                color: lineColor,
                margin: EdgeInsets.only(
                  left: radius + verticalLineSideMargin,
                  bottom: horizontalLineBottomMargin,
                ),
              ),
            ),

            /// QUARTER CIRCLE
            if (onlyVertical == false)
            Padding(
              padding: EdgeInsets.only(
                bottom: horizontalLineBottomMargin,
                left: verticalLineSideMargin,
              ),
              child: Material(
                  shape: TheBrioSegmentedCircleBorder(
                    // offset: 0, // this rotates segments anticlockwise from top quadrant
                      numberOfSegments: 4,
                      sides: <BorderSide>[
                        const BorderSide(color: Colorz.nothing, width: 0),
                        BorderSide(color: lineColor, width: lineThickness),
                        const BorderSide(color: Colorz.nothing, width: 0),
                        const BorderSide(color: Colorz.nothing, width: 0),
                      ]),
                  child: Container(
                    width: radius * 2,
                    height: radius * 2,
                    color: Colorz.nothing,
                  )),
            ),

          ],
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}

/// TAMAM
class _TreeLineGoingUp extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TreeLineGoingUp({
    required this.isTop,
    required this.isBottom,
    required this.horizontalLineTopMargin,
    required this.horizontalLineWidth,
    required this.verticalLineMargin,
    required this.verticalLineSideMargin,
    this.lineThickness = 2,
    this.width = 40,
    this.height = 40,
    this.radius = 20,
    this.lineColor = Colorz.white255,
    this.horizontalLineTopMarginRatioOfHeight = 0,
    this.isLTR = true,
    this.onlyVertical = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final bool isTop;
  final bool isBottom;
  final double width;
  final double height;
  final double lineThickness;
  final Color lineColor;
  final double radius;
  final double horizontalLineTopMarginRatioOfHeight;
  final bool isLTR;
  final double horizontalLineTopMargin;
  final double horizontalLineWidth;
  final double verticalLineMargin;
  final bool onlyVertical;
  final double verticalLineSideMargin;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: width,
      height: height,
      child: Transform(
        transform: Matrix4.rotationY(isLTR == true ? 0 : pi),
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[

            /// VERTICAL LINE
            Container(
              height: height,
              width: width,
              alignment: Alignment.bottomLeft,
              child: Container(
                width: lineThickness,
                height: height - verticalLineMargin,
                color: lineColor,
                margin: EdgeInsets.only(
                  left: verticalLineSideMargin,
                ),
              ),
            ),

            /// HORIZONTAL LINE
            if (onlyVertical == false)
            Container(
              width: width,
              height: height,
              alignment: Alignment.topLeft,
              child: Container(
                width: horizontalLineWidth,
                height: lineThickness,
                color: lineColor,
                margin: EdgeInsets.only(
                  left: radius,
                  top: horizontalLineTopMargin,
                ),
              ),
            ),

            /// QUARTER CIRCLE
            if (onlyVertical == false)
            Padding(
              padding: EdgeInsets.only(
                top: horizontalLineTopMargin,
                left: verticalLineSideMargin,
              ),
              child: Material(
                  shape: TheBrioSegmentedCircleBorder(
                    // offset: 0, // this rotates segments anticlockwise from top quadrant
                      numberOfSegments: 4,
                      sides: <BorderSide>[
                        const BorderSide(color: Colorz.nothing, width: 0),
                        const BorderSide(color: Colorz.nothing, width: 0),
                        BorderSide(color: lineColor, width: lineThickness),
                        const BorderSide(color: Colorz.nothing, width: 0),
                      ]),
                  child: Container(
                    width: radius * 2,
                    height: radius * 2,
                    color: Colorz.nothing,
                  )),
            ),

          ],
        ),
      ),
    );

  }
// -----------------------------------------------------------------------------
}
