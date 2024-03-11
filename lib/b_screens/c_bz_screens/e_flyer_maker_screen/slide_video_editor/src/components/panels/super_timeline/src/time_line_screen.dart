part of super_time_line;

class SuperTimeLineScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const SuperTimeLineScreen({
    super.key
  });

  @override
  State<SuperTimeLineScreen> createState() => _SuperTimeLineScreenState();
}

class _SuperTimeLineScreenState extends State<SuperTimeLineScreen> {
  // --------------------------------------------------------------------------
  double _startSecond = 0;
  double _endSecond = 0;
  double _currentSecond = 0;
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
            limitScrollingBetweenHandles: true,
            onTimeChanged: (double current){
              setState(() {
                _currentSecond = current;
              });
            },
            onHandleChanged: (double start, double end){
              setState(() {
                _startSecond = start;
                _endSecond = end;
              });
            },
          ),

          Builder(
            builder: (context) {

              final String _start = Numeric.formatDoubleWithinDigits(
                value: _startSecond,
                digits: 2,
                addPlus: false,
              )!;

              final String _end = Numeric.formatDoubleWithinDigits(
                value: _endSecond,
                digits: 2,
                addPlus: false,
              )!;

              final String _current = Numeric.formatDoubleWithinDigits(
                value: _currentSecond,
                digits: 2,
                addPlus: false,
              )!;

              return BldrsBox(
                height: 30,
                width: 200,
                verse: Verse.plain('s$_start ---> e$_end'),
                secondLine: Verse.plain('c: $_current'),
                margins: 10,
                color: Colorz.blue80,
                bubble: false,
                verseScaleFactor: 0.7,
              );
            }
          ),

        ],
      ),
    );
    // --------------------
  }
}
