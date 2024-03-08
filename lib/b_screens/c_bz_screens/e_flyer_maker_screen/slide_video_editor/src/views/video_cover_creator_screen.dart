part of slide_video_editor;

class VideoCoverCreatorScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const VideoCoverCreatorScreen({
    required this.video,
    super.key
  });
  // --------------------
  final MediaModel? video;
  // --------------------
  @override
  _VideoCoverCreatorScreenState createState() => _VideoCoverCreatorScreenState();
  // --------------------------------------------------------------------------
}

class _VideoCoverCreatorScreenState extends State<VideoCoverCreatorScreen> {
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
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
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return MainLayout(
      canSwipeBack: true,
      loading: _loading,
      title: Verse.plain('cover creator'),
      appBarRowWidgets: <Widget>[

        AppBarButton(
          icon: Iconz.more,
          onTap: (){
            blog('Do the thing');
          },
        ),

      ],
      child: FloatingList(
        boxAlignment: Alignment.topCenter,
        padding: Stratosphere.stratosphereSandwich,
        columnChildren: <Widget>[

          WideButton(
            verse: Verse.plain('Button'),
            onTap: () async {

              blog('~~~~~~~~~test~~~~~~~~~~ onTap');

            },
          ),

        ],
      ),
    );
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
