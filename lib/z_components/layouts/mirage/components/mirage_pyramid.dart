part of mirage;
// ignore_for_file: unused_element

class _MiragePyramid extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MiragePyramid({
    required this.mounted,
    super.key
  });
  // --------------------
  final bool mounted;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final MirageModel _mirage0 = HomeProvider.proGetMirageByIndex(
        context: context,
        listen: true,
        index: 0,
    );
    // --------------------
    return ValueListenableBuilder(
      valueListenable: _mirage0.pyramidIsOn!,
      builder: (_, bool isOn, Widget? child) {

        return AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          bottom: isOn == true ? 0 : -Pyramids.khafreHeight,
          right: Pyramids.rightMargin,
          curve: Curves.easeInOut,
          child: child!,
        );
      },
      child: Khufu(
        onTap: () => _mirage0.onPyramidTap(mounted: mounted),
        onLongTap: () => Routing.goTo(route: ScreenName.logo),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
