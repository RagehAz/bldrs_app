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
          // padding: const EdgeInsets.symmetric(horizontal: 10),//MirageStrip.getStripPaddings(),
          itemScrollController: mirageModel.controller,
          // shrinkWrap: true,
          // reverse: false,
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
