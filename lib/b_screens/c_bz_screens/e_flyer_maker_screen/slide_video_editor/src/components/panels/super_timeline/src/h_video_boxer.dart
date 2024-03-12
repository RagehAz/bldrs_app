part of super_time_line;

class VideoBoxer extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoBoxer({
    required this.width,
    required this.height,
    required this.controller,
    super.key
  });
  // --------------------
  final double width;
  final double height;
  final VideoEditorController controller;
  // --------------------
  @override
  _VideoBoxerState createState() => _VideoBoxerState();
  // --------------------------------------------------------------------------
}

class _VideoBoxerState extends State<VideoBoxer> {
  // ---------------------------------------------------------------------------
  /// --- LOADING
  final ValueNotifier<bool> _loading = ValueNotifier(false);
  // --------------------
  Future<void> _triggerLoading({required bool setTo}) async {
    setNotifier(
      notifier: _loading,
      mounted: mounted,
      value: setTo,
    );
  }
  // ---------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _triggerLoading(setTo: true);
        /// GO BABY GO
        await _triggerLoading(setTo: false);

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  /*
  @override
  void didUpdateWidget(TheStatefulScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.thing != widget.thing) {
      unawaited(_doStuff());
    }
  }
   */
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // ---------------------------------------------------------------------------
  // List<Uint8List> _boxes = [];
  // // --------------------
  // Future<void> _generateAllPossibleBoxes() async {
  //
  //   setState(() {
  //     _boxes = [];
  //   });
  //
  //   final double _videoSeconds = widget.controller.videoDuration.inMilliseconds / 1000;
  //
  //   final double _maxPossibleWidth = TimelineScale.initialSecondPixelLength * TimelineScale.maxTimelineScale * _videoSeconds;
  //
  //   final double _allowableWidth = _maxPossibleWidth;
  //
  //   final double _boxHeight = widget.height;
  //   final double _boxWidth = _boxHeight;
  //   final int _numberOfBoxes = (_allowableWidth / _boxWidth).ceil();
  //   final double _boxSecondsDuration = _videoSeconds / _numberOfBoxes;
  //   final double _boxMilliSecondsDuration = _boxSecondsDuration * 1000;
  //
  //   const double _sizeFactor = 0.4;
  //
  //   for (int i = 0; i < _numberOfBoxes; i++){
  //
  //     await tryAndCatch(
  //         functions: () async {
  //
  //           final Uint8List? bytes = await VideoThumbnail.thumbnailData(
  //             imageFormat: ImageFormat.JPEG,
  //             video: widget.controller.file.path,
  //             timeMs: (_boxMilliSecondsDuration * i).toInt(),
  //             quality: 100,
  //             maxHeight: (widget.controller.videoHeight * _sizeFactor).toInt(),
  //             maxWidth:(widget.controller.videoWidth * _sizeFactor).toInt(),
  //           );
  //
  //           if (bytes != null && mounted == true){
  //             setState(() {
  //               _boxes = [..._boxes, bytes];
  //             });
  //           }
  //
  //         },
  //     );
  //
  //
  //   }
  //
  //
  // }

  List<FrameModel> _frames = [];

  Future<void> _doFrames() async {

    _frames = FrameModel.createEmptyFrames(
      videoDurationInSeconds: widget.controller.videoDuration.inMilliseconds / 1000,
    );

    setState(() {});

    int x = 0;
     _frames = await FrameModel.createFramesPicsInTheSmartSequence(
        frames: _frames,
        controller: widget.controller,
        onNewFrameAdded: (List<FrameModel> list){

          x++;

          setState(() {
            _frames = list;
          });

        }
    );

    setState(() {});

  }

  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return FloatingList(
      width: widget.width,
      height: widget.height*2,
      boxColor: Colorz.bloodTest,
      scrollDirection: Axis.horizontal,
      columnChildren: [

        BldrsBox(
          width: widget.height,
          height:  widget.height,
          verse: Verse.plain('${_frames.length}\npix'),
          verseMaxLines: 3,
          verseScaleFactor: 0.5,
          onTap: _doFrames,
        ),

        ...List.generate(_frames.length, (index){

          final FrameModel _frame = _frames[index];

          double? _kb = Filers.calculateSize(_frame.pic?.length, FileSizeUnit.kiloByte);
          _kb = Numeric.removeFractions(number: _kb);
          final String _x = Numeric.stringifyDouble(_kb);

          return Column(
            children: <Widget>[

              SuperImage(
                width: widget.height,
                height: widget.height,
                pic: _frame.pic ?? Colorz.black150,
                backgroundColor: _frame.pic == null ? Colorz.black150 : null,
                loading: false,
              ),

              // FutureBuilder(
              //   future: Dimensions.superDimensions(_frame.pic),
              //   builder: (context, AsyncSnapshot<Dimensions?> snap,) {
              //
              //     final Dimensions? _dims = snap.data;
              //     final _d = _dims == null ? '..' : '${_dims.width}\n${_dims.height}';
              //
              //     return
              //     BldrsText(
              //       verse: Verse.plain('$index\n$_x Kb\n$_d'),
              //       size: 0,
              //       scaleFactor: 0.7,
              //       maxLines: 4,
              //       centered: false,
              //       width: widget.height,
              //       height: widget.height,
              //     );
              //   }
              // ),

            ],
          );

        }),

      ],
    );
    // --------------------
  }
  // ---------------------------------------------------------------------------
}
