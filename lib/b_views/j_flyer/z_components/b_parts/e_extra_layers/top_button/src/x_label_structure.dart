part of top_button;

class _LabelStructure extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _LabelStructure({
    required this.width,
    required this.flyerBoxWidth,
    required this.color,
    required this.child,
    this.onTap,
    this.splashColor = Colorz.white50,
  });
  /// --------------------
  final double width;
  final double flyerBoxWidth;
  final Color color;
  final Widget child;
  final Function? onTap;
  final Color splashColor;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return BldrsBox(
      height: getTopButtonHeight(
        flyerBoxWidth: flyerBoxWidth,
      ),
      width: width,
      corners: getButtonCorners(
          flyerBoxWidth: flyerBoxWidth,
        ),
      color: color,
      splashColor: splashColor,
      onTap: onTap,
      bubble: onTap != null,
      subChild: child,
    );
    // --------------------
  }
  /// --------------------------------------------------------------------------
}
