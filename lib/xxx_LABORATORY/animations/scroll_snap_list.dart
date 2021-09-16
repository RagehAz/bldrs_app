// import 'package:flutter/material.dart';
//
// Widget scrollSnapListExample(){
//   return
//     ScrollSnapList(
//       onItemFocus: onPageChangedIsOn ? (i) => _onPageChanged(i) : (i) => Sliders.zombie(i),
//       background: Colorz.Black255,
//       itemSize: _flyerBoxWidth,
//       duration: 100,
//       curve: Curves.easeIn,
//       endOfListTolerance: 5,
//       initialIndex: (widget.index * widget.flyerBoxWidth),
//       updateOnScroll: false,
//       scrollDirection: Axis.horizontal,
//       dynamicItemOpacity: 1,
//       dynamicItemSize: true,
//       focusOnItemTap: false,
//       focusToItem: (int i){
//         print('focusToItem : $i');
//       },
//       // dynamicSizeEquation: ,
//       listController: _pageController,
//       listViewKey: ValueKey(widget.key),
//       onReachEnd: (){
//         print('end reached');
//       },
//       dynamicSizeEquation: (double distance){
//
//         print('distance : $distance');
//         //Current scroll-position in pixel
//
//         double _shrinkScalePercentageTo = 90; // means by 10%
//
//         // double intendedPixel = _currentSlideIndex * widget.flyerBoxWidth;
//         // double difference = intendedPixel - distance;
//         return (1 - min(distance.abs() / (_shrinkScalePercentageTo * 10), 0.5));
//       },
//       selectedItemAnchor: SelectedItemAnchor.MIDDLE,
//       itemCount: _assets.length,
//       reverse: false,
//       itemBuilder: (ctx, i){
//         return
//           AnimatedOpacity(
//             key: ObjectKey(widget.draftFlyerModel.key.value + i),
//             opacity: _slidesVisibility[i] == true ? 1 : 0,
//             duration: Duration(milliseconds: 100),
//             child: SingleSlide(
//               key: ObjectKey(widget.draftFlyerModel.key.value + i),
//               flyerBoxWidth: _flyerBoxWidth,
//               flyerID: null, //_flyer.flyerID,
//               picture: _assetsAsFiles[i],//_currentSlides[index].picture,
//               slideMode: SlideMode.Editor,//slidesModes[index],
//               boxFit: _currentPicFit, // [fitWidth - contain - scaleDown] have the blur background
//               titleController: _titleControllers[i],
//               imageSize: _originalAssetSize,
//               textFieldOnChanged: (text){
//                 print('text is : $text');
//               },
//             ),
//           );
//       },
//     );
// }