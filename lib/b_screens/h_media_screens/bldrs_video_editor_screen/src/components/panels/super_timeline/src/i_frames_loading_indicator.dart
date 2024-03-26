part of super_time_line;

class FrameLoadingIndicator extends StatelessWidget {
  // --------------------------------------------------------------------------
  const FrameLoadingIndicator({
    required this.loading,
    super.key
  });
  // --------------------
  final ValueNotifier<bool> loading;
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return ValueListenableBuilder(
      valueListenable: loading,
      builder: (_, bool loading, Widget? child) {

        if (loading){
          return child!;
        }
        else{
          return const SizedBox();
        }

      },
      child: const Align(
        alignment: Alignment.topLeft,
        child: WidgetFader(
          fadeType: FadeType.repeatAndReverse,
          min: 0.2,
          duration: Duration(milliseconds: 350),
          child: BldrsBox(
            margins: 3,
            height: 5,
            width: 5,
            color: Colorz.black255,
          ),
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
