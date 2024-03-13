// part of slide_video_editor;
//
// enum _TrimBoundaries { left, right, inside, progress }
//
// class VideoEditorTrimPanel extends StatefulWidget {
//   // --------------------------------------------------------------------------
//   const VideoEditorTrimPanel({
//     required this.controller,
//     required this.scrollController,
//     super.key
//   });
//   // --------------------
//   final VideoEditorController controller;
//   final ScrollController scrollController;
//   // --------------------
//   @override
//   State<VideoEditorTrimPanel> createState() => _VideoEditorTrimPanelState();
//   // --------------------------------------------------------------------------
// }
//
// class _VideoEditorTrimPanelState extends State<VideoEditorTrimPanel> with AutomaticKeepAliveClientMixin<VideoEditorTrimPanel> {
//   // --------------------------------------------------------------------------
//   @override
//   bool get wantKeepAlive => true;
//   // --------------------------------------------------------------------------
//   final double _height = 60;
//   // --------------------
//   final double _touchMargin = 24.0;
//   // --------------------
//   _TrimBoundaries? _boundary;
//   // --------------------
//   /// Set to `true` if the video was playing before the gesture
//   bool _isVideoPlayerHold = false;
//   // --------------------
//   /// Value of [widget.controller.trimPosition] precomputed by local change
//   /// When scrolling the view fast the position can get out of synch
//   /// using this param on local change fixes the issue
//   double? _preComputedVideoPosition;
//   // --------------------
//   Rect _rect = Rect.zero;
//   Size _trimLayout = Size.zero;
//   Size _fullLayout = Size.zero;
//   // --------------------
//   /// Horizontal margin around the [ThumbnailSlider]
//   late final double _horizontalMargin = 0 + widget.controller.trimStyle.edgeWidth;
//   // --------------------
//   late final _viewportRatio = min(
//     2.5, // widget.maxViewportRatio,
//     widget.controller.videoDuration.inMilliseconds / widget.controller.maxDuration.inMilliseconds,
//   );
//   // --------------------
//   late final _isExtendTrim = _viewportRatio > 1;
//   // --------------------
//   /// Edges touch margin come from it size, but minimum is [margin]
//   late final _edgesTouchMargin = max(widget.controller.trimStyle.edgeWidth, _touchMargin);
//   // --------------------
//   /// Position line touch margin come from it size, but minimum is [margin]
//   late final _positionTouchMargin = max(widget.controller.trimStyle.positionLineWidth, _touchMargin);
//   // --------------------
//   late final ScrollController _scrollController;
//   // --------------------
//   /// The distance of rect left side to the left of the scroll view before bouncing
//   double? _preSynchLeft;
//   // --------------------
//   /// The distance of rect right side to the right of the scroll view before bouncing
//   double? _preSynchRight;
//   // --------------------
//   /// Save last [_scrollController] pixels position before the bounce animation starts
//   double? _lastScrollPixelsBeforeBounce;
//   // --------------------
//   /// Save last [_scrollController] pixels position
//   double _lastScrollPixels = 0;
//   // --------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     _scrollController = widget.scrollController;
//
//     widget.controller.addListener(_updateTrim);
//
//     if (_isExtendTrim == true){
//       _scrollController.addListener(attachTrimToScroll);
//     }
//
//   }
//   // --------------------
//   @override
//   void dispose() {
//
//     widget.controller.removeListener(_updateTrim);
//
//     if (_isExtendTrim){
//       _scrollController.removeListener(attachTrimToScroll);
//     }
//
//     // _scrollController.dispose();
//
//     super.dispose();
//   }
//   // --------------------------------------------------------------------------
//   /// Returns the [Rect] side position (left or rect) in a range between 0 and 1
//   double _getRectToTrim(double rectVal) => (rectVal + _scrollController.offset - _horizontalMargin) / _fullLayout.width;
//   // --------------------
//   /// Convert the controller trim value into the trim slider view size
//   double _geTrimToRect(double trimVal) => (_fullLayout.width * trimVal) + _horizontalMargin;
//   // --------------------
//   /// Distance of scroll bounce on the right
//   double get _bounceRightOffset => (_scrollController.position.maxScrollExtent - _scrollController.offset).abs();
//   // --------------------
//   /// Returns `false` if the scroll controller is currently bouncing back
//   /// to reach either the min scroll extent or the max scroll extent
//   bool get isNotScrollBouncingBack {
//     final isBouncingFromLeft = _scrollController.offset < _scrollController.position.minScrollExtent && _scrollController.offset > _lastScrollPixels;
//     final isBouncingFromRight = _scrollController.offset > _scrollController.position.maxScrollExtent && _scrollController.offset < _lastScrollPixels;
//     return !(isBouncingFromLeft || isBouncingFromRight);
//   }
//   // --------------------
//   /// Update [_rect] and the view when controller is updated
//   void _updateTrim() {
//     if (widget.controller.minTrim != _getRectToTrim(_rect.left) || widget.controller.maxTrim != _getRectToTrim(_rect.right)) {
//       // if trim slider is extended, set rect based on viewport with left at minimum position
//       if (_isExtendTrim) {
//         setState(() {
//           _rect = Rect.fromLTWH(
//               _horizontalMargin,
//               _rect.top,
//               _geTrimToRect(widget.controller.maxTrim) - _geTrimToRect(widget.controller.minTrim),
//               _rect.height
//           );
//         });
//         // then update scroll controller to align the thumbnails with the new trim
//         _scrollController.jumpTo(_geTrimToRect(widget.controller.minTrim) - _horizontalMargin);
//       }
//
//       else {
//         // if the trim slider is not extended, set rect based on layout width
//         setState(() {
//           _rect = Rect.fromLTRB(
//               _geTrimToRect(widget.controller.minTrim),
//               _rect.top,
//               _geTrimToRect(widget.controller.maxTrim),
//               _rect.height);
//         });
//       }
//
//       _resetControllerPosition();
//     }
//   }
//   // --------------------
//   /// Scroll to update [_rect] and trim values on scroll
//   /// Will fix [_rect] to the scroll view when it is bouncing
//   void attachTrimToScroll() {
//     if (_scrollController.position.outOfRange == false) {
//       // the last scroll position is ommited (when outOfRange == false)
//       // because of that the last rect position after bouncing is inaccurate
//       // it causes that minTrim 0.0 and maxTrim 1.0 are never reach
//       // adding to the rect the difference between current scroll position and the last one fixes it
//
//       if (_scrollController.offset == 0.0) {
//         _changeTrimRect(
//           left: _rect.left - _lastScrollPixels.abs(),
//           updateTrim: false,
//         );
//       }
//
//       else if (_scrollController.offset == _scrollController.position.maxScrollExtent) {
//         _changeTrimRect(
//           left: _rect.left + (_lastScrollPixels.abs() - _scrollController.offset),
//           updateTrim: false,
//         );
//       }
//       _updateControllerTrim();
//       _preSynchLeft = null;
//       _preSynchRight = null;
//       _lastScrollPixelsBeforeBounce = null;
//       _lastScrollPixels = _scrollController.offset;
//       return;
//     }
//
//     // if is not bouncing save position
//     if (isNotScrollBouncingBack) {
//       // use last scroll position because isScrollingNotifier is updated after the max bounce position is set
//       _lastScrollPixelsBeforeBounce = _scrollController.offset;
//     } else {
//       // on the left side
//       if (_scrollController.position.extentBefore == 0.0 &&
//           _preSynchLeft == null) {
//         _preSynchLeft = max(
//           0,
//           _rect.left -
//               _horizontalMargin -
//               (_lastScrollPixelsBeforeBounce ?? _scrollController.offset).abs(),
//         );
//         // on the right side
//       } else if (_scrollController.position.extentAfter == 0.0 &&
//           _preSynchRight == null) {
//         final scrollOffset = (_scrollController.position.maxScrollExtent -
//             (_lastScrollPixelsBeforeBounce ?? _scrollController.offset))
//             .abs();
//         _preSynchRight = max(
//           0,
//           _trimLayout.width - (_rect.right - _horizontalMargin) - scrollOffset,
//         );
//       }
//       _lastScrollPixelsBeforeBounce = null;
//     }
//
//     // distance of rect to right side
//     final rectRightOffset = _trimLayout.width - (_rect.right - _horizontalMargin);
//
//     // if view is bouncing on the right side
//     if (_scrollController.position.extentAfter == 0.0 &&
//         (_preSynchRight != null || _bounceRightOffset > rectRightOffset)) {
//       _changeTrimRect(
//         left: _trimLayout.width -
//             _bounceRightOffset -
//             _rect.width +
//             _horizontalMargin -
//             (_preSynchRight ?? 0),
//         updateTrim: false,
//       );
//       // if view is bouncing on the left side
//     } else if (_scrollController.position.extentBefore == 0.0 &&
//         (_preSynchLeft != null ||
//             _scrollController.offset.abs() + _horizontalMargin > _rect.left)) {
//       _changeTrimRect(
//         left: -_scrollController.offset +
//             _horizontalMargin +
//             (_preSynchLeft ?? 0),
//         updateTrim: false,
//       );
//     }
//
//     // update trim and video position
//     _updateControllerTrim();
//     _lastScrollPixels = _scrollController.offset;
//   }
//   // --------------------------------------------------------------------------
//
//   /// GESTURES
//
//   // --------------------
//   void _onHorizontalDragStart(DragStartDetails details) {
//     final pos = details.localPosition;
//     final progressTrim = _getVideoPosition();
//
//     // Left, right and video progress indicator touch areas
//     Rect leftTouch = Rect.fromCenter(
//       center: Offset(_rect.left - _edgesTouchMargin / 2, _rect.height / 2),
//       width: _edgesTouchMargin,
//       height: _rect.height,
//     );
//     Rect rightTouch = Rect.fromCenter(
//       center: Offset(_rect.right + _edgesTouchMargin / 2, _rect.height / 2),
//       width: _edgesTouchMargin,
//       height: _rect.height,
//     );
//     final progressTouch = Rect.fromCenter(
//       center: Offset(progressTrim, _rect.height / 2),
//       width: _positionTouchMargin,
//       height: _rect.height,
//     );
//
//     // if the scroll view is touched, it will be by default an inside gesture
//     _boundary = _TrimBoundaries.inside;
//
//     /// boundary should not be set to other that inside when scroll controller is moving
//     /// it would lead to weird behavior to change position while scrolling
//     if (isNotScrollBouncingBack &&
//         !_scrollController.position.isScrollingNotifier.value) {
//       if (progressTouch.contains(pos)) {
//         // video indicator should have the higher priority since it does not affect the trim param
//         _boundary = _TrimBoundaries.progress;
//       } else {
//         // if video indicator is not touched, expand [leftTouch] and [rightTouch] on the inside
//         leftTouch = leftTouch.expandToInclude(
//             Rect.fromLTWH(_rect.left, 0, _edgesTouchMargin, 1));
//         rightTouch = rightTouch.expandToInclude(Rect.fromLTWH(
//             _rect.right - _edgesTouchMargin, 0, _edgesTouchMargin, 1));
//       }
//
//       if (leftTouch.contains(pos)) {
//         _boundary = _TrimBoundaries.left;
//       } else if (rightTouch.contains(pos)) {
//         _boundary = _TrimBoundaries.right;
//       }
//     }
//
//     _updateControllerIsTrimming(true);
//   }
//   // --------------------
//   void _onHorizontalDragUpdate(DragUpdateDetails details) {
//     final Offset delta = details.delta;
//     final posLeft = _rect.topLeft + delta;
//
//     switch (_boundary) {
//       case _TrimBoundaries.left:
//         final clampLeft = posLeft.dx.clamp(_horizontalMargin, _rect.right);
//         // avoid rect to be out of bounds & avoid minTrim to be bigger than maxTrim
//         _changeTrimRect(
//             left: clampLeft,
//             width: _rect.width - (clampLeft - posLeft.dx).abs() - delta.dx);
//         break;
//       case _TrimBoundaries.right:
//       // avoid rect to be out of bounds & maxTrim to be smaller than minTrim
//         _changeTrimRect(
//           width: (_rect.left + _rect.width + delta.dx)
//               .clamp(_rect.left, _trimLayout.width + _horizontalMargin) -
//               _rect.left,
//         );
//         break;
//       case _TrimBoundaries.inside:
//         if (_isExtendTrim) {
//           _scrollController.position.moveTo(
//             _scrollController.offset - delta.dx,
//             clamp: false,
//           );
//         } else {
//           // avoid rect to be out of bounds
//           _changeTrimRect(
//             left: posLeft.dx.clamp(
//               _horizontalMargin,
//               _trimLayout.width + _horizontalMargin - _rect.width,
//             ),
//           );
//         }
//         break;
//       case _TrimBoundaries.progress:
//         final pos = details.localPosition.dx;
//         // postion of pos on the layout width between 0 and 1
//         final localRatio = pos / (_trimLayout.width + _horizontalMargin * 2);
//         // because the video progress cursor is on a different layout context (horizontal margin are not applied)
//         // the gesture offset must be adjusted (remove margin when localRatio < 0.5 and add margin when localRatio > 0.5)
//         final localAdjust = (localRatio - 0.5) * (_horizontalMargin * 2);
//         _controllerSeekTo((pos + localAdjust).clamp(
//           _rect.left - _horizontalMargin,
//           _rect.right + _horizontalMargin,
//         ));
//         break;
//       default:
//         break;
//     }
//   }
//   // --------------------
//   void _onHorizontalDragEnd([_]) {
//     _preComputedVideoPosition = null;
//     _updateControllerIsTrimming(false);
//     if (_boundary == null) return;
//     if (_boundary != _TrimBoundaries.progress) {
//       _updateControllerTrim();
//     }
//   }
//   // --------------------------------------------------------------------------
//
//   /// RECT
//
//   // --------------------
//   void _changeTrimRect({
//     double? left,
//     double? width,
//     bool updateTrim = true
//   }) {
//
//     double _left = left ?? _rect.left;
//     double _width = max(0, width ?? _rect.width);
//
//     // if [left] and [width] params does not respect the min and max duration set in the controller
//     // reduce the trimmed area to respect it
//     final Duration diff = _getDurationDiff(_left, _width);
//
//     if (diff < widget.controller.minDuration || diff > widget.controller.maxDuration) {
//
//       if (_boundary == _TrimBoundaries.left) {
//
//         final limitLeft = _left.clamp(
//             _left + _width - _getRectWidthFromDuration(widget.controller.maxDuration),
//             _left + _width - _getRectWidthFromDuration(widget.controller.minDuration)
//         );
//
//         _width += _left - limitLeft;
//         _left = limitLeft;
//       }
//
//       else if (_boundary == _TrimBoundaries.right) {
//         _width = _width.clamp(
//           _getRectWidthFromDuration(widget.controller.minDuration),
//           _getRectWidthFromDuration(widget.controller.maxDuration),
//         );
//       }
//
//     }
//
//     bool shouldHaptic = _canDoHaptic(_left, _width);
//
//     if (updateTrim) {
//       _rect = Rect.fromLTWH(_left, _rect.top, _width, _rect.height);
//       _updateControllerTrim();
//     }
//
//     else {
//       setState(() => _rect = Rect.fromLTWH(left!, _rect.top, width!, _rect.height));
//     }
//
//     // if left edge or right edge is touched, vibrate
//     if (shouldHaptic){
//       HapticFeedback.lightImpact();
//     }
//
//   }
//   // --------------------
//   void _createTrimRect() {
//     _rect = Rect.fromPoints(
//       Offset(widget.controller.minTrim * _fullLayout.width, 0.0),
//       Offset(widget.controller.maxTrim * _fullLayout.width, _height),
//     ).shift(Offset(_horizontalMargin, 0));
//   }
//   // --------------------------------------------------------------------------
//
//   /// MISC
//
//   // --------------------
//   /// Reset the video cursor position to fit the rect
//   Future<void> _resetControllerPosition() async {
//
//     if (_boundary == _TrimBoundaries.progress){
//
//     }
//     /// if the left side changed and overtake the current postion
//     else if (_boundary == null || _boundary == _TrimBoundaries.inside || _boundary == _TrimBoundaries.left) {
//       // reset position to startTrim
//       _preComputedVideoPosition = _rect.left;
//       await widget.controller.video.seekTo(widget.controller.startTrim);
//     }
//
//     else if (_boundary == _TrimBoundaries.right) {
//       // or if the right side changed and is under the current postion, reset position to endTrim
//       // substract 10 milliseconds to avoid the video to loop and to show startTrim
//       _preComputedVideoPosition = _rect.right;
//       await widget.controller.video.seekTo(widget.controller.endTrim);
//     }
//
//   }
//   // --------------------
//   /// Sets the video's current timestamp to be at the [position] on the slider
//   /// If the expected position is bigger than [controller.endTrim], set it to [controller.endTrim]
//   Future<void> _controllerSeekTo(double position) async {
//
//     _preComputedVideoPosition = null;
//     final to = widget.controller.videoDuration * ((position + _scrollController.offset) / (_fullLayout.width + _horizontalMargin * 2));
//     await widget.controller.video.seekTo(to > widget.controller.endTrim ? widget.controller.endTrim : to);
//
//   }
//   // --------------------
//   void _updateControllerTrim() {
//     widget.controller.updateTrim(
//       _getRectToTrim(_rect.left),
//       _getRectToTrim(_rect.right),
//     );
//     _resetControllerPosition();
//   }
//   // --------------------
//   void _updateControllerIsTrimming(bool value) {
//     if (value && widget.controller.isPlaying) {
//       _isVideoPlayerHold = true;
//       widget.controller.video.pause();
//     } else if (_isVideoPlayerHold) {
//       _isVideoPlayerHold = false;
//       widget.controller.video.play();
//     }
//
//     if (_boundary != _TrimBoundaries.progress) {
//       widget.controller.isTrimming = value;
//     }
//     if (value == false) {
//       _boundary = null;
//     }
//   }
//   // --------------------
//   /// Returns the video position in the layout
//   /// NOTE : Using function instead of getter seems faster when grabbing the cursor
//   double _getVideoPosition() => _preComputedVideoPosition ?? (_fullLayout.width * widget.controller.trimPosition - _scrollController.offset + _horizontalMargin);
//   // --------------------
//   Duration _getDurationDiff(double left, double width) {
//     final double min = (left - _horizontalMargin) / _fullLayout.width;
//     final double max = (left + width - _horizontalMargin) / _fullLayout.width;
//     final Duration duration = widget.controller.videoDuration;
//     return (duration * max) - (duration * min);
//   }
//   // --------------------
//   /// Returns `true` if trimmed rect is touching an edge and it was not the case before
//   bool _canDoHaptic(double left, double width) {
//
//     if (isNotScrollBouncingBack == false){
//       return false;
//     }
//
//     else {
//
//       final checkLastSize = _boundary != null && _boundary != _TrimBoundaries.inside;
//
//       final isNotMin =
//           _rect.left != (_horizontalMargin + (checkLastSize ? 0 : _lastScrollPixels.abs()))
//           &&
//           widget.controller.minTrim > 0.0
//           &&
//           (checkLastSize ? left < _rect.left : true);
//
//       final isNotMax = _rect.right != _trimLayout.width + _horizontalMargin
//           &&
//           widget.controller.maxTrim < 1.0
//           &&
//           (checkLastSize ? (left + width) > _rect.right : true);
//
//       final isOnLeftEdge = (_scrollController.offset.abs() + _horizontalMargin - left).abs() < 1.0;
//
//       final isOnRightEdge = (_bounceRightOffset + left + width - _trimLayout.width - _horizontalMargin).abs() < 1.0;
//
//       return (isNotMin && isOnLeftEdge) || (isNotMax && isOnRightEdge);
//
//     }
//
//   }
//   // --------------------
//   /// Returns the width of a [Rect] in the slider that should represents the [duration]
//   double _getRectWidthFromDuration(Duration duration) =>
//       duration > Duration.zero
//           ? _fullLayout.width /
//           (widget.controller.videoDuration.inMilliseconds /
//               duration.inMilliseconds)
//           : 0.0;
//   // --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     super.build(context);
//     // --------------------
//     final double _screenWidth = Scale.screenWidth(context);
//     const double _panelHeight = VideoEditorScales.editorPanelHeight;
//     // --------------------
//     return Container(
//       width: _screenWidth - 40,
//       height: _panelHeight,
//       color: Colorz.bloodTest,
//       child: LayoutBuilder(
//           builder: (_, constraint) {
//
//             final Size trimLayout = Size(
//               constraint.maxWidth - _horizontalMargin * 2,
//               constraint.maxHeight,
//             );
//
//             _fullLayout = Size(
//               trimLayout.width * (_isExtendTrim ? _viewportRatio : 1),
//               constraint.maxHeight,
//             );
//
//             if (_trimLayout != trimLayout) {
//               _trimLayout = trimLayout;
//               _createTrimRect();
//             }
//
//
//             return SizedBox(
//                 width: _fullLayout.width,
//                 child: Stack(
//                     children: [
//
//                       /// TIMELINE SNAPSHOTS
//                       NotificationListener<ScrollNotification>(
//                         onNotification: (scrollNotification) {
//                           if (_boundary == null) {
//                             if (scrollNotification is ScrollStartNotification) {
//                               _updateControllerIsTrimming(true);
//                             } else if (scrollNotification is ScrollEndNotification) {
//                               _onHorizontalDragEnd();
//                             }
//                           }
//                           return true;
//                           },
//                         child: SingleChildScrollView(
//                           controller: _scrollController,
//                           physics: const BouncingScrollPhysics(),
//                           scrollDirection: Axis.horizontal,
//                           child: Padding(
//                             padding: EdgeInsets.symmetric(horizontal: _horizontalMargin),
//                             child: Column(
//                               children: [
//
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(
//                                     widget.controller.trimStyle.borderRadius,
//                                   ),
//                                   child: SizedBox(
//                                     height: _height,
//                                     width: _fullLayout.width,
//                                     child: ThumbnailSlider(
//                                       controller: widget.controller,
//                                       height: _height,
//                                     ),
//                                   ),
//                                 ),
//
//                                 /// THE TIMELINE WAS PLACED HERE
//                                 // if (widget.child != null)
//                                 //   SizedBox(width: _fullLayout.width, child: widget.child),
//
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       /// TIMELINE FRAME
//                       GestureDetector(
//                         onHorizontalDragStart: _onHorizontalDragStart,
//                         onHorizontalDragUpdate: _onHorizontalDragUpdate,
//                         onHorizontalDragEnd: _onHorizontalDragEnd,
//                         behavior: HitTestBehavior.opaque,
//                         child: AnimatedBuilder(
//                           animation: Listenable.merge([
//                             widget.controller,
//                             widget.controller.video,
//                           ]),
//                           builder: (_, __) {
//
//                             return RepaintBoundary(
//                               child: CustomPaint(
//                                 size: Size.fromHeight(_height),
//                                 painter: TrimSliderPainter(
//                                   _rect,
//                                   _getVideoPosition(),
//                                   widget.controller.trimStyle,
//                                   isTrimming: widget.controller.isTrimming,
//                                   isTrimmed: widget.controller.isTrimmed,
//                                 ),
//                               ),
//                             );
//
//                             },
//                         ),
//                       ),
//
//                     ]
//                 )
//             );
//           }
//           ),
//     );
//     // --------------------
//   }
//   // --------------------------------------------------------------------------
// }
