part of super_time_line;

class SuperTimeLineScreen extends StatelessWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLineScreen({
    super.key
  });
  // --------------------
  ///
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: false,
      title: Verse.plain('Super timeline screen'),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          SuperTimeLine(
            totalSeconds: 5.4,
            height: 80,
            width: Scale.screenWidth(context),
          ),

        ],
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
