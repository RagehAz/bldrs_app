// import 'package:bldrs/01_screens/xxx_zebala/f_header_data.dart';
// import 'package:bldrs/01_screens/xxx_zebala/f_multi_slides_data.dart';
// import 'package:bldrs/02_widgets/buttons/bt_rageh.dart';
// import 'package:bldrs/02_widgets/flyer/old_flyer.dart';
// import 'package:bldrs/02_widgets/flyer/old_flyer_footprint.dart';
// import 'package:bldrs/02_widgets/pyramids/pyramids.dart';
// import 'package:bldrs/02_widgets/skies/night_sky.dart';
// import 'package:bldrs/02_widgets/textings/super_verse.dart';
// import 'package:bldrs/view_brain.x_ui_stuff.04_localization/localization_constants.dart';
// import 'package:bldrs/view_brain.x_ui_stuff/colorz.dart';
// import 'package:bldrs/view_brain.x_ui_stuff/iconz.dart';
// import 'package:bldrs/view_brain.x_ui_stuff/ratioz.dart';
// import 'package:flutter/material.dart';
//
// import '../../main.dart';
//
// // Flyer in Full screen mode
// // side slidings : changes flyer pages, until end of flyer then gets next flyer of same Business
// // story taps : same as slide slidings
// // up & down slidings : gets next flyer in the collection
// // if in gallery : collection flyer index = gallery flyer index,, vertical sliding exits the flyer either up or down
// // pinch in : always exist flyer
// // pinch out : zooms in flyer slide, while preserving header & footer
//
// class FlyersTestScreen extends StatefulWidget {
//   final List<HeaderData> headerData = [
//     HeaderData(
//       id: 'a77a',
//       // --- BCard
//       bzName: 'Rageh for import and fucking sport',
//       bzLogo: Iconz.DumBusinessLogo,
//       bzCity: 'Kambodia',
//       bzCountry: 'Taiwan',
//       aName: 'Rageh Al Rajeah',
//       aPic: Iconz.DumAuthorPic,
//       aTitle: 'Ra2ees ette7ad el Mollak',
//       followers: 123,
//       followingOn: true,
//       galleryCount: 555,
//       bzFields: ['Architecture', 'Interior', 'Construction'],
//       phoneNumber : '01554555107',
//     ),
//   ];
//
//   final MultiSlidesData slidesData = MultiSlidesData(
//     // --- Slide
//     headlines: ['kalbaa', 'safla', 'wes5a', 'aywa', 'ba2a'],
//     pictures: [
//       Iconz.DumSlide1,
//       Iconz.DumSlide2,
//       Iconz.DumSlide3,
//       Iconz.DumSlide4,
//       Iconz.DumSlide5
//     ],
//     shares: [4564, 25164, 1025532, 555, 235235],
//     views: [1234, 56789, 1023456, 4646346, 43763267],
//     saves: [5875, 1, 2365, 45747, 34572347],
//     ankhsOn: [true, false, true, true, false],
//   );
//
//   @override
//   FlyersTestScreenState createState() => FlyersTestScreenState();
// }
//
// class FlyersTestScreenState extends State<FlyersTestScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     // double safeAreaHeight = MediaQuery.of(context).padding.top;
//     // double screenWithoutSafeAreaHeight = screenHeight - safeAreaHeight;
//
//     double flyerZoneWidth = screenWidth;
//     // double flyerMargins = screenHeight * Ratioz.rrFlyerMainMargin;
//     // double flyerBottomMargin = Ratioz.ddPyramidsHeight + 10;
//     // double flyerZoneHeight =
//     //     screenWithoutSafeAreaHeight - flyerBottomMargin - flyerMargins;
//     double flyerTopCorners = screenHeight * Ratioz.rrFlyerTopCorners;
//     double flyerBottomCorners = screenHeight * Ratioz.rrFlyerBottomCorners;
//
//     double _textMargins = 10;
//
//     // dynamic testPrint = safeAreaHeight;
//
//     // int slideSwipe = 0;
//     int _x = 0;
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             NightSky(),
//             ListView(
//               children: [
//                 Column(
//                   children: [
//                     // Flyer Full Screen
//                     SuperVerse(
//                       verse: 'Full Screen Mode',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 1,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer Grid x0.48
//                     SuperVerse(
//                       verse: 'GridView test',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Flyer(
//                           flyerSizeFactor: 0.45,
//                           id: 'a77a',
//                           bzLogo: widget.headerData[_x].bzLogo,
//                           bzName: widget.headerData[_x].bzName,
//                           bzCity: widget.headerData[_x].bzCity,
//                           bzCountry: widget.headerData[_x].bzCountry,
//                           aPic: widget.headerData[_x].aPic,
//                           aName: widget.headerData[_x].aName,
//                           aTitle: widget.headerData[_x].aTitle,
//                           followers: widget.headerData[_x].followers,
//                           followingOn: widget.headerData[_x].followingOn,
//                           galleryCount: widget.headerData[_x].galleryCount,
//                           bzFields: widget.headerData[_x].bzFields,
//                           headlines: widget.slidesData.headlines,
//                           pictures: widget.slidesData.pictures,
//                           shares: widget.slidesData.shares,
//                           views: widget.slidesData.views,
//                           saves: widget.slidesData.saves,
//                           ankhsOn: widget.slidesData.ankhsOn,
//                           phoneNumber: '01554555107',
//                         ),
//                         SizedBox(
//                           width: (screenWidth - (screenWidth * 0.45 * 2)) / 3,
//                         ),
//                         Flyer(
//                           flyerSizeFactor: 0.45,
//                           id: 'a77a',
//                           bzLogo: widget.headerData[_x].bzLogo,
//                           bzName: widget.headerData[_x].bzName,
//                           bzCity: widget.headerData[_x].bzCity,
//                           bzCountry: widget.headerData[_x].bzCountry,
//                           aPic: widget.headerData[_x].aPic,
//                           aName: widget.headerData[_x].aName,
//                           aTitle: widget.headerData[_x].aTitle,
//                           followers: widget.headerData[_x].followers,
//                           followingOn: widget.headerData[_x].followingOn,
//                           galleryCount: widget.headerData[_x].galleryCount,
//                           bzFields: widget.headerData[_x].bzFields,
//                           headlines: widget.slidesData.headlines,
//                           pictures: widget.slidesData.pictures,
//                           shares: widget.slidesData.shares,
//                           views: widget.slidesData.views,
//                           saves: widget.slidesData.saves,
//                           ankhsOn: widget.slidesData.ankhsOn,
//                           phoneNumber: '01554555107',
//                         ),
//                       ],
//                     ),
//
//                     // Flyer 0.95
//                     SuperVerse(
//                       verse: 'Flyer x0.95',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.95,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                           phoneNumber: '01554555107',
//                         ),
//
//                     // Flyer 0.90
//                     SuperVerse(
//                       verse: 'Flyer x0.90',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.90,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.85
//                     SuperVerse(
//                       verse: 'Flyer x0.85',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.85,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.80
//                     SuperVerse(
//                       verse: 'Flyer x0.80',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.80,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.75
//                     SuperVerse(
//                       verse: 'Flyer x0.75',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.75,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.70
//                     SuperVerse(
//                       verse: 'Flyer x0.70',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.70,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.65
//                     SuperVerse(
//                       verse: 'Flyer x0.65',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.65,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.60
//                     SuperVerse(
//                       verse: 'Flyer x0.60',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.60,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.55
//                     SuperVerse(
//                       verse: 'Flyer x0.55',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.55,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.50
//                     SuperVerse(
//                       verse: 'Flyer x0.50',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.50,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     // Flyer 0.465
//                     SuperVerse(
//                       verse: 'Flyer x0.465',
//                       color: Colorz.White,
//                       designMode: false,
//                       centered: true,
//                       size: 5,
//                       weight: 'bold',
//                       shadow: true,
//                       italic: true,
//                       margin: _textMargins,
//                     ),
//                     Flyer(
//                       flyerSizeFactor: 0.465,
//                       id: 'a77a',
//                       bzLogo: widget.headerData[_x].bzLogo,
//                       bzName: widget.headerData[_x].bzName,
//                       bzCity: widget.headerData[_x].bzCity,
//                       bzCountry: widget.headerData[_x].bzCountry,
//                       aPic: widget.headerData[_x].aPic,
//                       aName: widget.headerData[_x].aName,
//                       aTitle: widget.headerData[_x].aTitle,
//                       followers: widget.headerData[_x].followers,
//                       followingOn: widget.headerData[_x].followingOn,
//                       galleryCount: widget.headerData[_x].galleryCount,
//                       bzFields: widget.headerData[_x].bzFields,
//                       headlines: widget.slidesData.headlines,
//                       pictures: widget.slidesData.pictures,
//                       shares: widget.slidesData.shares,
//                       views: widget.slidesData.views,
//                       saves: widget.slidesData.saves,
//                       ankhsOn: widget.slidesData.ankhsOn,
//                       phoneNumber: '01554555107',
//                     ),
//
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                     ),
//
//                     FlyerFootPrint(
//                       flyerSizeFactoria: 0.47,
//                     ),
//
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                     ),
//
//                     Container(
//                       width: screenWidth,
//                       height: (screenWidth * 0.45) * Ratioz.xxflyerZoneHeight,
//                       padding: EdgeInsets.only(left: 10, right: 10),
//                       child: Stack(
//                         children: <Widget>[
//                           Positioned(
//                             right: 0,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                             ),
//
//                           Positioned(
//                             right: 20,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 40,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 60,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 80,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 100,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 120,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 140,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 160,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                           Positioned(
//                             right: 180,
//                             child: Flyer(
//                               flyerSizeFactor: 0.45,
//                               id: 'a77a',
//                               bzLogo: widget.headerData[_x].bzLogo,
//                               bzName: widget.headerData[_x].bzName,
//                               bzCity: widget.headerData[_x].bzCity,
//                               bzCountry: widget.headerData[_x].bzCountry,
//                               aPic: widget.headerData[_x].aPic,
//                               aName: widget.headerData[_x].aName,
//                               aTitle: widget.headerData[_x].aTitle,
//                               followers: widget.headerData[_x].followers,
//                               followingOn: widget.headerData[_x].followingOn,
//                               galleryCount: widget.headerData[_x].galleryCount,
//                               bzFields: widget.headerData[_x].bzFields,
//                               headlines: widget.slidesData.headlines,
//                               pictures: widget.slidesData.pictures,
//                               shares: widget.slidesData.shares,
//                               views: widget.slidesData.views,
//                               saves: widget.slidesData.saves,
//                               ankhsOn: widget.slidesData.ankhsOn,
//                               phoneNumber: widget.headerData[_x].phoneNumber,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 200,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Pyramids(
//               whichPyramid: Iconz.PyramidsGlass,
//             ),
//             Rageh(
//               tappingRageh:
//                   getTranslated(context, 'Active_Language') == 'Arabic'
//                       ? () async {
//                           Locale temp = await setLocale('en');
//                           BldrsApp.setLocale(context, temp);
//                         }
//                       : () async {
//                           Locale temp = await setLocale('ar');
//                           BldrsApp.setLocale(context, temp);
//                         },
//               doubleTappingRageh: () {
//                 print(flyerZoneWidth);
//                 print(flyerTopCorners);
//                 print(flyerBottomCorners);
//                 print(screenHeight);
//                 print(flyerBottomCorners);
//                 print(Ratioz.rrFlyerTopCorners);
//                 print(0);
//                 print(((Ratioz.rrFlyerTopCorners) * screenHeight) /
//                     flyerZoneWidth);
//                 print(((Ratioz.rrFlyerBottomCorners) * screenHeight) /
//                     flyerZoneWidth);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
