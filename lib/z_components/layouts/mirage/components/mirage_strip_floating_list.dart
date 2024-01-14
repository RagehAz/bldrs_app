part of mirage;
// ignore_for_file: unused_element

class _MirageStripFloatingList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MirageStripFloatingList({
    required this.columnChildren,
    super.key
  });
  // --------------------
  final List<Widget> columnChildren;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FloatingList(
      width: _MirageButton.getWidth,
      height: _MirageButton.getHeight,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      boxAlignment: Alignment.topCenter,
      scrollDirection: Axis.horizontal,
      padding: _MirageStrip.getStripPaddings(),
      columnChildren: columnChildren,
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
