part of super_time_line;
/// =>TAMAM
@immutable
class FrameModel {
  // --------------------------------------------------------------------------
  const FrameModel({
    required this.index,
    required this.pic,
    required this.second,
  });
  // --------------------
  final int index;
  final Uint8List? pic;
  final double second;
  // -----------------------------------------------------------------------------

  /// CLONING

  // --------------------
  /// TESTED : WORKS PERFECT
  FrameModel copyWith({
    int? index,
    Uint8List? pic,
    double? second,
  }){
    return FrameModel(
      index: index ?? this.index,
      pic: pic ?? this.pic,
      second: second ?? this.second,
    );
  }
  // -----------------------------------------------------------------------------

  /// CREATORS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FrameModel> createEmptyFrames({
    required double videoDurationInSeconds,
    int framesPerSecond = TimelineScale.maxFramesPerSecond,
  }){
    final List<FrameModel> _output = [];

    if (videoDurationInSeconds > 0){

      final int _maxNumberOfFrames = concludeNumberOfFrames(
          framesPerSecond: framesPerSecond,
          videoDurationInSeconds: videoDurationInSeconds
      );

      final double _frameDurationInSeconds = 1 / framesPerSecond;

      for (int i = 0; i < _maxNumberOfFrames; i++){

        final FrameModel _frame = FrameModel(
          index: i,
          second: _frameDurationInSeconds * i,
          pic: null,
        );

        _output.add(_frame);

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<Uint8List?> createFramePic({
    required VideoEditorController controller,
    required double second,
  }) async {

    const double _sizeFactor = TimelineScale.frameSizeFactor;

    Uint8List? bytes;

    await tryAndCatch(
      invoker: 'createFramePic',
      functions: () async {

        bytes = await VideoThumbnail.thumbnailData(
          imageFormat: ImageFormat.JPEG,
          video: controller.file.path,
          timeMs: (second * 1000).toInt(),
          quality: 99,
          maxHeight: (controller.videoHeight * _sizeFactor).toInt(),
          maxWidth:(controller.videoWidth * _sizeFactor).toInt(),
        );

        },
    );

    return bytes;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<FrameModel>> createFramesPicsInTheSmartSequence({
    required List<FrameModel> frames,
    required Function(List<FrameModel> frames) onNewFrameAdded,
    required ValueNotifier<bool> stop,
    required VideoEditorController controller,
    int framesPerSecond = TimelineScale.maxFramesPerSecond,
  }) async {
    List<FrameModel> _output = [...frames];

    for (int x = 0; x < TimelineScale.framesLoadingSequence.length; x++){

      if (stop.value == true){
        break;
      }

      final int _divisibleBy = TimelineScale.framesLoadingSequence[x];

      await loopDivisibles(
          frames: frames,
          divisibleBy: _divisibleBy,
          stop: stop,
          onDivisible: (int index) async {

            final FrameModel? _frame = getFrameByIndex(
              frames: _output,
              index: index,
            );

            if (_frame != null && _frame.pic == null){

              final Uint8List? _pic = await createFramePic(
                  controller: controller,
                  second: _frame.second,
              );

              if (_pic != null){
                _output = assignPicToFrame(
                  pic: _pic,
                  index: index,
                  frames: _output,
                );
                onNewFrameAdded(_output);
              }

            }

          },
      );

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> loopDivisibles({
    required List<FrameModel> frames,
    required int divisibleBy,
    required ValueNotifier<bool> stop,
    required Function(int index) onDivisible,
  }) async {

    for (int i = 0; i < frames.length; i++){

      if (stop.value == true){
        break;
      }

      final bool _isDivisible = divisibleBy == 0 ? true : (i % divisibleBy) == 0;

      if (_isDivisible == true){
        await onDivisible(i);
      }

    }

  }
  // -----------------------------------------------------------------------------

  /// MODIFIERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FrameModel> replaceFrame({
    required List<FrameModel> frames,
    required FrameModel frame,
  }){
    final List<FrameModel> _output = [...frames];

    if (Lister.checkCanLoop(frames) == true){

      final int _index = _output.indexWhere((FrameModel f){
        return f.index == frame.index;
      });

      if (_index != -1){
        _output.removeAt(_index);
        _output.insert(_index, frame);
      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<FrameModel> assignPicToFrame({
    required List<FrameModel> frames,
    required Uint8List pic,
    required int index,
  }){
    List<FrameModel> _output = [...frames];

    FrameModel? _frame = getFrameByIndex(
        frames: frames,
        index: index,
    );

    if (_frame != null){

      _frame = _frame.copyWith(
        pic: pic,
      );

      _output = replaceFrame(
          frames: _output,
          frame: _frame,
      );

    }

    return _output;
  }
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static FrameModel? getNearestFrame({
    required List<FrameModel> frames,
    required double second,
    required bool ignoreEmptyPics,
  }){
    FrameModel? _output;

    if (Lister.checkCanLoop(frames) == true){

      double _smallestDifference = 1000000;

      for (final FrameModel frame in frames){

        if (ignoreEmptyPics == true && frame.pic == null){
          /// do nothing
        }
        else {

          final double _difference = Numeric.modulus(frame.second - second)!;

          if (_difference <= _smallestDifference){
            _smallestDifference = _difference;
            _output = frame;
          }
          if (_difference > _smallestDifference){
            break;
          }

        }

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static FrameModel? getFrameByIndex({
    required List<FrameModel> frames,
    required int index
  }){
    return frames.singleWhereOrNull((element) => element.index == index);
  }
  // -----------------------------------------------------------------------------

  /// CONCLUDERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int concludeNumberOfFrames({
    required int framesPerSecond,
    required double videoDurationInSeconds,
  }){
    return (videoDurationInSeconds * framesPerSecond).ceil();
  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkFramesAreIdentical({
    required FrameModel? frame1,
    required FrameModel? frame2,
  }){
    bool _identical = false;

    if (frame1 == null && frame2 == null){
      _identical = true;
    }
    else if (frame1 == null || frame2 == null){
      _identical = false;
    }
    else {

      if (
          frame1.index == frame2.index &&
          Lister.checkListsAreIdentical(list1: frame1.pic, list2: frame2.pic) == true &&
          frame1.second == frame2.second
      ){
        _identical = true;
      }

    }

    return _identical;
  }
  // --------------------
  @override
  String toString(){
    double? _kb = Filers.calculateSize(pic?.length, FileSizeUnit.kiloByte);
    _kb = Numeric.removeFractions(number: _kb);
    String _x = Numeric.stringifyDouble(_kb);
    _x = _x == '' ? '...' : '${_x}kb';
    return 'FrameModel(i: $index, s: $second, pic: $_x)';
  }
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is FrameModel){
      _areIdentical = checkFramesAreIdentical(
        frame1: this,
        frame2: other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      index.hashCode^
      pic.hashCode^
      second.hashCode;
// -----------------------------------------------------------------------------
}
