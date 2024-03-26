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

    if (mounted == true && oldWidget.width != widget.width) {
      setState(() {});
    }

    final bool _filesAreIdentical = VideoOps.checkVideoEditorVideosAreIdentical(
        oldController: oldWidget.controller,
        newController: widget.controller,
    );

    if (mounted == true && _filesAreIdentical == false){
      _reset();
    }

  }
  // --------------------
  @override
  void dispose() {
    _loading.dispose();
    _stop.dispose();
    super.dispose();
  }
  // --------------------
  final ValueNotifier<bool> _stop = ValueNotifier(false);
  // --------------------
  Future<void> _loadFrames() async {

    await _triggerLoading(setTo: true);

    _frames = await FrameModel.createFramesPicsInTheSmartSequence(
        frames: _frames,
        controller: widget.controller,
        stop: _stop,
        onNewFrameAdded: (List<FrameModel> list){

          if (mounted == true){
            setState(() {
              _frames = list;
            });
          }

        }
    );

    if (mounted == true){
      setState(() {});
    }

    await _triggerLoading(setTo: false);

  }
  // --------------------
  Future<void> _reset() async {

    setNotifier(notifier: _stop, mounted: mounted, value: true);

    await Future.delayed(const Duration(milliseconds: 200));

    setState(() {
      _frames = [];
      _frames = FrameModel.createEmptyFrames(
        videoDurationInSeconds: widget.controller.videoDuration.inMilliseconds / 1000,
      );
    });

    await Future.delayed(const Duration(milliseconds: 200));

    setNotifier(notifier: _stop, mounted: mounted, value: false);

    await _loadFrames();

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
    return Stack(
      children: <Widget>[

        /// FRAMES
        SizedBox(
          width: widget.width,
          height: widget.height,
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
        ),

        /// LOADING INDICATOR
        FrameLoadingIndicator(
          loading: _loading,
        ),

      ],
    );
    // --------------------
  }
  // ---------------------------------------------------------------------------
}
