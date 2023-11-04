part of top_button;

class _ThreeLinesStructure extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const _ThreeLinesStructure({
    required this.columnWidth,
    required this.flyerBoxWidth,
    required this.topChild,
    required this.bottomChild,
    required this.middleChild,
  });
  // --------------------
  final double columnWidth;
  final double flyerBoxWidth;
  final Widget topChild;
  final Widget bottomChild;
  final Widget middleChild;
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
              height: _height * 0.55,
              alignment: BldrsAligners.superCenterAlignment(context),
              child: FittedBox(
                  child: topChild,
              ),
            ),
          ),

          /// MIDDLE
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: columnWidth,
              height: _height * 0.85,
              alignment: BldrsAligners.superCenterAlignment(context),
              child: FittedBox(
                child: middleChild,
              ),
            ),
          ),

          /// BOTTOM
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: columnWidth,
              height: _height * 0.35,
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
