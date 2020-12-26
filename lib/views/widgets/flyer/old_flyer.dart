// import 'package:bldrs/providers/combined_models/co_flyer.dart';
// import 'package:bldrs/view_brains/drafters/shadowers.dart';
// import 'package:bldrs/view_brains/localization/localization_constants.dart';
// import 'package:bldrs/view_brains/theme/colorz.dart';
// import 'package:bldrs/view_brains/theme/iconz.dart';
// import 'package:bldrs/view_brains/theme/ratioz.dart';
// import 'package:bldrs/views/widgets/buttons/dream_box.dart';
// import 'package:flutter/material.dart';
// import 'package:share/share.dart';
// import 'header/header.dart';
// import 'slides/slides.dart';
// import 'slides/slides_items/progress_bar.dart';
//
// class Flyer extends StatefulWidget {
//   final double flyerSizeFactor;
//   final CoFlyerData flyerData;
//   // bool followingOn;
//
//   int currentSlideIndex;
//   bool slidingIsOff;
//   final Function tappingMiniFlyer;
//
//   Flyer({
//     @required this.flyerSizeFactor,
//     this.flyerData,
//     this.currentSlideIndex = 0,
//     this.slidingIsOff,
//     this.tappingMiniFlyer,
//   });
//
//   @override
//   _FlyerState createState() => _FlyerState();
// }
//
// class _FlyerState extends State<Flyer> with AutomaticKeepAliveClientMixin{
//
//   bool get wantKeepAlive => true;
//
//   bool bzPageIsOn = false;
//
//
//
//   void switchBzPage (){
//     setState(() {
//       bzPageIsOn == false ? bzPageIsOn = true : bzPageIsOn = false;
//
//     });
//   }
//
//   void slidingPages (int slideIndex){
//     setState(() {
//       widget.currentSlideIndex = slideIndex;
//       print(
//           // 'flyerID :${widget.flyerData.flyerID} '
//               'slideID : ${widget.flyerData.coSlideDataList[slideIndex].moSlide.slideID}'
//       );
//     });
//   }
//
//   // we removed 'widget.' before followingOn temporarily
//   void tappingFollow (){
//     setState(() {
//       // we should save a new entry to database in this function
//     });
//   }
//   // void someshit(){
//   //   List<CoSlideData> coSlides = widget.flyerData.coSlideDataList;
//   //   List<MoSave> slidesSaves = coSlides
//   // }
//
//   // we removed 'widget.' before ankhsOn temporarily
//   dynamic tappingSave (int slideIndex){
//   setState(() {
//     // widget.flyerData.flyerAnkhIsOn =! widget.flyerData.flyerAnkhIsOn;
//     // theoretically,, we should save a new entry to the database
//     // xSavesList.add(MoSave(saveID: 's0${xSavesList.length + 1}', userID: 'u21', slideID: widget.flyerData.slidesIDsList[slideIndex]));
//   });
//   }
//
//   int bolbol = 0;
//   FlyerLink theFlyerLink = FlyerLink(flyerLink: 'flyer', description: 'flyer to be shared aho');
//
//   void tappingShare (int slideIndex){
//     setState(() {
//       bolbol = slideIndex;
//     });
//     print('sharing the bolbol index = $bolbol');
//     share(context, theFlyerLink);
//   }
//
//   bool slidingIsOn = false;
//
//   void _tappingMiniFlyer(){
//     widget.tappingMiniFlyer();
//     _triggerSliding();
//   }
//
//   void _triggerSliding(){
//     setState(() {
//       slidingIsOn = !slidingIsOn;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // final flyerData = Provider.of<ProcessedFlyerData>(context, listen: false);
//
//     // print('flyer blds');
//
//     int numberOfSlides = widget.flyerData.coSlideDataList.length;
//
//     // ----------------------------------------------------------------------
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//     double safeAreaHeight = MediaQuery.of(context).padding.top;
//     double screenWithoutSafeAreaHeight = screenHeight - safeAreaHeight;
//     // ----------------------------------------------------------------------
//     double flyerSizeFactor = widget.flyerSizeFactor;
//     double flyerZoneWidth = screenWidth * flyerSizeFactor;
//     double flyerZoneHeight = widget.flyerSizeFactor == 1 ?
//     screenWithoutSafeAreaHeight : flyerZoneWidth * Ratioz.xxflyerZoneHeight;
//     double flyerTopCorners = flyerZoneWidth * Ratioz.xxflyerTopCorners;
//     double flyerBottomCorners = flyerZoneWidth * Ratioz.xxflyerBottomCorners;
//     // ----------------------------------------------------------------------
//     void printingShit(){
//       print('follow');
//     }
//     // ----------------------------------------------------------------------
//     bool _barHidden = (bzPageIsOn == true) || (slidingIsOn = false) ?  true : false;
//     // ----------------------------------------------------------------------
//     int slideIndex = widget.currentSlideIndex;
//     bool ankhIsOn = true;//widget.flyerData.flyerAnkhIsOn;
//
//     bool microMode = flyerZoneWidth < screenWidth * 0.4 ? true : false;
//
//     double footerBTMargins =
//     (ankhIsOn == true && (microMode == true && slidingIsOn == false)) ? flyerZoneWidth * 0.01: // for micro flyer when AnkhIsOn
//     (ankhIsOn == true) ? flyerZoneWidth * 0.015 : // for Normal flyer when AnkhIsOn
//     flyerZoneWidth * 0.025; // for Normal flyer when !AnkhIsOn
//     double saveBTRadius = flyerBottomCorners - footerBTMargins;
//     Color footerBTColor = Colorz.GreySmoke;
//     String saveBTIcon = ankhIsOn == true ? Iconz.SaveOn : Iconz.SaveOff;
//     String saveBTVerse = ankhIsOn == true ? getTranslated(context, 'Saved') :
//     getTranslated(context, 'Save');
//     Color saveBTColor = ankhIsOn == true ? Colorz.YellowSmoke : Colorz.Nothing;
//
//     Color flyerShadowColor = Colorz.BlackBlack;
//     // ----------------------------------------------------------------------
//
//       // print ('slidingIsOn value =$slidingIsOn');
//
//     return GestureDetector(
//       onTap: _tappingMiniFlyer,
//       child: Center(
//         child: Container(
//           width: flyerZoneWidth,
//           height: flyerZoneHeight,
//           alignment: Alignment.topCenter,
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(flyerTopCorners),
//                 topRight: Radius.circular(flyerTopCorners),
//                 bottomLeft: Radius.circular(flyerBottomCorners),
//                 bottomRight: Radius.circular(flyerBottomCorners),
//               ),
//               gradient: RadialGradient(
//                 colors: [Colorz.WhiteAir, Colorz.Nothing],
//                 stops: [0, 0.3],
//                 center: Alignment.center,
//                 radius:  0.18,
//               ),
//               boxShadow: [CustomBoxShadow(
//                     color: flyerShadowColor,
//                     blurRadius: flyerZoneWidth * 0.055,
//                     blurStyle: BlurStyle.outer),
//               ]),
//           child: ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(flyerTopCorners),
//               topRight: Radius.circular(flyerTopCorners),
//               bottomLeft: Radius.circular(flyerBottomCorners),
//               bottomRight: Radius.circular(flyerBottomCorners),
//             ),
//
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//
//                 Slides(
//                   flyerZoneWidth: flyerZoneWidth,
//                   slidingIsOff: widget.slidingIsOff,
//                   currentSlideIndex: widget.currentSlideIndex,
//                   coSlidesData: widget.flyerData.coSlideDataList,
//                   // ankhsOn: widget.flyerData.flyerAnkhIsOn,
//                   tappingSave: tappingSave,
//                   tappingShare: tappingShare,
//                   sliding: slidingPages,
//                 ),
//
//                 Header(
//                   flyerZoneWidth: flyerZoneWidth,
//                   coBzData: widget.flyerData.coBzData,
//                   authorID: widget.flyerData.moFlyer.authorID,
//                   flyerShowsAuthor: widget.flyerData.moFlyer.flyerShowsAuthor,
//                   bzPageIsOn: bzPageIsOn,
//                   tappingHeader: () { switchBzPage(); print('Header Tapped'); },
//                   tappingFollow: tappingFollow,
//                   tappingUnfollow: () {print('UnFollow Tapped');},
//                   tappingGallery: () {print('Gallery Tapped');},
//                   galleryCoFlyers: [],
//                   coAuthorData: coAuthorData,
//                 ),
//
//                 ProgressBar(
//                   flyerZoneWidth: flyerZoneWidth,
//                   barHidden: _barHidden,
//                   currentSlide: widget.currentSlideIndex,
//                   numberOfSlides: numberOfSlides,
//                 ),
//
//                 // AnkhButton(
//                 //   bzPageIsOn: bzPageIsOn,
//                 //   flyerZoneWidth: flyerZoneWidth,
//                 //   slidingIsOn: slidingIsOn,
//                 //   microMode: microMode,
//                 // ),
//
//                 // --- SAVE BUTTON
//                 //--------------------------------------------------
//
//                 // (microMode == true && widget.flyerData.flyerAnkhIsOn == false) || bzPageIsOn == true ? Container():
//                 Positioned(
//                   left: getTranslated(context, 'Text_Direction') == 'ltr' ? null : 0,
//                   right: getTranslated(context, 'Text_Direction') == 'ltr' ? 0 : null,
//                   bottom: 0,
//                   child:
//                   DreamBox(
//                     icon: saveBTIcon,
//                     iconSizeFactor: 0.8,
//                     width: saveBTRadius*2,
//                     height: saveBTRadius*2,
//                     corners: saveBTRadius,
//                     boxMargins: EdgeInsets.all(footerBTMargins),
//                     boxFunction: (){},
//                     color: saveBTColor,
//                   ),
//
//                   // FlyerFooterBT(
//                   //   flyerZoneWidth: flyerZoneWidth,
//                   //   buttonVerse: saveBTVerse,
//                   //   buttonColor: saveBTColor,
//                   //   buttonIcon: saveBTIcon,
//                   //   buttonMargins: footerBTMargins,
//                   //   buttonRadius: saveBTRadius,
//                   //   tappingButton: tappingSave,
//                   //   slideIndex: slideIndex,
//                   // ),
//
//
//                 )
//
//                 //--------------------------------------------------
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FlyerLink{
//   final String flyerLink;
//   final String description;
//
//   FlyerLink({
//     @required this.flyerLink,
//     @required this.description,
//   });
// }
//
// void share (BuildContext context, FlyerLink flyerLink) {
//   final RenderBox box = context.findRenderObject();
//   final String text = '${flyerLink.flyerLink} & ${flyerLink.description}';
//
//   Share.share(
//       text,
//       subject: flyerLink.description,
//       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
//   );
// }
