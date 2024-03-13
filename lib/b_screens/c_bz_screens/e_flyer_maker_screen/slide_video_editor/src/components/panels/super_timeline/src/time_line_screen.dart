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
  VideoEditorController? _videoEditorController;
  final ScrollController _scrollController = ScrollController();
  final ValueNotifier<double> _secondPixelLength = ValueNotifier(TimelineScale.initialSecondPixelLength);
  // --------------------
  @override
  void dispose() {
    _videoEditorController?.dispose();
    _secondPixelLength.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------
  Future<void> _pickVideo() async {

    final String _fileName = Numeric.createUniqueID().toString();

    final MediaModel? _video = await VideoMaker.pickVideo(
      context: context,
      langCode: 'en',
      onError: (t){},
      onPermissionPermanentlyDenied: (t){},
      compressWithQuality: 100,
      assignPath: 'a/s',
      ownersIDs: ['x'],
      name: _fileName,
    );

    if (_video != null){

      final File? file = await Filers.getFileFromUint8List(
          uInt8List: _video.bytes,
          fileName: _fileName,
      );

      _videoEditorController = await VideoOps.initializeVideoEditorController(
        file: file,
        onError: (String error) async {
          await Dialogs.errorDialog(
            titleVerse: Verse.plain(error),
          );
          // await Nav.goBack(context: context);
        },
      );

      setState(() {});

    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _videoBoxerWidth = Scale.screenWidth(context);

    // --------------------
    return MainLayout(
      canSwipeBack: false,
      title: Verse.plain('Super timeline screen'),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          verse: Verse.plain('pick'),
          onTap: _pickVideo,
        ),

      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          /// SUPER TIMELINE
          SuperTimeLine(
            height: 80,
            totalWidth: Scale.screenWidth(context),
            limitScrollingBetweenHandles: false,
            videoEditorController: _videoEditorController,
            scrollController: _scrollController,
            secondPixelLength: _secondPixelLength,
            onTimeChanged: (double current){
              if (mounted){
                setState(() {
                  _currentSecond = current;
                });
              }
            },
            onHandleChanged: (double start, double end){
              if (mounted){
                setState(() {
                  _startSecond = start;
                  _endSecond = end;
                });
              }
            },
          ),

          /// temp timers
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
                icon: Iconz.play,
                verseScaleFactor: 0.7,
                onTap: () async {

                  await TimelineScale.scrollFromTo(
                    controller: _scrollController,
                    secondPixelLength: _secondPixelLength.value,
                    fromSecond: _startSecond,
                    toSecond: _endSecond,
                  );



                },
              );
            }
          ),

          /// REMOVE_ME
          // /// TEMP VIDEO BOXER
          // if (_videoEditorController != null)
          // VideoBoxer(
          //   width: _videoBoxerWidth,
          //   height: 40,
          //   controller: _videoEditorController!,
          // ),

          /// temp video view
          if (_videoEditorController != null)
          SizedBox(
            height: 80,
            child: CropGridViewer.preview(
                controller: _videoEditorController!
            ),
          ),

        ],
      ),
    );
    // --------------------
  }
}
