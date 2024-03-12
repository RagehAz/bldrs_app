part of slide_video_editor;

class ThumbnailSlider extends StatefulWidget {
  const ThumbnailSlider({
    super.key,
    required this.controller,
    this.height = 60,
  });

  /// The [height] param specifies the height of the generated thumbnails
  final double height;

  final VideoEditorController controller;

  @override
  State<ThumbnailSlider> createState() => _ThumbnailSliderState();
}

class _ThumbnailSliderState extends State<ThumbnailSlider> {

  final ValueNotifier<Rect> _rect = ValueNotifier<Rect>(Rect.zero);
  final ValueNotifier<TransformData> _transform = ValueNotifier<TransformData>(const TransformData());

  /// The max width of [ThumbnailSlider]
  double _sliderWidth = 1.0;

  Size _layout = Size.zero;
  late Size _maxLayout = _calculateMaxLayout();

  /// The quantity of thumbnails to generate
  int _thumbnailsCount = 8;
  late int _neededThumbnails = _thumbnailsCount;

  late Stream<List<Uint8List>> _stream = (() => _generateThumbnails())();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scaleRect);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_scaleRect);
    _transform.dispose();
    _rect.dispose();
    super.dispose();
  }

  void _scaleRect() {
    _rect.value = _calculateCroppedRect(widget.controller, _layout);
    _maxLayout = _calculateMaxLayout();

    _transform.value = TransformData.fromRect(
      _rect.value,
      _layout,
      _maxLayout, // the maximum size to show the thumb
      widget.controller,
    );

    // regenerate thumbnails if need more to fit the slider
    _neededThumbnails = (_sliderWidth ~/ _maxLayout.width) + 1;
    if (_neededThumbnails > _thumbnailsCount) {
      _thumbnailsCount = _neededThumbnails;
      setState(() => _stream = _generateThumbnails());
    }
  }

  Stream<List<Uint8List>> _generateThumbnails() => _generateTrimThumbnails(
    widget.controller,
    quantity: _thumbnailsCount,
  );

  /// Returns the max size the layout should take with the rect value
  Size _calculateMaxLayout() {
    final ratio = _rect.value == Rect.zero
        ? widget.controller.video.value.aspectRatio
        : _rect.value.size.aspectRatio;

    // check if the ratio is almost 1
    if (_isNumberAlmost(ratio, 1)) return Size.square(widget.height);

    final size = Size(widget.height * ratio, widget.height);

    if (widget.controller.isRotated) {
      return Size(widget.height / ratio, widget.height);
    }
    return size;
  }

  /// Calculate crop [Rect] area
  /// depending of [controller] min and max crop values and the size of the layout
  Rect _calculateCroppedRect(
      VideoEditorController controller,
      Size layout, {
        Offset? min,
        Offset? max,
      }) {
    final Offset minCrop = min ?? controller.minCrop;
    final Offset maxCrop = max ?? controller.maxCrop;

    return Rect.fromPoints(
      Offset(minCrop.dx * layout.width, minCrop.dy * layout.height),
      Offset(maxCrop.dx * layout.width, maxCrop.dy * layout.height),
    );
  }

  /// Return `true` if the difference between [a] and [b] is less than `0.001`
  bool _isNumberAlmost(double a, int b) => nearEqual(a, b.toDouble(), 0.01);

  /// Return the best index to spread among the list [length] when limited to a [max] value
  /// When [max] is 0 or smaller than [length], returns [index]
  ///
  /// ```
  /// i.e = max=4, length=11
  /// index=0 => 1
  /// index=1 => 4
  /// index=2 => 7
  /// index=3 => 9
  /// ```
  int _getBestIndex(int max, int length, int index) =>
      max >= length || max == 0 ? index : 1 + (index * (length / max)).round();

  Stream<List<Uint8List>> _generateTrimThumbnails(
      VideoEditorController controller, {
        required int quantity,
      }) async* {
    final String path = controller.file.path;
    final double eachPart = controller.videoDuration.inMilliseconds / quantity;
    List<Uint8List> byteList = [];

    for (int i = 1; i <= quantity; i++) {
      try {
        final Uint8List? bytes = await VideoThumbnail.thumbnailData(
          imageFormat: ImageFormat.JPEG,
          video: path,
          timeMs: (eachPart * i).toInt(),
          quality: controller.trimThumbnailsQuality,
        );
        if (bytes != null) {
          byteList.add(bytes);
        }
      } catch (e) {
        debugPrint(e.toString());
      }

      yield byteList;
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (_, box) {

      _sliderWidth = box.maxWidth;

      return StreamBuilder<List<Uint8List>>(
        stream: _stream,
        builder: (_, snapshot) {
          final data = snapshot.data;

          return snapshot.hasData ?
          ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _neededThumbnails,
            itemBuilder: (_, i) => ValueListenableBuilder<TransformData>(
              valueListenable: _transform,
              builder: (_, transform, __) {

                final index = _getBestIndex(_neededThumbnails, data!.length, i);

                return Stack(
                  children: [

                    _buildSingleThumbnail(
                      data[0],
                      transform,
                      isPlaceholder: true,
                    ),

                    if (index < data.length)
                      _buildSingleThumbnail(
                        data[index],
                        transform,
                        isPlaceholder: false,
                      ),

                  ],
                );
              },
            ),
          )
              :
          const SizedBox();
        },
      );
    });
  }

  Widget _buildSingleThumbnail(
      Uint8List bytes,
      TransformData transform, {
        required bool isPlaceholder,
      }) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(_maxLayout),
      child: CropTransform(
        transform: transform,
        child: ImageViewer(
          controller: widget.controller,
          bytes: bytes,
          fadeIn: !isPlaceholder,
          child: LayoutBuilder(builder: (_, constraints) {
            final size = constraints.biggest;
            if (!isPlaceholder && _layout != size) {
              _layout = size;
              // init the widget with controller values
              WidgetsBinding.instance.addPostFrameCallback((_) => _scaleRect());
            }

            return RepaintBoundary(
              child: CustomPaint(
                size: Size.infinite,
                painter: CropGridPainter(
                  _rect.value,
                  showGrid: false,
                  style: widget.controller.cropStyle,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

const kDefaultSelectedColor = Color(0xffffcc00);


// /// Returns a desired dimension of [layout] that respect [r] aspect ratio
// Size _computeSizeWithRatio(Size layout, double r) {
//   if (layout.aspectRatio == r) {
//     return layout;
//   }
//
//   if (layout.aspectRatio > r) {
//     return Size(layout.height * r, layout.height);
//   }
//
//   if (layout.aspectRatio < r) {
//     return Size(layout.width, layout.width / r);
//   }
//
//   assert(false, 'An error occured while computing the aspectRatio');
//   return Size.zero;
// }

// /// Returns a new crop [Rect] that respect [r] aspect ratio
// /// inside a [layout] and based on an existing [crop] area
// ///
// /// This rect must not become smaller and smaller, or be out of bounds from [layout]
// Rect _resizeCropToRatio(Size layout, Rect crop, double r) {
//   // if target ratio is smaller than current crop ratio
//   if (r < crop.size.aspectRatio) {
//     // use longest crop side if smaller than layout longest side
//     final maxSide = min(crop.longestSide, layout.shortestSide);
//     // to calculate the ratio of the new crop area
//     final size = Size(maxSide, maxSide / r);
//
//     final rect = Rect.fromCenter(
//       center: crop.center,
//       width: size.width,
//       height: size.height,
//     );
//
//     // if res is smaller than layout we can return it
//     if (rect.size <= layout) return _translateRectIntoBounds(layout, rect);
//   }
//
//   // if there is not enough space crop to the middle of the current [crop]
//   final newCenteredCrop = _computeSizeWithRatio(crop.size, r);
//   final rect = Rect.fromCenter(
//     center: crop.center,
//     width: newCenteredCrop.width,
//     height: newCenteredCrop.height,
//   );
//
//   // return rect into bounds
//   return _translateRectIntoBounds(layout, rect);
// }

// /// Returns a translated [Rect] that fit [layout] size
// Rect _translateRectIntoBounds(Size layout, Rect rect) {
//   final double translateX = (rect.left < 0 ? rect.left.abs() : 0) +
//       (rect.right > layout.width ? layout.width - rect.right : 0);
//   final double translateY = (rect.top < 0 ? rect.top.abs() : 0) +
//       (rect.bottom > layout.height ? layout.height - rect.bottom : 0);
//
//   if (translateX != 0 || translateY != 0) {
//     return rect.translate(translateX, translateY);
//   }
//
//   return rect;
// }

// /// Return the scale for [rect] to fit [layout]
// double _scaleToSize(Size layout, Rect rect) =>
//     min(layout.width / rect.width, layout.height / rect.height);
//
// /// Return the scale for [rect] to not be smaller [layout]
// double _scaleToSizeMax(Size layout, Rect rect) =>
//     max(layout.width / rect.width, layout.height / rect.height);


// /// Returns `true` if [rect] is left and top are bigger than 0
// /// and if right and bottom are smaller than [size] width and height
// bool _isRectContained(Size size, Rect rect) =>
//     rect.left >= 0 &&
//         rect.top >= 0 &&
//         rect.right <= size.width &&
//         rect.bottom <= size.height;
//
// /// Returns opposite aspect ratio
// ///
// /// ```
// /// i.e
// /// ratio=4/5 => 5/4
// /// ratio=5/4 => 4/5
// /// ratio=9/16 => 16/9
// /// ratio=1 => 1
// /// ```
// double _getOppositeRatio(double ratio) => 1 / ratio;


// /// Generate a cover at [timeMs] in video
// ///
// /// Returns a [CoverData] depending on [timeMs] milliseconds
// Future<CoverData> _generateSingleCoverThumbnail(
//     String filePath, {
//       int timeMs = 0,
//       int quality = 10,
//     }) async {
//   final Uint8List? thumbData = await VideoThumbnail.thumbnailData(
//     imageFormat: ImageFormat.JPEG,
//     video: filePath,
//     timeMs: timeMs,
//     quality: quality,
//   );
//
//   return CoverData(thumbData: thumbData, timeMs: timeMs);
// }


// Stream<List<CoverData>> _generateCoverThumbnails(
//     VideoEditorController controller, {
//       required int quantity,
//     }) async* {
//   final int duration = controller.isTrimmed
//       ? controller.trimmedDuration.inMilliseconds
//       : controller.videoDuration.inMilliseconds;
//   final double eachPart = duration / quantity;
//   List<CoverData> byteList = [];
//
//   for (int i = 0; i < quantity; i++) {
//     try {
//       final CoverData bytes = await _generateSingleCoverThumbnail(
//         controller.file.path,
//         timeMs: (controller.isTrimmed
//             ? (eachPart * i) + controller.startTrim.inMilliseconds
//             : (eachPart * i))
//             .toInt(),
//         quality: controller.coverThumbnailsQuality,
//       );
//
//       if (bytes.thumbData != null) {
//         byteList.add(bytes);
//       }
//     } catch (e) {
//       debugPrint(e.toString());
//     }
//
//     yield byteList;
//   }
// }
