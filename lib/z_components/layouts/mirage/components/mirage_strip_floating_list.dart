part of mirage;
// ignore_for_file: unused_element

class _MirageStripScrollableList extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MirageStripScrollableList({
    required this.columnChildren,
    required this.mirageModel,
    super.key
  });
  // --------------------
  final List<Widget> columnChildren;
  final MirageModel mirageModel;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: Scale.screenWidth(context),
      height: MirageButton.getHeight,
      child: ScrollablePositionedList.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: columnChildren.length,
          scrollDirection: Axis.horizontal,
          padding: MirageStrip.getStripPaddings(),
          itemScrollController: mirageModel.controller,
          // initialAlignment: 100,
          // addRepaintBoundaries: true,
          // addAutomaticKeepAlives: false,
          // initialScrollIndex: 0,
          itemBuilder: (BuildContext context, int index){

            return columnChildren[index];

          }
      ),
    );
    // --------------------
  }
// --------------------------------------------------------------------------
}

// class _MirageStripFloatingList extends StatelessWidget {
//   // --------------------------------------------------------------------------
//   const _MirageStripFloatingList({
//     required this.columnChildren,
//     super.key
//   });
//   // --------------------
//   final List<Widget> columnChildren;
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     return FloatingList(
//       width: _MirageButton.getWidth,
//       height: _MirageButton.getHeight,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       boxAlignment: Alignment.topCenter,
//       scrollDirection: Axis.horizontal,
//       padding: MirageStrip.getStripPaddings(),
//       columnChildren: columnChildren,
//     );
//     // --------------------
//   }
//   // --------------------------------------------------------------------------
// }
