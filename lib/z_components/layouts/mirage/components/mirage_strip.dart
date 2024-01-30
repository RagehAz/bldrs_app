part of mirage;
// ignore_for_file: unused_element

class MirageStrip extends StatelessWidget {
  // --------------------------------------------------------------------------
  const MirageStrip({
    required this.index,
    required this.mounted,
    required this.child,
    this.onShow,
    this.onHide,
    super.key
  });
  // --------------------
  final int index;
  final bool mounted;
  final Widget child;
  final Function? onHide;
  final Function? onShow;
  // --------------------
  static EdgeInsets getStripPaddings(){
    return Scale.superInsets(
      context: getMainContext(),
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      enRight: 10 - RedDotBadge.getShrinkageDX(childWidth: MirageButton.getWidth, isNano: false),
      enLeft: 10,
      top: 3,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final List<MirageModel> _allMirages = HomeProvider.proGetMirages(
      context: context,
      listen: true,
    );
    // --------------------
    final MirageModel _mirage = _allMirages[index];
    // --------------------
    final List<MirageModel> _miragesAbove = MirageModel.getMiragesAbove(
        allMirages: _allMirages,
        aboveIndex: index,
    );
    // --------------------
    final double _width = _mirage.getWidth();
    // --------------------
    return ValueListenableBuilder(
      valueListenable: _mirage.position,
      builder: (_, double position, Widget? child) {

        return AnimatedPositioned(
          duration: MirageModel.getMirageDuration(mirage: _mirage),
          bottom: -position,
          right: 0,
          child: child!,
        );
      },
      child: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) => _mirage.onDragUpdate(
          details: details,
          mounted: mounted,
          miragesAbove: _miragesAbove,
          onHide: onHide,
        ),
        onVerticalDragEnd: (DragEndDetails details) => _mirage.onDragEnd(
          details: details,
          mounted: mounted,
          onHide: onHide,
          onShow: onShow,
        ),
        child: Container(
          /// this makes the drag listens : don't remove this
          color: Colorz.nothing,
          child: BlurLayer(
            width: _width,
            height: _mirage.getHeight(),
            color: Colorz.white10,
            blurIsOn: true,
            blur: 3,
            alignment: Alignment.topCenter,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                /// DRAGGER
                Container(
                  width: _width - 20,
                  height: MirageModel.draggerHeight,
                  decoration: const BoxDecoration(
                    color: MirageModel.draggerColor,
                    borderRadius: MirageModel.draggerCorners,
                  ),
                ),

                /// CHILD
                Container(
                  width: _width,
                  height: _mirage.getClearHeight(),
                  alignment: Alignment.topCenter,
                  child: child,
                ),

              ],
            ),
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
