part of top_button;

class TopButtonLabelStructure extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const TopButtonLabelStructure({
    required this.width,
    required this.flyerBoxWidth,
    required this.color,
    required this.child,
    this.onTap,
    this.splashColor = Colorz.white50,
    super.key,
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
