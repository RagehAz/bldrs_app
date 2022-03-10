// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_flyer_stuff/old_flyer_zone_box.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer_parts/footer_button.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
// import 'package:bldrs/f_helpers/localization/localizer.dart';
// import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class OldAnkhButton extends StatefulWidget {
//   /// --------------------------------------------------------------------------
//   const OldAnkhButton({
//     @required this.flyerBoxWidth,
//     @required this.bzPageIsOn,
//     @required this.listenToSwipe,
//     @required this.ankhIsOn,
//     @required this.onAnkhTap,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final bool bzPageIsOn;
//   final bool listenToSwipe;
//   final bool ankhIsOn;
//   final Function onAnkhTap;
//
//   /// --------------------------------------------------------------------------
//   @override
//   _OldAnkhButtonState createState() => _OldAnkhButtonState();
//
//   /// --------------------------------------------------------------------------
// }
//
// class _OldAnkhButtonState extends State<OldAnkhButton>
//     with SingleTickerProviderStateMixin {
//   AnimationController _ankhAniController;
//   // Animation _ankhColorAni;
//   bool _ankhIsOn;
//   String _saveBTIcon;
//
//   // Color _onColor = Colorz.Yellow80;
//   // Color _offColor = Colorz.Nothing;
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//
//     _ankhIsOn = widget.ankhIsOn;
//     _saveBTIcon = _ankhIsOn == true ? Iconz.saveOn : Iconz.saveOff;
//
//     _ankhAniController =
//         AnimationController(duration: Ratioz.durationFading200, vsync: this);
//
//     // _ankhColorAni = _initialTween().animate(_ankhAniController);
//
//     _ankhAniController.addListener(() {
//       // print(_ankhAniController.value);
//       // print(_ankhColorAni.value);
//     });
//
//     // _ankhAniController.addStatusListener((status) {
//     //   if(status == AnimationStatus.completed){
//     //     setState(() {
//     //       _ankhIsOn = true;
//     //     });
//     //   }
//     //   if(status == AnimationStatus.dismissed){
//     //     setState(() {
//     //       _ankhIsOn = false;
//     //     });
//     //   }
//     //
//     // });
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     _ankhAniController.dispose();
//     super.dispose();
//   }
//
// // -----------------------------------------------------------------------------
// //   ColorTween _initialTween(){
// //     ColorTween _tween;
// //
// //     if(widget.ankhIsOn){
// //       _tween = ColorTween(begin: _onColor, end: _offColor);
// //     }
// //
// //     else {
// //       _tween = ColorTween(begin: _offColor, end: _onColor);
// //     }
// //
// //     return _tween;
// //   }
// // -----------------------------------------------------------------------------
//   Future<void> _onAnkhTap() async {
//     widget.onAnkhTap();
//
//     if (_ankhIsOn == true) {
//       setState(() {
//         _ankhIsOn = false;
//         _saveBTIcon = Iconz.saveOff;
//       });
//       await _ankhAniController.reverse();
//     } else {
//       setState(() {
//         _ankhIsOn = true;
//         _saveBTIcon = Iconz.saveOn;
//       });
//       await _ankhAniController.forward();
//     }
//   }
//
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     // final pro = Provider.of<CoFlyer>(context, listen: false);
//     // String flyerID = pro.flyer.flyerID;
// // -----------------------------------------------------------------------------
// //     double _saveBTSize = FlyerFooter.buttonSize(
// //       context: context,
// //       flyerBoxWidth: widget.flyerBoxWidth,
// //       buttonIsOn: _ankhIsOn,
// //     ) ;
//
//     final String _saveBTVerse = widget.ankhIsOn == true
//         ? Localizer.translate(context, 'Saved')
//         : Localizer.translate(context, 'Save');
//     // Color _saveBTColor = _ankhIsOn == true ? Colorz.Yellow80 : Colorz.White10;
// // -----------------------------------------------------------------------------
//     // Color flyerShadowColor = ankhIsOn == true ? Colorz.BlackBlack : Colorz.BlackBlack;
// // -----------------------------------------------------------------------------
//     final bool _tinyMode = FlyerBox.isTinyMode(context, widget.flyerBoxWidth);
//
//     // print('AnkhButton : _ankhColorAni : $_ankhColorAni');
//     return Positioned(
//       right: Aligners.rightPositionInRightAlignmentEn(context, 0),
//       left: Aligners.leftPositionInRightAlignmentEn(context, 0),
//       bottom: 0,
//       child: widget.bzPageIsOn
//           ? Container()
//           : _tinyMode == true && widget.ankhIsOn == true
//               ? OldFooterButton(
//                   icon: _saveBTIcon,
//                   flyerBoxWidth: widget.flyerBoxWidth,
//                   verse: _saveBTVerse,
//                   onTap: null,
//                 )
//               : _tinyMode == false && widget.ankhIsOn == false
//                   ? OldFooterButton(
//                       icon: _saveBTIcon,
//                       flyerBoxWidth: widget.flyerBoxWidth,
//                       verse: _saveBTVerse,
//                       onTap: _onAnkhTap,
//                     )
//                   : _tinyMode == false && widget.ankhIsOn == true
//                       ?
//                       // (_tinyMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
//                       OldFooterButton(
//                           icon: _saveBTIcon,
//                           flyerBoxWidth: widget.flyerBoxWidth,
//                           isOn: widget.ankhIsOn,
//                           verse: _saveBTVerse,
//                           onTap: _onAnkhTap,
//                         )
//                       : Container(),
//
//       ///
//       // AnimatedBuilder(
//       //   animation: _ankhAniController,
//       //   builder: (BuildContext context, _){
//       //     return
//       //       Stack(
//       //         alignment: Alignment.center,
//       //         children: <Widget>[
//       //
//       //           // AnimatedContainer(
//       //           //   duration: const Duration(milliseconds: 50),
//       //           //   width: _saveBTSize,
//       //           //   height: _saveBTSize,
//       //           //   decoration: BoxDecoration(
//       //           //     shape: BoxShape.circle,
//       //           //     color: _ankhColorAni.value,
//       //           //   ),
//       //           // ),
//       //
//       //           (widget.tinyMode == true && widget.ankhIsOn == false) || widget.bzPageIsOn == true ? Container():
//       //           FooterButton(
//       //               icon: _saveBTIcon,
//       //               flyerBoxWidth: widget.flyerBoxWidth,
//       //               isOn: widget.ankhIsOn,
//       //               verse: _saveBTVerse,
//       //               onTap: _onAnkhTap,
//       //           ),
//       //
//       //         ],
//       //       );
//       //     },
//       // ),
//       ///
//     );
//   }
// }