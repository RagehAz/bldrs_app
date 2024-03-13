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
  List<FrameModel> _frames = [];
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

    _frames = FrameModel.createEmptyFrames(
      videoDurationInSeconds: widget.controller.videoDuration.inMilliseconds / 1000,
    );

  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {

    if (_isInit && mounted) {
      _isInit = false; // good

      asyncInSync(() async {

        await _loadFrames();

      });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void didUpdateWidget(VideoBoxer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.width != widget.width) {
      setState(() {});
    }

    final bool _filesAreIdentical = Filers.checkFilesAreIdentical(
        file1: oldWidget.controller.file,
        file2: widget.controller.file,
    );

    if (_filesAreIdentical == false){

      setState(() {
        _frames = [];
        _frames = FrameModel.createEmptyFrames(
          videoDurationInSeconds: widget.controller.videoDuration.inMilliseconds / 1000,
        );
      });

      _loadFrames();

    }

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }
  // --------------------
  Future<void> _loadFrames() async {

    await _triggerLoading(setTo: true);

    _frames = await FrameModel.createFramesPicsInTheSmartSequence(
        frames: _frames,
        controller: widget.controller,
        onNewFrameAdded: (List<FrameModel> list){

          setState(() {
            _frames = list;
          });

        }
    );

    setState(() {});

    await _triggerLoading(setTo: false);

  }
  // ---------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _boxHeight = widget.height;
    final double _boxWidth = _boxHeight;
    final int _numberOfBoxes = (widget.width / _boxWidth).ceil();
    final double _videoSeconds = widget.controller.videoDuration.inMilliseconds / 1000;
    final double _boxDuration = _videoSeconds / _numberOfBoxes;
    // --------------------
    final FrameModel? _firstFrame = _frames.firstOrNull;
    // --------------------
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colorz.black255,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        child: Row(
          children: <Widget>[

            if (Lister.checkCanLoop(_frames) == true)
            ...List.generate(_numberOfBoxes, (index){

              final double _boxSecond = _boxDuration * index;

              final FrameModel? _frame = FrameModel.getNearestFrame(
                frames: _frames,
                second: _boxSecond,
                ignoreEmptyPics: true,
              );

              final Uint8List? _pic =  _frame?.pic ?? _firstFrame?.pic;

              if (_pic == null){
                return SizedBox(
                  width: widget.height,
                  height: widget.height,
                );
              }
              else {
                return Image.memory(
                  _pic,
                  width: widget.height,
                  height: widget.height,
                  fit: BoxFit.cover,
                );
              }

            }),

          ],
        ),
      ),
    );
    // --------------------
  }
  // ---------------------------------------------------------------------------
}
