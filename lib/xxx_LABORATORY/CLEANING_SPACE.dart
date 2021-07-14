// Future<void> _deleteSlide() async {
//   print('DELETING STARTS AT : index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides ------------------------------------');
//
//   /// A - if slides are empty
//   if (_numberOfSlides == 0){
//     print('nothing can be done');
//   }
//
//   /// A - if slides are not empty
//   else {
//     print('_numberOfSlides was : $_numberOfSlides');
//
//     int _originalNumberOfSlides = _numberOfSlides;
//     int _decreasedNumberOfSlides = _numberOfSlides - 1;
//     int _originalIndex = _currentSlideIndex;
//     int _decreasedIndex = _currentSlideIndex == 0 ? 0 : _currentSlideIndex - 1;
//
//     setState(() {
//       _slidesVisibility[_currentSlideIndex] = !_slidesVisibility[_currentSlideIndex];
//       _numberOfSlides = _decreasedNumberOfSlides;
//       _currentSlideIndex = _decreasedIndex;
//     });
//
//     print('_numberOfSlides is : $_numberOfSlides');
//     print('_originalNumberOfSlides is : $_originalNumberOfSlides');
//
//     await Future.delayed(_fadingDuration, () async {
//       print('during visibility');
//
//       await Future.delayed(_fadingDurationX, () async {
//         print('after visibility with ${_fadingDurationX.inMilliseconds} millisecond');
//
//
//         SwipeDirection _slidingDecision = Sliders.slidingDecision(_originalNumberOfSlides, _originalIndex);
//
//         print('before sliding going ${_slidingDecision.toString()}');
//         await Sliders.slidingAction(_pageController, _originalNumberOfSlides, _originalIndex);
//
//         await Future.delayed(_slidingDurationX, () async {
//           print('after sliding with ${_slidingDurationX.inMilliseconds} millisecond, index : $_currentSlideIndex, _originalNumberOfSlides : $_originalNumberOfSlides');
//
//           // int _correctedIndex =
//           // _slidingDecision == SwipeDirection.back ? _currentSlideIndex + 1
//           //     :
//           // _slidingDecision == SwipeDirection.next ? _currentSlideIndex - 1
//           //     :
//           // _currentSlideIndex;
//
//           print('staring deleting at first slide, _originalIndex : $_originalIndex, _originalNumberOfSlides : $_originalNumberOfSlides');
//
//           setState(() {
//             _assetsAsFiles.removeAt(_originalIndex);
//             _assets.removeAt(_originalIndex);
//             _slidesVisibility.removeAt(_originalIndex);
//             _titleControllers.removeAt(_originalIndex);
//             _picsFits.removeAt(_originalIndex);
//             _matrixes.removeAt(_originalIndex);
//             // _numberOfSlides = _assets.length;
//             // _correctedIndex = _currentSlideIndex;
//           });
//
//           print('After deleting things : _originalNumberOfSlides : $_originalNumberOfSlides & _numberOfSlides : $_numberOfSlides');
//
//           // /// if were at first slide
//           // if(_currentSlideIndex == 0){
//           //   await Sliders.snapTo(_pageController, 0);
//           // }
//           // /// if were at last slide
//           // else if (_currentSlideIndex + 1  == _originalNumberOfSlides){
//           //   // await Sliders.snapTo(_pageController, _currentSlideIndex);
//           // }
//           // /// if were in a middle slide
//           // else {
//           //
//           // }
//
//           print('x -- after deleting at _currentSlideIndex : $_currentSlideIndex, _originalIndex : $_originalIndex, new numberOfSlides : $_numberOfSlides');
//
//
//
//         });
//
//       });
//
//     });
//
//   }
//
//   print('DELETING ENDS AT : index : $_currentSlideIndex, numberOfSlides : $_numberOfSlides ------------------------------------');
// }
