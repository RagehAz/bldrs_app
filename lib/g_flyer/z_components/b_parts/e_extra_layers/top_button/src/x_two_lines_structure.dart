part of top_button;

class _TwoLinesStructure extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _TwoLinesStructure({
    required this.columnWidth,
    required this.flyerBoxWidth,
    required this.topChild,
    required this.bottomChild,
  });
  // --------------------
  final double columnWidth;
  final double flyerBoxWidth;
  final Widget topChild;
  final Widget bottomChild;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _height = getTopButtonHeight(
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    return SizedBox(
      width: columnWidth,
      height: _height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          /// TOP
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: columnWidth,
              height: _height * 0.74,
              alignment: BldrsAligners.superCenterAlignment(context),
              child: FittedBox(
                  child: topChild,
              ),
            ),
          ),

          /// BOTTOM
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: columnWidth,
              height: _height * 0.65,
              alignment: BldrsAligners.superCenterAlignment(context),
              child: FittedBox(
                child: bottomChild,
              ),
            ),
          ),

        ],

      ),
    );

  }
  // -----------------------------------------------------------------------------
}
