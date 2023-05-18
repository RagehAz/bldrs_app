part of z_grid;

class ZGridScale {
  // --------------------------------------------------------------------------
  const ZGridScale({
    @required this.gridWidth,
    @required this.gridHeight,
    @required this.itemAspectRatio,
    @required this.columnCount,
    @required this.topPaddingOnZoomOut,
    @required this.topPaddingOnZoomIn,
    @required this.bottomPaddingOnZoomedOut,
    @required this.gridSidePadding,
    @required this.bigItemWidth,
    @required this.bigItemHeight,
    @required this.smallItemHeight,
    @required this.smallItemWidth,
  });
  // --------------------------------------------------------------------------
  final double gridWidth;
  final double gridHeight;
  /// SPACING RATIO BETWEEN ITEMS AND AROUND THE GRID TO SMALL ITEM WIDTH
  final double itemAspectRatio;
  final int columnCount;
  final double topPaddingOnZoomOut; // can be null
  final double topPaddingOnZoomIn; // can be null
  final double bottomPaddingOnZoomedOut;
  final double gridSidePadding;
  final double bigItemWidth;
  final double bigItemHeight;
  final double smallItemWidth;
  final double smallItemHeight;
  // --------------------------------------------------------------------------
  static ZGridScale initialize({
    @required double gridWidth,
    @required double gridHeight,
    @required double itemAspectRatio,
    @required int columnCount,
    @required double gridSidePadding,
    @required double topPaddingOnZoomOut,
    @required double bottomPaddingOnZoomedOut,
  }){

    final double _topPaddingOnZoomedIn = gotCenteredTopPaddingOnZoomedIn(
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      gridSidePadding: gridSidePadding,
    );

    final double _smallItemWidth = getSmallItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    final double _smallItemHeight = getSmallItemHeight(
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    final double _bigItemWidth = getBigItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    final double _bigItemHeight = getBigItemHeight(
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    return ZGridScale(
      gridWidth: gridWidth,
      gridHeight: gridHeight,
      itemAspectRatio: itemAspectRatio,
      columnCount: columnCount,
      topPaddingOnZoomOut: topPaddingOnZoomOut,
      topPaddingOnZoomIn: _topPaddingOnZoomedIn,
      bottomPaddingOnZoomedOut: bottomPaddingOnZoomedOut,
      gridSidePadding: gridSidePadding,
      bigItemWidth: _bigItemWidth,
      bigItemHeight: _bigItemHeight,
      smallItemHeight: _smallItemHeight,
      smallItemWidth: _smallItemWidth,
    );

  }
    // -----------------------------------------------------------------------------

  /// SMALL ITEM DIMENSIONS

  // --------------------
  static double getSmallItemWidth({
    @required double gridWidth,
    @required int columnCount,
    @required double gridSidePadding,
  }){

    final double _clearWidth = gridWidth - (gridSidePadding * 2);

    return _clearWidth /
            (
                columnCount
                    + (columnCount * spacingRatio)
                    - spacingRatio
            );

  }
  // --------------------
  static double getSmallItemHeight({
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required double gridSidePadding,
  }){

    final double _smallItemWidth = getSmallItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    return _smallItemWidth / itemAspectRatio;
  }
  // -----------------------------------------------------------------------------

  /// BIG ITEM DIMENSIONS

  // --------------------
  static double getBigItemWidth({
    @required double gridWidth,
    @required int columnCount,
    @required double gridSidePadding,
  }){

      final double _scale = calculateMaxScale(
        gridWidth: gridWidth,
        columnCount: columnCount,
        gridSidePadding: gridSidePadding,
      );

      final double _smallItemWidth = getSmallItemWidth(
        gridWidth: gridWidth,
        columnCount: columnCount,
        gridSidePadding: gridSidePadding,
      );

      return _smallItemWidth * _scale;
  }
  // --------------------
  static double getBigItemHeight({
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required double gridSidePadding,
  }){

    final double _bigItemWidth = getBigItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    return _bigItemWidth / itemAspectRatio;
  }
  // -----------------------------------------------------------------------------

  /// GRID SPACING

  // --------------------
  static const double spacingRatio = 0.03;
  // --------------------
  static double getSpacing({
    @required double gridWidth,
    @required int columnCount,
    @required double gridSidePadding,
  }){

    final double _smallItemWidth = getSmallItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    return _smallItemWidth * spacingRatio;
  }
    // -----------------------------------------------------------------------------

  /// GRID PADDING

  // --------------------
  static double getTopPaddingOnZoomIn({
    @required double topPaddingOnZoomIn
  }){
    assert (topPaddingOnZoomIn != null, 'topPaddingOnZoomIn cannot be null');
    return topPaddingOnZoomIn ?? 10;
  }
  // --------------------
  static double gotCenteredTopPaddingOnZoomedIn({
    @required double gridHeight,
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required double gridSidePadding,
  }){

    final double _bigItemHeight = getBigItemHeight(
        gridWidth: gridWidth,
        columnCount: columnCount,
        itemAspectRatio: itemAspectRatio,
        gridSidePadding: gridSidePadding,
    );

    final double _remaining = gridHeight - _bigItemHeight;
    return _remaining / 2;
  }
  // --------------------
  static double getTopPaddingOnZoomOut({
    @required double topPaddingOnZoomOut
  }){
    return topPaddingOnZoomOut ?? Stratosphere.smallAppBarStratosphere;
  }
  // --------------------
  static EdgeInsets getGridPadding({
    @required BuildContext context,
    @required double gridWidth,
    @required int columnCount,
    @required double topPaddingOnZoomOut,
    @required bool isZoomed,
    @required double itemAspectRatio,
    @required double gridSidePadding,
    @required double bottomPaddingOnZoomedOut,
  }){

    final double _topPaddingOnZoomedOut = getTopPaddingOnZoomOut(
      topPaddingOnZoomOut: topPaddingOnZoomOut,
    );

    final double _bottomPaddingOnZoomedIn = getBottomPaddingOnZoomedIn(
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    final double _bottomPaddingOnZoomedOut = getBottomPaddingOnZoomedOut(
        bottomPaddingOnZoomedOut: bottomPaddingOnZoomedOut,
        gridSidePadding: gridSidePadding,
    );

    final double _bottom = isZoomed == true ? _bottomPaddingOnZoomedIn : _bottomPaddingOnZoomedOut;

    return Scale.superInsets(
      context: context,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enLeft: gridSidePadding,
      top: _topPaddingOnZoomedOut,
      enRight: gridSidePadding,
      bottom: _bottom,
    );

  }
  // --------------------
  static double getBottomPaddingOnZoomedIn({
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required double gridSidePadding,
  }){

    final double _smallItemHeight = getSmallItemHeight(
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    final double _scale = calculateMaxScale(
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridSidePadding: gridSidePadding,
    );

    return (_smallItemHeight + gridSidePadding) * _scale;
  }
  // --------------------
  static double getBottomPaddingOnZoomedOut({
    @required double bottomPaddingOnZoomedOut,
    @required double gridSidePadding,
  }){
    return bottomPaddingOnZoomedOut ?? gridSidePadding ?? 10;
  }
  // -----------------------------------------------------------------------------

  /// GRID DELEGATE

  // --------------------
  static SliverGridDelegate getGridDelegate({
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required double gridSidePadding,
  }){

    final double _gridSpacingValue = getSpacing(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    final double _smallItemHeight = getSmallItemHeight(
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    return SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: _gridSpacingValue,
      mainAxisSpacing: _gridSpacingValue,
      childAspectRatio: itemAspectRatio,
      crossAxisCount: columnCount,
      mainAxisExtent: _smallItemHeight,
    );

  }
    // -----------------------------------------------------------------------------

  /// ZOOMING OFFSETS (MATRIX TRANSLATIONS)

  // --------------------
  static double _getZoomableWidth({
    @required double gridWidth,
    @required int columnCount,
    @required double gridSidePadding,
  }){
    final double _spacing = getSpacing(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );
    final double _smallItemWidth = getSmallItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );
    return _smallItemWidth + (_spacing * 2);
  }
  // --------------------
  static double _getRowOffset({
    @required int rowIndex,
    @required double gridWidth,
    @required int columnCount,
    @required double itemAspectRatio,
    @required double gridSidePadding,
  }){

    final double _smallItemHeight = getSmallItemHeight(
      gridWidth: gridWidth,
      columnCount: columnCount,
      itemAspectRatio: itemAspectRatio,
      gridSidePadding: gridSidePadding,
    );

    final double _spacing = getSpacing(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    return (_smallItemHeight + _spacing) * rowIndex;
  }
  // --------------------
  static double _getTopPaddingZoomOffset({
    @required int columnCount,
    @required double gridWidth,
    @required double topPaddingOnZoomOut,
    @required double topPaddingOnZoomIn,
    @required double gridSidePadding,
  }){

    final double _scale = calculateMaxScale(
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridSidePadding: gridSidePadding,
    );

    final double _topPaddingOnZoomedOut = getTopPaddingOnZoomOut(
      topPaddingOnZoomOut: topPaddingOnZoomOut,
    );

    final double _topPaddingOnZoomedIn = getTopPaddingOnZoomIn(
      topPaddingOnZoomIn: topPaddingOnZoomIn,
    );

    final double _scaledTopPadding = _topPaddingOnZoomedOut * _scale;

    return - _scaledTopPadding + _topPaddingOnZoomedIn;
  }
  // --------------------
  static double _getHorizontalZoomOffset({
    @required int columnIndex,
    @required int columnCount,
    @required double gridWidth,
    @required double gridSidePadding,
  }){
    final double _scale = calculateMaxScale(
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridSidePadding: gridSidePadding,
    );

    final double _spacing = getSpacing(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    final double _smallItemWidth = getSmallItemWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );

    final double _scaledSidePadding = gridSidePadding * _scale;
    final double _scaledItemWidth = _smallItemWidth * _scale;
    final double _scaledSpacing = _spacing * _scale;
    final double _zoomedSidePaddingFix = _scaledSidePadding - _scaledSpacing;

    return - (_zoomedSidePaddingFix + ((_scaledItemWidth + _scaledSpacing) * columnIndex));
  }
  // --------------------
  static double calculateMaxScale({
    @required double gridWidth,
    @required int columnCount,
    @required double gridSidePadding,
  }){
    final double _zoomableWidth = _getZoomableWidth(
      gridWidth: gridWidth,
      columnCount: columnCount,
      gridSidePadding: gridSidePadding,
    );
    return gridWidth / _zoomableWidth;
  }
  // -----------------------------------------------------------------------------

  /// MATRIXES

  // --------------------
  static Matrix4 _getZoomMatrix({
    @required BuildContext context,
    @required int rowIndex,
    @required int columnIndex,
    @required double gridWidth,
    @required int columnCount,
    @required double topPaddingOnZoomIn,
    @required double topPaddingOnZoomOut,
    @required double gridSidePadding,
  }){

    final double _scale = calculateMaxScale(
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridSidePadding: gridSidePadding,
    );
    final double _transX = _getHorizontalZoomOffset(
      columnIndex: columnIndex,
      columnCount: columnCount,
      gridWidth: gridWidth,
      gridSidePadding: gridSidePadding,
    );
    final double _transY = _getTopPaddingZoomOffset(
      columnCount: columnCount,
      gridWidth: gridWidth,
      topPaddingOnZoomOut: topPaddingOnZoomOut,
      topPaddingOnZoomIn: topPaddingOnZoomIn,
      gridSidePadding: gridSidePadding,
    );
    // const double _transY = 0;

    final Float64List _list = Float64List.fromList(<double>[
      _scale,  0,        0,        0,
      0,        _scale,  0,        0,
      0,        0,        _scale,  0,
      _transX,  _transY,  0,       1,
    ]);

    return Matrix4.fromFloat64List(_list);
  }
  // --------------------------------------------------------------------------
}
