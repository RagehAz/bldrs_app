part of mirage;
// ignore_for_file: unused_element

class _MiragePyramid extends StatelessWidget {
  // --------------------------------------------------------------------------
  const _MiragePyramid({
    required this.mirage1,
    required this.mounted,
    super.key
  });
  // --------------------
  final _MirageModel mirage1;
  final bool mounted;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: mirage1.pyramidIsOn!,
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
        onTap: () => mirage1.onPyramidTap(mounted: mounted),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
