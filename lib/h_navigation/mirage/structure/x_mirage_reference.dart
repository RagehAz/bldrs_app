/// KEPT FOR REFERENCE
// import 'package:basics/bldrs_theme/classes/colorz.dart';
// import 'package:basics/helpers/checks/tracers.dart';
// import 'package:basics/helpers/space/scale.dart';
// import 'package:bldrs/z_components/blur/blur_layer.dart';
// import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
// import 'package:bldrs/z_components/layouts/pyramids/pyramids.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs_dashboard/b_modules/ui_manager/layout/mirage/khufu.dart';
// import 'package:flutter/material.dart';
//
// class Mirage extends StatefulWidget {
//   // --------------------------------------------------------------------------
//   const Mirage({
//     super.key
//   });
//   // --------------------
//   ///
//   // --------------------
//   @override
//   _MirageState createState() => _MirageState();
// // --------------------------------------------------------------------------
// }
//
// class _MirageState extends State<Mirage> {
//   // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//   }
//   // --------------------
//   bool _isInit = true;
//   @override
//   void didChangeDependencies() {
//
//     if (_isInit && mounted) {
//       _isInit = false; // good
//
//       asyncInSync(() async {
//
//       });
//
//     }
//     super.didChangeDependencies();
//   }
//   // --------------------
//   /*
//   @override
//   void didUpdateWidget(TheStatefulScreen oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.thing != widget.thing) {
//       unawaited(_doStuff());
//     }
//   }
//    */
//   // --------------------
//   @override
//   void dispose() {
//     _pyramidIsOn.dispose();
//     _strip1Position.dispose();
//     super.dispose();
//   }
//   // -----------------------------------------------------------------------------
//
//   /// PYRAMID CONTROLS
//
//   // --------------------
//   final ValueNotifier<bool> _pyramidIsOn = ValueNotifier(true);
//   static const double _pyramidHeight = Pyramids.khafreHeight;
//   // --------------------
//   void _showPyramid(){
//     setNotifier(notifier: _pyramidIsOn, mounted: mounted, value: true);
//   }
//   // --------------------
//   void _hidePyramid(){
//     setNotifier(notifier: _pyramidIsOn, mounted: mounted, value: false);
//   }
//   // -----------------------------------------------------------------------------
//   void _onPyramidTap(){
//
//
//     if (_pyramidIsOn.value == true){
//
//       /// HIDE PYRAMID
//       _hidePyramid();
//
//       /// SHOW STRIP
//       _showStrip1();
//
//     }
//
//     else {
//
//       /// SHOW PYRAMID
//       _showPyramid();
//
//       /// HIDE STRIP
//       _hideStrip2();
//
//     }
//
//     // setNotifier(notifier: notifier, mounted: mounted, value: value)
//     //
//     // setState(() {
//     //   _pyramidIsOn = ! _pyramidIsOn;
//     // });
//
//     // if (_pyramidIsOn == true){
//     //   _closeSheet();
//     // }
//     // else {
//     //   _snapToInitialPosition();
//     // }
//   }
//   // -----------------------------------------------------------------------------
//
//   /// STRIP 1 CONTROLS
//
//   // --------------------
//   final ValueNotifier<double> _strip1Position = ValueNotifier(strip1Height);
//   static const double strip1Height = _pyramidHeight;
//   static const double strip1ExitLimit = strip1Height * 0.25;
//   // --------------------
//   void _showStrip1(){
//     setNotifier(
//       notifier: _strip1Position,
//       mounted: mounted,
//       value: 0.0,
//     );
//   }
//   // --------------------
//   void _hideStrip1(){
//     setNotifier(
//       notifier: _strip1Position,
//       mounted: mounted,
//       value: strip1Height,
//     );
//   }
//   // --------------------
//   void _onDragStrip1Update(DragUpdateDetails details) {
//
//     final double newPosition = (_strip1Position.value + details.primaryDelta!).clamp(0.0, strip1Height);
//
//     setNotifier(
//       notifier: _strip1Position,
//       mounted: mounted,
//       value: newPosition,
//     );
//
//     if (newPosition > strip1ExitLimit) {
//       _showPyramid();
//       _hideStrip1();
//       _hideStrip2();
//       _hideStrip3();
//       _hideStrip4();
//       _hideStrip5();
//     }
//
//   }
//   // --------------------
//   void _onDragStrip1End(DragEndDetails details) {
//
//     if (_strip1Position.value <= strip1ExitLimit) {
//       _showStrip1();
//       _hidePyramid();
//     }
//     else {
//       _hideStrip1();
//       _showPyramid();
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// STRIP 2 CONTROLS
//
//   // --------------------
//   final ValueNotifier<double> _strip2Position = ValueNotifier(strip2Height);
//   static const double strip2Height = _pyramidHeight * 2.2;
//   static const double strip2ExitLimit = _pyramidHeight * 0.5;
//   // --------------------
//   void _showStrip2(){
//     setNotifier(
//       notifier: _strip2Position,
//       mounted: mounted,
//       value: 0.0,
//     );
//   }
//   // --------------------
//   void _hideStrip2(){
//
//     setNotifier(
//       notifier: _strip2Position,
//       mounted: mounted,
//       value: strip2Height,
//     );
//
//   }
//   // --------------------
//   void _onDragStrip2Update(DragUpdateDetails details) {
//
//     final double newPosition = (_strip2Position.value + details.primaryDelta!).clamp(0.0, strip2Height);
//
//     setNotifier(
//       notifier: _strip2Position,
//       mounted: mounted,
//       value: newPosition,
//     );
//
//     if (newPosition > strip2ExitLimit) {
//       _hideStrip2();
//       _hideStrip3();
//       _hideStrip4();
//       _hideStrip5();
//     }
//
//   }
//   // --------------------
//   void _onDragStrip2End(DragEndDetails details) {
//     if (_strip2Position.value <= strip2ExitLimit) {
//       _showStrip2();
//     }
//     else {
//       _hideStrip2();
//     }
//   }
//   // -----------------------------------------------------------------------------
//
//   /// STRIP 3 CONTROLS
//
//   // --------------------
//   final ValueNotifier<double> _strip3Position = ValueNotifier(strip3Height);
//   static const double strip3Height = _pyramidHeight * 3.3;
//   static const double strip3ExitLimit = _pyramidHeight * 0.5;
//   // --------------------
//   void _showStrip3(){
//     setNotifier(
//       notifier: _strip3Position,
//       mounted: mounted,
//       value: 0.0,
//     );
//   }
//   // --------------------
//   void _hideStrip3(){
//     setNotifier(
//       notifier: _strip3Position,
//       mounted: mounted,
//       value: strip3Height,
//     );
//   }
//   // --------------------
//   void _onDragStrip3Update(DragUpdateDetails details) {
//
//     final double newPosition = (_strip3Position.value + details.primaryDelta!).clamp(0.0, strip3Height);
//
//     setNotifier(
//       notifier: _strip3Position,
//       mounted: mounted,
//       value: newPosition,
//     );
//
//     if (newPosition > strip3ExitLimit) {
//       _hideStrip3();
//       _hideStrip4();
//       _hideStrip5();
//     }
//
//   }
//   // --------------------
//   void _onDragStrip3End(DragEndDetails details) {
//     if (_strip3Position.value <= strip3ExitLimit) {
//       _showStrip3();
//     }
//     else {
//       _hideStrip3();
//     }
//   }
//   // -----------------------------------------------------------------------------
//
//   /// STRIP 4 CONTROLS
//
//   // --------------------
//   final ValueNotifier<double> _strip4Position = ValueNotifier(strip4Height);
//   static const double strip4Height = _pyramidHeight * 4.4;
//   static const double strip4ExitLimit = _pyramidHeight * 0.5;
//   // --------------------
//   void _showStrip4(){
//     setNotifier(
//       notifier: _strip4Position,
//       mounted: mounted,
//       value: 0.0,
//     );
//   }
//   // --------------------
//   void _hideStrip4(){
//
//     setNotifier(
//       notifier: _strip4Position,
//       mounted: mounted,
//       value: strip4Height,
//     );
//
//   }
//   // --------------------
//   void _onDragStrip4Update(DragUpdateDetails details) {
//
//     final double newPosition = (_strip4Position.value + details.primaryDelta!).clamp(0.0, strip4Height);
//
//     setNotifier(
//       notifier: _strip4Position,
//       mounted: mounted,
//       value: newPosition,
//     );
//
//     if (newPosition > strip4ExitLimit) {
//       _hideStrip4();
//       _hideStrip5();
//     }
//
//   }
//   // --------------------
//   void _onDragStrip4End(DragEndDetails details) {
//     if (_strip4Position.value <= strip4ExitLimit) {
//       _showStrip4();
//     }
//     else {
//       _hideStrip4();
//     }
//   }
//   // -----------------------------------------------------------------------------
//
//   /// STRIP 4 CONTROLS
//
//   // --------------------
//   final ValueNotifier<double> _strip5Position = ValueNotifier(strip5Height);
//   static const double strip5Height = _pyramidHeight * 5.5;
//   static const double strip5ExitLimit = _pyramidHeight * 0.5;
//   // --------------------
//   void _showStrip5(){
//     setNotifier(
//       notifier: _strip5Position,
//       mounted: mounted,
//       value: 0.0,
//     );
//   }
//   // --------------------
//   void _hideStrip5(){
//
//     setNotifier(
//       notifier: _strip5Position,
//       mounted: mounted,
//       value: strip5Height,
//     );
//
//   }
//   // --------------------
//   void _onDragStrip5Update(DragUpdateDetails details) {
//
//     final double newPosition = (_strip5Position.value + details.primaryDelta!).clamp(0.0, strip5Height);
//
//     setNotifier(
//       notifier: _strip5Position,
//       mounted: mounted,
//       value: newPosition,
//     );
//
//     if (newPosition > strip5ExitLimit) {
//       _hideStrip5();
//     }
//
//   }
//   // --------------------
//   void _onDragStrip5End(DragEndDetails details) {
//     if (_strip5Position.value <= strip5ExitLimit) {
//       _showStrip5();
//     }
//     else {
//       _hideStrip5();
//     }
//   }
//   // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     // --------------------
//     final double _screenWidth = Scale.screenWidth(context);
//     // --------------------
//     return Stack(
//       children: <Widget>[
//
//         /// STRIP 5
//         ValueListenableBuilder(
//           valueListenable: _strip5Position,
//           builder: (_, double position, Widget? child) {
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 150),
//               bottom: -position,
//               right: 0,
//               child: child!,
//             );
//           },
//           child: GestureDetector(
//             onVerticalDragUpdate: _onDragStrip5Update,
//             onVerticalDragEnd: _onDragStrip5End,
//             child: Container(
//               color: Colorz.nothing, // this makes the drag listens : don't remove this
//               child: BlurLayer(
//                 width: _screenWidth,
//                 height: strip5Height,
//                 color: Colorz.white10,
//                 blurIsOn: true,
//                 blur: 3,
//                 alignment: Alignment.topCenter,
//               ),
//             ),
//           ),
//         ),
//
//         /// STRIP 4
//         ValueListenableBuilder(
//           valueListenable: _strip4Position,
//           builder: (_, double position, Widget? child) {
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 150),
//               bottom: -position,
//               right: 0,
//               child: child!,
//             );
//           },
//           child: GestureDetector(
//             onVerticalDragUpdate: _onDragStrip4Update,
//             onVerticalDragEnd: _onDragStrip4End,
//             child: Container(
//               color: Colorz.nothing, // this makes the drag listens : don't remove this
//               child: BlurLayer(
//                 width: _screenWidth,
//                 height: strip4Height,
//                 color: Colorz.white10,
//                 blurIsOn: true,
//                 blur: 3,
//                 alignment: Alignment.topCenter,
//                 child: BldrsBox(
//                   width: 100,
//                   height: strip1Height * 0.8,
//                   verse: Verse.plain('Do it'),
//                   onTap: _showStrip5,
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         /// STRIP 3
//         ValueListenableBuilder(
//           valueListenable: _strip3Position,
//           builder: (_, double position, Widget? child) {
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 150),
//               bottom: -position,
//               right: 0,
//               child: child!,
//             );
//           },
//           child: GestureDetector(
//             onVerticalDragUpdate: _onDragStrip3Update,
//             onVerticalDragEnd: _onDragStrip3End,
//             child: Container(
//               color: Colorz.nothing, // this makes the drag listens : don't remove this
//               child: BlurLayer(
//                 width: _screenWidth,
//                 height: strip3Height,
//                 color: Colorz.white10,
//                 blurIsOn: true,
//                 blur: 3,
//                 alignment: Alignment.topCenter,
//                 child: BldrsBox(
//                   width: 100,
//                   height: strip1Height * 0.8,
//                   verse: Verse.plain('Do Them'),
//                   onTap: _showStrip4,
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         /// STRIP 2
//         ValueListenableBuilder(
//           valueListenable: _strip2Position,
//           builder: (_, double position, Widget? child) {
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 150),
//               bottom: -position,
//               right: 0,
//               child: child!,
//             );
//           },
//           child: GestureDetector(
//             onVerticalDragUpdate: _onDragStrip2Update,
//             onVerticalDragEnd: _onDragStrip2End,
//             child: Container(
//               color: Colorz.nothing, // this makes the drag listens : don't remove this
//               child: BlurLayer(
//                 width: _screenWidth,
//                 height: strip2Height,
//                 color: Colorz.white10,
//                 blurIsOn: true,
//                 blur: 3,
//                 alignment: Alignment.topCenter,
//                 child: BldrsBox(
//                   width: 100,
//                   height: strip1Height * 0.8,
//                   verse: Verse.plain('Do That'),
//                   onTap: _showStrip3,
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         /// STRIP 1
//         ValueListenableBuilder(
//           valueListenable: _strip1Position,
//           builder: (_, double position, Widget? child) {
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 150),
//               bottom: -position,
//               right: 0,
//               child: child!,
//             );
//           },
//           child: GestureDetector(
//             onVerticalDragUpdate: _onDragStrip1Update,
//             onVerticalDragEnd: _onDragStrip1End,
//             child: Container(
//               color: Colorz.nothing, // this makes the drag listens : don't remove this
//               child: BlurLayer(
//                 width: _screenWidth,
//                 height: strip1Height,
//                 color: Colorz.white10,
//                 blurIsOn: true,
//                 blur: 3,
//                 alignment: Alignment.topCenter,
//                 child: BldrsBox(
//                   width: 100,
//                   height: strip1Height * 0.8,
//                   verse: Verse.plain('Do this'),
//                   onTap: _showStrip2,
//                 ),
//               ),
//             ),
//           ),
//         ),
//
//         /// PYRAMID
//         ValueListenableBuilder(
//           valueListenable: _pyramidIsOn,
//           builder: (_, bool isOn, Widget? child) {
//
//             return AnimatedPositioned(
//               duration: const Duration(milliseconds: 300),
//               bottom: isOn == true ? 0 : -Pyramids.khafreHeight,
//               right: Pyramids.rightMargin,
//               curve: Curves.easeInOut,
//               child: child!,
//             );
//           },
//           child: Khufu(
//             onTap: _onPyramidTap,
//           ),
//         ),
//
//       ],
//     );
//     // --------------------
//   }
//   // -----------------------------------------------------------------------------
// }
